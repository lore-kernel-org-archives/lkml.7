Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA1EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0C222459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seXrg8NB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKMHiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:38:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38128 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKMHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:38:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so706990plq.5;
        Tue, 12 Nov 2019 23:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Dqo+HHyzpUZvcLFB00rgL3cknv3+L2HGBvlQ56C4xug=;
        b=seXrg8NBCUBqhoU2zR23Rl300pvx7hI0g2jf4M7osDf4BFiBMx63ebVhS/UxR2QBBp
         zU+J3WF5oUx8FqOauB28EVQF++nIxGP7xUlFEO48DIH3Yod+eHVQpULUl2X8A6IPbqZf
         QG+hYLfZHpkcbVYEcHgBw1KXCkY7tlvWR2tdxVv0qrrSAJoZlZwmVRGDoBXgWmq6UUZd
         /vHUg+H13yVZxyV7YZEMxMassAUxmv90mf3iwJxuM9QcVAYvIiXHr6dj/oip9VSjjox0
         vI1MxIh8FVdYLesa8ubGuttyAy4+/bSjdrQ2p32VPWl2HPLHiZxISkyRZRLM6ceK/pZ3
         cnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Dqo+HHyzpUZvcLFB00rgL3cknv3+L2HGBvlQ56C4xug=;
        b=QhIOT6iRCOeJ/xSvk+/rpz66dDdEmnTLmj2qPaYVRUxAX4sX4K4qxEs09ZIo5Jq8bG
         YfsPLoSntZTTdz4U9+Z8ZL5B1Z5xFo8QXYuffT5QVrxvmkgBWVlmlqv/dWAZiUVliWkr
         uiuRy2Bw9ZHdpjcel5OWJGl+hxjNF9yHfoetlFFd2Uge/P57PGQODIya47zV/1O7WnUW
         vNT4EI/3F2KC6qxtGebe28qTe7fgDoUAgcVP55EuXcXAmVmXhAZFTYxWZ4hMViMphje9
         nrrMZvx9cwzkXn7OBEvqdPNWQChb4AryVnnVsw+Tc6klDb4DmvcwUxAyolthFpu4HB3y
         x13A==
X-Gm-Message-State: APjAAAVflK5YQoSTjMIT03h4AeZhbmSwKQYZuav/gVkycJU04iUuX7vV
        leLqiy0DWW8/Wu6TsJ4aS/QjHSd3w4XSdw==
X-Google-Smtp-Source: APXvYqzMW6reqWkLG4fysN0LG4q6iiwhjtmvbKHkwL2X+Ek8FjgwgQQe9GJE8tennbNZM0yo7EAd0w==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr2210746plf.243.1573630733883;
        Tue, 12 Nov 2019 23:38:53 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:166c:698d:7a64:6a4b:9d08:b425])
        by smtp.gmail.com with ESMTPSA id s66sm2303595pfb.38.2019.11.12.23.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 23:38:53 -0800 (PST)
Message-ID: <4809d47e3060caba7a0c71088b219b955ecbb8b0.camel@gmail.com>
Subject: Re: [RFC PATCH] convert autofs.txt to reST
From:   Jaskaran Singh <jaskaransingh7654321@gmail.com>
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>
Cc:     corbet@lwn.net, raven@themaw.net, akpm@linux-foundation.org,
        jaskaransingh7654321@gmail.com, mchehab+samsung@kernel.org,
        christian@brauner.io, neilb@suse.com, mszeredi@redhat.com,
        willy@infradead.org, stefanha@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Date:   Wed, 13 Nov 2019 13:08:46 +0530
In-Reply-To: <20191113072814.GA31364@localhost.localdomain>
References: <20191113072814.GA31364@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 12:58 +0530, Jaskaran Singh wrote:
> This patch converts autofs.txt to reST.
> 
>  - Most of the changes pertain to reST formatting.
>  - Some of the code snippets are updated to reflect current source.
>  - A definition of the autofs packet header has been added in the
> chapter
> 	"Communicating with autofs: the event pipe".
>  - An indentation of an 8 space tab has been added wherever suitable,
> so
>    as to maintain consistency.
>  - Removed indentation of the description of the ioctls which are
> similar
>    to the AUTOFS_IOC ioctls, as it does not come out quite right in
> HTML.
> 
> Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> ---
>  .../filesystems/{autofs.txt => autofs.rst}    | 258 ++++++++++----
> ----
>  Documentation/filesystems/index.rst           |   1 +
>  2 files changed, 140 insertions(+), 119 deletions(-)
>  rename Documentation/filesystems/{autofs.txt => autofs.rst} (77%)
> 
> diff --git a/Documentation/filesystems/autofs.txt
> b/Documentation/filesystems/autofs.rst
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
> -
> +=====================
>  autofs - how it works
>  =====================
>  
>  Purpose
> --------
> +=======
>  
>  The goal of autofs is to provide on-demand mounting and race free
>  automatic unmounting of various other filesystems.  This provides
> two
> @@ -28,7 +25,7 @@ key advantages:
>     first accessed a name.
>  
>  Context
> --------
> +=======
>  
>  The "autofs" filesystem module is only one part of an autofs system.
>  There also needs to be a user-space program which looks up names
> @@ -43,7 +40,7 @@ filesystem type.  Several "autofs" filesystems can
> be mounted and they
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
>  mount traps are created with `mkdir`.  The determination of whether
> a
> -directory should be a mount trap or not is quite _ad hoc_, largely
> for
> +directory should be a mount trap or not is quite _ad hoc\_, largely
> for
>  historical reasons, and is determined in part by the
>  *direct*/*indirect*/*offset* mount options, and the *maxproto* mount
> option.
>  
> @@ -80,7 +77,7 @@ where in the tree they are (root, top level, or
> lower), the *maxproto*,
>  and whether the mount was *indirect* or not.
>  
>  Mount Traps
> ----------------
> +===============
>  
>  A core element of the implementation of autofs is the Mount Traps
>  which are provided by the Linux VFS.  Any directory provided by a
> @@ -201,7 +198,7 @@ initiated or is being considered, otherwise it
> returns 0.
>  
>  
>  Mountpoint expiry
> ------------------
> +=================
>  
>  The VFS has a mechanism for automatically expiring unused mounts,
>  much as it can expire any unused dentry information from the dcache.
> @@ -301,7 +298,7 @@ completed (together with removing any directories
> that might have been
>  necessary), or has been aborted.
>  
>  Communicating with autofs: detecting the daemon
> ------------------------------------------------
> +===============================================
>  
>  There are several forms of communication between the automount
> daemon
>  and the filesystem.  As we have already seen, the daemon can create
> and
> @@ -317,33 +314,39 @@ If the daemon ever has to be stopped and
> restarted a new pgid can be
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
> -                int proto_version;                /* Protocol
> version */
> -                int type;                        /* Type of packet
> */
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
> +
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
> +		int proto_version;		/* Protocol version
> */
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
>  access it but it isn't there) or that it has been selected for
> expiry.
> @@ -360,7 +363,7 @@ acknowledged using one of the ioctls below with
> the relevant
>  `wait_queue_token`.
>  
>  Communicating with autofs: root directory ioctls
> -------------------------------------------------
> +================================================
>  
>  The root directory of an autofs filesystem will respond to a number
> of
>  ioctls.  The process issuing the ioctl must have the CAP_SYS_ADMIN
> @@ -368,58 +371,66 @@ capability, or must be the automount daemon.
>  
>  The available ioctl commands are:
>  
> -- **AUTOFS_IOC_READY**: a notification has been handled.  The
> argument
> -    to the ioctl command is the "wait_queue_token" number
> -    corresponding to the notification being acknowledged.
> -- **AUTOFS_IOC_FAIL**: similar to above, but indicates failure with
> -    the error code `ENOENT`.
> -- **AUTOFS_IOC_CATATONIC**: Causes the autofs to enter "catatonic"
> -    mode meaning that it stops sending notifications to the daemon.
> -    This mode is also entered if a write to the pipe fails.
> -- **AUTOFS_IOC_PROTOVER**:  This returns the protocol version in
> use.
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
> -                int proto_version;              /* Protocol version
> */
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
> -     sent to the daemon, and it blocks until the daemon
> acknowledges.
> -     The argument is an integer which can contain two different
> flags.
> +	is required.  This is filled in with the name of something
> +	that can be unmounted or removed.  If nothing can be expired,
> +	`errno` is set to `EAGAIN`.  Even though a `wait_queue_token`
> +	is present in the structure, no "wait queue" is established
> +	and no acknowledgment is needed.
> +- **AUTOFS_IOC_EXPIRE_MULTI**:
> +	This is similar to
> +	**AUTOFS_IOC_EXPIRE** except that it causes notification to be
> +	sent to the daemon, and it blocks until the daemon
> acknowledges.
> +	The argument is an integer which can contain two different
> flags.
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
> -     **AUTOFS_EXP_LEAVES** will select a leaf rather than a top-
> level
> -     name to expire.  This is only safe when *maxproto* is 4.
> +	**AUTOFS_EXP_LEAVES** will select a leaf rather than a top-
> level
> +	name to expire.  This is only safe when *maxproto* is 4.
>  
>  Communicating with autofs: char-device ioctls
> ----------------------------------------------
> +=============================================
>  
>  It is not always possible to open the root of an autofs filesystem,
>  particularly a *direct* mounted filesystem.  If the automount daemon
> @@ -429,9 +440,9 @@ need there is a "miscellaneous" character device
> (major 10, minor 235)
>  which can be used to communicate directly with the autofs
> filesystem.
>  It requires CAP_SYS_ADMIN for access.
>  
> -The `ioctl`s that can be used on this device are described in a
> separate
> +The `ioctl`\s that can be used on this device are described in a
> separate
>  document `autofs-mount-control.txt`, and are summarised briefly
> here.
> -Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure:
> +Each ioctl is passed a pointer to an `autofs_dev_ioctl` structure:
> ::
>  
>          struct autofs_dev_ioctl {
>                  __u32 ver_major;
> @@ -469,41 +480,50 @@ that the kernel module can support.
>  
>  Commands are:
>  
> -- **AUTOFS_DEV_IOCTL_VERSION_CMD**: does nothing, except validate
> and
> -    set version numbers.
> -- **AUTOFS_DEV_IOCTL_OPENMOUNT_CMD**: return an open file descriptor
> -    on the root of an autofs filesystem.  The filesystem is
> identified
> -    by name and device number, which is stored in `openmount.devid`.
> -    Device numbers for existing filesystems can be found in
> -    `/proc/self/mountinfo`.
> -- **AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD**: same as `close(ioctlfd)`.
> -- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**: if the filesystem is in
> -    catatonic mode, this can provide the write end of a new pipe
> -    in `setpipefd.pipefd` to re-establish communication with a
> daemon.
> -    The process group of the calling process is used to identify the
> -    daemon.
> -- **AUTOFS_DEV_IOCTL_REQUESTER_CMD**: `path` should be a
> -    name within the filesystem that has been auto-mounted on.
> -    On successful return, `requester.uid` and `requester.gid` will
> be
> -    the UID and GID of the process which triggered that mount.
> -- **AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD**: Check if path is a
> -    mountpoint of a particular type - see separate documentation for
> -    details.
> -- **AUTOFS_DEV_IOCTL_PROTOVER_CMD**:
> -- **AUTOFS_DEV_IOCTL_PROTOSUBVER_CMD**:
> -- **AUTOFS_DEV_IOCTL_READY_CMD**:
> -- **AUTOFS_DEV_IOCTL_FAIL_CMD**:
> -- **AUTOFS_DEV_IOCTL_CATATONIC_CMD**:
> -- **AUTOFS_DEV_IOCTL_TIMEOUT_CMD**:
> -- **AUTOFS_DEV_IOCTL_EXPIRE_CMD**:
> -- **AUTOFS_DEV_IOCTL_ASKUMOUNT_CMD**:  These all have the same
> -    function as the similarly named **AUTOFS_IOC** ioctls, except
> -    that **FAIL** can be given an explicit error number in
> `fail.status`
> -    instead of assuming `ENOENT`, and this **EXPIRE** command
> -    corresponds to **AUTOFS_IOC_EXPIRE_MULTI**.
> +- **AUTOFS_DEV_IOCTL_VERSION_CMD**:
> +	does nothing, except validate and
> +	set version numbers.
> +- **AUTOFS_DEV_IOCTL_OPENMOUNT_CMD**:
> +	return an open file descriptor
> +	on the root of an autofs filesystem.  The filesystem is
> identified
> +	by name and device number, which is stored in
> `openmount.devid`.
> +	Device numbers for existing filesystems can be found in
> +	`/proc/self/mountinfo`.
> +- **AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD**:
> +	same as `close(ioctlfd)`.
> +- **AUTOFS_DEV_IOCTL_SETPIPEFD_CMD**:
> +	if the filesystem is in
> +	catatonic mode, this can provide the write end of a new pipe
> +	in `setpipefd.pipefd` to re-establish communication with a
> daemon.
> +	The process group of the calling process is used to identify
> the
> +	daemon.
> +- **AUTOFS_DEV_IOCTL_REQUESTER_CMD**:
> +	`path` should be a
> +	name within the filesystem that has been auto-mounted on.
> +	On successful return, `requester.uid` and `requester.gid` will
> be
> +	the UID and GID of the process which triggered that mount.
> +- **AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD**:
> +	Check if path is a
> +	mountpoint of a particular type - see separate documentation
> for
> +	details.
> +
> +- **AUTOFS_DEV_IOCTL_PROTOVER_CMD**
> +- **AUTOFS_DEV_IOCTL_PROTOSUBVER_CMD**
> +- **AUTOFS_DEV_IOCTL_READY_CMD**
> +- **AUTOFS_DEV_IOCTL_FAIL_CMD**
> +- **AUTOFS_DEV_IOCTL_CATATONIC_CMD**
> +- **AUTOFS_DEV_IOCTL_TIMEOUT_CMD**
> +- **AUTOFS_DEV_IOCTL_EXPIRE_CMD**
> +- **AUTOFS_DEV_IOCTL_ASKUMOUNT_CMD**
> +
> +These all have the same
> +function as the similarly named **AUTOFS_IOC** ioctls, except
> +that **FAIL** can be given an explicit error number in `fail.status`
> +instead of assuming `ENOENT`, and this **EXPIRE** command
> +corresponds to **AUTOFS_IOC_EXPIRE_MULTI**.
>  
>  Catatonic mode
> ---------------
> +==============
>  
>  As mentioned, an autofs mount can enter "catatonic" mode.  This
>  happens if a write to the notification pipe fails, or if it is
> @@ -527,7 +547,7 @@ Catatonic mode can only be left via the
>  **AUTOFS_DEV_IOCTL_OPENMOUNT_CMD** ioctl on the `/dev/autofs`.
>  
>  The "ignore" mount option
> --------------------------
> +=========================
>  
>  The "ignore" mount option can be used to provide a generic indicator
>  to applications that the mount entry should be ignored when
> displaying
> @@ -542,18 +562,18 @@ This is intended to be used by user space
> programs to exclude autofs
>  mounts from consideration when reading the mounts list.
>  
>  autofs, name spaces, and shared mounts
> ---------------------------------------
> +======================================
>  
>  With bind mounts and name spaces it is possible for an autofs
>  filesystem to appear at multiple places in one or more filesystem
>  name spaces.  For this to work sensibly, the autofs filesystem
> should
> -always be mounted "shared". e.g.
> +always be mounted "shared". e.g. ::
>  
> -> `mount --make-shared /autofs/mount/point`
> +	mount --make-shared /autofs/mount/point
>  
>  The automount daemon is only able to manage a single mount location
> for
>  an autofs filesystem and if mounts on that are not 'shared', other
>  locations will not behave as expected.  In particular access to
> those
> -other locations will likely result in the `ELOOP` error
> +other locations will likely result in the `ELOOP` error ::
>  
> -> Too many levels of symbolic links
> +	Too many levels of symbolic links
> diff --git a/Documentation/filesystems/index.rst
> b/Documentation/filesystems/index.rst
> index 2c3a9f761205..ad6315a48d14 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -46,4 +46,5 @@ Documentation for filesystem implementations.
>  .. toctree::
>     :maxdepth: 2
>  
> +   autofs
>     virtiofs

Forgot to add the correct subject on this, please ignore.

