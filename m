Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C7C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634ED2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558573218;
	bh=6VmfxYZT1/N9X/Zww2/fBpROnyCJQdfMekxssWKH/pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0m/ojduVShR9BYyrgDAr17G4yQKlU2QjXu8i9xCN10IK+gq+DZ0u8Dszi1MA62LmP
	 nnIi6fBiWq3Std+UeqJDKhNdFMFGPC8GjZ2t9B3Z3f+fvPvCrDuxucB9t7B0FLDpXu
	 3bkQ0GWSajzWkvaXd+d7hKmadDGr/mD1W7Ik8n/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfEWBAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfEWBAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:00:17 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E475E2089E;
        Thu, 23 May 2019 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558573216;
        bh=6VmfxYZT1/N9X/Zww2/fBpROnyCJQdfMekxssWKH/pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIXouqScCt16f2CM3Ld1QgkW38/LkVS0CAQ5w6Mqg3cOhpOu2HEk38JHBZ0CJ/0nd
         zk9e0BS2k2WZQ0C1Nazg+9wAW1CK3jXRKbZHrTMSMTclIy7e8TAPj/gG6gZFoPOnZ2
         otxiMy87B2aBsIgZnTyGoZPYPpN7j8p6YLZHmCN4=
Date:   Thu, 23 May 2019 08:59:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3] clk: imx8mq: add SNVS clock to clock tree
Message-ID: <20190523005917.GC16359@dragon>
References: <1557882259-3353-1-git-send-email-Anson.Huang@nxp.com>
 <1557882259-3353-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557882259-3353-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:09:30AM +0000, Anson Huang wrote:
> i.MX8MQ has clock gate for SNVS module, add it into clock tree
> for SNVS RTC driver to manage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
