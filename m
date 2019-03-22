Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA87C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B63213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553218909;
	bh=uYBX3bhEnaUPTBPYiSzhoRkAXPPBFjyffwyaKLoda04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GfAQ1YH8gw6b9htG+o+91z7uJahYOwr7iMYZnGoNCYIviLnlxXsctCHsTaePOcqrY
	 AAiGTaJ+d3GqJeTU3Cpy9OoTBxBu40EihprpCwoS1LEYh+zumKHSTbmm9lLwrT0KNg
	 8Z3P4gRecKM3MNPO/5cMJInrcyuWtPpwfTXkepFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCVBlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfCVBlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:41:47 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3218B213F2;
        Fri, 22 Mar 2019 01:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553218907;
        bh=uYBX3bhEnaUPTBPYiSzhoRkAXPPBFjyffwyaKLoda04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+B28mnD656Mesqh783xtgIY1Sg1pbJoXdpf4IDA8/ZQO9LB/mss0CtFJQumqECnN
         InnjiES+DBWEahodseqR87DNhSHMtZl3khgUUa5jT0MWNyxHKufIhMeDWCFeV5aWhJ
         /ykHe6hsrhiw/7CVV18LlXeqfbu3wSRWU9ZGjB2Y=
Date:   Fri, 22 Mar 2019 09:41:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: dts: imx50: Add PHY node for usbotg and adjust
 clocks
Message-ID: <20190322014120.GS12513@dragon>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
 <20190319152421.16179-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319152421.16179-4-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:24:18PM +0100, Jonathan Neuschäfer wrote:
> Even though the ChipIdea USB controller binding[1] doesn't specify the
> properties that reference a PHY as required, the Linux driver
> requires[2] such a reference.
> 
> The clock situation is like on i.MX53: The USB controller is clocked
> from IMX5_CLK_USBOH3_GATE and the PHY from IMX5_CLK_USB_PHY1_GATE.
> 
> [1]: Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> [2]: Search for EINVAL in drivers/usb/chipidea/ci_hdrc_imx.c
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied, thanks.
