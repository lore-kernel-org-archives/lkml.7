Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C68C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DEA20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOibXhuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgAGOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:22:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54119 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgAGOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:22:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so19148143wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wk7NHZalQZ1UjOdJ8ZWvs/hit0iBCMoY2txpdTCN4GQ=;
        b=fOibXhuSieWvb1qUSapgehbecao5J/gPeNA0kLDDfZmrbYPPhL4ghZM8ihMRDxCtfD
         hP4UHcJe4OnhyyIvWr7DOKaslMnYgYEUkg3XQF9IQAYJ8SiOlav3hU6xW1JtS6IWPegc
         auKUrZqLnO7SD7eGIrPlN91wfCe5JFct8BxtCqHdDGSCaD34ikfAh+tRc9FPFbNq/c83
         ApktI5Tm4RFTp3cEDaKD6cPoSnkKTRYA4VDeefjRxSFcCwgn00X/29zsvxnisYQol9Jo
         qf8+piYW8epV8G8RCEwhRPX9wVh6ZVLUqdkpPB8Y3AS2Ue/AiowrUH+N7IgbbWGjJYxV
         Repw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wk7NHZalQZ1UjOdJ8ZWvs/hit0iBCMoY2txpdTCN4GQ=;
        b=pPSjxlMAhOJE72GONxfJWLiv27bZvRoRv+pDpi/7nG0M5EP43R+3VFCjDDSaggqHut
         tIY2OPNG2Ihv8R6J7Y9axMW8CcxablUBxTKmk3IaGYeO6jPNULyo5R4NHtI+4HV+JVYs
         UExbZrOMuaqzLh8HB/dwTt5YesGEpL/zZWR9YLxpv3u8kNcacM6c7ufa/JM+bZSnegRT
         6Cx5e9SzgdQyrw/q2+Qr7RrhSsyVsisGk6tUbFOjXGkKd8KHwrBVNwPQBPZVKFzPIdWI
         Ki5q4j8+yywcnSN1NkqgoGDIerSXLJCLxF7dBlO6S0hJNLqJh83eiv3sWjL1kvLXQoAd
         vMww==
X-Gm-Message-State: APjAAAUVCF9UVy6BOkwADq8gG4Ebr48dwpFZwN79RX5cr4Mq4j6fjaFx
        Z68IehxGkFlXOZYbFQ5+5ubut24zQSg=
X-Google-Smtp-Source: APXvYqzh6VzltP60UrbK+lVpjxE2Y3cgOYj5xY3tv94tLPnQKyX5C2TsYHSQ60VAjM+fBdmdnpKxqA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr40509510wmj.96.1578406919509;
        Tue, 07 Jan 2020 06:21:59 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id b137sm27962168wme.26.2020.01.07.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:21:58 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:22:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/20] mfd: samsung: Rename Samsung to lowercase
Message-ID: <20200107142213.GM14821@dell>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-19-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200104152107.11407-19-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jan 2020, Krzysztof Kozlowski wrote:

> Fix up inconsistent usage of upper and lowercase letters in "Samsung"
> name.
> 
> "SAMSUNG" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
> 
> Although advertisement materials usually use uppercase "SAMSUNG", the
> lowercase version is used in all legal aspects (e.g. on Wikipedia and in
> privacy/legal statements on
> https://www.samsung.com/semiconductor/privacy-global/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
