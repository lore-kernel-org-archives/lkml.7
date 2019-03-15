Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC617C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867362077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YfUpW3qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfCOLuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:50:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44920 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfCOLui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:50:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id u9so6586751lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1skTJj6HHHRWua0cE5sPm6z+McI8wT6PEJwIOHW+cdU=;
        b=YfUpW3qFaKDdwr6mDAJHFkULkW4dFhOnvNwl02zrPZaTkgVRw+lLZfgbsSv21wjrfs
         BzgtCPnUGKITg+jvw3XSJoXs763tYZACPeFPMiyz39zzaDOjYi8PzLD3Z65eCq35foj0
         sM/Qol/vg1lbFl4MDuR7y53WcukMuBODeRkJOX2a3Q+d5jWShzS6msXMqxR25Xe1UpW7
         J/WuowkIPFeHF1+DLLLKr3eTHPd8jaSE0d95eVWoNjbtk8bxSMzlt54tABF+eLhzR4tU
         1nXcdJyFStj22RfErLPL3qP3y8o6Cd8s4qkCUK2Srr7q6OzftKq+0ihpNa24yeFKEhFu
         WXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1skTJj6HHHRWua0cE5sPm6z+McI8wT6PEJwIOHW+cdU=;
        b=d6Mf613fQMHAzBoyebX68/dB3ZgU4v/j4eVYHeFURm13XP+k/lz7O7cKwwN1uvIooc
         wamtI84mIhFUQTOrvwEZyHZiXqdGoPrbsYw6PHNCjKpjCUWaZ4S6WDL3qMvu8Tiaffoq
         Dd0qz6GFwT+CBEPQFJ96aehA/Yc1ef3AROOBQAZ66ekS3ogiwaLMeCAzipHYPo9nUgsY
         6njmHBk8gAnGyxFJ/UTqM09DgVDmOE179/DHMOiRJ9yLi3Io9AiKjSZFBIcW6fBsdtvr
         JFA/IEmpD6SHP9KraUbjje3QG08p78U59jGB2ThogFEAFVe1R4yXVCS9P9EuL7XwWmWs
         dP6g==
X-Gm-Message-State: APjAAAXPL7juvZk3yWxMsqFbqwKrQ8C0Dmd2FjRECpjMY1Ufr1DTuDM/
        0mKpiBBZpPtW93OJITF2GdQhR9lWEFO+LW2wHkH5eg==
X-Google-Smtp-Source: APXvYqx6PRctHDhf23YqBLIrUC0/mwToO1OVrYPngkl6cFQ3VChbtn8wJ/QcdddC2rFUq03Ysx4LHYZ5JK1WXDAo1K4=
X-Received: by 2002:a19:4948:: with SMTP id l8mr2115436lfj.156.1552650636613;
 Fri, 15 Mar 2019 04:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com> <mvmimwotn60.fsf@suse.de>
In-Reply-To: <mvmimwotn60.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 15 Mar 2019 17:19:59 +0530
Message-ID: <CAJ2_jOE3RH9FyFg_NATcLEpHv5y89zdh06Ji2x8n3C_gp-wn6A@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 3:44 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On M=C3=A4r 12 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > This patch series adds a PWM driver and DT documentation
> > for HiFive Unleashed board. The patches are mostly based on
> > Wesley's patch.
>
> Heartbeat trigger still doesn't work for me.

You need to make sure the period setting is passed via the
conventional way in DT file.
Example:
pwmleds {
    compatible =3D "pwm-leds";
    heartbeat {
        pwms =3D <&L45 0 10000000 0>;
        max-brightness =3D <255>;
        linux,default-trigger =3D "heartbeat";
    };
};

I have tested on HiFive unleashed board. To modify DT file I performed
the following steps:

Use the open-source FSBL from:
https://github.com/sifive/freedom-u540-c000-bootloader

Modify the fsbl/ux00_fsbl.dts file and re-build the fsbl.bin

Steps for using fsbl.bin in HiFive Unleashed board:
https://github.com/sifive/freedom-u540-c000-bootloader/issues/9

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."
