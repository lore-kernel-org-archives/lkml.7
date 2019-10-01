Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB00C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072AB21D81
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928376;
	bh=01Fgx2X/pbHtHLDYadB2PI9BcV53+uAq9QGr+OEnWcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BsDwE1b90pZg7ih9F89SzSWK+Nig80tQpeLNWEVKovqZOvTPO0OoGRJ0XSD25J889
	 CUA9MdOeG1ML4zFJetGB66bRGLcDQJr8J0nwJrKZsk87i4vPZBcXwvvmaPh149skW/
	 uEzpv0CrDu06eeOsS+lxs68n+Bj5CPorTP7AVE7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfJALMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbfJALMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:12:53 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EA7621924;
        Tue,  1 Oct 2019 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928372;
        bh=01Fgx2X/pbHtHLDYadB2PI9BcV53+uAq9QGr+OEnWcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAZD1W5eEYrfKEikKmzuYoxuZwXEnzdC2IGJXO0EZy5mE6014ObcyandrlQRGWK6L
         moSCnPBmiJl+5vLFMUnsifQnmpHb3ubxQOgyprPgRJxk1QJCADZRFIGMzl+QnDNKBh
         0D38hJ+ivK//kGpJLoixI3xhzsi6Pp0I98hUcdz0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 06/24] tools headers uapi: Sync linux/usbdevice_fs.h with the kernel sources
Date:   Tue,  1 Oct 2019 08:11:58 -0300
Message-Id: <20191001111216.7208-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 78efe870c2b7..cf525cddeb94 100644
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
-- 
2.21.0

