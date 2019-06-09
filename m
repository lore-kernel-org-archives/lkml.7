Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0859CC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78D8206E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 20:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="loFZ3wg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfFIUik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 16:38:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39560 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfFIUij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 16:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aAgxuie2Hz2Ygvh1FvKs8sfXSa5TA6FHsD2v2BeNmlU=; b=loFZ3wg+RZyrJP5WO6P8HV8ypt
        gJzwviy22tCzfN56o6PocZ5VpSRqs864Mo6i6I+Uw8bhxw/vrbHap1giCG/rTkFt64tRsLPv8TE/L
        pPNZIwacKiE8RFy8kheg+N5BzbBM0mDbgETBoA9ACUsBkqJgg0bAHswXQXmQ2g7Xzl9k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1ha4aC-0002PI-Ik; Sun, 09 Jun 2019 22:38:28 +0200
Date:   Sun, 9 Jun 2019 22:38:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com,
        devicetree@vger.kernel.org, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC next v1 2/5] gpio: of: parse stmmac PHY reset line specific
 active-low property
Message-ID: <20190609203828.GA8247@lunn.ch>
References: <20190609180621.7607-1-martin.blumenstingl@googlemail.com>
 <20190609180621.7607-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609180621.7607-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 08:06:18PM +0200, Martin Blumenstingl wrote:
> The stmmac driver currently ignores the GPIO flags which are passed via
> devicetree because it operates with legacy GPIO numbers instead of GPIO
> descriptors.

Hi Martin

I don't think this is the reason. I think historically stmmac messed
up and ignored the flags. There are a number of device tree blobs
which have the incorrect flag value, but since it was always ignored,
it did not matter. Then came along a board which really did need the
flag, but it was too late, it could not be enabled because too many
boards would break. So the hack was made, and snps,reset-active-low
was added.

Since snps,reset-active-low is a hack, it should not be in the
core. Please don't add it to gpiolib-of.c, keep it within stmmac
driver.

	Andrew
