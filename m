Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B67C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D66217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633974AbfIYGFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633961AbfIYGFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:05:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A88A306F4AE;
        Wed, 25 Sep 2019 06:05:42 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-181.pek2.redhat.com [10.72.12.181])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF1745D9D3;
        Wed, 25 Sep 2019 06:05:36 +0000 (UTC)
Date:   Wed, 25 Sep 2019 14:05:33 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 13/17] kexec: add machine_kexec_post_load()
Message-ID: <20190925060533.GB30921@dhcp-128-65.nay.redhat.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
 <20190923203427.294286-14-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923203427.294286-14-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 25 Sep 2019 06:05:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/23/19 at 04:34pm, Pavel Tatashin wrote:
> It is the same as machine_kexec_prepare(), but is called after segments are
> loaded. This way, can do processing work with already loaded relocation
> segments. One such example is arm64: it has to have segments loaded in
> order to create a page table, but it cannot do it during kexec time,
> because at that time allocations won't be possible anymore.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/kexec.c          | 4 ++++
>  kernel/kexec_core.c     | 6 ++++++
>  kernel/kexec_file.c     | 4 ++++
>  kernel/kexec_internal.h | 2 ++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 1b018f1a6e0d..27b71dc7b35a 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -159,6 +159,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  
>  	kimage_terminate(image);
>  
> +	ret = machine_kexec_post_load(image);
> +	if (ret)
> +		goto out;
> +
>  	/* Install the new kernel and uninstall the old */
>  	image = xchg(dest_image, image);
>  
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 2c5b72863b7b..8360645d1bbe 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -587,6 +587,12 @@ static void kimage_free_extra_pages(struct kimage *image)
>  	kimage_free_page_list(&image->unusable_pages);
>  
>  }
> +
> +int __weak machine_kexec_post_load(struct kimage *image)
> +{
> +	return 0;
> +}
> +
>  void kimage_terminate(struct kimage *image)
>  {
>  	if (*image->entry != 0)
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b8cc032d5620..cb531d768114 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -391,6 +391,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  
>  	kimage_terminate(image);
>  
> +	ret = machine_kexec_post_load(image);
> +	if (ret)
> +		goto out;
> +
>  	/*
>  	 * Free up any temporary buffers allocated which are not needed
>  	 * after image has been loaded
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 48aaf2ac0d0d..39d30ccf8d87 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -13,6 +13,8 @@ void kimage_terminate(struct kimage *image);
>  int kimage_is_destination_range(struct kimage *image,
>  				unsigned long start, unsigned long end);
>  
> +int machine_kexec_post_load(struct kimage *image);
> +
>  extern struct mutex kexec_mutex;
>  
>  #ifdef CONFIG_KEXEC_FILE
> -- 
> 2.23.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
