Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CCB208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfC0E6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:58:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:62793 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfC0E6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:58:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 21:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="156135964"
Received: from yannluen-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.205])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2019 21:58:07 -0700
Date:   Wed, 27 Mar 2019 06:58:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Mimi Zohar <zohar@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Morris <james.morris@microsoft.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-ID: <20190327045806.GD15397@linux.intel.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
 <20190326113725.GA10898@linux.intel.com>
 <1553602220.3960.29.camel@linux.ibm.com>
 <1553610317.2900.2.camel@linux.ibm.com>
 <c7f70a06-65a5-a1cd-69c5-dae7567b851f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f70a06-65a5-a1cd-69c5-dae7567b851f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:59:40AM -0500, Denis Kenzior wrote:
> Hi James,
> 
> On 03/26/2019 09:25 AM, James Bottomley wrote:
> > Looking at the contents of linux/keys/trusted.h, it looks like the
> > wrong decision to move it.  The contents are way too improperly named
> > and duplicative to be in a standard header.  It's mostly actually TPM
> > code including a redefinition of the tpm_buf structure, so it doesn't
> > even seem to be necessary for trusted keys.
> The reason this was done was because asym_tpm.c needed a bunch of the same
> functionality already provided by trusted.c, e.g. TSS_authmac and friends.
> 
> > 
> > If you want to fix this as a bug, I'd move it back again, but long term
> > I think it should simply be combined with trusted.c because nothing
> > else can include it sanely anyway.
> 
> Ideally I'd like to see the TPM subsystem expose these functions using some
> proper API / library abstraction.  David Howells had an RFC patch set that
> tried to address some of this a while back.  Not sure if that went anywhere.

I think it'd be best to expose tpm_buf API to outside and allow trusted
keys code to construct the TPM commands. It is a single consumer use
(e.g. not like PCR operations where it does make sense to consolidate
to the TPM subsystem).

/Jarkko
