Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5873CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8E02133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="umsdsBb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jofimkhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfDCVAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:00:13 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45981 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDCVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:00:12 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D363222B3;
        Wed,  3 Apr 2019 17:00:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Apr 2019 17:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=qD4XgDwzxgnWbLic4KWoMXxBDp7
        6r8NO4iI3RmqZ82M=; b=umsdsBb/m4y3vJAd4Oa1M5D6OVEYdJJO2iVjN/9fARh
        slRWk5+std2dreG+V64qgBH34nNDl7y/NK59vqbi5Wv6CzUxXtmTK7LDS7N8zVyr
        CBDYD3LwUMM2eZl9A6HMGqXr+IBi7xIBo8PnMekrkSlvGB2rFW+FL4bkQ5DWWcbk
        1UXmQHkGpOb780cqSUaDt4jR1OjOsFxI7PSqCV9Er5HNNkKR7E92cjrcuJkf26T5
        K4LRf8bUY5eOTWVkxWXLE8rrdzYr2YWR0rGamp1XK9JvGNz53gFzQXOBL0nZ+Hpb
        8IYYhzU9FHZubcZIvabpdxnoSPJpA/aWCMwu2U8FouQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qD4XgD
        wzxgnWbLic4KWoMXxBDp76r8NO4iI3RmqZ82M=; b=jofimkhXhGhYL6ehwmM9Bs
        laE+l5BuOyJNs1OnSKbN52qJby2FERk9/qxXoyZXJkK5sADzhv5qoawYg6HTtjvD
        STPuNW7RAO7W7H8MzPs5Nayje4ijd0pN61dnrb6LgmYE5c6OSq9BOfxcSq9kVg+j
        x+2vvi7ZULuxmK48JJr4k/RSXTh6NesLmTYmUtEbE0zsotGNvwSZoql9bMSU7pEe
        3in+mFc1ZTJfxtG/PcA7d+xxmWj4kYerU6tuuhbSwQjcELMYx/z5henuWj0HzTgG
        q4nEzn68iv4ZJ6tFLvd+i+tQPpcVSOJWXElLk25VZZPPCoR8p8CrmxtQGbz+3JSA
        ==
X-ME-Sender: <xms:2x6lXJj1Pw39wnGdweHgwUO7oziWQ65g29E4YNzA9FR5ODpPSBmrUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdefgdduvdelucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffk
    fhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrh
    guihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduvdegrddugeelrdduudeg
    rdekieenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:2x6lXB0oJkLQbhgUb3EIDEc3ULCCc0y3Qyc3lEJh2TtCe-KpRYeerw>
    <xmx:2x6lXF-_k9Ge6kCp1lHzFXze1XR6e9rf9yrf7GxHdtpKfrXk3VMy4w>
    <xmx:2x6lXBmpP0-UiM--8pUHrkxHWAByrPQUKuhJvMQyuJERl7N0WDPpzw>
    <xmx:3B6lXAN74ydlQJVNBJx6Yh7ZlVixUtDt0Pkv1yLYQRjrLERUPdfzkw>
Received: from localhost (124-149-114-86.dyn.iinet.net.au [124.149.114.86])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6037CE4BC4;
        Wed,  3 Apr 2019 17:00:10 -0400 (EDT)
Date:   Thu, 4 Apr 2019 07:59:38 +1100
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
Message-ID: <20190403205938.GA23288@eros.localdomain>
References: <20190327051717.23225-1-tobin@kernel.org>
 <20190402094934.5b242dc0@lwn.net>
 <20190402164824.GK2217@ZenIV.linux.org.uk>
 <20190402192520.GA6285@eros.localdomain>
 <20190403194720.GY2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403194720.GY2217@ZenIV.linux.org.uk>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:47:21PM +0100, Al Viro wrote:
> On Wed, Apr 03, 2019 at 06:25:20AM +1100, Tobin C. Harding wrote:
> > On Tue, Apr 02, 2019 at 05:48:24PM +0100, Al Viro wrote:
> > > On Tue, Apr 02, 2019 at 09:49:34AM -0600, Jonathan Corbet wrote:
> > > > On Wed, 27 Mar 2019 16:16:53 +1100
> > > > "Tobin C. Harding" <tobin@kernel.org> wrote:
> > > > 
> > > > > Hi Al,
> > > > > 
> > > > > This series converts the VFS file Documentation/filesystems/vfs.txt to
> > > > > reStructuredText format.  Please consider taking this series through
> > > > > your tree as apposed to Jon's tree because this set makes a fair amount
> > > > > of changes to VFS files (and also the VFS tree and docs tree are out of
> > > > > sync right now with the recent work by Mauro and Neil).
> > > > 
> > > > Al, do you have any thoughts on how you want to handle this?  I was about
> > > > to apply Jeff Layton's vfs.txt update, but would rather not create
> > > > conflicts unnecessarily.  Let me know if you'd like me to pick this work
> > > > up.
> > > 
> > > Frankly, I would rather see that file be eventually replaced by something
> > > saner, and I'm not talking about the format.
> > 
> > Are you able to extrapolate on this comment please?  Is this something
> > someone new to the VFS (me) can do with a little nudge in the right
> > direction or is this something that needs thorough knowledge of the VFS? 
> 
> Put it that way - IMO the best way to do it is not a list of methods with
> explanations what each does, but a bunch of per-data structure documents
> describing their life cycles.  The fundamental ones for VFS would be
> 	* inode
> 	* dentry
> 	* super_block
> 	* (vfs)mount
> 	* file
> 	* files_struct
> Having a list of methods is nice, but those would be better off with short
> description along with "see <document> for details, including the locking,
> etc."; said short descriptions make little sense without the background...

Ok, got it.  Thanks.

	Tobin
