Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F6DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56582208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f2ECr/tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfDWTCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:02:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41827 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWTCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ia7LuYatyrJGh91HOiVWhiN0ei1JZZ9US3zdwwg6W5I=; b=f2ECr/tzohUDJ7Hl/gZZoaMKxw
        qJaKRdiyGCWNGCWMEV/abwg8UvFAGB5iMXfRVcNVLO+Vdgfq/09av1h5kQm+GHfCCyXdjdcu5QbCE
        hlfd/TDgVEB5yEu2ywHIMoQMtnQrzeczALEgiShCQ5+Usxw3rlHPVRwOvrNlYc2vXaLw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJ0g0-0001lf-KU; Tue, 23 Apr 2019 21:01:56 +0200
Date:   Tue, 23 Apr 2019 21:01:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 17/19] net: ethernet: ti: cpsw: introduce mac sl
 module api
Message-ID: <20190423190156.GJ28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-18-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556024950-20752-18-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:09:08PM +0300, Grygorii Strashko wrote:
> +void cpsw_sl_reset(struct cpsw_sl *sl, unsigned long tmo)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(tmo);
> +
> +	/* Set the soft reset bit */
> +	cpsw_sl_reg_write(sl, CPSW_SL_SOFT_RESET, CPSW_SL_SOFT_RESET_BIT);
> +
> +	/* Wait for the bit to clear */
> +	do {
> +		cpu_relax();
> +	} while ((cpsw_sl_reg_read(sl, CPSW_SL_SOFT_RESET) &
> +		  CPSW_SL_SOFT_RESET_BIT) &&
> +		  time_after(timeout, jiffies));

Hi Grygorii

If you are waiting for milliseconds, you probably should have a
sleep/delay in here.

> +int cpsw_sl_wait_for_idle(struct cpsw_sl *sl, unsigned long tmo)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(tmo);
> +
> +	do {
> +		cpu_relax();
> +	} while (!(cpsw_sl_reg_read(sl, CPSW_SL_MACSTATUS) &
> +		  sl->idle_mask) && time_after(timeout, jiffies));
> +

Same here.

> +	if (!(cpsw_sl_reg_read(sl, CPSW_SL_MACSTATUS) & sl->idle_mask)) {
> +		dev_err(sl->dev, "cpsw_sl failed to soft-reset.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;

  Andrew
