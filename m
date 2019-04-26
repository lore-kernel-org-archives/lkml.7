Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A05CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C002089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556279328;
	bh=y2eO2+Egp17vfAqy6bGFhHQulFyPwA2ldw8S2io0kE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Md2ltv0rfORGyQEMBt1F2vbmIetEsMcXVoSi/bpV61QBLqj+LV8j+EXkhM9etM6ZU
	 Z6j4Uu2Vme7TaXgoNkOV53ISnQonSNlXfiufVtxSfo73oJaoXBirzGxl1FtT6bLdwG
	 T/rbOUblObOKR7q9+tYrqSH7UKC07vy9ZGQpVTtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfDZLsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZLsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:48:46 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 572DC2077B;
        Fri, 26 Apr 2019 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556279326;
        bh=y2eO2+Egp17vfAqy6bGFhHQulFyPwA2ldw8S2io0kE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qadh/VoYlZuYyfU98gD8T6FZEBSGf4A0lW0Krf1HiEmLpuYiI1WM64cXRQRbBE7kj
         07YlK+kaiJJSpTCKo5eZHS8+UiXcb3Jdxroc8ALPRiHcPIuZIKsK7vtaZqzTmNDPQi
         dcd+ACdjcsDBM6TsrU6tqhjcqQ56zSh8sN4N+tys=
Date:   Fri, 26 Apr 2019 17:18:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dmaengine: imx-sdma: Only check ratio on parts
 that support 1:1
Message-ID: <20190426114840.GV28103@vkoul-mobl>
References: <20190328133828.20999-1-angus@akkea.ca>
 <20190329152130.18411-1-angus@akkea.ca>
 <20190329152130.18411-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152130.18411-3-angus@akkea.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-03-19, 08:21, Angus Ainslie (Purism) wrote:
> On imx8mq B0 chip, AHB/SDMA clock ratio 2:1 can't be supported,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
> 
> To limit this change to the imx8mq for now this patch also adds an
> im8mq-sdma compatible string.

Applied, thanks

-- 
~Vinod
