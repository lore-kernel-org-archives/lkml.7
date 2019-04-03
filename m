Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D0EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE38C206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukMmPCNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDCKnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:43:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40411 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfDCKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:43:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id a28so11331787lfo.7;
        Wed, 03 Apr 2019 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DcTmFfB3VDL/cCLY+rfICK2qcZkK67M426hRryMBpSE=;
        b=ukMmPCNvmXncl2AwBxbr6aWQoEau1QD6UFObPWLRrh3tUfXFqkDjyMxVKw1NFltfnu
         dOuZDVGLFTmKa0zkOSEg3HN+tCrX2pVewnSjljZw6z+MFGD18XZS8I4cu/A6byshOMfg
         fBl2W+YZyE1WtOfCkBctyREOK6KajoMdJJZPdGRVL4NfdQ2FyESdLZumZYXmOndVNAqb
         sm8KRk9sRrY1sGFKJJY4baE5urVRaq98+itd9rVtl+0YBCPpxd0saw7Pqhcqi6rwf0ox
         dHaSPSv1cNj1prcYLOWqiu7kP6rkA+NnoS3EfPsenb81kjil8Vr7+eozkMswx51n+z1o
         3jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DcTmFfB3VDL/cCLY+rfICK2qcZkK67M426hRryMBpSE=;
        b=Qmfi0JKepx5oCh8cs7RxxYiT3QpmwRIdsNxncsKxi8KfS4LBtzkv1GZ7RmnV7nWhgt
         X+7OlNTuq0jeAfr3631xr87Woy3tYY4pOmXEY8x3iMhn22ZqQg4XsSFe3tGe2R2cVyZc
         ausxNYkUkqNA++MrSoVGpeD6N/WFfvLnF3U+8GFfi7RZnoNNiE0TI26bJhmPh0vB+ULD
         9M/r6Ho6/vKDkcZ2yteO6ceXG+qi/HMJQl5xxG84mj1105ytfGN/ZWEoqijMH2xpf788
         YgQtlcJg43Z/wDnMGMxpQ9pEcij/1BrGi3yHgwftgBMVZ9ivfsYg+qlDyvFYaI12fuPi
         pgNg==
X-Gm-Message-State: APjAAAXngE4eM9F6AbZB+7lyAOc+nSm/nmBSR+OkwL6U183FLnbr3Mg5
        OkAkqKbNp4I1pwWRkaaMHS/Suz29
X-Google-Smtp-Source: APXvYqzE9iPiqacrSEKEuRgvX0mJV/6H0atkNMdHmjGAHdtIbrZUduicKYm46ioUKAzCBXauhgOCdA==
X-Received: by 2002:a19:ec17:: with SMTP id b23mr37389716lfa.76.1554288191119;
        Wed, 03 Apr 2019 03:43:11 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id x30sm3217341ljd.38.2019.04.03.03.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 03:43:10 -0700 (PDT)
Subject: Re: [PATCH v10 0/7] Support Trusted Foundations firmware on Tegra30
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190317225211.23091-1-digetx@gmail.com>
Message-ID: <2e3d45c9-c31b-e7e3-74f3-b0e8fb767c1f@gmail.com>
Date:   Wed, 3 Apr 2019 13:43:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190317225211.23091-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.03.2019 1:52, Dmitry Osipenko пишет:
> Hello,
> 
> This patchset adds support for the Trusted Foundations firmware on
> NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have that
> firmware and upstream kernel can't boot on those devices without the
> firmware support. This series was tested on Nexus 7, TF300T and Ouya
> Tegra30 devices.

Russell, could you please give yours ACK to the firmware patches so that Thierry could pick up the patchset to the Tegra's tree? Alternatively we may take your silence as an implicit ACK and move on if you won't answer.
