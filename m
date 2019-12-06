Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE00C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48D92077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ln2+8XGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfLFCCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:02:03 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56019 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFCCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:02:01 -0500
Received: by mail-pl1-f201.google.com with SMTP id 66so2662707plc.22
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 18:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YGa/L/Mr7Uz/QYpQqGTTCPKCu7L8FPjERNxtmSKm5BY=;
        b=Ln2+8XGO5H2TfRQ/QWpgtHOld3FOGFsXqOTKyAVisHiApC5OxjUKMPFtUq6JvnLmdY
         I9o4UrOIgM+bq7BwiCa1nzJlQnuRPViBl5qsoZvFhAZ7kDdU64TOSfdRZHeN8ybF4A63
         PR6s6C8LM9DV//Y065jkwIuBUE0GWA2L97d9JbBU06KCu0o9Z5gTafVxWvlDda1W5H3/
         zgVFDU55ap7AQ2b3ypVGMGSPDX3ClYfIVZO93EPRBs7MHv9FhSkNxt5zEzWVkVk1T/jX
         Oqe6DwcjKFO8NlhrTKNdeudAFZnvH3g9rbQcj3RKRMMUtc/q59jyMRoxRq7+1RGuVfrY
         1b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YGa/L/Mr7Uz/QYpQqGTTCPKCu7L8FPjERNxtmSKm5BY=;
        b=sHJd8QJ0VDg8H0+uCy6X8tLKpKRbaOyJsTQhY3ihjXEmUYpVaoVg2BN+ISg4XQ3Cdt
         oayXN7ZoKSIoji8wv9luDdkT2FRuQWJVUk5bXYR2O1kJzbxEvNFcv+SYfp/fHbUKVc9m
         Itbm2jJlsR4mZJVCYzqFR1nl9TWIx+/kAFBz8THTpG+6jf0m79MWKxcIGfRjxakbblqc
         I9/blDBQBdso1QvCmkaTqiP1wiBZCz2UX6XjYuZASo/RuyjVzzQ6osUQnK+BqeV2KqiD
         IQm2TOevPnZ3e1fN0w41KQgOoWIH1oTduI/rHADJtgF05m/GJiCFNDKztU3uZ8sg6Xax
         YeXQ==
X-Gm-Message-State: APjAAAV5GmBDa7PuIJbbdGBicFgvz2bjt53fZvXAQ4gj282lbJbs7v+W
        CgEM5b2ZLUoSMdWdhLkkMt1WqeL8N3X9adt5wpRiVg==
X-Google-Smtp-Source: APXvYqy+PKkvv2AIjDmjpOBBiRGtOuRvXhAimcF4OHZQ6+mefAaiV4laxkAoqsEvZ6RVblPnffQp4LiDJ2lN+lysoBeF2g==
X-Received: by 2002:a63:a508:: with SMTP id n8mr808314pgf.278.1575597719867;
 Thu, 05 Dec 2019 18:01:59 -0800 (PST)
Date:   Thu,  5 Dec 2019 18:01:52 -0800
In-Reply-To: <20191206020153.228283-1-brendanhiggins@google.com>
Message-Id: <20191206020153.228283-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     johannes.berg@intel.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove support for UML_NET_PCAP. It is broken. When building with
libpcap installed, the build fails:

arch/um/drivers/pcap_user.c:35:12: error: conflicting types for =E2=80=98pc=
ap_open=E2=80=99
 static int pcap_open(void *data)
            ^~~~~~~~~
In file included from /usr/include/pcap.h:43,
                 from arch/um/drivers/pcap_user.c:7:
/usr/include/pcap/pcap.h:859:18: note: previous declaration of =E2=80=98pca=
p_open=E2=80=99 was here
 PCAP_API pcap_t *pcap_open(const char *source, int snaplen, int flags,
                  ^~~~~~~~~

So it looks like this has probably been broken for some time.

In interest of trying to make allyesconfig work with UML, it is best
just to drop this.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/drivers/Kconfig     |  16 -----
 arch/um/drivers/Makefile    |  17 +----
 arch/um/drivers/pcap_kern.c | 113 -----------------------------
 arch/um/drivers/pcap_user.c | 137 ------------------------------------
 arch/um/drivers/pcap_user.h |  21 ------
 5 files changed, 2 insertions(+), 302 deletions(-)
 delete mode 100644 arch/um/drivers/pcap_kern.c
 delete mode 100644 arch/um/drivers/pcap_user.c
 delete mode 100644 arch/um/drivers/pcap_user.h

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 388096fb45a25..98fead07c33de 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -291,22 +291,6 @@ config UML_NET_MCAST
 	  exclusive).  If you don't need to network UMLs say N to each of
 	  the transports.
=20
-config UML_NET_PCAP
-	bool "pcap transport"
-	depends on UML_NET
-	help
-	The pcap transport makes a pcap packet stream on the host look
-	like an ethernet device inside UML.  This is useful for making
-	UML act as a network monitor for the host.  You must have libcap
-	installed in order to build the pcap transport into UML.
-
-	  For more information, see
-	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-	  has examples of the UML command line to use to enable this option.
-
-	If you intend to use UML as a network monitor for the host, say
-	Y here.  Otherwise, say N.
-
 config UML_NET_SLIRP
 	bool "SLiRP transport"
 	depends on UML_NET
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index a290821e355c2..7548b18e77a27 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -3,9 +3,6 @@
 # Copyright (C) 2000, 2002, 2003 Jeff Dike (jdike@karaya.com)
 #
=20
-# pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
-# in to pcap.o
-
 slip-objs :=3D slip_kern.o slip_user.o
 slirp-objs :=3D slirp_kern.o slirp_user.o
 daemon-objs :=3D daemon_kern.o daemon_user.o
@@ -18,14 +15,9 @@ ubd-objs :=3D ubd_kern.o ubd_user.o
 port-objs :=3D port_kern.o port_user.o
 harddog-objs :=3D harddog_kern.o harddog_user.o
=20
-LDFLAGS_pcap.o :=3D -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=3Dl=
ibpcap.a)
-
 LDFLAGS_vde.o :=3D -r $(shell $(CC) $(CFLAGS) -print-file-name=3Dlibvdeplu=
g.a)
=20
-targets :=3D pcap_kern.o pcap_user.o vde_kern.o vde_user.o
-
-$(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
-	$(LD) -r -dp -o $@ $^ $(ld_flags)
+targets :=3D vde_kern.o vde_user.o
=20
 $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 	$(LD) -r -dp -o $@ $^ $(ld_flags)
@@ -34,9 +26,6 @@ $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 # object name, so nothing from the library gets linked.
 #$(call if_changed,ld)
=20
-# When the above is fixed, don't forget to add this too!
-#targets +=3D $(obj)/pcap.o
-
 obj-y :=3D stdio_console.o fd.o chan_kern.o chan_user.o line.o
 obj-$(CONFIG_SSL) +=3D ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) +=3D stderr_console.o
@@ -47,7 +36,6 @@ obj-$(CONFIG_UML_NET_DAEMON) +=3D daemon.o
 obj-$(CONFIG_UML_NET_VECTOR) +=3D vector.o
 obj-$(CONFIG_UML_NET_VDE) +=3D vde.o
 obj-$(CONFIG_UML_NET_MCAST) +=3D umcast.o
-obj-$(CONFIG_UML_NET_PCAP) +=3D pcap.o
 obj-$(CONFIG_UML_NET) +=3D net.o=20
 obj-$(CONFIG_MCONSOLE) +=3D mconsole.o
 obj-$(CONFIG_MMAPPER) +=3D mmapper_kern.o=20
@@ -63,8 +51,7 @@ obj-$(CONFIG_BLK_DEV_COW_COMMON) +=3D cow_user.o
 obj-$(CONFIG_UML_RANDOM) +=3D random.o
 obj-$(CONFIG_VIRTIO_UML) +=3D virtio_uml.o
=20
-# pcap_user.o must be added explicitly.
-USER_OBJS :=3D fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o v=
de_user.o vector_user.o
+USER_OBJS :=3D fd.o null.o pty.o tty.o xterm.o slip_common.o vde_user.o ve=
ctor_user.o
 CFLAGS_null.o =3D -DDEV_NULL=3D$(DEV_NULL_PATH)
=20
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
deleted file mode 100644
index cfe4cb17694cc..0000000000000
--- a/arch/um/drivers/pcap_kern.c
+++ /dev/null
@@ -1,113 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <net_kern.h>
-#include "pcap_user.h"
-
-struct pcap_init {
-	char *host_if;
-	int promisc;
-	int optimize;
-	char *filter;
-};
-
-void pcap_init(struct net_device *dev, void *data)
-{
-	struct uml_net_private *pri;
-	struct pcap_data *ppri;
-	struct pcap_init *init =3D data;
-
-	pri =3D netdev_priv(dev);
-	ppri =3D (struct pcap_data *) pri->user;
-	ppri->host_if =3D init->host_if;
-	ppri->promisc =3D init->promisc;
-	ppri->optimize =3D init->optimize;
-	ppri->filter =3D init->filter;
-
-	printk("pcap backend, host interface %s\n", ppri->host_if);
-}
-
-static int pcap_read(int fd, struct sk_buff *skb, struct uml_net_private *=
lp)
-{
-	return pcap_user_read(fd, skb_mac_header(skb),
-			      skb->dev->mtu + ETH_HEADER_OTHER,
-			      (struct pcap_data *) &lp->user);
-}
-
-static int pcap_write(int fd, struct sk_buff *skb, struct uml_net_private =
*lp)
-{
-	return -EPERM;
-}
-
-static const struct net_kern_info pcap_kern_info =3D {
-	.init			=3D pcap_init,
-	.protocol		=3D eth_protocol,
-	.read			=3D pcap_read,
-	.write			=3D pcap_write,
-};
-
-int pcap_setup(char *str, char **mac_out, void *data)
-{
-	struct pcap_init *init =3D data;
-	char *remain, *host_if =3D NULL, *options[2] =3D { NULL, NULL };
-	int i;
-
-	*init =3D ((struct pcap_init)
-		{ .host_if 	=3D "eth0",
-		  .promisc 	=3D 1,
-		  .optimize 	=3D 0,
-		  .filter 	=3D NULL });
-
-	remain =3D split_if_spec(str, &host_if, &init->filter,
-			       &options[0], &options[1], mac_out, NULL);
-	if (remain !=3D NULL) {
-		printk(KERN_ERR "pcap_setup - Extra garbage on "
-		       "specification : '%s'\n", remain);
-		return 0;
-	}
-
-	if (host_if !=3D NULL)
-		init->host_if =3D host_if;
-
-	for (i =3D 0; i < ARRAY_SIZE(options); i++) {
-		if (options[i] =3D=3D NULL)
-			continue;
-		if (!strcmp(options[i], "promisc"))
-			init->promisc =3D 1;
-		else if (!strcmp(options[i], "nopromisc"))
-			init->promisc =3D 0;
-		else if (!strcmp(options[i], "optimize"))
-			init->optimize =3D 1;
-		else if (!strcmp(options[i], "nooptimize"))
-			init->optimize =3D 0;
-		else {
-			printk(KERN_ERR "pcap_setup : bad option - '%s'\n",
-			       options[i]);
-			return 0;
-		}
-	}
-
-	return 1;
-}
-
-static struct transport pcap_transport =3D {
-	.list 		=3D LIST_HEAD_INIT(pcap_transport.list),
-	.name 		=3D "pcap",
-	.setup  	=3D pcap_setup,
-	.user 		=3D &pcap_user_info,
-	.kern 		=3D &pcap_kern_info,
-	.private_size 	=3D sizeof(struct pcap_data),
-	.setup_size 	=3D sizeof(struct pcap_init),
-};
-
-static int register_pcap(void)
-{
-	register_transport(&pcap_transport);
-	return 0;
-}
-
-late_initcall(register_pcap);
diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
deleted file mode 100644
index bbd20638788af..0000000000000
--- a/arch/um/drivers/pcap_user.c
+++ /dev/null
@@ -1,137 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <errno.h>
-#include <pcap.h>
-#include <string.h>
-#include <asm/types.h>
-#include <net_user.h>
-#include "pcap_user.h"
-#include <um_malloc.h>
-
-#define PCAP_FD(p) (*(int *)(p))
-
-static int pcap_user_init(void *data, void *dev)
-{
-	struct pcap_data *pri =3D data;
-	pcap_t *p;
-	char errors[PCAP_ERRBUF_SIZE];
-
-	p =3D pcap_open_live(pri->host_if, ETH_MAX_PACKET + ETH_HEADER_OTHER,
-			   pri->promisc, 0, errors);
-	if (p =3D=3D NULL) {
-		printk(UM_KERN_ERR "pcap_user_init : pcap_open_live failed - "
-		       "'%s'\n", errors);
-		return -EINVAL;
-	}
-
-	pri->dev =3D dev;
-	pri->pcap =3D p;
-	return 0;
-}
-
-static int pcap_open(void *data)
-{
-	struct pcap_data *pri =3D data;
-	__u32 netmask;
-	int err;
-
-	if (pri->pcap =3D=3D NULL)
-		return -ENODEV;
-
-	if (pri->filter !=3D NULL) {
-		err =3D dev_netmask(pri->dev, &netmask);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
-			return -EIO;
-		}
-
-		pri->compiled =3D uml_kmalloc(sizeof(struct bpf_program),
-					UM_GFP_KERNEL);
-		if (pri->compiled =3D=3D NULL) {
-			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
-			return -ENOMEM;
-		}
-
-		err =3D pcap_compile(pri->pcap,
-				   (struct bpf_program *) pri->compiled,
-				   pri->filter, pri->optimize, netmask);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
-			       "'%s'\n", pcap_geterr(pri->pcap));
-			goto out;
-		}
-
-		err =3D pcap_setfilter(pri->pcap, pri->compiled);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
-			       "failed - '%s'\n", pcap_geterr(pri->pcap));
-			goto out;
-		}
-	}
-
-	return PCAP_FD(pri->pcap);
-
- out:
-	kfree(pri->compiled);
-	return -EIO;
-}
-
-static void pcap_remove(void *data)
-{
-	struct pcap_data *pri =3D data;
-
-	if (pri->compiled !=3D NULL)
-		pcap_freecode(pri->compiled);
-
-	if (pri->pcap !=3D NULL)
-		pcap_close(pri->pcap);
-}
-
-struct pcap_handler_data {
-	char *buffer;
-	int len;
-};
-
-static void handler(u_char *data, const struct pcap_pkthdr *header,
-		    const u_char *packet)
-{
-	int len;
-
-	struct pcap_handler_data *hdata =3D (struct pcap_handler_data *) data;
-
-	len =3D hdata->len < header->caplen ? hdata->len : header->caplen;
-	memcpy(hdata->buffer, packet, len);
-	hdata->len =3D len;
-}
-
-int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
-{
-	struct pcap_handler_data hdata =3D ((struct pcap_handler_data)
-		                          { .buffer  	=3D buffer,
-					    .len 	=3D len });
-	int n;
-
-	n =3D pcap_dispatch(pri->pcap, 1, handler, (u_char *) &hdata);
-	if (n < 0) {
-		printk(UM_KERN_ERR "pcap_dispatch failed - %s\n",
-		       pcap_geterr(pri->pcap));
-		return -EIO;
-	}
-	else if (n =3D=3D 0)
-		return 0;
-	return hdata.len;
-}
-
-const struct net_user_info pcap_user_info =3D {
-	.init		=3D pcap_user_init,
-	.open		=3D pcap_open,
-	.close	 	=3D NULL,
-	.remove	 	=3D pcap_remove,
-	.add_address	=3D NULL,
-	.delete_address =3D NULL,
-	.mtu		=3D ETH_MAX_PACKET,
-	.max_packet	=3D ETH_MAX_PACKET + ETH_HEADER_OTHER,
-};
diff --git a/arch/um/drivers/pcap_user.h b/arch/um/drivers/pcap_user.h
deleted file mode 100644
index 216246f5f09bd..0000000000000
--- a/arch/um/drivers/pcap_user.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*=20
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- */
-
-#include <net_user.h>
-
-struct pcap_data {
-	char *host_if;
-	int promisc;
-	int optimize;
-	char *filter;
-	void *compiled;
-	void *pcap;
-	void *dev;
-};
-
-extern const struct net_user_info pcap_user_info;
-
-extern int pcap_user_read(int fd, void *buf, int len, struct pcap_data *pr=
i);
-
--=20
2.24.0.393.g34dc348eaf-goog

