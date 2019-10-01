Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8DDECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683EA21D80
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfJAN74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:59:56 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48220 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726710AbfJAN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:59:56 -0400
Received: (qmail 2179 invoked by uid 2102); 1 Oct 2019 09:59:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Oct 2019 09:59:55 -0400
Date:   Tue, 1 Oct 2019 09:59:55 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: Re: [PATCH 06/24] tools headers uapi: Sync linux/usbdevice_fs.h with
 the kernel sources
In-Reply-To: <20191001111216.7208-7-acme@kernel.org>
Message-ID: <Pine.LNX.4.44L0.1910010957340.1991-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019, Arnaldo Carvalho de Melo wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To pick up the changes from:
> 
>   4ed3350539aa ("USB: usbfs: Add a capability flag for runtime suspend")
>   7794f486ed0b ("usbfs: Add ioctls for runtime power management")
> 
> This triggers these changes in the kernel sources, automagically
> supporting these new ioctls in the 'perf trace' beautifiers.
> 
> Soon this will be used in things like filter expressions for tracepoints
> in 'perf record', 'perf trace', 'perf top', i.e. filter expressions will
> do a lookup to turn things like USBDEVFS_WAIT_FOR_RESUME into _IO('U',
> 35) before associating the tracepoint expression to tracepoint perf
> event.
> 
>   $ tools/perf/trace/beauty/usbdevfs_ioctl.sh  > before
>   $ cp include/uapi/linux/usbdevice_fs.h tools/include/uapi/linux/usbdevice_fs.h
>   $ git diff
>   diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
>   index 78efe870c2b7..cf525cddeb94 100644
>   --- a/tools/include/uapi/linux/usbdevice_fs.h
>   +++ b/tools/include/uapi/linux/usbdevice_fs.h
>   @@ -158,6 +158,7 @@ struct usbdevfs_hub_portinfo {
>    #define USBDEVFS_CAP_MMAP                      0x20
>    #define USBDEVFS_CAP_DROP_PRIVILEGES           0x40
>    #define USBDEVFS_CAP_CONNINFO_EX               0x80
>   +#define USBDEVFS_CAP_SUSPEND                   0x100
> 
>    /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
> 
>   @@ -223,5 +224,8 @@ struct usbdevfs_streams {
>     * extending size of the data returned.
>     */
>    #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
>   +#define USBDEVFS_FORBID_SUSPEND    _IO('U', 33)
>   +#define USBDEVFS_ALLOW_SUSPEND     _IO('U', 34)
>   +#define USBDEVFS_WAIT_FOR_RESUME   _IO('U', 35)
> 
>    #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
>   $ tools/perf/trace/beauty/usbdevfs_ioctl.sh  > after
>   $ diff -u before after
>   --- before	2019-09-27 11:41:50.634867620 -0300
>   +++ after	2019-09-27 11:42:07.453102978 -0300
>   @@ -24,6 +24,9 @@
>    	[30] = "DROP_PRIVILEGES",
>    	[31] = "GET_SPEED",
>    	[32] = "CONNINFO_EX",
>   +	[33] = "FORBID_SUSPEND",
>   +	[34] = "ALLOW_SUSPEND",
>   +	[35] = "WAIT_FOR_RESUME",
>    	[3] = "RESETEP",
>    	[4] = "SETINTERFACE",
>    	[5] = "SETCONFIGURATION",
>   $
> 
> This addresses the following perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/usbdevice_fs.h' differs from latest version at 'include/uapi/linux/usbdevice_fs.h'
>   diff -u tools/include/uapi/linux/usbdevice_fs.h include/uapi/linux/usbdevice_fs.h

This may sound silly, and undoubtedly the question has been asked 
before.  Nevertheless...

Why go to the time and trouble to detect differences between 
tools/include/uapi/linux/usbdevice_fs.h and 
include/uapi/linux/usbdevice_fs.h?  Why not just make the first a 
symbolic link to the second?  Or get rid of the first entirely, and 
change the source code so that it #include's the second?

Alan Stern

