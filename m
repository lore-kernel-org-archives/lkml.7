Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA570C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D742147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfHFJ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfHFJ0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:26:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23E24C008621;
        Tue,  6 Aug 2019 09:26:52 +0000 (UTC)
Received: from [10.36.117.71] (ovpn-117-71.ams2.redhat.com [10.36.117.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E2705D704;
        Tue,  6 Aug 2019 09:26:50 +0000 (UTC)
Subject: Re: [PATCH v1] driver/base/memory.c: Validate memory block size early
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190806090142.22709-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <74d3653a-59cd-15c8-4a11-13f57060ad2c@redhat.com>
Date:   Tue, 6 Aug 2019 11:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190806090142.22709-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 06 Aug 2019 09:26:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.19 11:01, David Hildenbrand wrote:

"s/driver/drivers/" in subject.

I think long term, we should move the whole memory block size
configuration (set_memory_block_size_order() and
memory_block_size_bytes()) into drivers/base/memory.c.

> Let's validate the memory block size early, when initializing the
> memory device infrastructure. Fail hard in case the value is not
> suitable.
> 
> As nobody checks the return value of memory_dev_init(), turn it into a
> void function and fail with a panic in all scenarios instead. Otherwise,
> we'll crash later during boot when core/drivers expect that the memory
> device infrastructure (including memory_block_size_bytes()) works as
> expected.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c  | 31 +++++++++----------------------
>  include/linux/memory.h |  6 +++---
>  2 files changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 790b3bcd63a6..6bea4f3f8040 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -100,21 +100,6 @@ unsigned long __weak memory_block_size_bytes(void)
>  }
>  EXPORT_SYMBOL_GPL(memory_block_size_bytes);
>  
> -static unsigned long get_memory_block_size(void)
> -{
> -	unsigned long block_sz;
> -
> -	block_sz = memory_block_size_bytes();
> -
> -	/* Validate blk_sz is a power of 2 and not less than section size */
> -	if ((block_sz & (block_sz - 1)) || (block_sz < MIN_MEMORY_BLOCK_SIZE)) {
> -		WARN_ON(1);
> -		block_sz = MIN_MEMORY_BLOCK_SIZE;
> -	}
> -
> -	return block_sz;
> -}
> -
>  /*
>   * Show the first physical section index (number) of this memory block.
>   */
> @@ -461,7 +446,7 @@ static DEVICE_ATTR_RO(removable);
>  static ssize_t block_size_bytes_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%lx\n", get_memory_block_size());
> +	return sprintf(buf, "%lx\n", memory_block_size_bytes());
>  }
>  
>  static DEVICE_ATTR_RO(block_size_bytes);
> @@ -811,19 +796,22 @@ static const struct attribute_group *memory_root_attr_groups[] = {
>  /*
>   * Initialize the sysfs support for memory devices...
>   */
> -int __init memory_dev_init(void)
> +void __init memory_dev_init(void)
>  {
>  	int ret;
>  	int err;
>  	unsigned long block_sz, nr;
>  
> +	/* Validate the configured memory block size */
> +	block_sz = memory_block_size_bytes();
> +	if (!is_power_of_2(block_sz) || block_sz < MIN_MEMORY_BLOCK_SIZE)
> +		panic("Memory block size not suitable: 0x%lx\n", block_sz);
> +	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
> +
>  	ret = subsys_system_register(&memory_subsys, memory_root_attr_groups);
>  	if (ret)
>  		goto out;
>  
> -	block_sz = get_memory_block_size();
> -	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
> -
>  	/*
>  	 * Create entries for memory sections that were found
>  	 * during boot and have been initialized
> @@ -839,8 +827,7 @@ int __init memory_dev_init(void)
>  
>  out:
>  	if (ret)
> -		printk(KERN_ERR "%s() failed: %d\n", __func__, ret);
> -	return ret;
> +		panic("%s() failed: %d\n", __func__, ret);
>  }
>  
>  /**
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 704215d7258a..0ebb105eb261 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -79,9 +79,9 @@ struct mem_section;
>  #define IPC_CALLBACK_PRI        10
>  
>  #ifndef CONFIG_MEMORY_HOTPLUG_SPARSE
> -static inline int memory_dev_init(void)
> +static inline void memory_dev_init(void)
>  {
> -	return 0;
> +	return;
>  }
>  static inline int register_memory_notifier(struct notifier_block *nb)
>  {
> @@ -112,7 +112,7 @@ extern int register_memory_isolate_notifier(struct notifier_block *nb);
>  extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
>  int create_memory_block_devices(unsigned long start, unsigned long size);
>  void remove_memory_block_devices(unsigned long start, unsigned long size);
> -extern int memory_dev_init(void);
> +extern void memory_dev_init(void);
>  extern int memory_notify(unsigned long val, void *v);
>  extern int memory_isolate_notify(unsigned long val, void *v);
>  extern struct memory_block *find_memory_block(struct mem_section *);
> 


-- 

Thanks,

David / dhildenb
