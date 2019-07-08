Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D4C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5BA20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfGHHOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:14:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35991 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGHHOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:14:21 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hkNqt-0000Xy-P7; Mon, 08 Jul 2019 09:14:19 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hkNqt-0001y2-4P; Mon, 08 Jul 2019 09:14:19 +0200
Date:   Mon, 8 Jul 2019 09:14:19 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: nvmem creates multiple devices with the same name
Message-ID: <20190708071419.eqhajizbipt24xl3@pengutronix.de>
References: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
 <a9ccac90-7b2f-41da-2ca9-ca3bba52781b@linaro.org>
 <20190521092107.zpdkkhaanzruhqui@pengutronix.de>
 <20190701080642.4oxmw7c3rmwrt5ee@pengutronix.de>
 <45d0cfaf-2511-4b1e-f4da-b67fa9f9e867@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d0cfaf-2511-4b1e-f4da-b67fa9f9e867@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:02:28 up 13:12, 24 users,  load average: 0.18, 0.32, 0.32
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:54:54PM +0100, Srinivas Kandagatla wrote:
> Hi Sascha,
> 
> On 01/07/2019 09:06, Sascha Hauer wrote:
> > Hi Srinivas,
> > 
> > On Tue, May 21, 2019 at 11:21:07AM +0200, Sascha Hauer wrote:
> > > On Tue, May 21, 2019 at 10:02:32AM +0100, Srinivas Kandagatla wrote:
> > > > 
> > > > 
> > > > On 21/05/2019 09:56, Sascha Hauer wrote:
> > > > > . Are there any suggestions how to register the nvmem devices
> > > > > with a different name?
> > > > 
> > > > struct nvmem_config provides id field for this purpose, this will be used by
> > > > nvmem to set the device name space along with name field.
> > > 
> > > There's no way for a caller to know a unique name/id combination.
> > > The mtd layer could initialize the id field with the mtd number, but
> > > that would still not guarantee that another caller, like an EEPROM
> > > driver or such, doesn't use the same name/id combination.
> > 
> > This is still an unresolved issue. Do you have any input how we could
> > proceed here?
> 
> Sorry for the delay!
> I think simplest solution would be to check if there is already an nvmem
> provider with the same name before assigning name to the device and then
> append the id in case it exists.
> 
> Let me know if below patch helps the situation so that I can take this in
> next cycle!
> 
> ----------------------------------->cut<----------------------------
>     nvmem: core: Check nvmem device name before adding the same one
> 
>     In some usecases where nvmem names are directly derived from
>     partition names, its likely that different devices might have
>     same partition name.
>     This will be an issue as we will be creating two different
>     nvmem devices with same name and sysfs will not be very happy with that.
> 
>     Simple solution is to check the existance of the nvmem provider with
>     same name and append an id if it exists before creating the device name.

This solution obviously works for me. I am not sure if that's really
what we want as the resulting names in sysfs are not predictable in any
way. In that case we might be better off using mtdx as Boris suggested.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
