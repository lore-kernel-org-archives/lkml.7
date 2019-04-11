Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E728C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516D92133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554960516;
	bh=5RMz2ud1JQG5UkANn3TAsPGnAwIFuZIlRxDq7I0Y6Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mt9eU2nYsMB1EN89BHDyk2UNdAS39NGYFJ180bWNTvt6C6lzh+RSp/7tKnkmj9YjT
	 RtoCBIowEFCTfnFmMRzQfhBEKoVTMfGBDl9j3Lrt1vg3WbkHG9zjCdtmA9pVXRHMqZ
	 k40dEcL9ofFSidrm+2Z5kFxSGDJDIo7KRu8z5uoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDKF2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKF2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:28:22 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A642133D;
        Thu, 11 Apr 2019 05:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554960501;
        bh=5RMz2ud1JQG5UkANn3TAsPGnAwIFuZIlRxDq7I0Y6Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2TNqAJ+EdMIT7CYF/TINS1daEhN+t28yDP9WGCkg+sz51tC3Fb8z0DcEWpsPiX+G
         jyRn1lE+s+4WZw4TFIEEYzgRjBCmK4FWBM0gGBD8cGj1A+MfPbH3C8ZPEtMCs9YfZ9
         DQTTQg48B7LW2CcoN1wIltw2cDqj6hvkrIRe0O0E=
Date:   Thu, 11 Apr 2019 13:28:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Sven.Schmitt@mixed-mode.de" <Sven.Schmitt@mixed-mode.de>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] soc: imx: gpc: use devm_platform_ioremap_resource()
 to simplify code
Message-ID: <20190411052803.GR26817@dragon>
References: <1554098543-5036-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554098543-5036-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 06:07:08AM +0000, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
