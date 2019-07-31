Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA21CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E0D206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564537238;
	bh=i97ozyZSB79AVKRSwbJmyXlCnoRo8bUjqoJ7TEpNBcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HZjIOxm3auOTXZJYnH8kGEEROy2mp0hjuivUH2JN+d0nVbUtxGrazwp5hXLDUqFV/
	 NraNtoAkhJA4r9R4CgHImluCet6S0zjPMbiaNGwtfFbYZQvR8rDr9MLtlrJ2V/KYPy
	 76kFW1f2kyKWdmo9nv+62FqHCBR+qvMi0PDKBFzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGaBkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfGaBkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:40:36 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB082067D;
        Wed, 31 Jul 2019 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564537236;
        bh=i97ozyZSB79AVKRSwbJmyXlCnoRo8bUjqoJ7TEpNBcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8ETSYMgPt76VLypqay5hLTpJOQgiHV8nGEc+pNQBvqi9qLJA2YH7/9LafNelNBrj
         x9pMrD5FfwgdhIKARxa0ct5zOOMIKRQ/PoN6AAhHJ87/r91zfYYyKxWWd2V4TzytGx
         9Idj0XaGmiufVDOUjmbRI+79wWHHEI2Yy9taWCS0=
Date:   Tue, 30 Jul 2019 18:40:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org
Subject: Re: linux-next: build warnings after merge of the keys tree
Message-ID: <20190731014034.GB687@sol.localdomain>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org
References: <20190730123042.1f17cdd4@canb.auug.org.au>
 <20190730034704.GA1966@sol.localdomain>
 <20190730135216.377a16d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730135216.377a16d5@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:52:16PM +1000, Stephen Rothwell wrote:
> Hi Eric,
> 
> On Mon, 29 Jul 2019 20:47:04 -0700 Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Jul 30, 2019 at 12:30:42PM +1000, Stephen Rothwell wrote:
> > > +static struct key_acl fsverity_acl = {
> > > +	.usage	= REFCOUNT_INIT(1),
> > > +	.possessor_viewable = true,  
> > 
> > I don't think .possessor_viewable should be set here, since there's no
> > KEY_POSSESSOR_ACE(KEY_ACE_VIEW) in the ACL.  David, this bool is supposed to
> > mean such an entry is present, right?  Is it really necessary, since it's
> > redundant with the ACL itself?
> 
> OK, I can take that out of the patch for tomorrow.
> 
> > Otherwise this looks good, thanks Stephen.  I'll want to remove a few of these
> > permissions in a separate patch later, but for now we can just keep it
> > equivalent to the original code as you've done.
> 
> Thanks for the review.
> 

Hmm, apparently it's not *exactly* equivalent, since the ACL is missing INVAL
and JOIN permission for the owner, while those were originally granted by SEARCH
permission.  We don't need those, but just to keep the merge resolution itself
as boring as possible, can you please use the following to make it equivalent:

static struct key_acl fsverity_acl = {
	.usage	= REFCOUNT_INIT(1),
	.nr_ace	= 2,
	.aces = {
		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_JOIN |
				  KEY_ACE_INVAL),
		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_WRITE |
			      KEY_ACE_SEARCH | KEY_ACE_SET_SECURITY |
			      KEY_ACE_INVAL | KEY_ACE_REVOKE | KEY_ACE_JOIN |
			      KEY_ACE_CLEAR),
	}
};


Thanks!

- Eric
