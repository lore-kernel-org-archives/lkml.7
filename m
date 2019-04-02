Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8138AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4421420700
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NRCuIUie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDBErN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:47:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBErN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aMPPfj5JnNOQrKOZmzKYJq4pNGTHYuLUKAkg9cwvBis=; b=NRCuIUie73WIwB+IKHA2kfPsR
        1eEMLtiJ3mtAnHhDZQsGtDIBPSMouSt0UyL1OroZVOZAIqEfcyfcEZPzolQxhgwsNoYw0ww6HPC5+
        DwIVi5CXoyDsMzHcqwvY2isfTCbbTLyCMVCItkXkL+IGN3IqN3e6o19k5PMYkji4x//9XR8dlnqoz
        As9BU9+ORPZkUFrxRbkIFXqAYL2y1/279CRlF+O73Ub7YK4mfvfs086c6ZEOlGeBtikouVur8eF6k
        7CNBabBO54kv6KMQFeBLDg/4djZb+HQYLBdr1oJjYMuN7nfb0L1AdxMPBy7sXemTqF6rNjvqrj3Ez
        NXTBQRcxg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBBKJ-00007H-9Z; Tue, 02 Apr 2019 04:47:11 +0000
Subject: Re: [PATCH v3] gcov: fix when CONFIG_MODULES is not set
To:     trong@android.com, oberpar@linux.ibm.com, akpm@linux-foundation.org
Cc:     ndesaulniers@google.com, ghackmann@android.com, linux-mm@kvack.org,
        kbuild-all@01.org, lkp@intel.com, linux-kernel@vger.kernel.org
References: <20190402030956.48166-1-trong@android.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef2492c2-2b30-b431-3aaa-33b619a2e1d3@infradead.org>
Date:   Mon, 1 Apr 2019 21:47:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402030956.48166-1-trong@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 8:09 PM, trong@android.com wrote:
> From: Tri Vo <trong@android.com>
> 
> Fixes: 8c3d220cb6b5 ("gcov: clang support")
> 
> Cc: Greg Hackmann <ghackmann@android.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-mm@kvack.org
> Cc: kbuild-all@01.org
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Tri Vo <trong@android.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  kernel/gcov/clang.c   | 4 ++++
>  kernel/gcov/gcc_3_4.c | 4 ++++
>  kernel/gcov/gcc_4_7.c | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index 125c50397ba2..cfb9ce5e0fed 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -223,7 +223,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
>   */
>  bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
>  {
> +#ifdef CONFIG_MODULES
>  	return within_module((unsigned long)info->filename, mod);
> +#else
> +	return false;
> +#endif
>  }
>  
>  /* Symbolic links to be created for each profiling data file. */
> diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
> index 801ee4b0b969..8fc30f178351 100644
> --- a/kernel/gcov/gcc_3_4.c
> +++ b/kernel/gcov/gcc_3_4.c
> @@ -146,7 +146,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
>   */
>  bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
>  {
> +#ifdef CONFIG_MODULES
>  	return within_module((unsigned long)info, mod);
> +#else
> +	return false;
> +#endif
>  }
>  
>  /* Symbolic links to be created for each profiling data file. */
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index ec37563674d6..0b6886d4a4dd 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -159,7 +159,11 @@ void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
>   */
>  bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
>  {
> +#ifdef CONFIG_MODULES
>  	return within_module((unsigned long)info, mod);
> +#else
> +	return false;
> +#endif
>  }
>  
>  /* Symbolic links to be created for each profiling data file. */
> 


-- 
~Randy
