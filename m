Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEFCC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93252464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCJ8gMw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfLEPof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:44:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35490 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:44:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so1801032pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rngQqX+uv1IWlsc+XdIBg6anXPpozUizYSNw4lihTus=;
        b=MCJ8gMw/yiNkVr/5iso1FHOosyK8veX+Ghu+9dKn2fb32Cc2n4k6mDIqxUeeXsuYna
         7fIFhptKnfbt7BlMOCXGycjmYXgqrOhvb+TOO7cQgakI6NcJk9EiOs0EhEZWcDsWFPel
         uuM17NEVjAiJNRGNe2Y74Irz2UMN1dCtnHfT+SlHjfeC+Yj0Vzbeenp5QQp7JqlzGpXb
         +WjHycr6Liu8F1Kdc+wsMiIEpDv9lIF7PHRoy1Z+36+VPHU2hANqSytxu5wyxJUkuOGq
         lqGSNK6mf2TS0WZOF5oLUfItWze7GD4csg+1oy8l5EcVagrwlnuY/Qf2yKN4siBVsKpy
         Rj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rngQqX+uv1IWlsc+XdIBg6anXPpozUizYSNw4lihTus=;
        b=avdXDEZ6fkmP0Zj04plh6Xz24JHIwKvX0062oSLSdR0KSPAGqwmj6gWVyfJPdlUITR
         NSS2h18vOFj68yXQPyrmn00ErYWvw24JVv2fZ6/KDhwyNZxSuB4WVmwRsd8QIGwIcB/G
         0od+skYUCiLCFNO+8DiMJBXz2kKeXexdJhVLHCWc71kUcmNJYoxVnZjgskKQeSjVFV08
         BtQg3RzPeoVBthc0gp+/txqYBkzg+DKZzoV5Tzqg4l32LSkgE6a5jnlk0J0QMbRFPfj9
         K3lVmmjuPdIi57i9QDvMEo4B3tRW6IO1nQRuMXoMsbQ4fdrY69dMDlUPOqrRIPnYQ3kt
         2mdw==
X-Gm-Message-State: APjAAAWd6gqTvnLZKh3soBbiySCEO5bgGB1/gtdskqH+s3soHDap9fsb
        bbiIsATN+/uCssKzKMPKno3JEbKg
X-Google-Smtp-Source: APXvYqx3mUPRaPG4LI81nqZTjG2HxmI3hORVUsyvS7y3QEkralxccjDXT+P24TJ/MoGkTlPgX/gEcA==
X-Received: by 2002:a63:78cf:: with SMTP id t198mr9771000pgc.287.1575560673321;
        Thu, 05 Dec 2019 07:44:33 -0800 (PST)
Received: from [192.168.0.53] ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id q9sm132999pjb.27.2019.12.05.07.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 07:44:32 -0800 (PST)
Subject: Re: [PATCH] irqchip: define EXYNOS_IRQ_COMBINER
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     tglx@linutronix.de, Hyunki Koo <hyunki00.koo@samsung.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191205151319.22981-1-hyunki00.koo@gmail.com>
 <CAJKOXPeiJ-_w_=q+5Tk=X+LKzc+cCZzF_R5zHezrgQNDwLSucg@mail.gmail.com>
From:   Hyunki Koo <hyunki00.koo@gmail.com>
Message-ID: <aa416a22-590d-e6df-ea99-4fe1fa3be388@gmail.com>
Date:   Fri, 6 Dec 2019 00:44:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeiJ-_w_=q+5Tk=X+LKzc+cCZzF_R5zHezrgQNDwLSucg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is no new driver

I just want remove direct dependency between ARCH_EXYNOS and 
exynos-combiner.c

because all exynos device is not needed the exynos-combiner

only used in aarch32 devices.


On 19. 12. 6. 오전 12:37, Krzysztof Kozlowski wrote:
> On Thu, 5 Dec 2019 at 16:16, Hyunki Koo <hyunki00.koo@gmail.com> wrote:
>> From: Hyunki Koo <hyunki00.koo@samsung.com>
>>
>> Not all exynos device have IRQ_COMBINER.
>> Thus add the config for EXYNOS_IRQ_COMBINER.
>>
>> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
>> ---
>>   drivers/irqchip/Kconfig  | 7 +++++++
>>   drivers/irqchip/Makefile | 2 +-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
> I do not have a clue what you want to achieve here. Where is the driver?
>
> Best regards,
> Krzysztof
