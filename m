Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE85C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6AA21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfLSADM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:03:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:30626 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfLSADM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:03:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 16:02:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="248076103"
Received: from jtreacy-mobl1.ger.corp.intel.com ([10.251.82.127])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2019 16:02:56 -0800
Message-ID: <17c3fc41ea6ff890c686489b9977c2d886295d6e.camel@linux.intel.com>
Subject: Re: [PATCH] tpm/ppi: replace assertion code with recovery in
 tpm_eval_dsm
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20191218134513.GE17227@ziepe.ca>
References: <20191215182314.32208-1-pakki001@umn.edu>
         <20191218134513.GE17227@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 19 Dec 2019 02:02:18 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-18 at 09:45 -0400, Jason Gunthorpe wrote:
> On Sun, Dec 15, 2019 at 12:23:14PM -0600, Aditya Pakki wrote:
> > In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
> > By returning NULL to the callers, instead of crashing, the error
> > can be better handled.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> >  drivers/char/tpm/tpm_ppi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > index b2dab941cb7f..4b6f6a9c0b48 100644
> > +++ b/drivers/char/tpm/tpm_ppi.c
> > @@ -42,7 +42,9 @@ static inline union acpi_object *
> >  tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
> >  	     union acpi_object *argv4, u64 rev)
> >  {
> > -	BUG_ON(!ppi_handle);
> > +	if (!ppi_handle)
> > +		return NULL;
> 
> If it can't happen the confusing if should either be omitted entirely
> or written as 
> 
> if (WARN_ON(!ppi_handle))
>        return NULL;
> 
> Leaving it as apparently operational code just creates confusion for
> the reader that now has the task to figure out why ppi_handle can be
> null.
> 
> I favour not including tests for impossible conditions. The kernel
> will crash immediately if ppi_handle is null anyhow.
> 
> Jason

Absolutely should be changed WARN_ON() as it never should happen. I'll
update the patch before sending PR to Linus since I have it already
applied.

Thanks Jason for the remark!

/Jarkko

