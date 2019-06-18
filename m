Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472E5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98920679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="enFM3kbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfFRHKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:10:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37148 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRHKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:10:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so11979573ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BTHcQlnyDBrk/vVKoZFXaiXG2jLN3xgAFU0JZm+aOTY=;
        b=enFM3kbmp1oC0J1f6YVid+ZHzKwUdS3x2SVbP2CvT6VpLQ9fXL+v+nPWfQSoZmay5M
         lIOkbR/EXN1IID9938V6Qwo2Ji2zL4T5v8Ye5iGraaJyc2qSzLAE5dbuUmFd/2hHhrzO
         OBys/8aTUL8b0sN912nC7nI13tJJcX8EFuWYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BTHcQlnyDBrk/vVKoZFXaiXG2jLN3xgAFU0JZm+aOTY=;
        b=rdiDolyLzjHsjO3tfa0sXRt7EE2uIH+NVD1d5uWZ2Q2SaYPI7G9cm+18jC7SqUnqJD
         Id4VAV5t2MKY4wMCKl1//T/TbvpwX0QLnA+eRd8pq3Ne+bg94v+kwSyofGvcvnQevZDp
         AwglDjCPa01Uaa0t7vSc/qR39/v1JB/NDOxadG9sSpYzboOOEWT49F5Cmd9hmJMkjosD
         mki8iyuM83bwWAIWICz0VAxeXbBAitqAvCWGXfxLg167REDr6+QkL0/GPlX9seOCiF4U
         bSXl7beOxafFrrOpDRMjlw7w7bERWabZp2Pa5hVbJToSaVD6HTJV8YZCLKeK9HNObDW1
         ZIZg==
X-Gm-Message-State: APjAAAWRfDdyxnZXGMtFz4xzM0Pou1h8blHnAjXgoOhppUublixYREzy
        6cMaUxoeND9K98BCPqrY4rXFlqdeDHtGD4I2
X-Google-Smtp-Source: APXvYqxTuNWS0lSbNyN4XFV77XPgYGYxMNIQOVrttk/90SBJAHeqhfEiimkkJqs5HcCJp16RNDfWhA==
X-Received: by 2002:a2e:8892:: with SMTP id k18mr15855620lji.239.1560841815348;
        Tue, 18 Jun 2019 00:10:15 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v17sm2769055ljg.36.2019.06.18.00.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 00:10:14 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] lkdtm: Check for SMEP clearing protections
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20190618045503.39105-1-keescook@chromium.org>
 <20190618045503.39105-2-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <580611da-fd97-e82e-b604-581f105416ee@rasmusvillemoes.dk>
Date:   Tue, 18 Jun 2019 09:10:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618045503.39105-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 06.55, Kees Cook wrote:

> +#else
> +	pr_err("FAIL: this test is x86_64-only\n");
> +#endif
> +}

Why expose it at all on all other architectures? If you wrap the
CRASHTYPE() in an #ifdef, you can also guard the whole lkdtm_UNSET_SMEP
definition (the declaration in lkdtm.h can stay, possibly with a comment
saying /* x86-64 only */).

> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index b51cf182b031..58cfd713f8dc 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -123,6 +123,7 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(CORRUPT_LIST_ADD),
>  	CRASHTYPE(CORRUPT_LIST_DEL),
>  	CRASHTYPE(CORRUPT_USER_DS),
> +	CRASHTYPE(UNSET_SMEP),
>  	CRASHTYPE(CORRUPT_STACK),
>  	CRASHTYPE(CORRUPT_STACK_STRONG),
>  	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index b69ee004a3f7..d7eb5a8f1da4 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -26,6 +26,7 @@ void lkdtm_CORRUPT_LIST_DEL(void);
>  void lkdtm_CORRUPT_USER_DS(void);
>  void lkdtm_STACK_GUARD_PAGE_LEADING(void);
>  void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
> +void lkdtm_UNSET_SMEP(void);
>  
>  /* lkdtm_heap.c */
>  void lkdtm_OVERWRITE_ALLOCATION(void);
Rasmus
