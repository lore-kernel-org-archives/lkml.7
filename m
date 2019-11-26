Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9256C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4562068F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J+HyXtxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfKZBN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:13:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44709 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfKZBN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 20:13:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id g24so12711256qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 17:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rfPK0DW11RQCCEDcxZu9s9ehCYd8wL3gZp5EtT3+S4=;
        b=J+HyXtxJxQ9cmxUOaTi3edrKTi1um9hQ0jl5kLojxkLncTYNx/1VSM946bOpff6x+v
         np/hS25qgsQFaFoccVLTunSDJKdxc7MZdXwz8syC/1rwbtklaNSw80VoXG2uOu6ERbH5
         ltEuDVFv8LHpEBXTslHVbOuOXXBM3bP/y8IHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rfPK0DW11RQCCEDcxZu9s9ehCYd8wL3gZp5EtT3+S4=;
        b=BhnqkH1xcHxTaEBz0R2dglpcpYn5Lhdul1MUxxyhqJ4QQWV3RT1m7/ImY42NEmPrVG
         a1PkWV4+pXGZ5W1XsHLS4mqbHhKcnYfjSi+BgLdzsfiu7g7MYUc952rE/EX3Vv6UTeCk
         qfDe69jmddPYnUQhs/kG7kLpxK1a4mCwkj4fwQ9gYlqGaI6w2pbin7wUaxA9l3e8hnKP
         bPp2apeVLUwQbsOepGpYxv/hVBYNW8RltWRbbdvWkWIWJCKLHvPsUj38gtXvZjZpcdDF
         rD/Ed1KoAtZ/0M3YsKTFqJ3GB96OS7kgbH9FfM6BhJHxhl+dmF1RWg2bn7wiXym1JBeL
         Wv/w==
X-Gm-Message-State: APjAAAWofFIEyacseG81Xg9M4evTrvROYSKamGqN0sYLfmWJ1o5w8voP
        It4CjShaldKWYrU9n0Ft+CZTvWCG5mA=
X-Google-Smtp-Source: APXvYqzKwqlH4rU+Wd3PbTek/jYf3UerElPj8lJeKSPdLoK7ByA3U7LjNhMO7x+GfmdTKBcm8ER5vQ==
X-Received: by 2002:ac8:2e57:: with SMTP id s23mr32069004qta.204.1574730805658;
        Mon, 25 Nov 2019 17:13:25 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id i35sm4978637qtc.18.2019.11.25.17.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 17:13:24 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id e2so14694120qkn.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 17:13:23 -0800 (PST)
X-Received: by 2002:a37:8285:: with SMTP id e127mr13935443qkd.62.1574730803238;
 Mon, 25 Nov 2019 17:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20191113005816.37084-1-briannorris@chromium.org>
 <32422b2d-6cab-3ea2-aca3-3e74d68599a3@gmail.com> <20191123005054.GA116745@google.com>
 <9d6210ec-fab5-c072-bdf4-ed43a6272a51@gmail.com>
In-Reply-To: <9d6210ec-fab5-c072-bdf4-ed43a6272a51@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Nov 2019 17:13:11 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMN-=jXQieqsCN+18H7wMnYLw_M1WijAYcb_2AaCwK5cg@mail.gmail.com>
Message-ID: <CA+ASDXMN-=jXQieqsCN+18H7wMnYLw_M1WijAYcb_2AaCwK5cg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] r8169: check for valid MAC before clobbering
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Chun-Hao Lin <hau@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 2:46 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> On 23.11.2019 01:51, Brian Norris wrote:
> > On Wed, Nov 13, 2019 at 09:30:42PM +0100, Heiner Kallweit wrote:
> >> If recompiling the BIOS isn't an option,
> >
> > It's not 100% impossible, but it seems highly unlikely to happen. To me
> > (and likely the folks responsible for this BIOS), this looks like a
> > kernel regression (this driver worked just fine for me before commit
> > 89cceb2729c7).
> >
> On an additional note:
> The referenced coreboot driver is part of the Google JECHT baseboard
> support. Most likely the driver is just meant to support the Realtek
> chip version found on this board. I doubt the driver authors intended
> to support each and every Realtek NIC chip version.

I understand that -- I'm specifically seeing problems on the Jecht
family of devices (Jecht was the reference board), which is why I
pointed you there :) All devices in that family use a Realtek chipset
that appears to be RTL8168G, and they all only program the registers I
pointed at in the first place.

One side note: I'm not quite sure how (again, no documentation...) but
some devices appear to have a different valid MAC address in the
GigaMAC register, which is why I see this problem. If they all just
left it 0x00, then I'd be in OK shape.

Brian
