Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A743F20665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="gFpS54Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfGVLMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:12:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52798 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGVLMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:12:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so34724534wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugRN07ELNBGju0FZXfeTINwMh3Eu6S1IN6qjdKCIFBE=;
        b=gFpS54Ax3j5KsNqU6isZdGlE+UrqmTn1H7kDrcDfPtz5MDBUHiilO+ZhfhdUYaCeeU
         rnEF6ZKsuR9+Iv9LsEGoAaEVzSJuQ9SY3MRzFskJQjMVNJtpIQo5TVJC2A470Fnv5WKA
         Kkwh4Qvq5M8KWeAHKby9Ab4DdLCxK9kvQlmG+LVcXjze03oJ9l16KEKk7AfepwwSlUmB
         4PCxmpKH72WnymNl5ig50UJfK/N7j5HIxINywTZieue+9SYmx5xcD735gsjHwAFt1cX0
         5yC2/bv/9IG7OT2uIPZuVOkzW+kwc0AoBZclZ7h01TmKpUOxv2kH86Bx5WGN7FOca3nn
         oKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugRN07ELNBGju0FZXfeTINwMh3Eu6S1IN6qjdKCIFBE=;
        b=FgD0FrS31qxxdd2e8t76S5qzhzkAGqxHHOROmU0OjTfzYZMDtM9E0sDS8huFUdwPJA
         utYXcPaOzwoJsDOlawWPRGOZqqfSepJ2FYm/dGGmq3N3RBZoS7VzRDBltsnHF7GdqO4j
         YaxcYvz52CZUxQRwyBKV8mMorYMBvb0TiqwIjlqTUcHBBoAPxHetLgYYfOQ01GAYGtaY
         H6ZypjNNDEzt7lIAJDPPF/v9jeHOR5ur7pasjM7m8Si8Y2wtTYVVcdZC+93Q7pLSqiQL
         7s3moVGD9F3Vn+79ykYmTIsTpbjpi4b+6vg2/1gFjP2+sqAkEboYBuz6mzYt6RUuQKVE
         uKhg==
X-Gm-Message-State: APjAAAU0Ar9F1tbHUoVPQfps2sgL56Ek7RPfJLspIn0iL67QmBUep1ed
        Up8zThLLTJ3tO2kRsEK/IKLH84W1zYRAspFuF1E=
X-Google-Smtp-Source: APXvYqyMOVi1QeBfQY7y3XFV+dCnJfmPmLUDhkHjFCy6dBRz6GZNepCI13S7cLN1oIlGT7gkQSUn4ppFimfg0qTYAS4=
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr64703351wmj.7.1563793921410;
 Mon, 22 Jul 2019 04:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562149883.git.joabreu@synopsys.com> <1b254bb7fc6044c5e6e2fdd9e00088d1d13a808b.1562149883.git.joabreu@synopsys.com>
 <29dcc161-f7c8-026e-c3cc-5adb04df128c@nvidia.com> <BN8PR12MB32661E919A8DEBC7095BAA12D3C80@BN8PR12MB3266.namprd12.prod.outlook.com>
 <20190722101830.GA24948@apalos>
In-Reply-To: <20190722101830.GA24948@apalos>
From:   Lars Persson <lists@bofh.nu>
Date:   Mon, 22 Jul 2019 13:11:50 +0200
Message-ID: <CADnJP=thexf2sWcVVOLWw14rpteEj0RrfDdY8ER90MpbNN4-oA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: stmmac: Introducing support for Page Pool
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:18 PM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, Jul 18, 2019 at 07:48:04AM +0000, Jose Abreu wrote:
> > From: Jon Hunter <jonathanh@nvidia.com>
> > Date: Jul/17/2019, 19:58:53 (UTC+00:00)
> >
> > > Let me know if you have any thoughts.
> >
> > Can you try attached patch ?
> >
>
> The log says  someone calls panic() right?
> Can we trye and figure were that happens during the stmmac init phase?
>

The reason for the panic is hidden in this one line of the kernel logs:
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

The init process is killed by SIGSEGV (signal 11 = 0xb).

I would suggest you look for data corruption bugs in the RX path. If
the code is fetched from the NFS mount then a corrupt RX buffer can
trigger a crash in userspace.

/Lars
