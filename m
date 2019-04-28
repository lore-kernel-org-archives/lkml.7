Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97CCC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBBA206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 20:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfD1UHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:07:16 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:36406 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfD1UHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 16:07:01 -0400
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 1A4287A006E;
        Sun, 28 Apr 2019 22:06:59 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] fdomain: Resurrect driver (modular version)
Date:   Sun, 28 Apr 2019 22:06:22 +0200
Message-Id: <20190428200626.28092-1-linux@zary.sk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Resurrect previously removed fdomain driver, in modern style.
Initialization is rewritten completely, with support for multiple cards,
no more global state variables.
Most of the code from interrupt handler is moved to a workqueue.

This is a modularized version with core separated from bus-specific drivers
(PCI, ISA and PCMCIA). Only PCI driver is tested for now. The other two could
be dropped until they get tested.

Changes since RFC:
 - multi-line comment style, some coding style
 - usage of scsi_k(un)map_atomic_sg for buffer access
 - static marking of fdomain_host_reset and fdomain_template
 - IRQ lookup moved to ISA bus driver
 - EXPORT_SYMBOL_GPL

-- 
Ondrej Zary
