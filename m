Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F72420449
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RWHc3SRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfICTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:07:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33445 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfICTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:07:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id p23so17949023oto.0;
        Tue, 03 Sep 2019 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3aev7x2FcRIqe6J3Q1VipxXTWXY2gzdFLeKEuyXyxo=;
        b=RWHc3SRbRf5QRAyWscodVJW+0S24fkLuby1zUP0KJ2evYT4MuYyJVvDvhtCv94QE1E
         /Uz1SOL5M/Cdqpk0ecIJA5VaRb8gHQCeGBJXFsmftSOdIoOpoGUdvDljHcNNWIh2jhYQ
         SSE9+TR+lnXwuf3HClCbH7pRSsO/eZrPWRfrE54N/rTfKOLMBc4JInagPEAmuJJcBktJ
         0/aRZMIhe+kp+C8v/nWZHMSJwcG+f4pPpdsJq+HO0x+vkHZmQE+cFhi4srB4KE+K/jLg
         LdtyrfqDRa5afybHrxgE+emhUsLuambMWuxdaJX3YbvEwnqlDf8gaLRh9p9EWbxLHUp+
         2/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3aev7x2FcRIqe6J3Q1VipxXTWXY2gzdFLeKEuyXyxo=;
        b=Lh9tYrpa/H/CbR0QSajks69p+86u4Uyze83hsi1Tx9gvGlwDRRChM+aEaHu17ZMFfR
         RqvWUezM0uIw05B9pVL3zrvt/g2xiyqS7kMbMuT6oeFmVRmG2b/vj2H8ID8i79oLWEqN
         0wnX3TujEkPUmjnFtSfhEgLkZQyx5g03Frt3NYxNu7TS0hG8ttDaH5dAY98SbAn8yO57
         3BnaJM1miZJDsMROD3zHb7RCJ8EAD4xhVitZQk1+sMtYl/Xt6/PRwK9tazqx7R7NBaeQ
         plvnHn0+A4ohgN0HjyT0ODEmOu0ilNGnEPmp5I3GC1tj4oRgrm/ljGl0y4O4X6FYGxk3
         2R8A==
X-Gm-Message-State: APjAAAVQ0fwogOFyTX23WX9qmH2saiRPdJbDk0H6UDzgbmH0BBFGmCKD
        PJkL7YNBE10X3p3LOJ0UhlUNkW1AAlLlJlo3fi8=
X-Google-Smtp-Source: APXvYqx4cEcKC4Pu7goYArzcWb/HJXhNTrOtWlDYALGS5Yz4pLIh9S3YA3UNWoxmkLOmC9OR33nyeXRzwkdcKmC+A3k=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr621031ote.98.1567537673321;
 Tue, 03 Sep 2019 12:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <8c40f334-c723-b524-857c-73734b7d0827@baylibre.com>
 <CANAwSgShr-K-44UzdxFC7pvpTye_pbEMdS6ug1eWwYhnsVNGdQ@mail.gmail.com>
 <101a12ac-1464-8864-4f8c-56bb46034a08@baylibre.com> <CANAwSgQwZg_AXAnAY4KwDzHpwcSA9up7SrR6jyv5Bem24wtaJg@mail.gmail.com>
In-Reply-To: <CANAwSgQwZg_AXAnAY4KwDzHpwcSA9up7SrR6jyv5Bem24wtaJg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Sep 2019 21:07:42 +0200
Message-ID: <CAFBinCBY9SJKOaVYCV2HzDOrjngtcreM4Ftvk+hgr8KAGV_V+Q@mail.gmail.com>
Subject: Re: [PATCHv1 0/3] Odroid c2 missing regulator linking
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Fri, Aug 30, 2019 at 11:34 AM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> > SCPI works fine on all tested devices, except Odroid-C2, because Hardkernel left
> > the > 1.5GHz freq in the initial SCPI tables loaded by the BL2, i.e. packed with U-Boot.
> > Nowadays they have removed the bad frequencies, but still some devices uses the old
> > bootloader.
> >
> > But in the SCPI case we trust the table returned by the firmware and use it as-in,
> > and there is no (simple ?) way to override the table and set a max frequency.
> >
> > This is why we disabled SCPI.
> >
> > See https://patchwork.kernel.org/patch/9500175/
>
> I have quickly enable this on my board and here the cpufreq info
[...]
> Almost all the test case pass with this one as off now.
I suggest to send an RFC patch to (re-)enable DVFS on Odroid-C2
I find it easy to miss a DVFS discussion inside a "missing regulator" series

with a separate patch you can also get feedback from other Odroid-C2
owners who can help testing
coincidence or not: on Friday someone asked in the #linux-amlogic IRC
channel why Odroid-C2 didn't have DVFS enabled and what to do about it


Martin
