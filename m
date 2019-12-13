Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BEDC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560D7206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLMIFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:05:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36751 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:05:10 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iffwj-0002Dt-9O; Fri, 13 Dec 2019 09:05:09 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iffwi-0008Gn-Vs; Fri, 13 Dec 2019 09:05:08 +0100
Date:   Fri, 13 Dec 2019 09:05:08 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] libata: Fix retrieving of active qcs
Message-ID: <20191213080508.if5yxhtyl27nej5z@pengutronix.de>
References: <20191213080334.26922-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213080334.26922-1-s.hauer@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:04:26 up 158 days, 14:14, 54 users,  load average: 0.26, 0.30,
 0.18
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:03:34AM +0100, Sascha Hauer wrote:
> ata_qc_complete_multiple() is called with a mask of the still active
> tags.
> 
> mv_sata doesn't have this information directly and instead calculates
> the still active tags from the started tags (ap->qc_active) and the
> finished tags as (ap->qc_active ^ done_mask)
> 
> Since 28361c40368 the hw_tag and tag are no longer the same and the
> equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> started and this will be in done_mask on completion. ap->qc_active ^
> done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
> the internal tag will never be reported as completed.
> 
> This is fixed by introducing ata_qc_get_active() which returns the
> active hardware tags and calling it where appropriate.
> 
> This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
> problem. There is another case in sata_nv that most likely needs fixing
> as well, but this looks a little different, so I wasn't confident enough
> to change that.
> 
> Fixes: 28361c403683 ("libata: add extra internal command")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Ignore this, it lacks the v2 tag :-/

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
