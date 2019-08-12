Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1264C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FE82067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fD5g47S8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfHLReU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:34:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33446 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfHLReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:34:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so50038400pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYWUhLUhFWFaj2IBlyeqpyuiKYe3byR6cuy6O3+sAu0=;
        b=fD5g47S8va3cncoYwUYSfFVsmYgZaWoR2hcX0eKKr+lM5nS0EMz/ThVSf72l3/xsfD
         h4IlLKwvYcz9v/Oaar90eFTbIZObIY1NtQQTMtlIOPsoS+d/Hr8jTEWOrWaBCOZy1F7X
         W4A6Isn4U+hPtfj0YcYUWhMCB7VYTpU36Nevk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYWUhLUhFWFaj2IBlyeqpyuiKYe3byR6cuy6O3+sAu0=;
        b=Mw8hQIgwcgz4hOdEo8/o/341wmzxgDTPj4/BEn9pYCdTQsRlcTpkNSojcShRo7aSuX
         gewfajytfQ4CXZAmdxAKshzE0yxukBqX/Ww2DlYpKCEm8JeqOSO3Zi1i+87cC5iOwmVM
         7xLoynmVY7Mu7HL1OUUtWI/Vuzeo0WUAgtsFB2sbxFpU9FcsIksbYHbfk4wrMFq1mwow
         N9UA0K2JXdwk5v/L8Ri0uJKB7SnYuc5N1ulK651fmx26Stt0v0/5cDYL3KVRjlx/+R3A
         YltEh8HBqNDFFdqe+Ng1jUyICpBwwr4ZbEvB2f9RDaWwijOjxGuHGyOc9LksKGm58Vsk
         0S/g==
X-Gm-Message-State: APjAAAVALKaIWRldgVeamLAT9KBtRSqKk4VkDY9e8RWQPnv5eBt1E/Ox
        erSHMXoloXG4J7f+X9shnxBiIiZFqRg=
X-Google-Smtp-Source: APXvYqy7nuO9ZhZSKKRKRLzTnBsZpSlU4CtfOGJO2cEtb5hebTjlSiZu4egZRrDRFERHPfcTBeSvxw==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr30385877pgd.394.1565631259650;
        Mon, 12 Aug 2019 10:34:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g11sm117389053pgu.11.2019.08.12.10.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 10:34:19 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:34:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Morris <jmorris@namei.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: linux-next: build failure after merge of the security tree
Message-ID: <201908121033.BFBE9516AC@keescook>
References: <20190812145823.63d77573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812145823.63d77573@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:58:23PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the security tree, today's linux-next build (arm
> multi_v7_defconfig) failed like below.
> 
> Caused by commit
> 
>   45d29f9e9b8b ("security: Support early LSMs")
> 
> I have added the following fix for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 12 Aug 2019 14:54:20 +1000
> Subject: [PATCH] early_security_init() needs a stub got !CONFIG_SECURITY
> 
> An arm multi_v7_defconfig fails like this:
> 
> init/main.c: In function 'start_kernel':
> init/main.c:596:2: error: implicit declaration of function 'early_security_init'; did you mean 'security_init'? [-Werror=implicit-function-declaration]
>   early_security_init();
>   ^~~~~~~~~~~~~~~~~~~
>   security_init
> 
> Fixes: 45d29f9e9b8b ("security: Support early LSMs")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 807dc0d24982..23e1c3f17d48 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -473,6 +473,11 @@ static inline int security_init(void)
>  	return 0;
>  }
>  
> +static inline int early_security_init(void)
> +{
> +	return 0;
> +}
> +
>  static inline int security_binder_set_context_mgr(struct task_struct *mgr)
>  {
>  	return 0;
> -- 
> 2.20.1
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Kees Cook
