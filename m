Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00567C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C800921721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="huVj3wZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGAVVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:21:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39669 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfGAVVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so7163764pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=70Y1QPu/qhMgHyq/2RSm32FTi8ixyuGULx6P5hAiwAo=;
        b=huVj3wZJ/5a01x2u8yW9IKMsW2kdHXmGlQ6d+tRcMwljLwf9bU3a87QCR33p1OfXgi
         z+0x6xiwiY1ZVtrHhxpX6jhBU3FHsRO7qVLmJzH4EDPQjePaS9VmDNkWo5bQbSkitBhw
         st31rPwZIa9/knPvA1KVMpYLI4u4aysRL6QO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=70Y1QPu/qhMgHyq/2RSm32FTi8ixyuGULx6P5hAiwAo=;
        b=qZBJigkOwCNrsRmBCmxN8Kk02RPEaodC/aRNeOIsEi1LlOWZPjpcplI71oMkqIleIM
         /P2kmWY3KcycjCEtAFqs/P6wK4ij0I6h5AHCwUpHW+xcL6SqU7QtIV4d7NV5JnA8FRx0
         LCgZ79jyKtRb8emKfHKvJlzoPPhwOAHTVDubd1m2L6RReuj8W1a75G+PnQk0GQHEHC9k
         8J90sAVugiONYF7+jjcx4XV1MtYWSpdsKb3xX9FKRBc6WbPdJXod36OTXcvy3AcV8yfF
         lgPJ50bUOWv97IbHamGDeqTFQmuIaoNIYBvB2uO+eokIk2WUNkWAMihbo30iBAi5bwGk
         o7yQ==
X-Gm-Message-State: APjAAAXCG9dEHKiGYUhzx3L85X91rRpKaHk063t+e3RL4GD8iqR+5uiU
        C1Q7rH3Wd9WL4zeEtjlIq87n8A==
X-Google-Smtp-Source: APXvYqwNXsJhhY160Fk9GwXuW8u5kfJBWIDO19fh8yy/VUem+6dkNurZTZpdAhxeEGrNG+RIrLLtCQ==
X-Received: by 2002:a65:5242:: with SMTP id q2mr12138983pgp.135.1562016112307;
        Mon, 01 Jul 2019 14:21:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h62sm11280323pgc.54.2019.07.01.14.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 14:21:51 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:21:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] net: phy: realtek: Enable accessing RTL8211E
 extension pages
Message-ID: <20190701212149.GA250418@google.com>
References: <20190701195225.120808-1-mka@chromium.org>
 <20190701195225.120808-2-mka@chromium.org>
 <20190701200248.GJ30468@lunn.ch>
 <35db1bff-f48e-5372-06b7-3140cb7cbb71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35db1bff-f48e-5372-06b7-3140cb7cbb71@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:37:16PM +0200, Heiner Kallweit wrote:
> On 01.07.2019 22:02, Andrew Lunn wrote:
> > On Mon, Jul 01, 2019 at 12:52:24PM -0700, Matthias Kaehlcke wrote:
> >> The RTL8211E has extension pages, which can be accessed after
> >> selecting a page through a custom method. Add a function to
> >> modify bits in a register of an extension page and a few
> >> helpers for dealing with ext pages.
> >>
> >> rtl8211e_modify_ext_paged() and rtl821e_restore_page() are
> >> inspired by their counterparts phy_modify_paged() and
> >> phy_restore_page().
> > 
> > Hi Matthias
> > 
> > While an extended page is selected, what happens to the normal
> > registers in the range 0-0x1c? Are they still accessible?
> > 
> AFAIK: no

From my observations it looks like registers 0x00 to 0x0f are still
accessible, but not the ones above. IIUC 0x00-0x0f are standard
registers, the others are vendor specific.
