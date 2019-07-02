Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34BEC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAECB21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcuSkOZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGBAnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:43:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39024 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfGBAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:43:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so1321329wma.4;
        Mon, 01 Jul 2019 17:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=44Hy7l3xGdVk9fCa/7ZGzEoihUbfiHVXEZpjhEhRbnw=;
        b=tcuSkOZF0whehNi4G3te02nKcyghe/RMMLuftdQtw2cUqpY1V7rmrEGOkdo6jcd8mJ
         wzQBkPiyts+Vl1g/74wY2O88/ay4I79mqcBOPKO8x0UpIER4gH70/zD3+Tz3UoAcYeV3
         W0lGnx0ZhtGHPMudTv2P3M+BtzrB5UCT1OXqVoQs1bYcCSLbmTKHHdR7QvLKENZvmhYA
         D3QD+GuOi8AyNxVVCGDkbJH2cb+bKvSWRDyhn19v8oYeAmitPuN83C2lAGTAeb+ZmZEI
         e1vPOxMRE7on5Up5EZwPI8Zjwf/hyGFvgJ2vn78rTxqJuiHoB7T+rd+djLV9gMdwFGYD
         a6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=44Hy7l3xGdVk9fCa/7ZGzEoihUbfiHVXEZpjhEhRbnw=;
        b=GT7SyWggZN/3/ydrJDnTopvfGxiu6Zvc0mp7n8hrihtMNW78yZfyFEoYUQyO3VoCR1
         2Sw5iBHCG6TKcwfeeD0N+MTxsgNjAHFJU5qArzj7fCC4BZjFPRYWn4Ki0Bu9Wlz7HulV
         UHxYN7NRpStVBD2qOvp3UMTQrvZfJqcPY2Mzj2ySeEs+kQWgVVvNwC7m08mEv7BjcgOg
         ea9UUjLlrD3m841YBW3xHl/UO95JFtXabkR2PDpBHIXCjBHHQ6BtTNPnHvR5bMBn9hT+
         upecCXj6oMPBqg5tKo6NoOFvxkvoH5gEAaUFrwSp7yWf+DsbKy50kg6fT2EH9YFuOYY7
         bkVQ==
X-Gm-Message-State: APjAAAVTJ6e6iTQbG7MqEgikTlCw4TaC9G7kL6LV4QLAZFP1dxwIsveT
        ZGuUm2iO+XMRyMEqsczlnUI=
X-Google-Smtp-Source: APXvYqyEKPR/YkIqetqO/xYtX6MWVb1sg7tBSFJTFSaPiKVhCbW2FqMm35erUs2UktTeCRR1ln0iow==
X-Received: by 2002:a1c:a6d1:: with SMTP id p200mr1013504wme.169.1562028228712;
        Mon, 01 Jul 2019 17:43:48 -0700 (PDT)
Received: from [192.168.2.202] (p5487BBD4.dip0.t-ipconnect.de. [84.135.187.212])
        by smtp.gmail.com with ESMTPSA id b5sm8710950wru.69.2019.07.01.17.43.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 17:43:48 -0700 (PDT)
Subject: Re: [PATCH 0/2] Support for buttons on newer MS Surface devices
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20190620115056.4169-1-luzmaximilian@gmail.com>
 <CAHp75VcSDvjnS57mS2HyEvUyBRGv68yxXt7wCbJHK3pw98UiOg@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <ec5d799f-91da-378e-dc0f-0e0460d8c545@gmail.com>
Date:   Tue, 2 Jul 2019 02:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VcSDvjnS57mS2HyEvUyBRGv68yxXt7wCbJHK3pw98UiOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/19 4:18 PM, Andy Shevchenko wrote:
> Pushed to my review and testing queue, thanks!

Sorry for my rookie mistake of not checking that this works without
CONFIG_ACPI. I have updated and re-sent the patches to fix this.

Maximilian
