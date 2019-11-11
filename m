Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6413A206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKBsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:48:22 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52836 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbfKKBsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:48:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Thg.zlR_1573436895;
Received: from C02XQC8CJG5H.local(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0Thg.zlR_1573436895)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Nov 2019 09:48:16 +0800
Subject: Re: [PATCH 2/2] mm, zswap: Support THP
To:     Dan Streetman <ddstreet@ieee.org>
Cc:     Hui Zhu <teawater@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <1571111349-5041-1-git-send-email-teawater@gmail.com>
 <1571111349-5041-2-git-send-email-teawater@gmail.com>
 <CALZtONA9Y9tvOJcHUyac770fSQhCoGMb7kDL1R5N9Bueqd+7_g@mail.gmail.com>
From:   Hui Zhu <teawaterz@linux.alibaba.com>
Message-ID: <c67747b9-35cf-ec42-9cd3-6217e9d717b9@linux.alibaba.com>
Date:   Mon, 11 Nov 2019 09:48:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CALZtONA9Y9tvOJcHUyac770fSQhCoGMb7kDL1R5N9Bueqd+7_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/9 12:15 上午, Dan Streetman wrote:
> On Mon, Oct 14, 2019 at 11:49 PM Hui Zhu <teawater@gmail.com> wrote:
>>
>> This commit let zswap treats THP as continuous normal pages
>> in zswap_frontswap_store.
>> It will store them to a lot of "zswap_entry".  These "zswap_entry"
>> will be inserted to "zswap_tree" together.
> 
> why does zswap need to carry the added complexity of converting THP
> into separate normal sized pages?  That should be done higher up in
> the swap layer.
> 

Hi Dan,

There are 2 issues will increase the performance overhead if thp is 
handle in swap layer.
1, When zswap is full, it will let page go back to swap device.
Thp swap out faster if it is not split.
But swap layer doesn't know if zswap is full or not, so it need split
the thp each time.  It will decrease thp swap out speed.
2. If thp can handle the thp with itself, it can decrease the times
of access the locks.
For example:
	spin_lock(&tree->lock);
	for (i = 0; i < nr; i++) {
		do {
			ret = zswap_rb_insert(&tree->rbroot, entries[i],
					&dupentry);
			if (ret == -EEXIST) {
				zswap_duplicate_entry++;
				/* remove from rbtree */
				zswap_rb_erase(&tree->rbroot, dupentry);
				zswap_entry_put(tree, dupentry);
			}
		} while (ret == -EEXIST);
	}
	spin_unlock(&tree->lock);

This is my test in a vm that has 1 CPU, 1G memory and 4G swap:
First, I write a very small patch that let shrink_page_list split all
thps.
@@ -1298,8 +1298,7 @@ static unsigned long shrink_page_list(struct 
list_head *page_list,
                                          * away. Chances are some or 
all of the
                                          * tail pages can be freed 
without IO.
                                          */
-                                       if (!compound_mapcount(page) &&
-                                           split_huge_page_to_list(page,
+                                       if (split_huge_page_to_list(page,
 
page_list))
                                                 goto activate_locked;
                                 }
Following is my test with this kernel:
echo lz4 > /sys/module/zswap/parameters/compressor
echo zsmalloc > /sys/module/zswap/parameters/zpool
echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
echo 50 > /sys/module/zswap/parameters/max_pool_percent
echo 1 > /sys/module/zswap/parameters/enabled
swapon /swapfile
echo always > /sys/kernel/mm/transparent_hugepage/enabled

/ # usemem -a -n 1 $((2000 * 1024 * 1024))
2359296000 bytes / 3384272 usecs = 680796 KB/s
71011 usecs to free memory
/ # usemem -a -n 1 $((2000 * 1024 * 1024))
2359296000 bytes / 3288668 usecs = 700587 KB/s
74503 usecs to free memory
/ # usemem -a -n 1 $((2000 * 1024 * 1024))
2359296000 bytes / 3402337 usecs = 677181 KB/s
142834 usecs to free memory
/ # usemem -a -n 1 $((2000 * 1024 * 1024))
2359296000 bytes / 3299039 usecs = 698385 KB/s
130385 usecs to free memory

Second, same test with zswap thp patch:
echo lz4 > /sys/module/zswap/parameters/compressor
echo zsmalloc > /sys/module/zswap/parameters/zpool
echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
echo 50 > /sys/module/zswap/parameters/max_pool_percent
echo 1 > /sys/module/zswap/parameters/enabled
swapon /swapfile
echo always > /sys/kernel/mm/transparent_hugepage/enabled
/ # usemem -a -n 1 $((2000 * 1024 * 1024))
2359296000 bytes / 2799385 usecs = 823037 KB/s
69978 usecs to free memory
/ # usemem -a -n 1 $((2000 * 1024 * 1024))
2359296000 bytes / 2794564 usecs = 824457 KB/s
69124 usecs to free memory
/ # usemem -a -n 1 $((2000 * 1024 * 1024))
2359296000 bytes / 3000326 usecs = 767916 KB/s
123705 usecs to free memory

You can see that let zswap handle zswap is faster.

Thanks,
Hui

>>
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>>   mm/zswap.c | 170 +++++++++++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 109 insertions(+), 61 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 46a3223..36aa10d 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -316,11 +316,7 @@ static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
>>          }
>>   }
>>
>> -/*
>> - * Carries out the common pattern of freeing and entry's zpool allocation,
>> - * freeing the entry itself, and decrementing the number of stored pages.
>> - */
>> -static void zswap_free_entry(struct zswap_entry *entry)
>> +static void zswap_free_entry_1(struct zswap_entry *entry)
>>   {
>>          if (!entry->length)
>>                  atomic_dec(&zswap_same_filled_pages);
>> @@ -329,6 +325,15 @@ static void zswap_free_entry(struct zswap_entry *entry)
>>                  zswap_pool_put(entry->pool);
>>          }
>>          zswap_entry_cache_free(entry);
>> +}
>> +
>> +/*
>> + * Carries out the common pattern of freeing and entry's zpool allocation,
>> + * freeing the entry itself, and decrementing the number of stored pages.
>> + */
>> +static void zswap_free_entry(struct zswap_entry *entry)
>> +{
>> +       zswap_free_entry_1(entry);
>>          atomic_dec(&zswap_stored_pages);
>>          zswap_update_total_size();
>>   }
>> @@ -980,15 +985,11 @@ static void zswap_fill_page(void *ptr, unsigned long value)
>>          memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>>   }
>>
>> -/*********************************
>> -* frontswap hooks
>> -**********************************/
>> -/* attempts to compress and store an single page */
>> -static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>> -                               struct page *page)
>> +static int zswap_frontswap_store_1(unsigned type, pgoff_t offset,
>> +                               struct page *page,
>> +                               struct zswap_entry **entry_pointer)
>>   {
>> -       struct zswap_tree *tree = zswap_trees[type];
>> -       struct zswap_entry *entry, *dupentry;
>> +       struct zswap_entry *entry;
>>          struct crypto_comp *tfm;
>>          int ret;
>>          unsigned int hlen, dlen = PAGE_SIZE;
>> @@ -998,36 +999,6 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>>          struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
>>          gfp_t gfp;
>>
>> -       /* THP isn't supported */
>> -       if (PageTransHuge(page)) {
>> -               ret = -EINVAL;
>> -               goto reject;
>> -       }
>> -
>> -       if (!zswap_enabled || !tree) {
>> -               ret = -ENODEV;
>> -               goto reject;
>> -       }
>> -
>> -       /* reclaim space if needed */
>> -       if (zswap_is_full()) {
>> -               zswap_pool_limit_hit++;
>> -               if (zswap_shrink()) {
>> -                       zswap_reject_reclaim_fail++;
>> -                       ret = -ENOMEM;
>> -                       goto reject;
>> -               }
>> -
>> -               /* A second zswap_is_full() check after
>> -                * zswap_shrink() to make sure it's now
>> -                * under the max_pool_percent
>> -                */
>> -               if (zswap_is_full()) {
>> -                       ret = -ENOMEM;
>> -                       goto reject;
>> -               }
>> -       }
>> -
>>          /* allocate entry */
>>          entry = zswap_entry_cache_alloc(GFP_KERNEL);
>>          if (!entry) {
>> @@ -1035,6 +1006,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>>                  ret = -ENOMEM;
>>                  goto reject;
>>          }
>> +       *entry_pointer = entry;
>>
>>          if (zswap_same_filled_pages_enabled) {
>>                  src = kmap_atomic(page);
>> @@ -1044,7 +1016,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>>                          entry->length = 0;
>>                          entry->value = value;
>>                          atomic_inc(&zswap_same_filled_pages);
>> -                       goto insert_entry;
>> +                       goto out;
>>                  }
>>                  kunmap_atomic(src);
>>          }
>> @@ -1093,31 +1065,105 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>>          entry->handle = handle;
>>          entry->length = dlen;
>>
>> -insert_entry:
>> +out:
>> +       return 0;
>> +
>> +put_dstmem:
>> +       put_cpu_var(zswap_dstmem);
>> +       zswap_pool_put(entry->pool);
>> +freepage:
>> +       zswap_entry_cache_free(entry);
>> +reject:
>> +       return ret;
>> +}
>> +
>> +/*********************************
>> +* frontswap hooks
>> +**********************************/
>> +/* attempts to compress and store an single page */
>> +static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>> +                               struct page *page)
>> +{
>> +       struct zswap_tree *tree = zswap_trees[type];
>> +       struct zswap_entry **entries = NULL, *dupentry;
>> +       struct zswap_entry *single_entry[1];
>> +       int ret;
>> +       int i, nr;
>> +
>> +       if (!zswap_enabled || !tree) {
>> +               ret = -ENODEV;
>> +               goto reject;
>> +       }
>> +
>> +       /* reclaim space if needed */
>> +       if (zswap_is_full()) {
>> +               zswap_pool_limit_hit++;
>> +               if (zswap_shrink()) {
>> +                       zswap_reject_reclaim_fail++;
>> +                       ret = -ENOMEM;
>> +                       goto reject;
>> +               }
>> +
>> +               /* A second zswap_is_full() check after
>> +                * zswap_shrink() to make sure it's now
>> +                * under the max_pool_percent
>> +                */
>> +               if (zswap_is_full()) {
>> +                       ret = -ENOMEM;
>> +                       goto reject;
>> +               }
>> +       }
>> +
>> +       nr = hpage_nr_pages(page);
>> +
>> +       if (unlikely(nr > 1)) {
>> +               entries = kvmalloc(sizeof(struct zswap_entry *) * nr,
>> +                               GFP_KERNEL);
>> +               if (!entries) {
>> +                       ret = -ENOMEM;
>> +                       goto reject;
>> +               }
>> +       } else
>> +               entries = single_entry;
>> +
>> +       for (i = 0; i < nr; i++) {
>> +               ret = zswap_frontswap_store_1(type, offset + i, page + i,
>> +                                       &entries[i]);
>> +               if (ret)
>> +                       goto freepage;
>> +       }
>> +
>>          /* map */
>>          spin_lock(&tree->lock);
>> -       do {
>> -               ret = zswap_rb_insert(&tree->rbroot, entry, &dupentry);
>> -               if (ret == -EEXIST) {
>> -                       zswap_duplicate_entry++;
>> -                       /* remove from rbtree */
>> -                       zswap_rb_erase(&tree->rbroot, dupentry);
>> -                       zswap_entry_put(tree, dupentry);
>> -               }
>> -       } while (ret == -EEXIST);
>> +       for (i = 0; i < nr; i++) {
>> +               do {
>> +                       ret = zswap_rb_insert(&tree->rbroot, entries[i],
>> +                                       &dupentry);
>> +                       if (ret == -EEXIST) {
>> +                               zswap_duplicate_entry++;
>> +                               /* remove from rbtree */
>> +                               zswap_rb_erase(&tree->rbroot, dupentry);
>> +                               zswap_entry_put(tree, dupentry);
>> +                       }
>> +               } while (ret == -EEXIST);
>> +       }
>>          spin_unlock(&tree->lock);
>>
>>          /* update stats */
>> -       atomic_inc(&zswap_stored_pages);
>> +       atomic_add(nr, &zswap_stored_pages);
>>          zswap_update_total_size();
>>
>> -       return 0;
>> -
>> -put_dstmem:
>> -       put_cpu_var(zswap_dstmem);
>> -       zswap_pool_put(entry->pool);
>> +       ret = 0;
>>   freepage:
>> -       zswap_entry_cache_free(entry);
>> +       if (unlikely(nr > 1)) {
>> +               if (ret) {
>> +                       int j;
>> +
>> +                       for (j = 0; j < i; j++)
>> +                               zswap_free_entry_1(entries[j]);
>> +               }
>> +               kvfree(entries);
>> +       }
>>   reject:
>>          return ret;
>>   }
>> @@ -1136,6 +1182,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>>          unsigned int dlen;
>>          int ret;
>>
>> +       BUG_ON(PageTransHuge(page));
>> +
>>          /* find */
>>          spin_lock(&tree->lock);
>>          entry = zswap_entry_find_get(&tree->rbroot, offset);
>> --
>> 2.7.4
>>
