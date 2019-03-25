Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C08C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22C72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCYOJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:09:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:41285 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbfCYOJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:09:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 07:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="143654251"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.97])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2019 07:09:55 -0700
Date:   Mon, 25 Mar 2019 16:09:54 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     grawity@gmail.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3] tpm: fix an invalid condition in
 tpm_common_poll
Message-ID: <20190325140954.GA13699@linux.intel.com>
References: <155326553839.17270.7997105682830234546.stgit@tstruk-mobl1.jf.intel.com>
 <20190322155917.GA6987@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322155917.GA6987@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 05:59:17PM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 22, 2019 at 07:38:58AM -0700, Tadeusz Struk wrote:
> > The poll condition should only check response_length,
> > because reads should only be issued if there is data to read.
> > The response_read flag only prevents double writes.
> > The problem was that the write set the response_read to false,
> > enqued a tpm job, and returned. Then application called poll
> > which checked the response_read flag and returned EPOLLIN.
> > Then the application called read, but got nothing.
> > After all that the async_work kicked in.
> > Added also mutex_lock around the poll check to prevent
> > other possible race conditions.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 9488585b21bef0df12 ("tpm: add support for partial reads")
> > Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> > Tested-by: Mantas Mikulėnas <grawity@gmail.com>
> > Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

It is still missing the comment I asked to add. Otherwise, it is good.

/Jarkko
