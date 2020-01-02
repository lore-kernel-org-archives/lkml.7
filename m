Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137B5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89F321D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rHrqP0Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgABJgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:36:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbgABJga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:36:30 -0500
Received: from zn.tnic (p200300EC2F00E700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F0D71EC0985;
        Thu,  2 Jan 2020 10:36:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577957789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PKlSqyafL8AIli9grc9nmm6pWL3gqihT01Q5F/Gkd60=;
        b=rHrqP0Mq1OZ8i1Psi4Qnc1aCeHYfhpBqzAKFINIA59LxPob+RM8kokTCO1iCXZL44wsdcX
        LjCb1PJetGD8jJAnqjw/fh35xLLzrDJPXvy82v0yXr72P2b4tm2ujat19ygqE+qiqnANIX
        TmgLHkxykI4CkaG086QHeAXXw47jTMs=
Date:   Thu, 2 Jan 2020 10:36:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/jump_label: Fix old-style declaration
Message-ID: <20200102093627.GB8345@zn.tnic>
References: <20191225114500.7712-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191225114500.7712-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 07:45:00PM +0800, YueHaibing wrote:
> Fix gcc warning:
> 
> arch/x86/kernel/jump_label.c:61:1: warning:
>  inline is not at beginning of declaration [-Wold-style-declaration]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/x86/kernel/jump_label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index 9c4498e..5ba8477 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -58,7 +58,7 @@ __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type,
>  	return code;
>  }
>  
> -static void inline __jump_label_transform(struct jump_entry *entry,
> +static inline void __jump_label_transform(struct jump_entry *entry,
>  					  enum jump_label_type type,
>  					  int init)
>  {
> -- 

Looks not needed anymore:

$ test-apply.sh /tmp/yuehaibing.01
checking file arch/x86/kernel/jump_label.c
Hunk #1 FAILED at 58.
1 out of 1 hunk FAILED
Apply? (y/n) n
--merge? (y/n) y
patching file arch/x86/kernel/jump_label.c
Hunk #1 NOT MERGED at 67-71.
$ git diff
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index c1a8b9e71408..0a9e1dc65a3f 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -64,7 +64,11 @@ static void __jump_label_set_jump_code(struct jump_entry *entry,
                memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
 }
 
+<<<<<<<
 static void __ref __jump_label_transform(struct jump_entry *entry,
+=======
+static inline void __jump_label_transform(struct jump_entry *entry,
+>>>>>>>
                                         enum jump_label_type type,
                                         int init)
 {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
