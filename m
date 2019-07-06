Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08981C48BD3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62AC20843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cmJgo3I5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfGFPcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:32:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41944 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfGFPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q/Uw5dIsHFTudDNvgVGgrJz9lD9sd+Kaa8O2sHnXsmw=; b=cmJgo3I5TzZVReZe18xORp8oxP
        VXY4xNfqtX2mnXvoN/6ZEpFJNjR9dviNSO7LpOBOvXrbcTA9HelIkGn2GEfsOomvE11BQ3jWcK4Ng
        igvVajyszClx57PmbMHN/yeS3vriO30/nDt2jk/M11usjctitA7eVWBJPGE7eglxLDy738JqLqM93
        E0jRy/EdKzzOr0Vie7pv4vCQjYbGTyIVL23duY59LFdKPtiT0J7mmWXCWTUTtsQMGuCsaS2jxcHsC
        W+5Gys7PPNHitASuKSwYx5KvL32myUym+NFbDVrTIne5ykAP5n0trGhDacbe/h+B2QN17BBiPExzb
        5edt6X1w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjmfQ-00017D-Aw; Sat, 06 Jul 2019 15:32:00 +0000
Subject: Re: [PATCH v5 08/12] S.A.R.A.: trampoline emulation
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-9-git-send-email-s.mesoraca16@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <28431b5d-c34c-a54b-acbf-70d1ae635e0d@infradead.org>
Date:   Sat, 6 Jul 2019 08:31:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562410493-8661-9-git-send-email-s.mesoraca16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/19 3:54 AM, Salvatore Mesoraca wrote:
> diff --git a/security/sara/Kconfig b/security/sara/Kconfig
> index 54a96e0..458e0e8 100644
> --- a/security/sara/Kconfig
> +++ b/security/sara/Kconfig
> @@ -117,6 +117,24 @@ choice
>  		  Documentation/admin-guide/LSM/SARA.rst.
>  endchoice
>  
> +config SECURITY_SARA_WXPROT_EMUTRAMP
> +	bool "Enable emulation for some types of trampolines"
> +	depends on SECURITY_SARA_WXPROT
> +	depends on ARCH_HAS_LSM_PAGEFAULT
> +	depends on X86
> +	default y
> +	help
> +	  Some programs and libraries need to execute special small code
> +	  snippets from non-executable memory pages.
> +	  Most notable examples are the GCC and libffi trampolines.
> +	  This features make it possible to execute those trampolines even

	  This feature makes it possible

> +	  if they reside in non-executable memory pages.
> +	  This features need to be enabled on a per-executable basis

	  This feature needs to be

> +	  via user-space utilities.
> +	  See Documentation/admin-guide/LSM/SARA.rst. for further information.
> +
> +	  If unsure, answer y.
> +
>  config SECURITY_SARA_WXPROT_DISABLED
>  	bool "WX protection will be disabled at boot."
>  	depends on SECURITY_SARA_WXPROT


-- 
~Randy
