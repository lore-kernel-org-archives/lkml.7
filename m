Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D5C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE0B206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfC0Ey7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:54:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:21271 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfC0Ey6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:54:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 21:54:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="158735882"
Received: from yannluen-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.205])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2019 21:54:52 -0700
Date:   Wed, 27 Mar 2019 06:54:50 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Denis Kenzior <denkenz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Morris <james.morris@microsoft.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
Message-ID: <20190327045450.GC15397@linux.intel.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
 <20190326113725.GA10898@linux.intel.com>
 <1553602220.3960.29.camel@linux.ibm.com>
 <1553610317.2900.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553610317.2900.2.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:25:17AM -0700, James Bottomley wrote:
> On Tue, 2019-03-26 at 08:10 -0400, Mimi Zohar wrote:
> > Hi Jarrko,
> > 
> > On Tue, 2019-03-26 at 13:37 +0200, Jarkko Sakkinen wrote:
> > > Mimi,
> > > 
> > > Can you fix this and I can ack and send PR through my tree?
> > 
> > Making the "trusted.h" include file public was part of David's "KEYS:
> > Support TPM-wrapped key and crypto ops" patch set.  I wasn't involved
> > in reviewing or upstreaming this patch set.  As I recall, it was
> > upstreamed rather quickly without much review.  As it is TPM related,
> > it should have at least been posted on the linux-integrity mailing
> > list.  I have no idea if "trusted.h" should have been made public.
> > 
> > I'm not sure just "fixing" the MAINTAINERS file is the right
> > solution.  I was hoping to look at it later this week.  Perhaps you
> > and James could take a look?
> 
> Looking at the contents of linux/keys/trusted.h, it looks like the
> wrong decision to move it.  The contents are way too improperly named
> and duplicative to be in a standard header.  It's mostly actually TPM
> code including a redefinition of the tpm_buf structure, so it doesn't
> even seem to be necessary for trusted keys.
> 
> If you want to fix this as a bug, I'd move it back again, but long term
> I think it should simply be combined with trusted.c because nothing
> else can include it sanely anyway.

<offtopic>
Fully agree with the long term plan.

I think it would be better to take the TPM2 trusted keys code from the
driver to the keyring subsystem once TPM1 trusted keys code has been
converted to use tpm_buf.

I don't also know any good reason for the core TPM driver to be compiled
as a module. It is just makes the kernel build configuration more
awkward. Would be nice to get the TPM callable from any subsystem
without fuzz. There is no a production use case for "TPM as an LKM"
(obviously drivers for different types of TPM hardware must and will
be compilable as LKM's).
</offtopic>

/Jarkko
