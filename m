Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87633C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 14:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50649217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 14:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0Ti20aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfELOIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 10:08:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38892 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 10:08:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so8710380ljj.5;
        Sun, 12 May 2019 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SsdMUibOgwZjuAll78GXO0IJFVu4htERDbgeRDvLGlY=;
        b=k0Ti20aNFtGS8xI430w/FIJoeJ/iFF+ZwYq1+T2C6q1os18QLLQRQ+9r+hYvnde0vS
         xGO1F0g6apQ+oO/9TqIRynGff91Q2jg4LozCz1B29NfJiF2rdojwzcHFMtddXd03e4Oj
         ufXCFjKODWjJ2Bm3HpYS7y2JYpfOWgVng8rTMcdjp3zFpWVT2GIxrbSeQ35G5zsv4edU
         Dp8f2txiy0wtZfweVPrZGlyqk9qY9Hpk7Z0ZOfVAvSu8HL5ItgwL17QWQeh1/Yzjp+iL
         Aob2VxV+k6sWZwxzGPrW+nP6zBPBx+F8G+6HpCc6Ejo+m3TB0CEupw9wTTkwE6hrzA0m
         NOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SsdMUibOgwZjuAll78GXO0IJFVu4htERDbgeRDvLGlY=;
        b=lkseNwomYDJTY0tYQpKCh4F8PxOFnNo5e1zetbScyufoOMc40CTMLRtW54H6Ihr6hI
         J91aqHn3twphKpb8t5BcNZ4f8U6pHMbjaSqkGEES74fW97kBOGMD/31+usJplsweLaWt
         BYc19BrDvRnVTGP8oRwQdbtB1h0CirpYWe7lpsTFPmChOMnVZf9ZC5o01WtDlFFftFg2
         InX3ZiycFvwqXXtfs76YkN6DrPq8+hmC+tb+AHjjRqxnWFW3byvE5qgdVwpsQGD5UVrU
         kwn8SSzM3s/+MdSJ6+tnZp3T8vqxOBYIb2hsLLt/go5bGSuhxUQQKglx/ufoHrD6Ly8d
         0lHQ==
X-Gm-Message-State: APjAAAXmXxxOeNAG15Z5b0lzpR4+ptrJFekL7b/JvlP8JwkzUGWJcNF8
        HBz7Y6jxKO+dABEW8KoBkc/08GgU
X-Google-Smtp-Source: APXvYqzBa0OuT3LFcawR/5VajeBvaBLitjWPtc4mROHTyB5IyW1EW1Vv/S4DRBixUg082YMTfhU6VA==
X-Received: by 2002:a2e:5dcb:: with SMTP id v72mr11895351lje.54.1557670131187;
        Sun, 12 May 2019 07:08:51 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id y19sm2745915lfl.40.2019.05.12.07.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 07:08:49 -0700 (PDT)
Subject: Re: [PATCH v4 6/6] regulator: max77620: Support Maxim 77663
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190505154325.30026-1-digetx@gmail.com>
 <20190505154325.30026-7-digetx@gmail.com>
Message-ID: <f8f67e00-0544-c999-92e0-3998c2f70ee7@gmail.com>
Date:   Sun, 12 May 2019 17:08:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505154325.30026-7-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.05.2019 18:43, Dmitry Osipenko пишет:
> Add support for Maxim 77663.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Hello Mark,

Just want to get yours attention to that Lee picked up the patches into
the MFD tree, excluding this patch. I assume this one will have to go
via the regulator's tree.
