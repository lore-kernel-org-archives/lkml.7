Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A273C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC85120840
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="jdV7G+N0";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="adHVKzGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFWHn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 03:43:56 -0400
Received: from mail180-6.suw31.mandrillapp.com ([198.2.180.6]:42682 "EHLO
        mail180-6.suw31.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726056AbfFWHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 03:43:56 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 03:43:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=heA1ye5BNgh1EP8cOvkyYqS+CIu9oX7BkDTAUuWSqzo=;
 b=jdV7G+N0xuN+X03q/9LTAL1LwB5YmbwtvlSHrOtQqdNRxZrHn3NuH8CqADn+cptoLeribb9GvhXd
   +3oS0bN9p7kwLBgJunb/EbxygPaAwbv2JLRU1IewTiJ87p8UX7rlbxqA4EpOflnNTw/da/fZzma8
   ffti3qG+rPMOdlxILnQ=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail180-6.suw31.mandrillapp.com id h1smrm22sc07 for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 07:28:53 +0000 (envelope-from <bounce-md_31050260.5d0f2a35.v1-b784ad94a0ef431287fdc374e9d05c1c@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1561274933; h=From : 
 Subject : To : Cc : Message-Id : Date : MIME-Version : Content-Type : 
 Content-Transfer-Encoding : From : Subject : Date : X-Mandrill-User : 
 List-Unsubscribe; bh=heA1ye5BNgh1EP8cOvkyYqS+CIu9oX7BkDTAUuWSqzo=; 
 b=adHVKzGzJx5PRnR2SWx/SexOQ/pyUP+lJfGFSgNcoa2egwdmgBfgykhFZD0b2Jvc5L9vhA
 0ocGYcOUuXbTwAnfO1INhKawCTNrvmpxhMeIFH5BagbEDmsm4nPO8y8KQXQO+PrhCnpvPBn0
 VvsV+NdVI3P2bD54ov9B2BpcZMOzU=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 1/2] coccinelle: api/stream_open: treat all wait_.*() calls as blocking
Received: from [87.98.221.171] by mandrillapp.com id b784ad94a0ef431287fdc374e9d05c1c; Sun, 23 Jun 2019 07:28:53 +0000
X-Mailer: git-send-email 2.20.1
To:     <cocci@systeme.lip6.fr>, <linux-kernel@vger.kernel.org>
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Message-Id: <20190623072838.31234-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.b784ad94a0ef431287fdc374e9d05c1c
X-Mandrill-User: md_31050260
Date:   Sun, 23 Jun 2019 07:28:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously steam_open.cocci was treating only wait_event_.* - e.g.
wait_event_interruptible - as a blocking operation. However e.g.
wait_for_completion_interruptible is also blocking, and so from this
point of view it would be more logical to treat all wait_.* as a
blocking point.

The logic of this change actually came up for real when
drivers/pci/switch/switchtec.c changed from using
wait_event_interruptible to wait_for_completion_interruptible:

	https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
	https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
	https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/

For a driver that uses nonseekable_open with read/write having stream
semantic and read also calling e.g. wait_for_completion_interruptible,
running stream_open.cocci before this patch would produce:

	WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.

while after this patch it will report:

	ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.

Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 scripts/coccinelle/api/stream_open.cocci | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index 350145da7669..12ce18fa6b74 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -35,11 +35,11 @@ type loff_t;
 // a function that blocks
 @ blocks @
 identifier block_f;
-identifier wait_event =~ "^wait_event_.*";
+identifier wait =~ "^wait_.*";
 @@
   block_f(...) {
     ... when exists
-    wait_event(...)
+    wait(...)
     ... when exists
   }
 
@@ -49,12 +49,12 @@ identifier wait_event =~ "^wait_event_.*";
 // XXX currently reader_blocks supports only direct and 1-level indirect cases.
 @ reader_blocks_direct @
 identifier stream_reader.readstream;
-identifier wait_event =~ "^wait_event_.*";
+identifier wait =~ "^wait_.*";
 @@
   readstream(...)
   {
     ... when exists
-    wait_event(...)
+    wait(...)
     ... when exists
   }
 
-- 
2.20.1
