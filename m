Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162F6217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564434932;
	bh=IPVlv6pmCNZgDdypAZhMwlele/HGvqgwg6Y6ygA9fSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0dFy5pUnk0sYdNsJwRTSDYF9if3ySS1oFr+Fbr/UF2arwCqGvq000pBHSSNtglGIH
	 g12SnAWl8w8r0mFMsriMIAqrkfm1i3hRkYNsY5pHfIuC71wOXYMth1s5xKYnIcb4Ng
	 og/yvdWfOqRo6GIva/NxMX7NE4nTaUTPo/VjkNpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbfG2VPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388694AbfG2VP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7E021850;
        Mon, 29 Jul 2019 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434926;
        bh=IPVlv6pmCNZgDdypAZhMwlele/HGvqgwg6Y6ygA9fSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ragzkd6BRtXfIztQV7SjMutAN1bhBExe8rXc+lAbAgbilGn9zv1phid14EYoiuOiE
         OIJT2T1lMJ3IJ/iNAKo8JmimwFxyNKTrbNhcAtHF2henKm1Txi/d8EzPkmGZ2YdZaE
         xOeeNsGmcoD8gtjp0eooJzHBLJCa7jAYBy9ndAf8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 06/12] tools headers UAPI: Sync usbdevice_fs.h with the kernels to get new ioctl
Date:   Mon, 29 Jul 2019 18:14:53 -0300
Message-Id: <20190729211456.6380-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  6d101f24f1dd ("USB: add usbfs ioctl to retrieve the connection parameters")

And address this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/usbdevice_fs.h' differs from latest version at 'include/uapi/linux/usbdevice_fs.h'
  diff -u tools/include/uapi/linux/usbdevice_fs.h include/uapi/linux/usbdevice_fs.h

Which ends up autogenerating a ioctl_cmd->string table used by 'perf
trace':

  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh > before
  $ cp include/uapi/linux/usbdevice_fs.h tools/include/uapi/linux/usbdevice_fs.h
  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh > after
  $ diff -u before after
  --- before 2019-07-26 15:26:55.513636844 -0300
  +++ after 2019-07-26 15:29:11.650518677 -0300
  @@ -23,6 +23,7 @@
          [2] = "BULK",
          [30] = "DROP_PRIVILEGES",
          [31] = "GET_SPEED",
  +       [32] = "CONNINFO_EX",
          [3] = "RESETEP",
          [4] = "SETINTERFACE",
          [5] = "SETCONFIGURATION",
  $

Now 'perf trace' ioctl beautifier will translate this new ioctl to a
string and at some point will allow filtering the 'ioctl' syscall with
something like this in a system wide strace-like sessin:

  # perf trace -e ioctl/cmd=USBDEVFS_CONNINFO_EX/

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tkdfbgzqypwco96b309c0ovd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/usbdevice_fs.h | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
index 964e87217be4..78efe870c2b7 100644
--- a/tools/include/uapi/linux/usbdevice_fs.h
+++ b/tools/include/uapi/linux/usbdevice_fs.h
@@ -76,6 +76,26 @@ struct usbdevfs_connectinfo {
 	unsigned char slow;
 };
 
+struct usbdevfs_conninfo_ex {
+	__u32 size;		/* Size of the structure from the kernel's */
+				/* point of view. Can be used by userspace */
+				/* to determine how much data can be       */
+				/* used/trusted.                           */
+	__u32 busnum;           /* USB bus number, as enumerated by the    */
+				/* kernel, the device is connected to.     */
+	__u32 devnum;           /* Device address on the bus.              */
+	__u32 speed;		/* USB_SPEED_* constants from ch9.h        */
+	__u8 num_ports;		/* Number of ports the device is connected */
+				/* to on the way to the root hub. It may   */
+				/* be bigger than size of 'ports' array so */
+				/* userspace can detect overflows.         */
+	__u8 ports[7];		/* List of ports on the way from the root  */
+				/* hub to the device. Current limit in     */
+				/* USB specification is 7 tiers (root hub, */
+				/* 5 intermediate hubs, device), which     */
+				/* gives at most 6 port entries.           */
+};
+
 #define USBDEVFS_URB_SHORT_NOT_OK	0x01
 #define USBDEVFS_URB_ISO_ASAP		0x02
 #define USBDEVFS_URB_BULK_CONTINUATION	0x04
@@ -137,6 +157,7 @@ struct usbdevfs_hub_portinfo {
 #define USBDEVFS_CAP_REAP_AFTER_DISCONNECT	0x10
 #define USBDEVFS_CAP_MMAP			0x20
 #define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
+#define USBDEVFS_CAP_CONNINFO_EX		0x80
 
 /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
 
@@ -197,5 +218,10 @@ struct usbdevfs_streams {
 #define USBDEVFS_FREE_STREAMS      _IOR('U', 29, struct usbdevfs_streams)
 #define USBDEVFS_DROP_PRIVILEGES   _IOW('U', 30, __u32)
 #define USBDEVFS_GET_SPEED         _IO('U', 31)
+/*
+ * Returns struct usbdevfs_conninfo_ex; length is variable to allow
+ * extending size of the data returned.
+ */
+#define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
-- 
2.21.0

