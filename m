Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF485C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B882077C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 13:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf9JEU4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfKINGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 08:06:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36422 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKINGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 08:06:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id v19so7036045pfm.3;
        Sat, 09 Nov 2019 05:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=32W9Tjji9DSY3yO5LdGQix32cQY0Jx1iD0Y1MTTBc48=;
        b=Qf9JEU4fXjNhn+vD6QAkYh3765EIatNSJKNMZyfsx5yTkt1DwyIz1D6g0yPCxfZNSr
         RLU1D6Fosqrjzqr6FV4W3kG6SOGhXNp1/y9G3qmIweY3m1W99rpc5YLDVmIFzHecdKge
         1tUVIUjtozzqUAKVNxJ63k7ry8JMMYcWwIHY789LmSBy/7sfJgIAP/U6T6kC8lZqZEiz
         AY1ckE9nEBq9PmW6ST0oUy1U4Vp4qsk0VwABtZxlwzWQBffqtECYotR5YreGOoJUAhB/
         wTilVaHCR6E+cbohYEx/gUrEAqKHGDXb0PeWF2i/t6KszxAwaxABDNmYmueX9A17yAj4
         LxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=32W9Tjji9DSY3yO5LdGQix32cQY0Jx1iD0Y1MTTBc48=;
        b=k4Z0OOG5RJeY4y8Dg2wK/Nob9N5sZp0nACKpEAOxMgvD7uY5iEw9KxDNpmu9XjH+a1
         qcFOXIQmZj9DYbV0pxa70FTtgIu6IlABnNRtpMpu/h69n6QJX+RBv3LuP4LfGJx4kgrf
         S+ylI3G6C3TP+ccAYffxQ3GmEfBxneROxT012STurrgZVBPnKwe4WkNaD1Zru/bBa+0y
         r92X2HRd7fXMZwdq/FT6a/Wmhs4yjgf5ABMlZYZ2+myTv4TCMdKjs9UXLEvRwUzAMA09
         WKerviRvaf4e3QtO+hwEKe1y+Me+eyO/eKMh80iua15UtDGMVOW8KFawGSp/cQW277Pm
         GKaw==
X-Gm-Message-State: APjAAAXmk9tP8Ly7Pk/plzHxJzCy32afBZ6wShfzd34+cPTsCo8e7Ff+
        n2GIKMbKMeMfeTgdL8pZqAw=
X-Google-Smtp-Source: APXvYqzX7cH+G65tjKCNHDWkZwu4vygIa3mrVRlUMbgJmYQoY3j3sAk/snqFLE7ET0mUSfjprSadRA==
X-Received: by 2002:a62:fcd2:: with SMTP id e201mr364180pfh.52.1573304793261;
        Sat, 09 Nov 2019 05:06:33 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1392:8370:2ee7:33a6:a48c:39ea])
        by smtp.gmail.com with ESMTPSA id c12sm11019799pfp.67.2019.11.09.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 05:06:32 -0800 (PST)
Message-ID: <cd9dbb3704d0a39a161c3e4df8fcd9f84bbc5b03.camel@gmail.com>
Subject: Re: [PATCH][RESEND] docs: filesystems: sysfs: convert sysfs.txt to
 reST
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        christian@brauner.io, neilb@suse.com, willy@infradead.org,
        tobin@kernel.org, stefanha@redhat.com, hofrat@osadl.org,
        gregkh@linuxfoundation.org, jeffrey.t.kirsher@intel.com,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Date:   Sat, 09 Nov 2019 18:36:16 +0530
In-Reply-To: <20191107120455.29a4c155@lwn.net>
References: <20191105071846.GA28727@localhost.localdomain>
         <20191107120455.29a4c155@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 12:04 -0700, Jonathan Corbet wrote:
> On Tue, 5 Nov 2019 12:48:46 +0530
> Jaskaran Singh <jaskaransingh7654321@gmail.com> wrote:
> 
> > This patch converts sysfs.txt to sysfs.rst, and adds a
> > corresponding
> > entry in index.rst.
> > 
> > Most of the whitespacing and indentation is kept similar to the
> > original document.
> > 
> > Changes to the original document include:
> > 
> >  - Adding an authors statement in the header.
> >  - Replacing the underscores in the title with asterisks. This is
> > so
> >    that the "The" in the title appears in italics in HTML.
> >  - Replacing the tilde (~) headings with equal signs, for reST
> > section
> >    headings.
> >  - List out the helper macros with backquotes and corresponding
> > description
> >    on the next line.
> >  - Placing C code and shell code in reST code blocks, with an
> > indentation
> >    of an 8 length tab.
> > 
> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> 
> Thanks for working to improve the documentation.  There are some
> problems
> here, none of which are your creation, but I would sure like to
> resolve
> them while working with this document.
> 
> The first of these is that Documentation/filesystems is really the
> wrong
> place for this file - it's covering the internal API for subsystems
> that
> want to create entries in sysfs.  IMO, it belongs in either the
> driver-API
> manual or the core-API manual - probably the latter.
> 
> >  Documentation/filesystems/index.rst           |   1 +
> >  .../filesystems/{sysfs.txt => sysfs.rst}      | 323 ++++++++++--
> > ------
> >  2 files changed, 189 insertions(+), 135 deletions(-)
> >  rename Documentation/filesystems/{sysfs.txt => sysfs.rst} (60%)
> > 
> > diff --git a/Documentation/filesystems/index.rst
> > b/Documentation/filesystems/index.rst
> > index 2c3a9f761205..18b5ea780b9b 100644
> > --- a/Documentation/filesystems/index.rst
> > +++ b/Documentation/filesystems/index.rst
> > @@ -46,4 +46,5 @@ Documentation for filesystem implementations.
> >  .. toctree::
> >     :maxdepth: 2
> >  
> > +   sysfs
> >     virtiofs
> > diff --git a/Documentation/filesystems/sysfs.txt
> > b/Documentation/filesystems/sysfs.rst
> > similarity index 60%
> > rename from Documentation/filesystems/sysfs.txt
> > rename to Documentation/filesystems/sysfs.rst
> > index ddf15b1b0d5a..de0de5869323 100644
> > --- a/Documentation/filesystems/sysfs.txt
> > +++ b/Documentation/filesystems/sysfs.rst
> > @@ -1,15 +1,18 @@
> > +======================================================
> > +sysfs - *The* filesystem for exporting kernel objects.
> > +======================================================
> >  
> > -sysfs - _The_ filesystem for exporting kernel objects. 
> 
> Nits: We can really just drop emphasis like that, it doesn't really
> help
> anybody.  Also the period can go on section headers.
> 
> > +Authors:
> >  
> > -Patrick Mochel	<mochel@osdl.org>
> > -Mike Murphy <mamurph@cs.clemson.edu>
> > +- Patrick Mochel	<mochel@osdl.org>
> > +- Mike Murphy   	<mamurph@cs.clemson.edu>
> 
> I would be absolutely amazed if either of those email addresses works
> at
> this point.  I'd take them out.
> 
> > -Revised:    16 August 2011
> > -Original:   10 January 2003
> > +| Revised:    16 August 2011
> > +| Original:   10 January 2003
> 
> Dates like that are a red flag.  See below.
> 
> >  What it is:
> > -~~~~~~~~~~~
> > +===========
> >  
> >  sysfs is a ram-based filesystem initially based on ramfs. It
> > provides
> >  a means to export kernel data structures, their attributes, and
> > the 
> > @@ -21,16 +24,18 @@ interface.
> >  
> >  
> >  Using sysfs
> > -~~~~~~~~~~~
> > +===========
> >  
> >  sysfs is always compiled in if CONFIG_SYSFS is defined. You can
> > access
> >  it by doing:
> >  
> > -    mount -t sysfs sysfs /sys 
> > +.. code-block:: sh
> > +
> > +	mount -t sysfs sysfs /sys
> 
> In the spirit of minimal markup, I'd do the above as:
> 
>    it by doing::
> 
> 	mount -t sysfs sysfs /sys
> 
> But then I know that others are much more fond of .. code-block and
> syntax
> highlighting than I am.
> 
> >  Directory Creation
> > -~~~~~~~~~~~~~~~~~~
> > +==================
> >  
> >  For every kobject that is registered with the system, a directory
> > is
> >  created for it in sysfs. That directory is created as a
> > subdirectory
> > @@ -48,7 +53,7 @@ only modified directly by the function
> > sysfs_schedule_callback().
> >  
> >  
> >  Attributes
> > -~~~~~~~~~~
> > +==========
> >  
> >  Attributes can be exported for kobjects in the form of regular
> > files in
> >  the filesystem. Sysfs forwards file I/O operations to methods
> > defined
> > @@ -67,15 +72,16 @@ you publicly humiliated and your code rewritten
> > without notice.
> >  
> >  An attribute definition is simply:
> >  
> > -struct attribute {
> > -        char                    * name;
> > -        struct module		*owner;
> > -        umode_t                 mode;
> > -};
> > +.. code-block:: c
> >  
> > +	struct attribute {
> > +		char                    * name;
> > +		struct module		*owner;
> > +		umode_t                 mode;
> > +	};
> 
> Here is where we go pretty far off the rails.  If you go looking in
> include/linux/sysfs.h, the actual definition of this structure is:
> 
> struct attribute {
> 	const char		*name;
> 	umode_t			mode;
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> 	bool			ignore_lockdep:1;
> 	struct lock_class_key	*key;
> 	struct lock_class_key	skey;
> #endif
> };
> 
> Most notably, the owner field went away quite some time ago.
> 
> Documentation like this is not really useful to anybody; once a
> reader
> realizes it doesn't describe current reality, they will justifiably
> disregard it.  This isn't your fault, of course, but converting
> something
> like this to RST gives the illusion that it has been updated, when
> that is
> very much not the case.
> 
> At a bare minimum, an effort like this needs to put a big flashing
> warning
> at the top of the file.  But it would be soooooo much better to
> actually
> update the content as well.
> 
> The best way to do that would be to annotate the source with proper
> kerneldoc comments, then pull them into the documentation rather than
> repeating the information here.  Is there any chance you might be up
> for
> taking on a task like this?
> 


Sure! I'll send the documentation patch(es) followed by a v2 for this
patch.

Cheers,
Jaskaran.


> Thanks,
> 
> jon
> 

