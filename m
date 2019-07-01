Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262DBC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF7A208CA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWEisIGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfGAP3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:29:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40349 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfGAP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:29:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so9119243lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SOvEzIsyPYSWoFpceKvBPzRNKwkTSAIVrMTKJiszK48=;
        b=JWEisIGnTrJG4aQ3q4jIgAOPzd8kW/+9VKiP4BKx1byI/FJGlLm5h1BCz7GVF9wygr
         s+b7qmoxpgsOUS9uaFZcrlumh6txTejxR/pBZNRcsRt3Uhtl6aTBmst6cpHuirxwrGdC
         NHUxDgDXUGC4stfKORU/UYvBjEf/ZaAIn/e94WeyfJzUw+Txrwgs2Q8fMLSChNkQ/UtA
         R2RQqH+QaKBJVvV8gTZ84Iw+uHKbipvXNnVv1q56vw4Cnp7N2n1u7v/OsjK8F0B2frUE
         Y7NYDQlPjVf0i3+OvqkAkSzFzFu0Rd/rLyCvRZMXsz9UQgVr7dkiaWRlPpfxNZwvx9YY
         O/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SOvEzIsyPYSWoFpceKvBPzRNKwkTSAIVrMTKJiszK48=;
        b=LEUoTbLwjKwmRZwYuLtaXfSkFX2S2f+9yWFkbxvf2TS2/r1tMSktF5wjNErsboDgkB
         nUuorhvKmYface7+WHpwzF+OG/2Om+JSIVI735cWkKdVEC5+Yyd7IEHaz2ybFhtwx0Ic
         GNCENo1bzLraGkvuDBJmc/1IINqKRCgrjDeKtwtmnvC/69SlMxmxJIeuskFWd0Ad+hht
         oYdqvobYpPBQYeG6QxcRxSG9b3ryuZQL5La4efP3DrAbrhzlijPEhbjW6sGkGLRoeH9/
         hYIVfeYOy+U6eOB8ttitDRpUdKFzu2vVrN1XZqAvKSuPt1Fl4gSDMQyowsz5NeAwaCUx
         vfaw==
X-Gm-Message-State: APjAAAVH62xP7+UH/LgwoMLydz+OtSXBC8Xq1ziTmMMwb77LBFXryjBB
        GV0UZJtFWK2x87B2TIF8WhQj41AIlt4=
X-Google-Smtp-Source: APXvYqwUvpqn/mr43CFHEsb/8WcOP2CsUKU/Z3SbznwJvpse4MzzqIf3giHXr01yQcLxIRKL1UoEYg==
X-Received: by 2002:a19:750b:: with SMTP id y11mr12011957lfe.16.1561994959680;
        Mon, 01 Jul 2019 08:29:19 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id q4sm3742689lje.99.2019.07.01.08.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:29:18 -0700 (PDT)
Subject: Re: [PATCH] media: venus: Update to bitrate based clock scaling
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1561537416-2067-1-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <562ad77d-1259-b757-03be-3fd9d56ad8ec@linaro.org>
Date:   Mon, 1 Jul 2019 18:29:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561537416-2067-1-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aniket,

On 6/26/19 11:23 AM, Aniket Masule wrote:
> This patch introduces bitrate based clock scaling. Also, clock scaling is now
> triggered before buffer being queued to the device. This checks for frequency
> requirement throughout the session and updates clock with correct frequency only
> if requirement is changed.
> 
> Aniket Masule (1):
>   media: venus: Update to bitrate based clock scaling

You don't need cover letter for one patch. Also, please include this
patch in "venus: Update clock scaling and core selection" series.

> 
>  drivers/media/platform/qcom/venus/core.c    | 16 +++++------
>  drivers/media/platform/qcom/venus/core.h    |  1 +
>  drivers/media/platform/qcom/venus/helpers.c | 43 +++++++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 13 deletions(-)
> 

-- 
regards,
Stan
