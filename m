Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC724C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FB92086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404818AbfFKJTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:19:34 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35556 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404428AbfFKJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:19:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 263822952E;
        Tue, 11 Jun 2019 05:19:30 -0400 (EDT)
Date:   Tue, 11 Jun 2019 19:19:10 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NCR5380: Support chained sg lists
In-Reply-To: <a1fe2d99-fc2f-c12d-41fe-025ee1f66c0b@gmail.com>
Message-ID: <alpine.LNX.2.21.1906111910220.25@nippy.intranet>
References: <739c214bafcb9af3f6d5037cc03f57f692966675.1560223509.git.fthain@telegraphics.com.au> <a1fe2d99-fc2f-c12d-41fe-025ee1f66c0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jun 2019, Michael Schmitz wrote:

> Hi Finn,
> 
> Thanks - can't test this on my hardware but looks good to me.
> 

Thanks for looking it over.

Would you be willing to send a "reviewed-by" tag?

I tested this successfully on my PowerBook 180 using the parameters 
mac_scsi.setup_sg_tablesize=128 mac_scsi.setup_use_pdma=0

(Only because PDMA doesn't work with sg_tablesize > 1 with this particular 
drive.)

-- 

> Cheers,
> 
> 	Michael
> 
> Am 11.06.2019 um 15:25 schrieb Finn Thain:
> > My understanding is that support for chained scatterlists is to
> > become mandatory for LLDs.
> > 
> > Cc: Michael Schmitz <schmitzmic@gmail.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> >  drivers/scsi/NCR5380.c | 41 ++++++++++++++++++-----------------------
> >  1 file changed, 18 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> > index d9fa9cf2fd8b..536426f25e86 100644
> > --- a/drivers/scsi/NCR5380.c
> > +++ b/drivers/scsi/NCR5380.c
> > @@ -149,12 +149,10 @@ static inline void initialize_SCp(struct scsi_cmnd
> > *cmd)
> > 
> >  	if (scsi_bufflen(cmd)) {
> >  		cmd->SCp.buffer = scsi_sglist(cmd);
> > -		cmd->SCp.buffers_residual = scsi_sg_count(cmd) - 1;
> >  		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> >  		cmd->SCp.this_residual = cmd->SCp.buffer->length;
> >  	} else {
> >  		cmd->SCp.buffer = NULL;
> > -		cmd->SCp.buffers_residual = 0;
> >  		cmd->SCp.ptr = NULL;
> >  		cmd->SCp.this_residual = 0;
> >  	}
> > @@ -163,6 +161,17 @@ static inline void initialize_SCp(struct scsi_cmnd
> > *cmd)
> >  	cmd->SCp.Message = 0;
> >  }
> > 
> > +static inline void advance_sg_buffer(struct scsi_cmnd *cmd)
> > +{
> > +	struct scatterlist *s = cmd->SCp.buffer;
> > +
> > +	if (!cmd->SCp.this_residual && s && !sg_is_last(s)) {
> > +		cmd->SCp.buffer = sg_next(s);
> > +		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> > +		cmd->SCp.this_residual = cmd->SCp.buffer->length;
> > +	}
> > +}
> > +
> >  /**
> >   * NCR5380_poll_politely2 - wait for two chip register values
> >   * @hostdata: host private data
> > @@ -1670,12 +1679,7 @@ static void NCR5380_information_transfer(struct
> > Scsi_Host *instance)
> >  			    sun3_dma_setup_done != cmd) {
> >  				int count;
> > 
> > -				if (!cmd->SCp.this_residual &&
> > cmd->SCp.buffers_residual) {
> > -					++cmd->SCp.buffer;
> > -					--cmd->SCp.buffers_residual;
> > -					cmd->SCp.this_residual =
> > cmd->SCp.buffer->length;
> > -					cmd->SCp.ptr =
> > sg_virt(cmd->SCp.buffer);
> > -				}
> > +				advance_sg_buffer(cmd);
> > 
> >  				count = sun3scsi_dma_xfer_len(hostdata, cmd);
> > 
> > @@ -1725,15 +1729,11 @@ static void NCR5380_information_transfer(struct
> > Scsi_Host *instance)
> >  				 * scatter-gather list, move onto the next
> > one.
> >  				 */
> > 
> > -				if (!cmd->SCp.this_residual &&
> > cmd->SCp.buffers_residual) {
> > -					++cmd->SCp.buffer;
> > -					--cmd->SCp.buffers_residual;
> > -					cmd->SCp.this_residual =
> > cmd->SCp.buffer->length;
> > -					cmd->SCp.ptr =
> > sg_virt(cmd->SCp.buffer);
> > -					dsprintk(NDEBUG_INFORMATION, instance,
> > "%d bytes and %d buffers left\n",
> > -					         cmd->SCp.this_residual,
> > -					         cmd->SCp.buffers_residual);
> > -				}
> > +				advance_sg_buffer(cmd);
> > +				dsprintk(NDEBUG_INFORMATION, instance,
> > +					"this residual %d, sg ents %d\n",
> > +					cmd->SCp.this_residual,
> > +					sg_nents(cmd->SCp.buffer));
> > 
> >  				/*
> >  				 * The preferred transfer method is going to
> > be
> > @@ -2126,12 +2126,7 @@ static void NCR5380_reselect(struct Scsi_Host
> > *instance)
> >  	if (sun3_dma_setup_done != tmp) {
> >  		int count;
> > 
> > -		if (!tmp->SCp.this_residual && tmp->SCp.buffers_residual) {
> > -			++tmp->SCp.buffer;
> > -			--tmp->SCp.buffers_residual;
> > -			tmp->SCp.this_residual = tmp->SCp.buffer->length;
> > -			tmp->SCp.ptr = sg_virt(tmp->SCp.buffer);
> > -		}
> > +		advance_sg_buffer(tmp);
> > 
> >  		count = sun3scsi_dma_xfer_len(hostdata, tmp);
> > 
> > 
> 
