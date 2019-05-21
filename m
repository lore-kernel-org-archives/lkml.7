Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C6C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E9521783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558412157;
	bh=TQBbgsbg7JWnbEI2dswhoI88Uh8METCt3Pb9gkO1tk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BKkaQJhPmgZxV7HGSOerTA+CMsoH23wztFl5rDio3Yu3bSjCIc63NqFy85YlVO6rK
	 IKjBjnqtQIXV6aVTBlUItmYGfCl6dUABE2VXw3MhN1ik17zSMtrWglasVy3Kk4C5Et
	 EaJGMXDUBsCiHQ0C4O1cW6YD+tsYKretYTGlSNCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfEUEP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfEUEP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:15:56 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442BB21773;
        Tue, 21 May 2019 04:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558412156;
        bh=TQBbgsbg7JWnbEI2dswhoI88Uh8METCt3Pb9gkO1tk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vv7SowBI+n/sk5Bcp/+vac8sDqclukeH2MwatV8jwS/MfWlLmFWVgC29U1txvJ/Tm
         8iuhELNZb76yAYDz0ZclUy5UZ4HBCnjqFlr4KssG5dilko3ePfNe8EEsrmIBNrwGa3
         qaR4Wp69ZyLwqFt4ECaaP8NenJRD7ObNQFG72nGA=
Date:   Tue, 21 May 2019 09:45:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 04/14] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Message-ID: <20190521041552.GD15118@vkoul-mobl>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-5-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557249513-4903-5-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-19, 09:16, Robin Gong wrote:
> Since sdma_transfer_init() will do sdma_load_context before any
> sdma transfer, no need once more in sdma_config_channel().

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
