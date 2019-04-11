Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C583C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4421841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554966005;
	bh=VgxethY+m781ZfdZXixxzI2OEMx5Q5yDPaE2WMKkeag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fbPtxVe/LfYqQMuQV4yqbkMqCrDpqRHLia/5dMLw2lN7nY3okKx4NdHt9XW971Ftx
	 i4t16fNvaPZIC2o9nhIedC6fHHux8ewINajdIEeI0dk7CQOpnXCvtK30dNEOMnYMpF
	 dFJGGou/2Iwu4h+G8kww7nERinZ5fBwVgJ/xdVNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDKHAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfDKHAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:00:03 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2657B2082E;
        Thu, 11 Apr 2019 06:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554966002;
        bh=VgxethY+m781ZfdZXixxzI2OEMx5Q5yDPaE2WMKkeag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sqlg86fqjJ9FXjjnrsTKBlUg2weuklSB/piyUzWU3P36J8aw4v+xbnEL88JqD3Hhj
         CHmlyem+NQS4OMRV0Egdk7dbrUaPhLLUL0ytVlGtZHToNjhAPndgKU9VOCKdrJtuPF
         VDFygPnZ5uoAC2S7fKeHk4JKexFfHnnNGAiI087Q=
Date:   Thu, 11 Apr 2019 14:59:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-sabreauto: update opp table for auto
 part
Message-ID: <20190411065945.GD26817@dragon>
References: <1554709166-21952-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554709166-21952-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 07:44:21AM +0000, Anson Huang wrote:
> Update i.MX6DL automotive part's opp table according to i.MX6DL
> automotive datasheet Rev.9, 11/2018, it adds 996MHz set-point
> support as below:
> 
> LDO enabled(min value):
> 996MHz: VDDARM: 1.275V, VDDSOC: 1.175V;
> 792MHz: VDDARM: 1.150V, VDDSOC: 1.150V;
> 396MHz: VDDARM: 1.125V, VDDSOC: 1.150V;
> 
> Adding 25mV to cover board IR drop, for LDO enabled mode of 996MHz,
> as the max value of LDO output can NOT exceed 1.3V, so 25mV is NOT
> added for VDDARM.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
