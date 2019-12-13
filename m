Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65375C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450C8206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLMIF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:05:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60261 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfLMIF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:05:28 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iffx1-0002LI-3f; Fri, 13 Dec 2019 09:05:27 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iffx0-0008Nd-Qn; Fri, 13 Dec 2019 09:05:26 +0100
Date:   Fri, 13 Dec 2019 09:05:26 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] libata: Fix retrieving of active qcs
Message-ID: <20191213080526.7xfbzlagiaom5qx6@pengutronix.de>
References: <20191212141656.11439-1-s.hauer@pengutronix.de>
 <20191212142314.pcp662fb22pjidaw@pengutronix.de>
 <3edd5096-e824-1e83-8c91-43d1183c73e3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3edd5096-e824-1e83-8c91-43d1183c73e3@kernel.dk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:03:39 up 158 days, 14:13, 54 users,  load average: 0.23, 0.30,
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

On Thu, Dec 12, 2019 at 08:12:27AM -0700, Jens Axboe wrote:
> On 12/12/19 7:23 AM, Sascha Hauer wrote:
> > On Thu, Dec 12, 2019 at 03:16:56PM +0100, Sascha Hauer wrote:
> >> ata_qc_complete_multiple() is called with a mask of the still active
> >> tags.
> >>
> >> mv_sata doesn't have this information directly and instead calculates
> >> the still active tags from the started tags (ap->qc_active) and the
> >> finished tags as (ap->qc_active ^ done_mask)
> >>
> >> Since 28361c40368 the hw_tag and tag are no longer the same and the
> >> equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> >> initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> >> started and this will be in done_mask on completion. ap->qc_active ^
> >> done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
> >> the internal tag will never be reported as completed.
> >>
> >> This is fixed by introducing ata_qc_get_active() which returns the
> >> active hardware tags and calling it where appropriate.
> >>
> >> This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
> >> problem. There is another case in sata_nv that most likely needs fixing
> >> as well, but this looks a little different, so I wasn't confident enough
> >> to change that.
> >>
> >> Fixes: 28361c403683 ("libata: add extra internal command")
> >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> ---
> >>  drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
> >>  drivers/ata/sata_fsl.c    |  2 +-
> >>  drivers/ata/sata_mv.c     |  2 +-
> >>  drivers/ata/sata_nv.c     |  2 +-
> >>  include/linux/libata.h    |  1 +
> >>  5 files changed, 27 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> >> index 28c492be0a57..d73bec933892 100644
> >> --- a/drivers/ata/libata-core.c
> >> +++ b/drivers/ata/libata-core.c
> >> @@ -5325,6 +5325,29 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
> >>  	}
> >>  }
> >>  
> >> +/**
> >> + *	ata_qc_get_active - get bitmask of active qcs
> >> + *	@ap: port in question
> >> + *
> >> + *	LOCKING:
> >> + *	spin_lock_irqsave(host lock)
> >> + *
> >> + *	RETURNS:
> >> + *	Bitmask of active qcs
> >> + */
> >> +u64 ata_qc_get_active(struct ata_port *ap)
> >> +{
> >> +	u64 qc_active = ap->qc_active;
> >> +
> >> +	/* ATA_TAG_INTERNAL is sent to hw as tag 0 */
> >> +	if (qc_active & (1ULL << ATA_TAG_INTERNAL)) {
> >> +		qc_active |= (1 << 0);
> >> +		qc_active &= ~(1ULL << ATA_TAG_INTERNAL);
> >> +	}
> >> +
> >> +	return qc_active;
> >> +}
> >> +
> >>  /**
> >>   *	ata_qc_complete_multiple - Complete multiple qcs successfully
> >>   *	@ap: port in question
> >> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> >> index 8e9cb198fcd1..ca6c706e9c25 100644
> >> --- a/drivers/ata/sata_fsl.c
> >> +++ b/drivers/ata/sata_fsl.c
> >> @@ -1278,7 +1278,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
> >>  				     i, ioread32(hcr_base + CC),
> >>  				     ioread32(hcr_base + CA));
> >>  		}
> >> -		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> >> +		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
> >>  		return;
> >>  
> >>  	} else if ((ap->qc_active & (1ULL << ATA_TAG_INTERNAL))) {
> >> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> >> index ad385a113391..bde695a32097 100644
> >> --- a/drivers/ata/sata_mv.c
> >> +++ b/drivers/ata/sata_mv.c
> >> @@ -2827,7 +2827,7 @@ static void mv_process_crpb_entries(struct ata_port *ap, struct mv_port_priv *pp
> >>  	}
> >>  
> >>  	if (work_done) {
> >> -		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> >> +		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
> >>  
> >>  		/* Update the software queue position index in hardware */
> >>  		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |
> >> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> >> index 56946012d113..7510303111fa 100644
> >> --- a/drivers/ata/sata_nv.c
> >> +++ b/drivers/ata/sata_nv.c
> >> @@ -984,7 +984,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
> >>  					check_commands = 0;
> >>  				check_commands &= ~(1 << pos);
> >>  			}
> >> -			ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> >> +			ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
> >>  		}
> >>  	}
> >>  
> >> diff --git a/include/linux/libata.h b/include/linux/libata.h
> >> index 207e7ee764ce..f4c045b56e6c 100644
> >> --- a/include/linux/libata.h
> >> +++ b/include/linux/libata.h
> >> @@ -1174,6 +1174,7 @@ extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
> >>  					struct ata_taskfile *tf, u16 *id);
> >>  extern void ata_qc_complete(struct ata_queued_cmd *qc);
> >>  extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
> >> +extern u64 ata_qc_get_started(struct ata_port *ap);
> > 
> > s/ata_qc_get_started/ata_qc_get_active/ obviously.
> 
> Last minute edit? Please send a v2.

Just did that

Thanks,
 Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
