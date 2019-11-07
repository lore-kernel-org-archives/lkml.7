Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0833C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E6021D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfKGTE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:04:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:39040 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfKGTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:58 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E11736EC;
        Thu,  7 Nov 2019 19:04:56 +0000 (UTC)
Date:   Thu, 7 Nov 2019 12:04:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        christian@brauner.io, neilb@suse.com, willy@infradead.org,
        tobin@kernel.org, stefanha@redhat.com, hofrat@osadl.org,
        gregkh@linuxfoundation.org, jeffrey.t.kirsher@intel.com,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH][RESEND] docs: filesystems: sysfs: convert sysfs.txt to
 reST
Message-ID: <20191107120455.29a4c155@lwn.net>
In-Reply-To: <20191105071846.GA28727@localhost.localdomain>
References: <20191105071846.GA28727@localhost.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 12:48:46 +0530
Jaskaran Singh <jaskaransingh7654321@gmail.com> wrote:

> This patch converts sysfs.txt to sysfs.rst, and adds a corresponding
> entry in index.rst.
> 
> Most of the whitespacing and indentation is kept similar to the
> original document.
> 
> Changes to the original document include:
> 
>  - Adding an authors statement in the header.
>  - Replacing the underscores in the title with asterisks. This is so
>    that the "The" in the title appears in italics in HTML.
>  - Replacing the tilde (~) headings with equal signs, for reST section
>    headings.
>  - List out the helper macros with backquotes and corresponding description
>    on the next line.
>  - Placing C code and shell code in reST code blocks, with an indentation
>    of an 8 length tab.
>
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>

Thanks for working to improve the documentation.  There are some problems
here, none of which are your creation, but I would sure like to resolve
them while working with this document.

The first of these is that Documentation/filesystems is really the wrong
place for this file - it's covering the internal API for subsystems that
want to create entries in sysfs.  IMO, it belongs in either the driver-API
manual or the core-API manual - probably the latter.

>  Documentation/filesystems/index.rst           |   1 +
>  .../filesystems/{sysfs.txt => sysfs.rst}      | 323 ++++++++++--------
>  2 files changed, 189 insertions(+), 135 deletions(-)
>  rename Documentation/filesystems/{sysfs.txt => sysfs.rst} (60%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 2c3a9f761205..18b5ea780b9b 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -46,4 +46,5 @@ Documentation for filesystem implementations.
>  .. toctree::
>     :maxdepth: 2
>  
> +   sysfs
>     virtiofs
> diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.rst
> similarity index 60%
> rename from Documentation/filesystems/sysfs.txt
> rename to Documentation/filesystems/sysfs.rst
> index ddf15b1b0d5a..de0de5869323 100644
> --- a/Documentation/filesystems/sysfs.txt
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -1,15 +1,18 @@
> +======================================================
> +sysfs - *The* filesystem for exporting kernel objects.
> +======================================================
>  
> -sysfs - _The_ filesystem for exporting kernel objects. 

Nits: We can really just drop emphasis like that, it doesn't really help
anybody.  Also the period can go on section headers.

> +Authors:
>  
> -Patrick Mochel	<mochel@osdl.org>
> -Mike Murphy <mamurph@cs.clemson.edu>
> +- Patrick Mochel	<mochel@osdl.org>
> +- Mike Murphy   	<mamurph@cs.clemson.edu>

I would be absolutely amazed if either of those email addresses works at
this point.  I'd take them out.

> -Revised:    16 August 2011
> -Original:   10 January 2003
> +| Revised:    16 August 2011
> +| Original:   10 January 2003

Dates like that are a red flag.  See below.

>  What it is:
> -~~~~~~~~~~~
> +===========
>  
>  sysfs is a ram-based filesystem initially based on ramfs. It provides
>  a means to export kernel data structures, their attributes, and the 
> @@ -21,16 +24,18 @@ interface.
>  
>  
>  Using sysfs
> -~~~~~~~~~~~
> +===========
>  
>  sysfs is always compiled in if CONFIG_SYSFS is defined. You can access
>  it by doing:
>  
> -    mount -t sysfs sysfs /sys 
> +.. code-block:: sh
> +
> +	mount -t sysfs sysfs /sys

In the spirit of minimal markup, I'd do the above as:

   it by doing::

	mount -t sysfs sysfs /sys

But then I know that others are much more fond of .. code-block and syntax
highlighting than I am.

>  Directory Creation
> -~~~~~~~~~~~~~~~~~~
> +==================
>  
>  For every kobject that is registered with the system, a directory is
>  created for it in sysfs. That directory is created as a subdirectory
> @@ -48,7 +53,7 @@ only modified directly by the function sysfs_schedule_callback().
>  
>  
>  Attributes
> -~~~~~~~~~~
> +==========
>  
>  Attributes can be exported for kobjects in the form of regular files in
>  the filesystem. Sysfs forwards file I/O operations to methods defined
> @@ -67,15 +72,16 @@ you publicly humiliated and your code rewritten without notice.
>  
>  An attribute definition is simply:
>  
> -struct attribute {
> -        char                    * name;
> -        struct module		*owner;
> -        umode_t                 mode;
> -};
> +.. code-block:: c
>  
> +	struct attribute {
> +		char                    * name;
> +		struct module		*owner;
> +		umode_t                 mode;
> +	};

Here is where we go pretty far off the rails.  If you go looking in
include/linux/sysfs.h, the actual definition of this structure is:

struct attribute {
	const char		*name;
	umode_t			mode;
#ifdef CONFIG_DEBUG_LOCK_ALLOC
	bool			ignore_lockdep:1;
	struct lock_class_key	*key;
	struct lock_class_key	skey;
#endif
};

Most notably, the owner field went away quite some time ago.

Documentation like this is not really useful to anybody; once a reader
realizes it doesn't describe current reality, they will justifiably
disregard it.  This isn't your fault, of course, but converting something
like this to RST gives the illusion that it has been updated, when that is
very much not the case.

At a bare minimum, an effort like this needs to put a big flashing warning
at the top of the file.  But it would be soooooo much better to actually
update the content as well.

The best way to do that would be to annotate the source with proper
kerneldoc comments, then pull them into the documentation rather than
repeating the information here.  Is there any chance you might be up for
taking on a task like this?

Thanks,

jon

