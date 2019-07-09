Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39BC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B8D21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fVEQecKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGIOyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:54:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGIOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=weOuI78HmXrJES/Fz6rOOsfYQ8aeJH/DEMsQ8pHbDzg=; b=fVEQecKj8xz460Juv5NaWWdQn
        puVmwf1WuTljW4yGPmaJqQ00rUv1OejZbtUmMe4zTE4RBXUo3svipzq0y9oQHYq3di6x0m1GWc262
        ukf9I2Oa0MOfN5wnaMZe6X7mm7k1e9QKD9slqq7JQnuVCL4plSLFuZNvb3mNOo8eBPJLs7Sxq4auu
        SprOfMUiWjRi7ZLLWR1Fv/hLnHxJttFd4/42UjTH3YKnygCOvwdPAf1moFk1se1qeOnjznWe7DDhq
        qB5uAR6SZDyHxjTkkmWZ0eoVkarCENtFNBMaThQ1u7NjT3yUORJjCX/vLXJeQjKbcBnuuaYi9sYRK
        rW+EiVb8w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkrVP-0000De-BE; Tue, 09 Jul 2019 14:54:07 +0000
Subject: Re: [PATCH 1/4] Makefile: rules for printing kernel architecture and
 localversion
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        apw@canonical.com, joe@perches.com, linux-kbuild@vger.kernel.org,
        linux-riscv@lists.infradead.org, clang-built-linux@googlegroups.com
References: <1562664759-16009-1-git-send-email-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3d4da301-618e-e348-2a6a-144b802d240f@infradead.org>
Date:   Tue, 9 Jul 2019 07:54:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562664759-16009-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/19 2:32 AM, Enrico Weigelt, metux IT consult wrote:
> trivial rule to print out the kernel arch and localversion, so
> external tools, like distro packagers, can easily get it.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Hi,
If accepted, these targets should be added to the top level Makefile's
"make help" output also.

Thanks.

> ---
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 3e4868a..5afc3de 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1706,6 +1706,12 @@ kernelrelease:
>  kernelversion:
>  	@echo $(KERNELVERSION)
>  
> +kernellocalversion:
> +	@$(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree) | sed -e 's~^\-~~'
> +
> +kernelarch:
> +	@echo $(ARCH)
> +
>  image_name:
>  	@echo $(KBUILD_IMAGE)
>  
> 


-- 
~Randy
