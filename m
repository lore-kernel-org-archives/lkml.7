Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC1C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BEE207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0j1BrL//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfFGQv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:51:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32871 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfFGQv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:51:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so1534909pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=KAdja4g+5K1yNRadSGa4iS254vjYz6FUIwDf3E1mgJA=;
        b=0j1BrL//JTMqPk4S/qOTR9Ht6RSavMWK+fEjT0ZZAIKcAfr9Pi1BMrnKrD2aHUPPaN
         vGzHheuuiH8JfT3i/I4/ZzTv8EoUJlo8/aw/LSSMrgKQXlRIfmxZXIBAlOYBh0vgHJfR
         XiW+idkrDc8Ph2C+3T7dnrwJn/0m3v5VLS7kY7AOauaRYRBEy0zM1n6C2DEAa0/ksB9J
         xuIP9TqP5hYs58ps5XHFrRiG4ezdyhfdhepMn9BTm+At8Ic/K+hJKqVmMDoeaG0h+HlI
         1lvZqHyP0H5JgT+4iX0S6mm7AJo+94Wc3a80kv/eiFmp9IbiPJVKG7dzlYTl1gq2qgjY
         TzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KAdja4g+5K1yNRadSGa4iS254vjYz6FUIwDf3E1mgJA=;
        b=KfxjItH19BoEbeowy4q2I7OvlBFyMgl92C7Ao41AfYET6WAy7sICghPkqLau66djzo
         5oW9XtGYCW34B0WTNv1UTpPzHPh+NYqncaDl78HV/llOWdmPD9At5bxRojpF7dGl0Kr/
         yr4HFQSyTS/El3u7RG6CzH5t/+LcgzjopOvVtJD8wYMLC4gFBRuEyj/2EQ59SQbun863
         PKHkIL9+Q9cxcm84GG50/G98MJBprDXvIkmZc1lNsK151b6siNCkNFcNRCoO7qJMiS0U
         kgpnsbSsE6nU2uMZdVG6udJU0AWveyUwiFFtOFEBscoP9mR3b4rtgrVBl6ARoZLwaCib
         369Q==
X-Gm-Message-State: APjAAAXD28aKpXOhEJwvlTs3u0rikmxZPktQHLDrpR/fvJm2z593ct5m
        7KSp1djjK+GJxOLLkx3kbjDk2Q==
X-Google-Smtp-Source: APXvYqzw67ywps2BIX0frRcevuXgajIjxlqqSkbhuQB8Awha+f/Wfl1unsc2kcMs5EH4mXVA+dx7lw==
X-Received: by 2002:a65:408d:: with SMTP id t13mr3497326pgp.373.1559926316302;
        Fri, 07 Jun 2019 09:51:56 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 2sm2705166pfo.41.2019.06.07.09.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:51:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 0/5] arch: riscv: add board and SoC DT file support
In-Reply-To: <05010310-baa2-c711-cb54-96a9138f582a@wdc.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <7h36kogchx.fsf@baylibre.com> <05010310-baa2-c711-cb54-96a9138f582a@wdc.com>
Date:   Fri, 07 Jun 2019 09:51:55 -0700
Message-ID: <7hftolcp90.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> writes:

> On 6/5/19 10:37 AM, Kevin Hilman wrote:
>> Hi Paul,
>> 
>> Paul Walmsley <paul.walmsley@sifive.com> writes:
>> 
>>> Add support for building flattened DT files from DT source files under
>>> arch/riscv/boot/dts.  Follow existing kernel precedent from other SoC
>>> architectures.  Start our board support by adding initial support for
>>> the SiFive FU540 SoC and the first development board that uses it, the
>>> SiFive HiFive Unleashed A00.
>>>
>>> This third version of the patch set adds I2C data for the chip,
>>> incorporates all remaining changes that riscv-pk was making
>>> automatically, and addresses a comment from Rob Herring
>>> <robh@kernel.org>.
>>>
>>> Boot-tested on v5.2-rc1 on a HiFive Unleashed A00 board, using the
>>> BBL and open-source FSBL, with modifications to pass in the DTB
>>> file generated by these patches.
>> 
>> Tested this series on top of v5.2-rc3 on HiFive Unleashed board using
>> OpenSBI + mainline u-boot (master branch as of today).
>> 
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>> 
>>> This patch series can be found, along with the PRCI patch set
>>> and the DT macro prerequisite patch, at:
>>>
>>> https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1
>> 
>> nit: I only see this series in that branch, not any of the prerequisite
>> patches you mentioned, which made me assume I could this series alone on
>> top of v5.2-rc3, which worked just fine.
>> 
>
> I tried only this series on top of v5.2-rc3. Kernel boots file with DT 
> updated via U-Boot. But networking didn't come up.
>
> Do you have networking up after the boot? If yes, can you please share 
> the config.

I didn't test networking from the kernel initially, but looking now, I
do not have networking come up in the kernel either.

Kevin
