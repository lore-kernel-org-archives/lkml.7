Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED6C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E243A21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567617259;
	bh=4lhedrTdvyNdZnIcwKpoBZ0Q5do9zTK6jHQL29tFVZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J3lhZ6b3VtKroGLHz4QKdhUfSHp9bDps0OkS7kofHwHL6lLklSxBHnfK9+WzB0gxO
	 tEZBRMPMNlgRFfhHlLFpg3kUTInRZfN/2QYzMkEI6jSXgyJ0ukx+ABdyfjUai+q5PF
	 YV8hPy84THBokMUBT/61lMlemUmMFbukIPXkh5dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfIDROR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbfIDROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:14:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF2D21726;
        Wed,  4 Sep 2019 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567617256;
        bh=4lhedrTdvyNdZnIcwKpoBZ0Q5do9zTK6jHQL29tFVZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naAF2dfkuBEiligHmtjWd3v3i9bZ8JYi0blq+r3tgLJoaqM7VrZG1NsRN+uaBjP3y
         In17bJ03iAHIZdxty25BGNeU5mPsbF1nkdNeCgHx6qdzzJ1GME4qSJtypq5qJte641
         fJE5cpxekm16N9eCR8flaq7d6+oCPkh46chnlj9M=
Date:   Wed, 4 Sep 2019 19:14:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakhar Sinha <prakharsinha2808@gmail.com>
Cc:     tobias.niessen@stud.uni-hannover.de, kim.jamie.bradley@gmail.com,
        pakki001@umn.edu, sabrina-gaube@web.de, nishkadg.linux@gmail.com,
        qader.aymen@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Fix 80 char warning by re-structuring
 if-blocks.
Message-ID: <20190904171413.GA18390@kroah.com>
References: <20190904130523.GA17126@MeraComputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904130523.GA17126@MeraComputer>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 06:35:23PM +0530, Prakhar Sinha wrote:
> This patch solves the following checkpatch.pl's messages in
> drivers/staging/rts5208/sd.c
> 
> WARNING: line over 80 characters
> 4517: FILE: drivers/staging/rts5208/sd.c:4517:
> +                                               sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> 
> WARNING: line over 80 characters
> 4518: FILE: drivers/staging/rts5208/sd.c:4518:
> +                                               goto sd_execute_write_cmd_failed;
> 
> WARNING: line over 80 characters
> 4522: FILE: drivers/staging/rts5208/sd.c:4522:
> +                               sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> 
> Signed-off-by: Prakhar Sinha <prakharsinha2808@gmail.com>
> ---
>  drivers/staging/rts5208/sd.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index a06045344301..7d6f2c56e740 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -4505,22 +4505,20 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  		dev_dbg(rtsx_dev(chip), "sd_lock_state = 0x%x, sd_card->sd_lock_status = 0x%x\n",
>  			sd_lock_state, sd_card->sd_lock_status);
> -		if (sd_lock_state ^ (sd_card->sd_lock_status & SD_LOCKED)) {
> +		if (sd_lock_state ^ (sd_card->sd_lock_status & SD_LOCKED))
>  			sd_card->sd_lock_notify = 1;
> -			if (sd_lock_state &&
> -			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
> -				sd_card->sd_lock_status |= (
> -					SD_UNLOCK_POW_ON | SD_SDR_RST);
> -				if (CHK_SD(sd_card)) {
> -					retval = reset_sd(chip);
> -					if (retval != STATUS_SUCCESS) {
> -						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> -						goto sd_execute_write_cmd_failed;
> -					}
> -				}
> -
> -				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> +		if ((sd_lock_state & !(sd_card->sd_lock_status & SD_LOCKED)) &&
> +		    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
> +			sd_card->sd_lock_status |= (SD_UNLOCK_POW_ON |
> +						    SD_SDR_RST);
> +			if (CHK_SD(sd_card) &&
> +			    reset_sd(chip) != STATUS_SUCCESS) {
> +				sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
> +							     SD_SDR_RST);
> +				goto sd_execute_write_cmd_failed;
>  			}
> +			sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
> +						     SD_SDR_RST);

Are you sure you can indent and call the if() statement twice like this?

If so, please document this in your changelog text.

thanks,

greg k-h
