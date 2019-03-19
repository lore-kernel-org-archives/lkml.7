Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338F220872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aJGHy2qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCSG1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:27:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40788 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSG1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:27:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so2609540ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jDL+Fn/cQghWTA3oSma3bwThX7AoUICzbfrMolBsrFE=;
        b=aJGHy2qO3QO4M/a5ud5O/SlM0dVAYdF6QRE2rNIvz8tFeuDop2+I5kIWHNDqgnvW7W
         HDLTi0DNUZKzsbPOtdkxifPlz3ZIwWx5CRYuMFf1knwaJ56GsmHJUGeHNT/GuPQvvoBl
         tV1+2e5KXv5jYdWp+A9od3APsryHLgy4z64ADkdtaxByar+UyK444xrXB1wEKw0Lv1p0
         9CjMWkaqx+G7MbWJCagEclth6apopL9gnGHF4HlVj1N4Ros6IFx7wYSl+ueHaTTtgHOn
         ssE4Ni0Fmy5Me0xrCHJWLinUwqBMLYMbPPUPR4PnbS5jZXAy8LX1wEIM0VRDUE8zLHLt
         GWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jDL+Fn/cQghWTA3oSma3bwThX7AoUICzbfrMolBsrFE=;
        b=pfhk+LUOwIUj1wC2wYKzw458liC+jQfMRaDKY50V9ig+YJ3ozndxwl02XjezmxYoAx
         JXIu5irpUbc38cyhQ5HSHN0jajo3WaW5QO8zi1Fm7gQChSOLPepM0SEkRCIbbF+Q52zu
         cVpMkkryjTpWICUPO4TZqJIqIVpb5lOfB4Wpkmn2UKv72QPXjX0HGsOT9YzzLgzHP730
         b4ejX627hLvGNO18/5NXt14w5+BkOR1m+HMauLLDMPoO0/9hq+7hp3qHfGnptzaLbQgp
         TCeGrelSBdIFzJUbkWn4wksuAn7G+Xo1/WfO4y+cu8c552w/RoC4SUSOYgTgbH1XnyYw
         QZLw==
X-Gm-Message-State: APjAAAVbAHh/8UUG/1fAbPKMmLcDGadI4y/U4p3hpaswfWD0zHfp5Z8T
        /HdoKpz95Qdv9WBSePeazELYcJK5Li7ckOT466I++g==
X-Google-Smtp-Source: APXvYqw7VoscLsbG/LdUeNfMqcTLTM/iY0hRK/0p6LScyzfmWl4haKxSl1YeGl34sr3ieHRu/s8756NN9VRXTR4LXOc=
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr4726655ljf.95.1552976832134;
 Mon, 18 Mar 2019 23:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <mvmimwotn60.fsf@suse.de> <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
 <mvm5zsgp00d.fsf@suse.de>
In-Reply-To: <mvm5zsgp00d.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 19 Mar 2019 11:56:35 +0530
Message-ID: <CAJ2_jOHoNnBF2UwU6G1vdvNrJAUJdGL_RncRAOaXMWoS03cagA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] PWM support for HiFive Unleashed
To:     Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:56 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 15 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > You need to make sure the period setting is passed via the
> > conventional way in DT file.
> > Example:
> > pwmleds {
> >     compatible =3D "pwm-leds";
> >     heartbeat {
> >         pwms =3D <&L45 0 10000000 0>;
> >         max-brightness =3D <255>;
> >         linux,default-trigger =3D "heartbeat";
> >     };
> > };
>
> I've now managed to build a working FSBL with that change, but that
> didn't change anything.  There is not even a heartbeat option in
> /sys/class/leds/heartbeat/trigger any more.

Below is the copy of the pwm nodes in my DTS file:

L45: pwm@10020000 {
        compatible =3D "sifive,pwm0";
        interrupt-parent =3D <&plic0>;
        interrupts =3D <42 43 44 45>;
        reg =3D <0x0 0x10020000 0x0 0x1000>;
        reg-names =3D "control";
        clocks =3D <&prci 3>;
        #pwm-cells =3D <2>;
};
L46: pwm@10021000 {
        compatible =3D "sifive,pwm0";
        interrupt-parent =3D <&plic0>;
        interrupts =3D <46 47 48 49>;
        reg =3D <0x0 0x10021000 0x0 0x1000>;
        reg-names =3D "control";
        clocks =3D <&prci 3>;
        #pwm-cells =3D <2>;
};
pwmleds {
        compatible =3D "pwm-leds";
        heartbeat {
                pwms =3D <&L45 0 10000000 0>;
                max-brightness =3D <255>;
                linux,default-trigger =3D "heartbeat";
        };
};

The above works for me.
I just noticed that I have been using pwm-cells =3D 2, instead of 3.
Maybe that is the problem here.
I will suggest you test it on v11 patch in which I will fix this
pwm-cells issue.

Thanks for pointing it out.

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
