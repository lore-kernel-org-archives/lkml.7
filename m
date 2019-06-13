Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65172C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E85B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GXPxPEvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfFMTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:43:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45307 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfFMTni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:43:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so897756pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KW0Z4bu+Gf02siC8Ql384namK/DDKjE4PFjCJrNDUjg=;
        b=GXPxPEvK72RwpcZiLiyRReXtw1Wjc/AGegiT4k7TB6D4NOH32vHiL2klJ7WDzrKRLd
         yFNZGhHmTM+M2WsPXWENW0p6HPCAxffoF+NtziVfVxZ0MC2CeUOhhl5EzPSryEoaJSZp
         tSZS0Qdx35I+q3Lhl5eqYLv+HsqBHwKCf2a1IjyByC2+Po9PcBx8fEvyNg7sgkl8HY3a
         LwkNJJPbz5V/n9zNDbIpO9nOAlLsTI9s/43jiCBHmB3wBjGgMv1kVQEpwCDddh3EZiIV
         /nG6WrLkpGvvwZMECY31KU9ciO/o58PjtWDXXPmtlUSlL0hhpMJ692W16K7a/tIjUv9B
         MrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KW0Z4bu+Gf02siC8Ql384namK/DDKjE4PFjCJrNDUjg=;
        b=SyCRYLYJHUyPl7m1fAd7dSMyk1XH8PbJCRwVYmi+XwigZTAC/IEFfjzc1iI5GNGyf6
         EejBapVvm+BF9pAGogt26G3zMF38L3ZceczjgjhYcBad+HsUWDhdOzL/BSPC6+i6W4E+
         qGu7QLXsY3kqs703/+C+U8JQq4ZWQnGIfbezlX+22bfYdnddIbkmRJImVodnMZYlg67Z
         V96ssif1XW559ZKdVLH0YdmmQvau36RWB7YVmh+BEdW19SjofTe5qshBkcemQMoRm+El
         9c9IodUuNeIGJ2kDEpxmhJw9DVqy16dhXKNmAmdza/feIIbdAQPAh3gvHNIbeloOuNq6
         1wig==
X-Gm-Message-State: APjAAAVoAJdoWhr47+DnRTfW7FrbkK5Q2+xfC6JLnCNKZyYxytFVFfKv
        n2wKdxF8zuXTEY/n0Z7Y2jZX4JrLpWw=
X-Google-Smtp-Source: APXvYqxSYHqNZdqTSfRe1FzHStMnfFh8RI/pkpNSFr1I9FxUSOwyYqc3IxV80z5rXApnfUIRc0w0zQ==
X-Received: by 2002:a63:610d:: with SMTP id v13mr31667742pgb.341.1560455017658;
        Thu, 13 Jun 2019 12:43:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id g71sm602255pgc.41.2019.06.13.12.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 12:43:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: dts: meson8b: add VDDEE / mali-supply
In-Reply-To: <CAFBinCAVqBxiRz+Fw5D+8XEPTxP13O35OhSD0pEzKjFcGK1H=A@mail.gmail.com>
References: <20190525190204.7897-1-martin.blumenstingl@googlemail.com> <7htvcv3dhh.fsf@baylibre.com> <CAFBinCAVqBxiRz+Fw5D+8XEPTxP13O35OhSD0pEzKjFcGK1H=A@mail.gmail.com>
Date:   Thu, 13 Jun 2019 12:43:36 -0700
Message-ID: <7hd0jh46fr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Wed, Jun 12, 2019 at 1:32 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>
>> > EC-100 and Odroid-C1 use a "copy" of the VCCK regulator as "VDDEE"
>> > regulator. VDDEE supplies the Mali GPU and various other bits within
>> > the SoC.
>> >
>> > The VDDEE regulator is not exclusive to the Mali GPU so it must not
>> > change it's voltage. The GPU OPP table has a fixed voltage for all
>> > frequencies of 1.10V. This matches with what u-boot sets on my EC-100
>> > and Odroid-C1.
>> >
>> > Dependencies:
>> > - compile time: patch #4 depends on my other patch "ARM: meson8b-mxq:
>> >   better support for the TRONFY MXQ" from [0]
>> > - runtime: we don't want the kernel to change the output of the VDDEE
>> >   regulator to the maximum value. Thus the PWM driver has to be able
>> >   to read the PWM period and duty cycle from u-boot. This is supported
>> >   with my series called "pwm-meson: cleanups and improvements" from [1]
>>
>> Just FYI... unless I hear otherwise, I'll wait for the PWM cleanups to
>> land before queuing this series.
>
> I'm happy with that because I'm not sure what will happen *without*
> the PWM improvements

OK, then I'll rely on you to ping (or resend) on this series to remind
me when the PWM stuff has landed.

Thanks,

Kevin

