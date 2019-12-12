Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0767BC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCACB214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfLLJpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:45:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36187 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfLLJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:45:41 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ifL2O-0005Pq-4u; Thu, 12 Dec 2019 10:45:36 +0100
Message-ID: <7e13626ae46b6241549e33c983695bed316e9a6f.camel@pengutronix.de>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Dec 2019 10:45:34 +0100
In-Reply-To: <20191212013323.GZ15858@dragon>
References: <20191212083556.1b98ece7@canb.auug.org.au>
         <20191212013323.GZ15858@dragon>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Do, 2019-12-12 at 09:33 +0800, Shawn Guo wrote:
> Hi Stephen,
> 
> On Thu, Dec 12, 2019 at 08:35:56AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the imx-mxs tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> 
> Sorry for the breakage.
> 
[...]
> > The warning was (probably) introduced by commit
> > 
> >   e79295edf1df ("ARM: dts: imx6: RDU2: link eDP bridge to panel")
> 
> I have just taken these two commits out.

The commit message of this change should maybe have been clearer, but
the warning is expected. The bootloader fixes the DT before passing it
on to Linux by completing the other direction of link if eDP is
enabled.

How do we want to handle this? If you totally dislike the warning I can
get around it by not adding the link and adding some more complexity to
the bootloader, but given the choice I would like to keep the
incomplete link in the Linux DT and keep bootloader complexity down.

Regards,
Lucas

