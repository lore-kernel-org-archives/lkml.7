Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7683BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED7020652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FH8+Zt+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfDZWMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:12:36 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46281 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfDZWMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ToePr+rdlhjeTYkBh742gtporvEJZI5OcYXuqgjiTnE=; b=FH8+Zt+fDFd6vtGYw7qvfbgfW7
        WoWesmYq2bOeXgxLqHbpnVmoteXlvzHvyb6RDY2QjydF7Z6ShgGv7ae5eRRSAcOT1quNTXKOiLNWV
        rt+lmrx5J7FliFhY2pE7p0LPUvzAfDkAtxCUZ2MpRx2Cx7JVaAI3TTLwPJfGqCfaHNaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK956-0006Kd-7R; Sat, 27 Apr 2019 00:12:32 +0200
Date:   Sat, 27 Apr 2019 00:12:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next v2 13/20] net: ethernet: ti: davinci_mdio: use
 devm_ioremap()
Message-ID: <20190426221232.GF23059@lunn.ch>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
 <1556298762-8632-14-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556298762-8632-14-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:12:35PM +0300, Grygorii Strashko wrote:
> The Davinci MDIO in most of the case implemented as module inside of TI
> CPSW subsystem and fully depends on CPSW to be enabled, but historically
> it's implemented as separate Platform device/driver and defined in DT files
> in two ways:
> - as standalone node
> - as child node of CPSW subsystem.
> 
> In later case it's required to split CPSW subsystem "reg" property to
> exclude MDIO I/O range which is not useful.
> 
> Hence, replace devm_ioremap_resource() with devm_ioremap() to allow define
> full I/O range in parent CPSW subsystem without spliting.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
