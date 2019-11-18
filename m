Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8775C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E2920718
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfKRDyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 22:54:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:27563 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfKRDyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:54:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 19:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,318,1569308400"; 
   d="scan'208";a="258292816"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Nov 2019 19:54:21 -0800
Message-ID: <5DD21784.8020506@intel.com>
Date:   Mon, 18 Nov 2019 12:01:08 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Khazhismel Kumykov <khazhy@google.com>, mst@redhat.com,
        jasowang@redhat.com
CC:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_balloon: fix shrinker pages_to_free calculation
References: <20191115225557.61847-1-khazhy@google.com>
In-Reply-To: <20191115225557.61847-1-khazhy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2019 06:55 AM, Khazhismel Kumykov wrote:
> To my reading, we're accumulating total freed pages in pages_freed, but
> subtracting it every iteration from pages_to_free, meaning we'll count
> earlier iterations multiple times, freeing fewer pages than expected.
> Just accumulate in pages_freed, and compare to pages_to_free.

Not sure about the above. But the following unit mismatch is a good 
capture, thanks!

>
> There's also a unit mismatch, where pages_to_free seems to be virtio
> balloon pages, and pages_freed is system pages (We divide by
> VIRTIO_BALLOON_PAGES_PER_PAGE), so sutracting pages_freed from
> pages_to_free may result in freeing too much.
>
> There also seems to be a mismatch between shrink_free_pages() and
> shrink_balloon_pages(), where in both pages_to_free is given as # of
> virtio pages to free, but free_pages() returns virtio pages, and
> balloon_pages returns system pages.
>
> (For 4K PAGE_SIZE, this mismatch wouldn't be noticed since
> VIRTIO_BALLOON_PAGES_PER_PAGE would be 1)
>
> Have both return virtio pages, and divide into system pages when
> returning from shrinker_scan()

Sounds good.

>
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>
> Tested this under memory pressure conditions and the shrinker seemed to
> shrink.
>
>   drivers/virtio/virtio_balloon.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 226fbb995fb0..7951ece3fe24 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -782,11 +782,8 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>   	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
>   	 * multiple times to deflate pages till reaching pages_to_free.
>   	 */
> -	while (vb->num_pages && pages_to_free) {
> -		pages_freed += leak_balloon(vb, pages_to_free) /
> -					VIRTIO_BALLOON_PAGES_PER_PAGE;
> -		pages_to_free -= pages_freed;
> -	}
> +	while (vb->num_pages && pages_to_free > pages_freed)
> +		pages_freed += leak_balloon(vb, pages_to_free - pages_freed);
>   	update_balloon_size(vb);
>   
>   	return pages_freed;
> @@ -805,11 +802,11 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
>   		pages_freed = shrink_free_pages(vb, pages_to_free);

We also need a fix here then:

pages_freed = shrink_free_pages(vb, sc->nr_to_scan) * 
VIRTIO_BALLOON_PAGES_PER_PAGE;


Btw, there is another mistake, in virtio_balloon_shrinker_count:

-       count += vb->num_free_page_blocks >> VIRTIO_BALLOON_FREE_PAGE_ORDER;
+      count += vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_ORDER;

You may want to include it in this fix patch as well.

Best,
Wei


