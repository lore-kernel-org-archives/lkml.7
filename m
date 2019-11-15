Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C3BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8EA20727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="I0Lm3AaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwUY9Z54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKOA0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:26:33 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:49685 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbfKOA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:26:32 -0500
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2019 19:26:32 EST
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id B38224CB;
        Thu, 14 Nov 2019 19:16:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 14 Nov 2019 19:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        okg+pbQZMLAFIVAtOQnx13wD35th3oHFa3FunzYvg0Q=; b=I0Lm3AaL52mEZmyL
        Ct1tTzrZt3urGFFppt1Cj0m3Psq12QTRbjr4Tt3x4GkJzq5MAdk0oe3DSQbCqN76
        SLZBH7ncxPmMCn7NciDetSEcPkwU4QUYXT0teICMBD94QWZLTv1ifJk1JeY2vVwR
        dQ3bIuXd5Bpo2C/akpho23Zsa7pasb8kTHBumIVFkhnavlVm2Mxxvd/KQ4Wc12Jv
        KKM1OIgyKFMWkdbRrHOphLtJDRGUn8E+b5lS8LNDb+vqE6dxFuy4YEdOXsSt3FlI
        TcZPfm58g2aeXXniqyNwqJUwwUTrJUxMmlYbcyGaQvcnF3WQ4taKK5KtovehY/xt
        S1wFwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=okg+pbQZMLAFIVAtOQnx13wD35th3oHFa3FunzYvg
        0Q=; b=NwUY9Z54rkbVbJErPqRaQiYQJYH1lzPmZa9q4XI4MFxWqeQV3zkMTbpG5
        L2cOYHpbtYAEjQvbTOqRl/ft3gAnwyhcQNsXao+4/gpPrcjNJd/dXL8Nj0n/dv8j
        /sqL7jMMb6ncc04YYYxB3gAyQnHAnlt8+zHF314IWr/nKlNOqR5EXKA6oVtYtTWn
        85uFek20PWjSbrq4kPoxuYY+GvVd1/YPH6YVK/btPs09mJnjv7h1ttk4szGcE8Qv
        BVXpUQ9gregPx4km5Zxrd+bi2qqpBfxNXAokVRW8ohhmZwBMkCA+1yLtAZZdVzSy
        iZTxSsAH353R03l5BXDZvOBuqhogQ==
X-ME-Sender: <xms:ee7NXfU9H8iv1Y_1UxcsrXR6cXM71lUwi42R_8QDCAZLUXW5wKaW_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drudekledrudeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ee7NXZ2Dodlsf4Nubf5iqxWeVIp5u7_H5jt5tCpROMDoRd7DH78uaA>
    <xmx:ee7NXdrzAyz5s6hArGycAknWzhcJ80vlpuNjMF-t1yXuq1q4o9KvdQ>
    <xmx:ee7NXQUebLKsclU5wP5QNAh3r_3yAJsGggdts2sxIss9yhxrQYyyAQ>
    <xmx:eu7NXcTbo3sJKnvSNyHhr05A0qXAfQTnhbDXQWH4fP2THa_SVh7UhAQLffI>
Received: from mickey.themaw.net (unknown [118.208.189.18])
        by mail.messagingengine.com (Postfix) with ESMTPA id 554108005C;
        Thu, 14 Nov 2019 19:16:53 -0500 (EST)
Message-ID: <1b33820317e577e6b2329b3e37edb9a7bf3b3983.camel@themaw.net>
Subject: Re: [RFC PATCH] docs: filesystems: convert autofs.txt to reST
From:   Ian Kent <raven@themaw.net>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>
Cc:     akpm@linux-foundation.org, mchehab+samsung@kernel.org,
        christian@brauner.io, neilb@suse.com, mszeredi@redhat.com,
        willy@infradead.org, stefanha@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Fri, 15 Nov 2019 08:16:49 +0800
In-Reply-To: <20191114093831.2ab8a077@lwn.net>
References: <20191113073822.GA31926@localhost.localdomain>
         <20191114093831.2ab8a077@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-14 at 09:38 -0700, Jonathan Corbet wrote:
> On Wed, 13 Nov 2019 13:08:22 +0530
> Jaskaran Singh <jaskaransingh7654321@gmail.com> wrote:
> 
> Thanks for doing this.  Naturally I have some requests :)
> 
> > This patch converts autofs.txt to reST.
> 
> Some subsystem maintainers react strongly to changelogs that read
> "this
> patch"; it's best to express things in the imperative form described
> in
> Documentation/process/submitting-patches.rst.
> 
> >  - Most of the changes pertain to reST formatting.
> >  - Some of the code snippets are updated to reflect current source.
> >  - A definition of the autofs packet header has been added in the
> > chapter
> > 	"Communicating with autofs: the event pipe".
> >  - An indentation of an 8 space tab has been added wherever
> > suitable, so
> >    as to maintain consistency.
> >  - Removed indentation of the description of the ioctls which are
> > similar
> >    to the AUTOFS_IOC ioctls, as it does not come out quite right in
> > HTML.
> 
> These seems like good changes, but they are too much for a single
> patch.
> Please split this into multiple patches, separating the formatting
> and
> white-space changes from those that change the text.  That makes it
> much
> easier to review.
> 
> Some nits below.
> 
> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > ---
> >  .../filesystems/{autofs.txt => autofs.rst}    | 258 ++++++++++--
> > ------
> >  Documentation/filesystems/index.rst           |   1 +
> >  2 files changed, 140 insertions(+), 119 deletions(-)
> >  rename Documentation/filesystems/{autofs.txt => autofs.rst} (77%)
> > 
> > diff --git a/Documentation/filesystems/autofs.txt
> > b/Documentation/filesystems/autofs.rst
> > similarity index 77%
> > rename from Documentation/filesystems/autofs.txt
> > rename to Documentation/filesystems/autofs.rst
> > index 3af38c7fd26d..a130cba76f07 100644
> > --- a/Documentation/filesystems/autofs.txt
> > +++ b/Documentation/filesystems/autofs.rst
> > @@ -1,12 +1,9 @@
> > -<head>
> > -<style> p { max-width:50em} ol, ul {max-width: 40em}</style>
> > -</head>
> 
> Heh, yeah, I'm not sure why that's there, it should definitely go.
> 
> > +=====================
> >  autofs - how it works
> >  =====================
> >  
> >  Purpose
> > --------
> > +=======
> >  
> >  The goal of autofs is to provide on-demand mounting and race free
> >  automatic unmounting of various other filesystems.  This provides
> > two
> > @@ -28,7 +25,7 @@ key advantages:
> >     first accessed a name.
> >  
> >  Context
> > --------
> > +=======
> >  
> >  The "autofs" filesystem module is only one part of an autofs
> > system.
> >  There also needs to be a user-space program which looks up names
> > @@ -43,7 +40,7 @@ filesystem type.  Several "autofs" filesystems
> > can be mounted and they
> >  can each be managed separately, or all managed by the same daemon.
> >  
> >  Content
> > --------
> > +=======
> >  
> >  An autofs filesystem can contain 3 sorts of objects: directories,
> >  symbolic links and mount traps.  Mount traps are directories with
> > @@ -52,7 +49,7 @@ extra properties as described in the next
> > section.
> >  Objects can only be created by the automount daemon: symlinks are
> >  created with a regular `symlink` system call, while directories
> > and
> >  mount traps are created with `mkdir`.  The determination of
> > whether a
> > -directory should be a mount trap or not is quite _ad hoc_, largely
> > for
> > +directory should be a mount trap or not is quite _ad hoc\_,
> > largely for
> 
> Remember that we want to preserve the readability of the plain-text
> document; sprinkling that sort of escape doesn't really
> help.  Recognize
> that what's there now is a sort of informal markup; I'd either fix it
> up or
> take it out.  So "*ad hoc*" or just "ad hoc".
> 
> (Or rephrase it, since this doesn't actually seem to be an
> appropriate use
> of "ad hoc" but that's a separate issue :)
> 
> >  historical reasons, and is determined in part by the
> >  *direct*/*indirect*/*offset* mount options, and the *maxproto*
> > mount option.

Yeah, this whole paragraph is not quite accurate.

For autofs user space the determination of whether these mounts are
trigger mounts (direct or offset mount option) or plain mount point
directories (indirect mount top level sub-directory) is done based
on the user supplied mount map syntax.

For other autofs users, such as systemd, the mount option (direct in
this case) is chosen based on what semantics the user wants.

Ian

