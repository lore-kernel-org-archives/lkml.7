Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C100EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944C32067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cPJCYXpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfIPLTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:19:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44753 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfIPLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:19:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so5389522ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBaeJfwfLppWDTN+c6Xvp7a5lgEjyq6CvqRjPSkCSsE=;
        b=cPJCYXpgljA0EuMpwlRYgb88hmtm+Zkd2PS4bdnP81XMW+yr9JYKQSAbNKNwxpt6at
         4PBcfW5bxEba2Tx5Sj3WwXWjz2azW8gO95W5Xi7jd3m2hwXZHpgullc+s5IzY2TfEm9V
         i4vYgOzSm5xR9z0hofUO7ZU/IcbXCQaJTXQ7dnXY7N8YIxMm5ac7qqYtp8larQie7Gx8
         JpWFAm4Uckdb1l4benKPwBRAv06azKk87xvEjm6KRLZq12ik3m5yutAbrWYwNsm9ng3V
         ulWYAkmwDNkw9l0coapQBWCETEbgrMyaIsKRyFec52KeYwd4DLO22lDOa2cmBxNCcEvc
         +l8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBaeJfwfLppWDTN+c6Xvp7a5lgEjyq6CvqRjPSkCSsE=;
        b=MMUfJvdLa/69Cc19ShMmyi4mIc0WvOMlSfCAjZbYu1S08+8Tk0QlxcTVJWeYKiY21X
         62Omv+t+oIErFHzGjNAQWOMhbRzdGhYHkA8GU92zvQGykOx1hz9P6Uhre0lwqXWPN4xx
         PB0AWHF+5gLia5HQPlGvEvls3JEwZt39XOgRKleES8YJiDvAOGuiqsM19Ts/FKOH7wTP
         HEo2GGu6yZaP48OfG9Zu263KU7ohVmLud4gNxsZqV/8CZvkynNThUdOy4N4IvzVVZLUE
         mcO1c02MZ4BU8sE7rC8cikfPys4/oZuTKTa/l68WlXv/Z0qla2fDp1+nljGS4pZSyXRk
         AiYQ==
X-Gm-Message-State: APjAAAVdUG+3f9l79yml0N3/8CUq+tqCwzqkgw7ucrwrXf0Qnuo78QEm
        dU3C9+Ut9mEgc2/dOrmESKeFory5kGfWEetSGnLLFg==
X-Google-Smtp-Source: APXvYqzOtuwatIM/fN0oMz9nahH5wOlxzjhK7WDQLmP/Km/rbyCRcFoqvVU/Rdd5uxZhJR9bw/zv3oHPCEVO+AqNIpc=
X-Received: by 2002:a2e:a408:: with SMTP id p8mr5099774ljn.54.1568632756996;
 Mon, 16 Sep 2019 04:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ2_jOGO-isv52rnwRusV7jtyCY_JWYWAj9opN3Zg6ZbZr-8-w@mail.gmail.com>
 <mhng-c8b87e96-987e-4577-acc2-1e22c9b81b10@palmer-si-x1e>
In-Reply-To: <mhng-c8b87e96-987e-4577-acc2-1e22c9b81b10@palmer-si-x1e>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Mon, 16 Sep 2019 16:48:40 +0530
Message-ID: <CAJ2_jOHJ5zuxDc6gsFiZou+-yVg=pr+uSHGJB8VPT1O-Bu3idg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: Add DT support for SiFive FU540 PWM driver
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 2:50 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 10 Sep 2019 02:52:07 PDT (-0700), yash.shah@sifive.com wrote:
> > Hi,
> >
> > Any comments on this patch?
>
> I don't see "sifive,pwm0" in the DT bindings documentation, and it doesn't
> match our standard way of doing these things (which would have at least
> "sifive,fu540-c000-pwm").

"sifive,pwm0" is present in the DT bindings documentation at
Documentation/devicetree/bindings/pwm/pwm-sifive.txt
Yes, I agree that this patch is missing "sifive,fu540-c000-pwm". I
will add it along with "sifive,pwm0" and repost as version 2.

Thanks for your comment.

- Yash
>
> >
> > - Yash
> >
> > On Wed, Aug 21, 2019 at 2:53 PM Yash Shah <yash.shah@sifive.com> wrote:
> >>
> >> Add the PWM DT node in SiFive FU540 soc-specific DT file.
> >> Enable the PWM nodes in HiFive Unleashed board-specific DT file.
> >>
> >> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> >> ---
> >>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 19 +++++++++++++++++++
> >>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++++++
> >>  2 files changed, 27 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> >> index 42b5ec2..bb422db 100644
> >> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> >> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> >> @@ -230,6 +230,25 @@
> >>                         #size-cells = <0>;
> >>                         status = "disabled";
> >>                 };
> >> +               pwm0: pwm@10020000 {
> >> +                       compatible = "sifive,pwm0";
> >> +                       reg = <0x0 0x10020000 0x0 0x1000>;
> >> +                       interrupt-parent = <&plic0>;
> >> +                       interrupts = <42 43 44 45>;
> >> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> >> +                       #pwm-cells = <3>;
> >> +                       status = "disabled";
> >> +               };
> >> +               pwm1: pwm@10021000 {
> >> +                       compatible = "sifive,pwm0";
> >> +                       reg = <0x0 0x10021000 0x0 0x1000>;
> >> +                       interrupt-parent = <&plic0>;
> >> +                       interrupts = <46 47 48 49>;
> >> +                       reg-names = "control";
> >> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> >> +                       #pwm-cells = <3>;
> >> +                       status = "disabled";
> >> +               };
> >>
> >>         };
> >>  };
> >> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> >> index 93d68cb..104d334 100644
> >> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> >> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> >> @@ -85,3 +85,11 @@
> >>                 reg = <0>;
> >>         };
> >>  };
> >> +
> >> +&pwm0 {
> >> +       status = "okay";
> >> +};
> >> +
> >> +&pwm1 {
> >> +       status = "okay";
> >> +};
> >> --
> >> 1.9.1
> >>
