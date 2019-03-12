Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E88C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55242147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfCLISF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:18:05 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43468 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726218AbfCLISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:18:04 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x2C8I3Hj007567
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:18:03 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x2C8HwQr025117
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:18:03 -0400
Received: by mail-qk1-f198.google.com with SMTP id x63so1549896qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=a5fefyGPzt6Suby/X7/1ngqQeRywBmqZs9LR1l3n53c=;
        b=py8hODrzySkC4tlsE36TdJjVRLRcOlqpUr96ktk53zNQcUu7ZT5tuV3Ol71wlD8epc
         gTjCljmKfJYP3TUw4aG8isi4Uz9kB4dWOhit5hiNjxr3FB6Vb0WhplXqhlOI8WJmT6Rk
         vVAfb6vb0E0jkhE9pbxeYpTb582PsGELFIKNhebr7QjEt7dm57ROgXocFQMgpuRoJrzR
         23a9r3lRsOcF5mjpdscnTlRZip9+S03ZWCRPC3+NBi6/9i2BF1nFIfr+lhtp1MW+Gyw4
         R0EBzr8g5xzgGBlAZPPh+sAcGO77M23nfw8vKKMAbUf2abofAkfNkrWLHbzoYKezQTiv
         r9CQ==
X-Gm-Message-State: APjAAAU/fMaB5k89g1S894MpOlLOSHR46G6bmL6zo1pxPEowg9AgtjRW
        0lZyiz7QK7y2gLyd+7UV7b8H+dd/DLztj0r9x4LrSNsuOJuGTcl+DDXDMZogpC80yjkn2NL26hv
        0EuzrRCwaiT+lzka35TP/43yUxB0yTEbS974=
X-Received: by 2002:ac8:148b:: with SMTP id l11mr27844534qtj.290.1552378678196;
        Tue, 12 Mar 2019 01:17:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzD1qYsUVUXSZvX2Hmy2RXMzhpCAE81mNlPPtga3PihkCH/lZ0mYdrwI53rFB6zExNHqtt7lQ==
X-Received: by 2002:ac8:148b:: with SMTP id l11mr27844528qtj.290.1552378678028;
        Tue, 12 Mar 2019 01:17:58 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::3b7])
        by smtp.gmail.com with ESMTPSA id s187sm3534657qkh.76.2019.03.12.01.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 01:17:56 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/irq/devres.c - fix kerneldoc comment
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Mar 2019 04:17:56 -0400
Message-ID: <31207.1552378676@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with 'make W=1' complains:

  CC      kernel/irq/devres.o
kernel/irq/devres.c:104: warning: Excess function parameter 'thread_fn' description in 'devm_request_any_context_irq'

Fix up the kerneldoc comment

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 5d5378ea0afe..f808c6a97dcc 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -84,8 +84,6 @@ EXPORT_SYMBOL(devm_request_threaded_irq);
  *	@dev: device to request interrupt for
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs
- *	@thread_fn: function to be called in a threaded interrupt context. NULL
- *		    for devices which handle everything in @handler
  *	@irqflags: Interrupt type flags
  *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
  *	@dev_id: A cookie passed back to the handler function

