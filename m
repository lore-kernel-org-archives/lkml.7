Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14256206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfJGOvi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:51:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKD-00063y-Bx; Mon, 07 Oct 2019 16:49:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4A24A1C0DD2;
        Mon,  7 Oct 2019 16:49:17 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:17 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers uapi: Sync linux/usbdevice_fs.h with
 the kernel sources
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-x1rb109b9nfi7pukota82xhj@git.kernel.org>
References: <tip-x1rb109b9nfi7pukota82xhj@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975718.9978.14795938261468093833.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     05f371f8c55d69e4c04db4473085303291e4e734
Gitweb:        https://git.kernel.org/tip/05f371f8c55d69e4c04db4473085303291e4e734
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 27 Sep 2019 11:42:26 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:02 -03:00

tools headers uapi: Sync linux/usbdevice_fs.h with the kernel sources

To pick up the changes from:

  4ed3350539aa ("USB: usbfs: Add a capability flag for runtime suspend")
  7794f486ed0b ("usbfs: Add ioctls for runtime power management")

This triggers these changes in the kernel sources, automagically
supporting these new ioctls in the 'perf trace' beautifiers.

Soon this will be used in things like filter expressions for tracepoints
in 'perf record', 'perf trace', 'perf top', i.e. filter expressions will
do a lookup to turn things like USBDEVFS_WAIT_FOR_RESUME into _IO('U',
35) before associating the tracepoint expression to tracepoint perf
event.

  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh  > before
  $ cp include/uapi/linux/usbdevice_fs.h tools/include/uapi/linux/usbdevice_fs.h
  $ git diff
  diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
  index 78efe870c2b7..cf525cddeb94 100644
  --- a/tools/include/uapi/linux/usbdevice_fs.h
  +++ b/tools/include/uapi/linux/usbdevice_fs.h
  @@ -158,6 +158,7 @@ struct usbdevfs_hub_portinfo {
   #define USBDEVFS_CAP_MMAP                      0x20
   #define USBDEVFS_CAP_DROP_PRIVILEGES           0x40
   #define USBDEVFS_CAP_CONNINFO_EX               0x80
  +#define USBDEVFS_CAP_SUSPEND                   0x100

   /* USBDEVFS_DISCONNECT_CLAIM flags & struct */

  @@ -223,5 +224,8 @@ struct usbdevfs_streams {
    * extending size of the data returned.
    */
   #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
  +#define USBDEVFS_FORBID_SUSPEND    _IO('U', 33)
  +#define USBDEVFS_ALLOW_SUSPEND     _IO('U', 34)
  +#define USBDEVFS_WAIT_FOR_RESUME   _IO('U', 35)

   #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh  > after
  $ diff -u before after
  --- before	2019-09-27 11:41:50.634867620 -0300
  +++ after	2019-09-27 11:42:07.453102978 -0300
  @@ -24,6 +24,9 @@
   	[30] = "DROP_PRIVILEGES",
   	[31] = "GET_SPEED",
   	[32] = "CONNINFO_EX",
  +	[33] = "FORBID_SUSPEND",
  +	[34] = "ALLOW_SUSPEND",
  +	[35] = "WAIT_FOR_RESUME",
   	[3] = "RESETEP",
   	[4] = "SETINTERFACE",
   	[5] = "SETCONFIGURATION",
  $

This addresses the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/usbdevice_fs.h' differs from latest version at 'include/uapi/linux/usbdevice_fs.h'
  diff -u tools/include/uapi/linux/usbdevice_fs.h include/uapi/linux/usbdevice_fs.h

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x1rb109b9nfi7pukota82xhj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/usbdevice_fs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
index 78efe87..cf525cd 100644
--- a/tools/include/uapi/linux/usbdevice_fs.h
+++ b/tools/include/uapi/linux/usbdevice_fs.h
@@ -158,6 +158,7 @@ struct usbdevfs_hub_portinfo {
 #define USBDEVFS_CAP_MMAP			0x20
 #define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
 #define USBDEVFS_CAP_CONNINFO_EX		0x80
+#define USBDEVFS_CAP_SUSPEND			0x100
 
 /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
 
@@ -223,5 +224,8 @@ struct usbdevfs_streams {
  * extending size of the data returned.
  */
 #define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
+#define USBDEVFS_FORBID_SUSPEND    _IO('U', 33)
+#define USBDEVFS_ALLOW_SUSPEND     _IO('U', 34)
+#define USBDEVFS_WAIT_FOR_RESUME   _IO('U', 35)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
