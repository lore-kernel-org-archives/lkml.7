Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1654DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D626620693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfCUNea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:34:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:1962 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfCUNe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:34:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 06:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="154422288"
Received: from dilu-mobl2.ccr.corp.intel.com (HELO localhost) ([10.249.254.184])
  by fmsmga004.fm.intel.com with ESMTP; 21 Mar 2019 06:34:25 -0700
Date:   Thu, 21 Mar 2019 15:34:23 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Tadeusz Struk <tadeusz.struk@intel.com>, grawity@gmail.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix a race between poll and write in tpm-dev-common
Message-ID: <20190321133423.GC2267@linux.intel.com>
References: <155294749695.20367.14472779462229450620.stgit@tstruk-mobl1.jf.intel.com>
 <1552951167.2785.22.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552951167.2785.22.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:19:27PM -0700, James Bottomley wrote:
> On Mon, 2019-03-18 at 15:18 -0700, Tadeusz Struk wrote:
> > Since the poll returns EPOLLIN base on the state of two
> > variables, the response_read being false and the
> > response_length > 0 the poll needs to take the buffer_mutex
> > after it is woken up.
> > 
> > Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> > Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> > Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> > ---
> >  drivers/char/tpm/tpm-dev-common.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-dev-common.c
> > b/drivers/char/tpm/tpm-dev-common.c
> > index 5eecad233ea1..61e458d6f652 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -203,12 +203,14 @@ __poll_t tpm_common_poll(struct file *file,
> > poll_table *wait)
> >  	__poll_t mask = 0;
> >  
> >  	poll_wait(file, &priv->async_wait, wait);
> > +	mutex_lock(&priv->buffer_mutex);
> >  
> >  	if (!priv->response_read || priv->response_length)
> >  		mask = EPOLLIN | EPOLLRDNORM;
> >  	else
> >  		mask = EPOLLOUT | EPOLLWRNORM;
> >  
> > +	mutex_unlock(&priv->buffer_mutex);
> 
> This doesn't do anything to address the theory that the queued work
> hasn't run before the poll wakes up, does it?  If you have an
> alternative theory, could you explain it?

I see now what you mean.

Tadeusz: before you send a new patch put this comment to that place
as a reminder:

/* Checking only response_length is correct because write() always zeros
 * it and poll() should succeed after the first partial read.
 */

/Jarkko
