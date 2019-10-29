Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC8CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93E8208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ari5oMPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfJ2Mu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:50:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35572 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2Mu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:50:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so15136936lji.2;
        Tue, 29 Oct 2019 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+1+E1Mkw61uNWs7GIpUIl/WGmE8S7qBe+e6s/cPqZw=;
        b=ari5oMPXp859DXdO+xnn+iL7LJAYqB1R/5IEpRjP0GyPrkUR+OXWZeDWb0mwdybwQZ
         1odHGNN7BvobQHpJnR/IOu2q09pKaCtoa3r7g6V38Lag8Dzi5V6d83LYNyLYlN3Xl8wl
         1PlZX8Fu5WOWKaLTTIb/AF0iuNGZDQRLLA2tuEAM7THXX+59A58mzGy6HARPryO0QIQ+
         FmcbzYCktyZdZx6CPUou2NWAb5CwBRxwPl654n2QBzlgoaVi2BxJ2AbBGcR7ogkN0lfj
         lT+g5wVHsWxBbCQJHqEjYgKE7GkZLyiLDjdgwiIGLFmfjeqQGYSQjLsAObdGlESu5zyJ
         RlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+1+E1Mkw61uNWs7GIpUIl/WGmE8S7qBe+e6s/cPqZw=;
        b=ZHZ5nAfLdKKrVUF83Xfk0BMSqp5u4+sHXpDswrH2JJI81817gvyPxTk8VD+xj651oV
         BJkICXmGlNRbXGP3UUJ5dOFBz3+IPmBSeT1SmcYXX51Sp5/osn2j6CVkaYFNzrkdBjmz
         cqc+H5bDePFOXlzFUZoyDDZCWel3g3iyiSs7nDMEilYkNjevGLXLRfezVGMujJkv50tu
         RLYyeJP5bpoBY49iSVBvRxzlxLejZTBI1yxPcjNUgb8HqfjO25MYGkXKI3m52dIlAJhU
         LtBrCjBTG4RY3jhmtC1XHIb8tObxSpzBBJuCnfDU80u6Qz7CekdzVKTrbd4PjWtvE6yA
         Jk+g==
X-Gm-Message-State: APjAAAWkYnO9oAUrEy43Z4z8G/vEdmqxydL3iWKUAt4U2emsGA8qgrAl
        g43W47ZOAGImk2VXhkm8ssjVmiE6
X-Google-Smtp-Source: APXvYqwT5xHzW80AdFTkNUJFyTUogFJ15bZtdQv5kxzSKhGfDa1Ig7x39l929QbapLvn7aSlJFZ3DQ==
X-Received: by 2002:a2e:8604:: with SMTP id a4mr2623578lji.89.1572353424838;
        Tue, 29 Oct 2019 05:50:24 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id q27sm6080287lfn.96.2019.10.29.05.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 05:50:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] clk: tegra: divider: Add missing check for
 enable-bit on rate's recalculation
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723025245.27754-1-digetx@gmail.com>
 <20191028142753.GC27141@pdeschrijver-desktop.Nvidia.com>
 <62c375bd-09ae-e09f-6ca2-c1395eebc5fa@gmail.com>
Message-ID: <1dfd0270-b8d7-da22-46dd-7efc907d5655@gmail.com>
Date:   Tue, 29 Oct 2019 15:50:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <62c375bd-09ae-e09f-6ca2-c1395eebc5fa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.10.2019 03:14, Dmitry Osipenko пишет:
> 28.10.2019 17:27, Peter De Schrijver пишет:
>> On Tue, Jul 23, 2019 at 05:52:44AM +0300, Dmitry Osipenko wrote:
>>> Unset "enable" bit means that divider is in bypass mode, hence it doesn't
>>> have any effect in that case. Please note that there are no known bugs
>>> caused by the missing check.
>>>
>>
>> Technically this is not quite true, but for the purposes of CCF you can
>> treat it that way. This bits defines if the value in the lower 16 bits
>> of the divider register is used to configure the divider or if the
>> contents of the UART DLM/DLL registers is used. So the divider isn't
>> actually bypassed, it's just configured differently.
>> In practice this bit is only set when the divider is non-zero when doing
>> set rate. So the extra test isn't strictly needed as long as the sw
>> running before the kernel also ensures the bit is only set when the
>> divider is non-zero.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Thank you for the clarification. I hope that bootloader doesn't enable
> the divider because it looks like standard 8250 driver won't be ready
> for that. But serial-tegra driver seems should be good.

Actually, it should be good because I missed that UART clocks are
per-initialized in the clk driver init table.

I'll update commit's message and send a new version of this patch.
