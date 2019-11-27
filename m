Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE69C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9F42070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5vSWBY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK0Mqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:46:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50625 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfK0Mqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:46:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so6975479wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 04:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qERnKv0tOOCfJjOfEE5blBnr7WHRcvWStEnbvb2aF0g=;
        b=J5vSWBY25deEcYjyrsrcOIy+XQBwg+kFxlEPoHPIkqdNnuTnbbjQX2hSreOloziNsq
         VSpBkcS+PsXVkXWwIfn6lycmoQD0DxFn86Yw+l5JHbxgLBYoUYFN0pvlAGKXlGHQp6Ps
         LkbuAv2QBezgfJw5/kDmN94hVTC2nMXptwDllsznuKyaTAesULZ+ANsL/wGaH8ESiUU3
         R0N5m1EFnkmr9MWbvCn+erMKqnCgpQiFQgy2jSCq5Z29oDJ0ho9luo+4xUu/9lxYoCIQ
         4w+ytdLXvPiGVJpKbZUcoFjDk6xOfdETwnQjDqleWjcqvIqf7Wd+ZFhaHRvGMF3sV2WA
         X1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qERnKv0tOOCfJjOfEE5blBnr7WHRcvWStEnbvb2aF0g=;
        b=V2xjpxId4HaHoBHqtFk/hE/b+KiKZOAGJfQtR6reHmvehJpR9SQwbWnPgsOZTAhsej
         Xge8jsktP0KMJRIJOeJeF5Fn4f2ZArS2nVuOc2SXLbFF85qgvbDrRDlhCFz6coRodyIb
         XhoP/EgyR+YTjef336Q6stzQXODVd3DTsNfDXWeFmCe12XYqw4G/TNS12qt9twxFGc5r
         LUjQJVLA9PzW++9XqKw0AiMxqCA5iNU9QzL/Woyb56e5JI/QP3OHGGg2miGZwqrSxY32
         4e2msOY/wDkEP4NGZoFmZZBpyqmb1kvks7rr4vc6j8Qn4HuvU1Jz4K5i5bpDDGx7KFwu
         PIPw==
X-Gm-Message-State: APjAAAX1di24+hC+Rt68qWzzNCoYoyd1pFSFAefX0oyABhlxa4wF5dU0
        5mg8ErTJ2m/JV6RNKJZzSuQ=
X-Google-Smtp-Source: APXvYqyjuY2NlQHia9pXct7GlLOBZAwtHBiHOsFyYDzLstDrLlgMr6IlILfQ0PbSaEvs8h/KYMhiWg==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr3903416wmg.134.1574858805137;
        Wed, 27 Nov 2019 04:46:45 -0800 (PST)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id i71sm20950628wri.68.2019.11.27.04.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 04:46:44 -0800 (PST)
Date:   Wed, 27 Nov 2019 13:46:38 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andrew Lunn <andrew@lunn.ch>, Peng Fan <peng.fan@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Message-ID: <20191127124638.GC5108@optiplex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39c043d-d098-283d-97b0-2a44aefec2f1@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/19, Marc Gonzalez wrote:
> On 26/11/2019 15:54, Oliver Graute wrote:
> 
> > this patch broke my imx8qm nfs setup. With the generic phy driver my
> > board is booting fine. But with the AT803X_PHY=y enabled  I'm running
> > into the following phy issue. So on my side it looks inverse as on
> > yours. What is the best proposal to fix this?
> > 
> > [    5.550442] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > [    5.573206] Sending DHCP requests ...... timed out!
> > [   95.339702] IP-Config: Retrying forever (NFS root)...
> > [   95.348873] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> > [   99.438443] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > [   99.461206] Sending DHCP requests ...... timed out!
> 
> Which DTS are you using?

I'am using this DTS which I'am currently working on:

https://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/689501.html
> 
> I bet one dollar that 6d4cd041f0af triggered a latent bug in the DTS.

So what should I fix in my device tree?

Best regards,

Oliver
