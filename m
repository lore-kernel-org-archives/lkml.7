Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A24AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98EA2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="uvmgAgam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWhPEyW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfDBTZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:25:56 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33773 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfDBTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:25:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 178512204C;
        Tue,  2 Apr 2019 15:25:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2019 15:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=VfV6qEx4GfxVkCo7NG9vbB5klK2
        CoGPcrGR89KYgSN8=; b=uvmgAgamqYQxUyvgTEGeOmMVBfFOxyKaVYlilZPReZe
        OmWFEhyLNXSmBH47sqeiOF4TFeQmH0IWtHOeF4DZuzus8KoNXkI00Uyti2YfhR5b
        z5QgKz9MVh+DGyTfh4QpasTgYo/ovq0XJU/MXSNwzOYb7e5jRq6njH7f0+v69+oq
        2Jz+EgE1pqUSns0eMS9ZM0C+EgekxlWSdQ4NIE07l0SHmgu5qYQHltE7/qmXG/sT
        xCABypGyj92UcO6oksXnoNMX6xCrVdHIs9LOdOGXj25ivlemqSna+M2jKurs6h6K
        Nrrst6ze6/ivhJZCdLwE6mWw7HOAwt9fHtJViY8DiHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VfV6qE
        x4GfxVkCo7NG9vbB5klK2CoGPcrGR89KYgSN8=; b=SWhPEyW2dP94KixYJL0MEp
        a4vp25kAz3goJDtnZuGdTiUs2NCrfGNv4cRmRaFI53AeIX/VlnlHiY3ajjQ1qsYz
        ir4HPETq/h5qUjQSiCQ6KUA5FotbSK4xmuT8Vezqf7pyPk9nNtc5/5J9icpfNypn
        Ct/pknguD8rrmtvf39X3StsWtAoDgBl7RnSZIJGiioNl3UoKING0z2VWi/OfWFHP
        WjMy5PEbCuvTf+4PTQHu7AUSRpDQV/RFfjKQMyqgbYvXWpoLFxU1Nw4ubP/oDOCf
        7GDIQj4YBRIkk07IxLVqh7FAvs39ffGpmBsxLD/hEliau0nOnjJEXMe4jTMSatdQ
        ==
X-ME-Sender: <xms:QrejXPv1z_ynknsCzPhckazNYn49QcwkGIXdAX9gYyVOTy-C4ga-tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtddtgdduudeiucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffk
    fhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrh
    guihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduvdegrdduieelrddvjedr
    vddtkeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:QrejXKSFWlxtwMibPrwmJosGhm3DGbdsnL-wR-6ORDYjtc22diQ0Kw>
    <xmx:QrejXBkqdRcIyMqfQi2r0ziXChhu0YJoaqFjcMiymP9RJXzOyF65kA>
    <xmx:QrejXJmMJlzvXSVBTPSCTLdKV81xqGGMMKkdzuwaC1raGUHI5fhj2g>
    <xmx:Q7ejXEH42KmWUcwkVuld-v4plakFly7joIC-rcsVeXjC78z7916DwQ>
Received: from localhost (124-169-27-208.dyn.iinet.net.au [124.169.27.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 99E1310395;
        Tue,  2 Apr 2019 15:25:53 -0400 (EDT)
Date:   Wed, 3 Apr 2019 06:25:20 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Message-ID: <20190402192520.GA6285@eros.localdomain>
References: <20190327051717.23225-1-tobin@kernel.org>
 <20190402094934.5b242dc0@lwn.net>
 <20190402164824.GK2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402164824.GK2217@ZenIV.linux.org.uk>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 05:48:24PM +0100, Al Viro wrote:
> On Tue, Apr 02, 2019 at 09:49:34AM -0600, Jonathan Corbet wrote:
> > On Wed, 27 Mar 2019 16:16:53 +1100
> > "Tobin C. Harding" <tobin@kernel.org> wrote:
> > 
> > > Hi Al,
> > > 
> > > This series converts the VFS file Documentation/filesystems/vfs.txt to
> > > reStructuredText format.  Please consider taking this series through
> > > your tree as apposed to Jon's tree because this set makes a fair amount
> > > of changes to VFS files (and also the VFS tree and docs tree are out of
> > > sync right now with the recent work by Mauro and Neil).
> > 
> > Al, do you have any thoughts on how you want to handle this?  I was about
> > to apply Jeff Layton's vfs.txt update, but would rather not create
> > conflicts unnecessarily.  Let me know if you'd like me to pick this work
> > up.
> 
> Frankly, I would rather see that file be eventually replaced by something
> saner, and I'm not talking about the format.

Are you able to extrapolate on this comment please?  Is this something
someone new to the VFS (me) can do with a little nudge in the right
direction or is this something that needs thorough knowledge of the VFS? 

> Re Jeff's patch... 
> 
> +  d_prune: called prior to pruning (i.e. unhashing and killing) a hashed
> +       dentry from the dcache.
> 
> is flat-out misguiding.  First of all, it *is* called for unhashed dentries,
> TYVM.  Furthermore, "prior to" is far too vague.

This patch includes documentation for d_prune() very similar to Jeff's
patch (taken from a comment somewhere in filesystems code IIRC).  I can
have a go at working all the comments below into better documentation if
that is useful (dependant on answer to question above).


thanks,
Tobin.

(leaving text below for reference)

> What really happens: there's a point in state diagram for dentries where
> we commit to destroying a dentry and start taking it apart.  That transition
> happens with ->d_lock of dentry, ->i_lock of its inode (if any) and
> ->d_lock of the parent (again, if any) held; ->d_prune() is the last
> chance for filesystem to see the (now doomed) dentry still intact.
> 
> It doesn't matter whether it's hashed or not, etc.  The locks held
> are sufficient to stabilize pretty much everything[1] in dentry and
> nothing is destroyed yet.  The only apparent exception is ->d_count,
> but that's not real - we are guaranteed that there had been no other
> counted references to dentry at the decision point and that none
> could've been added.  So this "oh, it's not 0 now, it's gone negative
> after lockref_mark_dead() the caller has just done" is a red herring.
> 
> ->d_prune() must not drop/regain any of the locks held by caller.
> It must _not_ free anything attached to dentry - that belongs
> later in the shutdown sequence.  If anything, I'm tempted to
> make it take const struct dentry * as argument, just to make
> that clear.
> 
> No new (counted) references can be acquired by that point;
> lockless dcache lookup might find our dentry a match, but
> result of such lookup is not going to be legitimized - it's
> doomed to be thrown out as stale.
> 
> It really makes more sense as part of struct dentry lifecycle
> description...  
> 
> [1] in theory, ->d_time might be changed by overlapping lockless
> call of ->d_revalidate().  Up to filesystem - VFS doesn't touch
> that field (and AFAICS only NFS uses it these days).
