Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B239C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED32133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Sb27QG4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfJIMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:04:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35495 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIMEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:04:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so2632764wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=JO2boY9XIzvrkHIaKUA5yfCjUYvN4PStHFpOCRTj0IU=;
        b=Sb27QG4zeMrMyblGOWbVXVqhM64b9igT0eyvM0n+yMALY78Hhs/InNJRQZRzEHrM64
         pRRSbkPlsVh28m0q6F6QIgXdusWugNeN1FOB2DtjQlJXIUY0NADoTEyuIutff25FPG/9
         MqhCbG4cznoIHCysiEwXaiKnFRS+GLuZxg11+KHOFAqcCoWd1SOPSKoT4qcEBEcve4vR
         zvPgb2594qAI4ORHz68aXDFY9669SZphZcBQhDSmEmZJz6WmeY9T5p8Uk/bh31aijbZh
         XlNL50zWs3JbKYXeh8/3evsO5gF0Ux6dxAViQ3ZIZ5rlxHHXKi59dr5QhIzUDtoqnWWT
         WCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=JO2boY9XIzvrkHIaKUA5yfCjUYvN4PStHFpOCRTj0IU=;
        b=QTIISvbcDYpjaCV6JlEtSdz/ptCY1jhxuo8P9+mILUDvpcJwoPsrpfmkG1BbrNIzTh
         R8HsPJicHHFgotvH5TD1wY+ygNa8VbLs/RZn7mDehAg+FSCTBm2OctSjuklHnbasa5eZ
         ZfmQQxEGBbG1/gVSoRZiTATQ2TH8y2niHmKecsbfHoXKezPiFILdC0KGC4jADisKvun1
         hGtqFqdeLT6kdNxtLa4X83I39Oj5zB+0ttg9WfBJbeTR0e9gaRslh2x2Ya/Aulg6dD9k
         nRg6nBbnKopjwJzjIQsSR7nC9jx87IlsB4WTaBKJhXhL4i3szhuB+PEiJUX7W5jWCcx7
         QuZg==
X-Gm-Message-State: APjAAAWHw7yJJBzJrS1qmP6ANFz0ZaicX0sfALtdXWGugD+J45Q95AcW
        bJBo4CsM1s6GtKfJxDb/vj1DVg==
X-Google-Smtp-Source: APXvYqxfSJCr9n23ZoCYM//W85uSjfZCWYHlQ3vm8HJkbBUb5NQ2yN7Uw43iwcqmki/bK3aM87soog==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr2616323wrr.220.1570622683443;
        Wed, 09 Oct 2019 05:04:43 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b5sm1890075wmj.18.2019.10.09.05.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 05:04:42 -0700 (PDT)
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com> <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com> <7hsgo4cgeg.fsf@baylibre.com> <CANAwSgRfcFa6uBNtpqz6y=9Uwsa4gcp_4tDD+Chhg4SynJCq0Q@mail.gmail.com> <CAFBinCA6ZoeR4m4bhj08HF1DqxY1qB5mygpaQCGbo3d8M+Wr9Q@mail.gmail.com> <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
In-reply-to: <CANAwSgSeYTnUkLnjw-RORw76Fyj3_WT0cdM9D0vFsY8g=9L94Q@mail.gmail.com>
Date:   Wed, 09 Oct 2019 14:04:41 +0200
Message-ID: <1jwode9lba.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 09 Oct 2019 at 10:48, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Kernel command line: console=ttyAML0,115200n8
> root=PARTUUID=45d7d61e-01 rw rootwait
> earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
>
> [0] https://pastebin.com/eBgJrSKe
>
>> you can also try the command line parameter "clk_ignore_unused" (it's
>> just a gut feeling: maybe a "critical" clock is being disabled because
>> it's not wired up correctly).
>>
>
> It look like some clk issue after I added the *clk_ignore_unused* to
> kernel command line
> it booted further to login prompt and cpufreq DVFS seem to be loaded.
> So I could conclude this is clk issue.below is the boot log
>
> Kernel command line: console=ttyAML0,115200n8
> root=PARTUUID=45d7d61e-01 rw rootwait
> earlyprintk=serial,ttyAML0,115200 initcall_debug printk.time=y
> clk_ignore_unused
>
> [1] https://pastebin.com/Nsk0wZQJ
>

Next step it to try narrow down the clock causing the issue.
Remove clk_ignore_unused from the command line and add CLK_INGORE_UNUSED
to the flag of some clocks your clock controller (g12a I think) until

The peripheral clock gates already have this flag (something we should
fix someday) so don't bother looking there.

Most likely the source of the pwm is getting disabled between the
late_init call and the probe of the PWM module. Since the pwm is already
active (w/o a driver), gating the clock source shuts dowm the power to
the cores.

Looking a the possible inputs in pwm driver, I'd bet on fdiv4.

