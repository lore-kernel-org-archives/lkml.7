Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06225C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E142086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566213312;
	bh=ymGwVAX0I+0VFt8WgKTpeTEznG8h0UMRvuX0NkQvpWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ood6qwrKjaiCT1p1vaeBucjk/Gzh67Kx1qxHuGp3MCtr9EkNbEZjVOoMqnEz2glGn
	 DgKotXjPwQmvquP94B6dDisduUCk/dKurVtsqlHDagNtJzx5OZgg0R3JGsg87mCnYk
	 VQpjRcnhQWbVilkvIk/GqeIu+c+7ZlpbZUDZStnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfHSLPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfHSLPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:15:11 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B342085A;
        Mon, 19 Aug 2019 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213310;
        bh=ymGwVAX0I+0VFt8WgKTpeTEznG8h0UMRvuX0NkQvpWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xa8JN/bP6xPf/UKv20Rx2Al9PMGu2UEpxrqTLEtQ/hZgWQhkkJCHusIa9KAwdraY+
         MSloNtTcsh86nTzofcfOSfdqRadgXmzv6z/rVm1kP2nVl9uRNv64nkKWzgeJa+92jI
         WtTFA3Yp4k4bPpoLrxl6SyVI+7lQJEzb0iJLxXHg=
Date:   Mon, 19 Aug 2019 13:14:58 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 05/21] ARM: dts: imx7-colibri: add recovery for I2C
 for iMX7
Message-ID: <20190819111457.GO5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-6-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-6-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:21PM +0000, Philippe Schenker wrote:
> From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> - add recovery mode for applicable i2c buses for
>   Colibri iMX7 module.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks.
