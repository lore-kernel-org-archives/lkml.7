Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11165C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7542073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcytyTHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfLJWee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:34:34 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36047 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfLJWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:34:22 -0500
Received: by mail-pf1-f202.google.com with SMTP id y127so769741pfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 14:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WyGQWTgeim8bwKoFOiUnJz7Undlykbo+pgfr/YAwFko=;
        b=ZcytyTHhIQ3z3v6rorH//toMRsPrq5A5FEwV+XNywJ6H04iFLGFJcdqgwHMzxpBro/
         bdSICwm6sSAe6qu0oqcgukb3gxEFT9YmDGTySFtYbVTfoRgDqZyYB00grc+aqUBBVS7q
         +BlaZOH1enfb1JQ3JYXza1nifzabu4leYZaR21eiWqa/kLkM3KAdkIwILbnzNB085uj7
         NRnsgZezUcCpnucg2F2O2vc6PATVMrFzi2vcx9RMdOMGfFFJMBOVuR6lf0bOjvW/KQ8G
         DjrBRaHpw2NRSeIV8Dr+CWIwZnLKa3TW81hpK4xV0wj+yDlw4OX17HViD2vJBXbDdKKx
         KyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WyGQWTgeim8bwKoFOiUnJz7Undlykbo+pgfr/YAwFko=;
        b=D9ghNAET80HQdxQeBIfvrYvcDM4d+AXlDTJS+6KMlL9qNGJChwqvmVfizHECitAEKl
         QsVpwVcrgVtR2/z2tWSjT5jCBDUNEPceuJn4IvgiQEgvVsb4fyVfaCt46ebdGjqVmEoX
         ZUrCTUTzhSdIAF7ioPc7Y96TdKS1GcCmNzpBDGc8XDeLr3CV5SLwN6Vl1786oKNZreUp
         cLft6IYS6h84bklpzbfW61qJbHuCQWsmWtQPkQ/iG73plN3MGciE+FbLNhbIg2h7zPRN
         RtElgQ/oKpNL5Lbu6r+IPCHyJFEAwf5HM9+EjQHJIR9S2xoHIBiSUKeSV9pmPkwqUMMb
         ZF/Q==
X-Gm-Message-State: APjAAAU40wvJTClG26K1jM7VsC7VjRfwbS/U2Yt0UI8QeOwPyM5zCr7k
        xjic8UNihz06qPSExiWlGVhc4yZzv7aURTXLWtHBQA==
X-Google-Smtp-Source: APXvYqzBhm64QQRnyzHjRsE2Z2suVedl3rsxqSuWpTvM5OF8TDVrWA+ITcfgSim81cqyaLNSx01t/VTS7sF0EEFqFx/5dg==
X-Received: by 2002:a63:ed56:: with SMTP id m22mr453813pgk.261.1576017262168;
 Tue, 10 Dec 2019 14:34:22 -0800 (PST)
Date:   Tue, 10 Dec 2019 14:34:03 -0800
Message-Id: <20191210223403.244842-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1] um: drivers: mark non-vector net transports as obsolete
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UML_NET_VECTOR now supports filters compiled with pcap outside of UML;
it also supports: EoGRE, EoL2TPv3, RAW (+/- BPF), TAP and BESS.

While vector drivers are not 1:1 replacements for the existing drivers,
you can achieve the same topologies and the same connectivity at much
higher performance (2.5 to 9 Gbit on mid-range Ryzen desktop) - the old
drivers test out in the 500Mbit range on the same hardware.

For all these reasons, the non-vector based transports are now
unnecessary, and some, most notably pcap and vde are maintenance
burdens. Thus, it makes sense to at least start thinking about removing
the non-vector transports, so for now, mark them as obsolete.

Link: https://lore.kernel.org/lkml/15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com/T/#u
Suggested-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---

I pretty much stole the commit message from Anton's comments in the
above link. Anton, if you would like me to credit you as a co-developer,
feel free to respond with the tags and I will include them on the next
revision.

---
 arch/um/drivers/Kconfig | 81 +++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 388096fb45a25..72d4170557820 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -147,7 +147,7 @@ config UML_NET
 	  make use of UML networking.
 
 config UML_NET_ETHERTAP
-	bool "Ethertap transport"
+	bool "Ethertap transport (obsolete)"
 	depends on UML_NET
 	help
 	  The Ethertap User-Mode Linux network transport allows a single
@@ -167,14 +167,13 @@ config UML_NET_ETHERTAP
 	  has examples of the UML command line to use to enable Ethertap
 	  networking.
 
-	  If you'd like to set up an IP network with the host and/or the
-	  outside world, say Y to this, the Daemon Transport and/or the
-	  Slip Transport.  You'll need at least one of them, but may choose
-	  more than one without conflict.  If you don't need UML networking,
-	  say N.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
+
+	  If unsure, say N.
 
 config UML_NET_TUNTAP
-	bool "TUN/TAP transport"
+	bool "TUN/TAP transport (obsolete)"
 	depends on UML_NET
 	help
 	  The UML TUN/TAP network transport allows a UML instance to exchange
@@ -185,8 +184,13 @@ config UML_NET_TUNTAP
 	  To use this transport, your host kernel must have support for TUN/TAP
 	  devices, either built-in or as a module.
 
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
+
+	  If unsure, say N.
+
 config UML_NET_SLIP
-	bool "SLIP transport"
+	bool "SLIP transport (obsolete)"
 	depends on UML_NET
 	help
 	  The slip User-Mode Linux network transport allows a running UML to
@@ -201,16 +205,13 @@ config UML_NET_SLIP
 	  has examples of the UML command line to use to enable slip
 	  networking, and details of a few quirks with it.
 
-	  The Ethertap Transport is preferred over slip because of its
-	  limitations.  If you prefer slip, however, say Y here.  Otherwise
-	  choose the Multicast transport (to network multiple UMLs on
-	  multiple hosts), Ethertap (to network with the host and the
-	  outside world), and/or the Daemon transport (to network multiple
-	  UMLs on a single host).  You may choose more than one without
-	  conflict.  If you don't need UML networking, say N.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
+
+	  If unsure, say N.
 
 config UML_NET_DAEMON
-	bool "Daemon transport"
+	bool "Daemon transport (obsolete)"
 	depends on UML_NET
 	help
 	  This User-Mode Linux network transport allows one or more running
@@ -225,13 +226,10 @@ config UML_NET_DAEMON
 	  has examples of the UML command line to use to enable Daemon
 	  networking.
 
-	  If you'd like to set up a network with other UMLs on a single host,
-	  say Y.  If you need a network between UMLs on multiple physical
-	  hosts, choose the Multicast Transport.  To set up a network with
-	  the host and/or other IP machines, say Y to the Ethertap or Slip
-	  transports.  You'll need at least one of them, but may choose
-	  more than one without conflict.  If you don't need UML networking,
-	  say N.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
+
+	  If unsure, say N.
 
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
@@ -245,7 +243,7 @@ config UML_NET_VECTOR
 	drivers.
 
 config UML_NET_VDE
-	bool "VDE transport"
+	bool "VDE transport (obsolete)"
 	depends on UML_NET
 	help
 	This User-Mode Linux network transport allows one or more running
@@ -263,11 +261,13 @@ config UML_NET_VDE
 	That site has a good overview of what VDE is and also examples
 	of the UML command line to use to enable VDE networking.
 
-	If you need UML networking with VDE,
-	say Y.
+	NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	migrate to UML_NET_VECTOR.
+
+	If unsure, say N.
 
 config UML_NET_MCAST
-	bool "Multicast transport"
+	bool "Multicast transport (obsolete)"
 	depends on UML_NET
 	help
 	  This Multicast User-Mode Linux network transport allows multiple
@@ -284,15 +284,13 @@ config UML_NET_MCAST
 	  has examples of the UML command line to use to enable Multicast
 	  networking, and notes about the security of this approach.
 
-	  If you need UMLs on multiple physical hosts to communicate as if
-	  they shared an Ethernet network, say Y.  If you need to communicate
-	  with other IP machines, make sure you select one of the other
-	  transports (possibly in addition to Multicast; they're not
-	  exclusive).  If you don't need to network UMLs say N to each of
-	  the transports.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
+
+	  If unsure, say N.
 
 config UML_NET_PCAP
-	bool "pcap transport"
+	bool "pcap transport (obsolete)"
 	depends on UML_NET
 	help
 	The pcap transport makes a pcap packet stream on the host look
@@ -304,11 +302,13 @@ config UML_NET_PCAP
 	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
 	  has examples of the UML command line to use to enable this option.
 
-	If you intend to use UML as a network monitor for the host, say
-	Y here.  Otherwise, say N.
+	NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	migrate to UML_NET_VECTOR.
+
+	If unsure, say N.
 
 config UML_NET_SLIRP
-	bool "SLiRP transport"
+	bool "SLiRP transport (obsolete)"
 	depends on UML_NET
 	help
 	  The SLiRP User-Mode Linux network transport allows a running UML
@@ -328,9 +328,10 @@ config UML_NET_SLIRP
 	  that of a host behind a firewall that masquerades all network
 	  connections passing through it (but is less secure).
 
-	  To use this you should first have slirp compiled somewhere
-	  accessible on the host, and have read its documentation.  If you
-	  don't need UML networking, say N.
+	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
+	  migrate to UML_NET_VECTOR.
+
+	  If unsure, say N.
 
 	  Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
 
-- 
2.24.0.525.g8f36a354ae-goog

