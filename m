Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C858C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C972182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfEUJVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:21:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51169 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:21:09 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hT0xH-00004w-P8; Tue, 21 May 2019 11:21:07 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hT0xH-0002Ya-4r; Tue, 21 May 2019 11:21:07 +0200
Date:   Tue, 21 May 2019 11:21:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-mtd@lists.infradead.org
Subject: Re: nvmem creates multiple devices with the same name
Message-ID: <20190521092107.zpdkkhaanzruhqui@pengutronix.de>
References: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
 <a9ccac90-7b2f-41da-2ca9-ca3bba52781b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ccac90-7b2f-41da-2ca9-ca3bba52781b@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:11:48 up 3 days, 15:30, 49 users,  load average: 0.10, 0.18, 0.16
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:02:32AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 21/05/2019 09:56, Sascha Hauer wrote:
> > . Are there any suggestions how to register the nvmem devices
> > with a different name?
> 
> struct nvmem_config provides id field for this purpose, this will be used by
> nvmem to set the device name space along with name field.

There's no way for a caller to know a unique name/id combination.
The mtd layer could initialize the id field with the mtd number, but
that would still not guarantee that another caller, like an EEPROM
driver or such, doesn't use the same name/id combination.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
