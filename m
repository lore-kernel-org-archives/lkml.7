Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0772EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EF8206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfKNQif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:38:35 -0500
Received: from ms.lwn.net ([45.79.88.28]:37332 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKNQif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:38:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E04CC7C0;
        Thu, 14 Nov 2019 16:38:32 +0000 (UTC)
Date:   Thu, 14 Nov 2019 09:38:31 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>
Cc:     raven@themaw.net, akpm@linux-foundation.org,
        mchehab+samsung@kernel.org, christian@brauner.io, neilb@suse.com,
        mszeredi@redhat.com, willy@infradead.org, stefanha@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH] docs: filesystems: convert autofs.txt to reST
Message-ID: <20191114093831.2ab8a077@lwn.net>
In-Reply-To: <20191113073822.GA31926@localhost.localdomain>
References: <20191113073822.GA31926@localhost.localdomain>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 13:08:22 +0530
Jaskaran Singh <jaskaransingh7654321@gmail.com> wrote:

Thanks for doing this.  Naturally I have some requests :)

> This patch converts autofs.txt to reST.

Some subsystem maintainers react strongly to changelogs that read "this
patch"; it's best to express things in the imperative form described in
Documentation/process/submitting-patches.rst.

>  - Most of the changes pertain to reST formatting.
>  - Some of the code snippets are updated to reflect current source.
>  - A definition of the autofs packet header has been added in the chapter
> 	"Communicating with autofs: the event pipe".
>  - An indentation of an 8 space tab has been added wherever suitable, so
>    as to maintain consistency.
>  - Removed indentation of the description of the ioctls which are similar
>    to the AUTOFS_IOC ioctls, as it does not come out quite right in HTML.

These seems like good changes, but they are too much for a single patch.
Please split this into multiple patches, separating the formatting and
white-space changes from those that change the text.  That makes it much
easier to review.

Some nits below.

> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  .../filesystems/{autofs.txt => autofs.rst}    | 258 ++++++++++--------
>  Documentation/filesystems/index.rst           |   1 +
>  2 files changed, 140 insertions(+), 119 deletions(-)
>  rename Documentation/filesystems/{autofs.txt => autofs.rst} (77%)
> 
> diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.rst
> similarity index 77%
> rename from Documentation/filesystems/autofs.txt
> rename to Documentation/filesystems/autofs.rst
> index 3af38c7fd26d..a130cba76f07 100644
> --- a/Documentation/filesystems/autofs.txt
> +++ b/Documentation/filesystems/autofs.rst
> @@ -1,12 +1,9 @@
> -<head>
> -<style> p { max-width:50em} ol, ul {max-width: 40em}</style>
> -</head>

Heh, yeah, I'm not sure why that's there, it should definitely go.

> +=====================
>  autofs - how it works
>  =====================
>  
>  Purpose
> --------
> +=======
>  
>  The goal of autofs is to provide on-demand mounting and race free
>  automatic unmounting of various other filesystems.  This provides two
> @@ -28,7 +25,7 @@ key advantages:
>     first accessed a name.
>  
>  Context
> --------
> +=======
>  
>  The "autofs" filesystem module is only one part of an autofs system.
>  There also needs to be a user-space program which looks up names
> @@ -43,7 +40,7 @@ filesystem type.  Several "autofs" filesystems can be mounted and they
>  can each be managed separately, or all managed by the same daemon.
>  
>  Content
> --------
> +=======
>  
>  An autofs filesystem can contain 3 sorts of objects: directories,
>  symbolic links and mount traps.  Mount traps are directories with
> @@ -52,7 +49,7 @@ extra properties as described in the next section.
>  Objects can only be created by the automount daemon: symlinks are
>  created with a regular `symlink` system call, while directories and
>  mount traps are created with `mkdir`.  The determination of whether a
> -directory should be a mount trap or not is quite _ad hoc_, largely for
> +directory should be a mount trap or not is quite _ad hoc\_, largely for

Remember that we want to preserve the readability of the plain-text
document; sprinkling that sort of escape doesn't really help.  Recognize
that what's there now is a sort of informal markup; I'd either fix it up or
take it out.  So "*ad hoc*" or just "ad hoc".

(Or rephrase it, since this doesn't actually seem to be an appropriate use
of "ad hoc" but that's a separate issue :)

>  historical reasons, and is determined in part by the
>  *direct*/*indirect*/*offset* mount options, and the *maxproto* mount option.
>  
> @@ -80,7 +77,7 @@ where in the tree they are (root, top level, or lower), the *maxproto*,
>  and whether the mount was *indirect* or not.
>  
>  Mount Traps
> ----------------
> +===============

As long as you're changing the underbar make it match the length of the
text.

>  A core element of the implementation of autofs is the Mount Traps
>  which are provided by the Linux VFS.  Any directory provided by a
> @@ -201,7 +198,7 @@ initiated or is being considered, otherwise it returns 0.
>  
>  
>  Mountpoint expiry
> ------------------
> +=================
>  
>  The VFS has a mechanism for automatically expiring unused mounts,
>  much as it can expire any unused dentry information from the dcache.
> @@ -301,7 +298,7 @@ completed (together with removing any directories that might have been
>  necessary), or has been aborted.
>  
>  Communicating with autofs: detecting the daemon
> ------------------------------------------------
> +===============================================
>  
>  There are several forms of communication between the automount daemon
>  and the filesystem.  As we have already seen, the daemon can create and
> @@ -317,33 +314,39 @@ If the daemon ever has to be stopped and restarted a new pgid can be
>  provided through an ioctl as will be described below.
>  
>  Communicating with autofs: the event pipe
> ------------------------------------------
> +=========================================
>  
>  When an autofs filesystem is mounted, the 'write' end of a pipe must
>  be passed using the 'fd=' mount option.  autofs will write
>  notification messages to this pipe for the daemon to respond to.
> -For version 5, the format of the message is:
> -
> -        struct autofs_v5_packet {
> -                int proto_version;                /* Protocol version */
> -                int type;                        /* Type of packet */
> -                autofs_wqt_t wait_queue_token;
> -                __u32 dev;
> -                __u64 ino;
> -                __u32 uid;
> -                __u32 gid;
> -                __u32 pid;
> -                __u32 tgid;
> -                __u32 len;
> -                char name[NAME_MAX+1];
> +For version 5, the format of the message is: ::

Too may colons.  Just say "...the message is::"  There's a few of these.

> +	struct autofs_v5_packet {
> +		struct autofs_packet_hdr hdr;
> +		autofs_wqt_t wait_queue_token;
> +		__u32 dev;
> +		__u64 ino;
> +		__u32 uid;
> +		__u32 gid;
> +		__u32 pid;
> +		__u32 tgid;
> +		__u32 len;
> +		char name[NAME_MAX+1];
>          };
>  
> -where the type is one of
> +And the format of the header is: ::
> +
> +	struct autofs_packet_hdr {
> +		int proto_version;		/* Protocol version */
> +		int type;			/* Type of packet */
> +	};
>  
> -        autofs_ptype_missing_indirect
> -        autofs_ptype_expire_indirect
> -        autofs_ptype_missing_direct
> -        autofs_ptype_expire_direct
> +where the type is one of ::
> +
> +	autofs_ptype_missing_indirect
> +	autofs_ptype_expire_indirect
> +	autofs_ptype_missing_direct
> +	autofs_ptype_expire_direct
>  
>  so messages can indicate that a name is missing (something tried to
>  access it but it isn't there) or that it has been selected for expiry.
> @@ -360,7 +363,7 @@ acknowledged using one of the ioctls below with the relevant
>  `wait_queue_token`.
>  
>  Communicating with autofs: root directory ioctls
> -------------------------------------------------
> +================================================
>  
>  The root directory of an autofs filesystem will respond to a number of
>  ioctls.  The process issuing the ioctl must have the CAP_SYS_ADMIN
> @@ -368,58 +371,66 @@ capability, or must be the automount daemon.
>  
>  The available ioctl commands are:
>  
> -- **AUTOFS_IOC_READY**: a notification has been handled.  The argument
> -    to the ioctl command is the "wait_queue_token" number
> -    corresponding to the notification being acknowledged.
> -- **AUTOFS_IOC_FAIL**: similar to above, but indicates failure with
> -    the error code `ENOENT`.
> -- **AUTOFS_IOC_CATATONIC**: Causes the autofs to enter "catatonic"
> -    mode meaning that it stops sending notifications to the daemon.
> -    This mode is also entered if a write to the pipe fails.
> -- **AUTOFS_IOC_PROTOVER**:  This returns the protocol version in use.
> -- **AUTOFS_IOC_PROTOSUBVER**: Returns the protocol sub-version which
> -    is really a version number for the implementation.
> -- **AUTOFS_IOC_SETTIMEOUT**:  This passes a pointer to an unsigned
> -    long.  The value is used to set the timeout for expiry, and
> -    the current timeout value is stored back through the pointer.
> -- **AUTOFS_IOC_ASKUMOUNT**:  Returns, in the pointed-to `int`, 1 if
> -    the filesystem could be unmounted.  This is only a hint as
> -    the situation could change at any instant.  This call can be
> -    used to avoid a more expensive full unmount attempt.
> -- **AUTOFS_IOC_EXPIRE**: as described above, this asks if there is
> -    anything suitable to expire.  A pointer to a packet:
> -
> -        struct autofs_packet_expire_multi {
> -                int proto_version;              /* Protocol version */
> -                int type;                       /* Type of packet */
> -                autofs_wqt_t wait_queue_token;
> -                int len;
> -                char name[NAME_MAX+1];
> -        };
> +- **AUTOFS_IOC_READY**:
> +	a notification has been handled.  The argument
> +	to the ioctl command is the "wait_queue_token" number
> +	corresponding to the notification being acknowledged.
> +- **AUTOFS_IOC_FAIL**:
> +	similar to above, but indicates failure with
> +	the error code `ENOENT`.
> +- **AUTOFS_IOC_CATATONIC**:
> +	Causes the autofs to enter "catatonic"
> +	mode meaning that it stops sending notifications to the daemon.
> +	This mode is also entered if a write to the pipe fails.
> +- **AUTOFS_IOC_PROTOVER**:
> +	This returns the protocol version in use.
> +- **AUTOFS_IOC_PROTOSUBVER**:
> +	Returns the protocol sub-version which
> +	is really a version number for the implementation.
> +- **AUTOFS_IOC_SETTIMEOUT**:
> +	This passes a pointer to an unsigned
> +	long.  The value is used to set the timeout for expiry, and
> +	the current timeout value is stored back through the pointer.
> +- **AUTOFS_IOC_ASKUMOUNT**:
> +	Returns, in the pointed-to `int`, 1 if
> +	the filesystem could be unmounted.  This is only a hint as
> +	the situation could change at any instant.  This call can be
> +	used to avoid a more expensive full unmount attempt.
> +- **AUTOFS_IOC_EXPIRE**:
> +	as described above, this asks if there is
> +	anything suitable to expire.  A pointer to a packet: ::
> +
> +		struct autofs_packet_expire_multi {
> +			struct autofs_packet_hdr hdr;
> +			autofs_wqt_t wait_queue_token;
> +			int len;
> +			char name[NAME_MAX+1];
> +		};
>  
> -     is required.  This is filled in with the name of something
> -     that can be unmounted or removed.  If nothing can be expired,
> -     `errno` is set to `EAGAIN`.  Even though a `wait_queue_token`
> -     is present in the structure, no "wait queue" is established
> -     and no acknowledgment is needed.
> -- **AUTOFS_IOC_EXPIRE_MULTI**:  This is similar to
> -     **AUTOFS_IOC_EXPIRE** except that it causes notification to be
> -     sent to the daemon, and it blocks until the daemon acknowledges.
> -     The argument is an integer which can contain two different flags.
> +	is required.  This is filled in with the name of something
> +	that can be unmounted or removed.  If nothing can be expired,
> +	`errno` is set to `EAGAIN`.  Even though a `wait_queue_token`
> +	is present in the structure, no "wait queue" is established
> +	and no acknowledgment is needed.
> +- **AUTOFS_IOC_EXPIRE_MULTI**:
> +	This is similar to
> +	**AUTOFS_IOC_EXPIRE** except that it causes notification to be
> +	sent to the daemon, and it blocks until the daemon acknowledges.
> +	The argument is an integer which can contain two different flags.
>  
> -     **AUTOFS_EXP_IMMEDIATE** causes `last_used` time to be ignored
> -     and objects are expired if the are not in use.
> +	**AUTOFS_EXP_IMMEDIATE** causes `last_used` time to be ignored
> +	and objects are expired if the are not in use.
>  
> -     **AUTOFS_EXP_FORCED** causes the in use status to be ignored
> -     and objects are expired ieven if they are in use. This assumes
> -     that the daemon has requested this because it is capable of
> -     performing the umount.
> +	**AUTOFS_EXP_FORCED** causes the in use status to be ignored
> +	and objects are expired ieven if they are in use. This assumes
> +	that the daemon has requested this because it is capable of
> +	performing the umount.
>  
> -     **AUTOFS_EXP_LEAVES** will select a leaf rather than a top-level
> -     name to expire.  This is only safe when *maxproto* is 4.
> +	**AUTOFS_EXP_LEAVES** will select a leaf rather than a top-level
> +	name to expire.  This is only safe when *maxproto* is 4.
>  
>  Communicating with autofs: char-device ioctls
> ----------------------------------------------
> +=============================================
>  
>  It is not always possible to open the root of an autofs filesystem,
>  particularly a *direct* mounted filesystem.  If the automount daemon
> @@ -429,9 +440,9 @@ need there is a "miscellaneous" character device (major 10, minor 235)
>  which can be used to communicate directly with the autofs filesystem.
>  It requires CAP_SYS_ADMIN for access.
>  
> -The `ioctl`s that can be used on this device are described in a separate
> +The `ioctl`\s that can be used on this device are described in a separate

Better to just avoid the use of the backtick here.  I'd say "ioctl()s" but
that's me.  If nothing else, change it to a regular apostrophe.

Thanks,

jon
