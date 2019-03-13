Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E342087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgZQf2+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfCMKsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:48:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37133 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMKsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:48:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id a17so1098659ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yt3F8B/eVJm2Hd//+yp/dZLjFDzdD2v2U/1pjIYvgUU=;
        b=JgZQf2+mNVDHVxBZhjwzgeidX1BC+b4dzOZcE6VG6HZIU9VX47jLS7snynZwLyliX8
         Di0PrNi/jZHvAJW8ZymihYbbZ4vjm8q4jpv1J+t3lR+9PBLVDDSQ5c2DnTB3N2ys8mc5
         jMyGPHmXSaRYgKkkeasT4kptyoTIkhDYVs8tKB26cH+J4PJ2/QxLhOi4731gkKpii66H
         Cwh3Ubz5mUGPFdVbeSpT/g4EBgof67DWhqIIs2OoPe4Prug567TWfOAppIVcj8HXSIvn
         sHG8Lfj6a9/KZx+eBPZkr6gndLD7yq9MkjxaO1hXKcgTh6f2dwRrH1v+ssAi2gFgxKy2
         3hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yt3F8B/eVJm2Hd//+yp/dZLjFDzdD2v2U/1pjIYvgUU=;
        b=T5bSk7Q61oNaQm5KnDImC68Ql245wAoKjUOxCPfMzWIONKYNEN8VOJ0k9vhDa4Y2QK
         vv+4aX1dWnQimb3ceTOzks87ohypBng4QVz3aoPIJVmetycVryTrez/0Z8unIcB2i+6W
         g1BGUjwWJ5xaLFfdh4T1HA/96BLB1JCtwE9Sg4KGl1yk3/P1vpIb99o4+4mz4sxVGPWB
         wfnUgDjT+zJr3wHZpwb+8XUSzTd87cx3TDSzzF5uIFuF92w0hlqwbIsNRKX3lonnY/zi
         FxdHeiTe4fk5KnktK5bB6bSHcE4EcVO7Qq+ynav4H6fMHRgK8MMU8nzoaYa3LrrKDSa4
         l6RA==
X-Gm-Message-State: APjAAAUSTh5PAytGNMA9YahdjmKBcnduq21RuAq/9IxWG/g8dK4KCAz+
        AghJp3UQtSywW+xtsio8GEMPhbE8Zcwe7gt/gu4=
X-Google-Smtp-Source: APXvYqyKOLaVhKi4pfs2aO0Xz+Vcw3PsWgGXerw1rCrm9le9/Pj2Gnz/NxHh7i/AbneKeWXUXQpDsKxdKV2kA2em59g=
X-Received: by 2002:a2e:8908:: with SMTP id d8mr2575989lji.174.1552474081532;
 Wed, 13 Mar 2019 03:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190313070224.30124-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190313070224.30124-1-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 Mar 2019 07:47:59 -0300
Message-ID: <CAOMZO5A-y9GSAARAVeHL-fTcmSzkr=fRN=WFawmx2Ob0Xfykfw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vf610: Add ZII SPB4 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 4:02 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add Device Tree for VF610 based Zodiac Seat Power Box.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
