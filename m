Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6D0C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B2821479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0hxt4DjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfGAUC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:02:57 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46530 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAUC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PQFAkapfS8xgZfnHXRT1zDqAKUWQOTpuUjViOkWeAro=; b=0hxt4DjO0jhoaYw+djxVjTVxNF
        +Dmlef7Xy2ylTdCkLXQzKY14rVGEylt4UE8hKAQs2cwMab7AAnECCexrj4c+WArywGYDAriMr9r3l
        0NqL/Yd1OnxQrZtzlFXAtt2Fpa073PuooQqhr6/mNUhL5ijA/hSQFGEZISwT9q1IngHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hi2Vk-0001Nm-Ep; Mon, 01 Jul 2019 22:02:48 +0200
Date:   Mon, 1 Jul 2019 22:02:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] net: phy: realtek: Enable accessing RTL8211E
 extension pages
Message-ID: <20190701200248.GJ30468@lunn.ch>
References: <20190701195225.120808-1-mka@chromium.org>
 <20190701195225.120808-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701195225.120808-2-mka@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 12:52:24PM -0700, Matthias Kaehlcke wrote:
> The RTL8211E has extension pages, which can be accessed after
> selecting a page through a custom method. Add a function to
> modify bits in a register of an extension page and a few
> helpers for dealing with ext pages.
> 
> rtl8211e_modify_ext_paged() and rtl821e_restore_page() are
> inspired by their counterparts phy_modify_paged() and
> phy_restore_page().

Hi Matthias

While an extended page is selected, what happens to the normal
registers in the range 0-0x1c? Are they still accessible?

	  Andrew
