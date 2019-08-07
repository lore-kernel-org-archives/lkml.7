Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8EAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0518821EF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfHGPhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:37:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43389 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfHGPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:37:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so34377505pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 08:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SbXighRqPCoPZWVDEmqUD9WiXHWD2WoHQaBKm2NnUQ0=;
        b=TLfgH3DoYq3Oa17B7acmQxuWyl1NQ1d2B9DrMw9ZzVvVK/HALUi2NT4XDE43cRhwCq
         1bEGGYbk/ige/PGSGgtK+VXGSv2DkIPk2JQ/F9mHFmRM28HlSmkUWaZwow8qNV1fX5qS
         JLOSlAg8xbg2hYQIjYnTh3ZtkiS8Pq+HUJAuAyyFEw+F9HzghPNQVlbHggDU/VLaWdQq
         1ERW0ke4JbziPYAtQcLS3LodzHozqxncCpZ2YEvOeVL74Tyzxk2soj64gqT6v0YmfKqv
         9kpAxFWHUuXx3PWtPfTnfgGvHdaSYL4phrY41lYCUjNLuNcROIqCH45Jon3/IBW+bOu6
         v/7A==
X-Gm-Message-State: APjAAAUH5JeEt7M/CskBWqDqB3mxlU/jzpZ60DcyT3Uv9uY9ltbrAmZ+
        /bH+zS9uYHQCbuCi/gMawhunSg==
X-Google-Smtp-Source: APXvYqwOxmLrwq/hmTiDm7ZkSCDmAQCrO2shh8IxFFNkXHW4/5EiApdsriHIksWl6eUkZz6HIzP15g==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr512178pjh.61.1565192269545;
        Wed, 07 Aug 2019 08:37:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 125sm127468985pfg.23.2019.08.07.08.37.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 08:37:48 -0700 (PDT)
Date:   Wed, 07 Aug 2019 08:37:48 -0700 (PDT)
X-Google-Original-Date: Wed, 07 Aug 2019 08:21:35 PDT (-0700)
Subject:     Re: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
In-Reply-To: <alpine.DEB.2.21.9999.1908061818360.13971@viisi.sifive.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, info@metux.net,
        allison@lohutok.net, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Anup Patel <Anup.Patel@wdc.com>, mark.rutland@arm.com,
        robh+dt@kernel.org, johan@kernel.org, tiny.windzz@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, gary@garyguo.net,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-6a70927a-4b6a-452f-910c-0639d5f47dff@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Aug 2019 18:26:08 PDT (-0700), Paul Walmsley wrote:
> On Wed, 7 Aug 2019, Atish Patra wrote:
>
>> On Tue, 2019-08-06 at 16:27 -0700, Paul Walmsley wrote:
>>
>> > Seems like the "su" should be dropped from mandatory_ext.  What do you
>> > think?
>> >
>>
>> Yup. As DT binding only mention imafdc, mandatory extensions should
>> contain only that and just consider "su" extensions are considered as
>> implicit as we are running Linux.
>
> Discussing this with Andrew and Palmer, it looks like "su" is currently
> non-compliant.  Section 22.6 of the user-level specification states that
> the "s" character indicates that a longer standard supervisor extension
> name will follow.  So far I don't think any of these have been defined.
>
>> Do you think QEMU DT should be updated to reflect that ?
>
> Yes.

https://lists.nongnu.org/archive/html/qemu-riscv/2019-08/msg00141.html

>
>> > There's no Kconfig option by this name, and we're requiring
>> > compressed
>>
>> Sorry. This was a typo. It should have been CONFIG_RISCV_ISA_C.
>>
>> > instruction support as part of the RISC-V Linux baseline.  Could you
>> > share the rationale behind this?
>>
>> I think I added this check at the config file. Looking at the Kconfig,
>> RISCV_ISA_C is always enabled. So we can drop this.
>
> OK great.  Do you want to resend an updated patch, or would you like me to
> fix it up here?
>
> I'll also send a patch to drop CONFIG_RISCV_ISA_C.
>
>
> - Paul
