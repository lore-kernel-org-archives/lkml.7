Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44310C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FB12067C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbJQMj6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfLRAO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:14:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38843 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRAO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:14:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so165926pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QySu5AL4vmDfm5xadll7zClUUSNeDPk2VDOL+wriQso=;
        b=PbJQMj6s8UDceq4fX78w3HBESE1jt/gjDcTA/IbIMqODLk2ua2SYiUyZtq6Lgqdqk5
         zhAH2Jg3Sh4ZeZ/U25OQSHTCh0eJnSGdSkvkDZ9Ce57bW/sXnq3Iub9gk05mEDiAPP4b
         41gSu+EOMa/I+Pdj3yAubRsaeeeS/fGyTdbxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QySu5AL4vmDfm5xadll7zClUUSNeDPk2VDOL+wriQso=;
        b=P+PWCpVa6Uif1j9J6z6gFjwULcdpGdT0czZzXcZIInKooGF6O8wdNJ7iGc5nKZPLLe
         jror3Z+eHZu8tZoFwkW8S3fRXMc7pdq9hGgzyqoe1n/PnpMY8lFgVnddTg8dWIeL4QKV
         aE4Z9iEkxPfNG4Ab+3Cracp5rKnLtILBOoCcSQcrVaTj3o6I+u4S4MCYjTKm/pjcCze1
         q/lxL2L16YvGe+77O9FFw+JFr9NJMonxgG/Zsb7eiln8rissPUjKBQgKZ6pnlDuYD7Zq
         t2kQwXBhYdIrjLsaVu9IS+BbjgVz5GBTYqSkFI7UytTrodsO/XbxTvG1uMQFSPhjGqjD
         w6sA==
X-Gm-Message-State: APjAAAX9J966TxKhvBMqdf2h8NpRFiAwH12T0FhZgFT6ShvTaas/u6Xf
        m5WyH6Ic/ZMEn6BlT9r4ufhjMw==
X-Google-Smtp-Source: APXvYqzXKaqFrpOCj80Rh9+nv8sotyqQ0zkCmoXkrbR2mi1RSKnpa0m7As9aDsEhoUgKHuvXX2uBeA==
X-Received: by 2002:a63:941:: with SMTP id 62mr101267pgj.203.1576628098553;
        Tue, 17 Dec 2019 16:14:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g10sm157229pgh.35.2019.12.17.16.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:14:57 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:14:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH v1] lkdtm/bugs: fix build error in lkdtm_UNSET_SMEP
Message-ID: <201912171613.454319D@keescook>
References: <20191213003522.66450-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191213003522.66450-1-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 04:35:22PM -0800, Brendan Higgins wrote:
> When building ARCH=um with CONFIG_UML_X86=y and CONFIG_64BIT=y we get
> the build errors:
> 
> drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_UNSET_SMEP’:
> drivers/misc/lkdtm/bugs.c:288:8: error: implicit declaration of function ‘native_read_cr4’ [-Werror=implicit-function-declaration]
>   cr4 = native_read_cr4();
>         ^~~~~~~~~~~~~~~
> drivers/misc/lkdtm/bugs.c:290:13: error: ‘X86_CR4_SMEP’ undeclared (first use in this function); did you mean ‘X86_FEATURE_SMEP’?
>   if ((cr4 & X86_CR4_SMEP) != X86_CR4_SMEP) {
>              ^~~~~~~~~~~~
>              X86_FEATURE_SMEP
> drivers/misc/lkdtm/bugs.c:290:13: note: each undeclared identifier is reported only once for each function it appears in
> drivers/misc/lkdtm/bugs.c:297:2: error: implicit declaration of function ‘native_write_cr4’; did you mean ‘direct_write_cr4’? [-Werror=implicit-function-declaration]
>   native_write_cr4(cr4);
>   ^~~~~~~~~~~~~~~~
>   direct_write_cr4
> 
> So specify that this block of code should only build when
> CONFIG_X86_64=y *AND* CONFIG_UML is unset.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for catching this! Is a similar marking needed for the recently
added lkdtm_DOUBLE_FAULT() when using UML on 32-bit?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> 
> This patch is part of my larger effort to get allyesconfig closer to
> working for ARCH=um. For more information about that, checkout the cover
> letter for a related patchset here:
> 
> https://lore.kernel.org/lkml/20191211192742.95699-1-brendanhiggins@google.com/
> 
> ---
>  drivers/misc/lkdtm/bugs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index a4fdad04809a9..6c1aab177fced 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -278,7 +278,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
>  
>  void lkdtm_UNSET_SMEP(void)
>  {
> -#ifdef CONFIG_X86_64
> +#if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
>  #define MOV_CR4_DEPTH	64
>  	void (*direct_write_cr4)(unsigned long val);
>  	unsigned char *insn;
> -- 
> 2.24.1.735.g03f4e72817-goog
> 

-- 
Kees Cook
