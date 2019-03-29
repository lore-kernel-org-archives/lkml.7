Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD1C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6F720693
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfC2Jl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:41:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:18863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbfC2Jl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:41:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 02:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="218706784"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.156])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2019 02:41:23 -0700
Date:   Fri, 29 Mar 2019 11:41:23 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pauldzim@gmail.com,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: turn on TPM on suspend for TPM 1.x
Message-ID: <20190329094123.GB21379@linux.intel.com>
References: <20190322105120.8441-1-jarkko.sakkinen@linux.intel.com>
 <20190328171926.4luwqofh67uwgt5e@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328171926.4luwqofh67uwgt5e@dumbo>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:19:26PM +0100, Domenico Andreoli wrote:
> On Fri, Mar 22, 2019 at 12:51:20PM +0200, Jarkko Sakkinen wrote:
> > tpm_chip_start/stop() should be also called for TPM 1.x devices on
> > suspend. Add that functionality back. Do not lock the chip because
> > it is unnecessary as there are no multiple threads using it when
> > doing the suspend.
> > 
> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > Reported-by: Paul Zimmerman <pauldzim@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 83ece5639f86..ae1030c9b086 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -402,15 +402,13 @@ int tpm_pm_suspend(struct device *dev)
> >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> >  		return 0;
> >  
> > -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > -		mutex_lock(&chip->tpm_mutex);
> > -		if (!tpm_chip_start(chip)) {
> > +	if (!tpm_chip_start(chip)) {
> > +		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> >  			tpm2_shutdown(chip, TPM2_SU_STATE);
> > -			tpm_chip_stop(chip);
> > -		}
> > -		mutex_unlock(&chip->tpm_mutex);
> > -	} else {
> > -		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > +		else
> > +			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > +
> > +		tpm_chip_stop(chip);
> >  	}
> >  
> >  	return rc;
> 
> Tested-by: Domenico Andreoli <domenico.andreoli@linux.com>

Thank you! I'll do a PR to James during the weekend.

/Jarkko
