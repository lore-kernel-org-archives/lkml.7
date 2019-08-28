Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A9722DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="qcH92gkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfH1IEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:04:38 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:18521 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfH1IEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:04:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 435C73F6D0;
        Wed, 28 Aug 2019 10:04:19 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=qcH92gkK;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SWkwWNcN3RDr; Wed, 28 Aug 2019 10:04:18 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 29BC93F6BF;
        Wed, 28 Aug 2019 10:04:16 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4A84F3610B9;
        Wed, 28 Aug 2019 10:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566979456; bh=VKkQTGpGTC8XRUPMMvYcx4iHYkMCo2E8nBqZRnVRLdg=;
        h=From:To:Cc:Subject:Date:From;
        b=qcH92gkKR7cdiTkfTd4xXI4rAP5b0KVgPOY8DWkyFYGRkfWN0hlCyrxNvJ16J5Q3a
         Wq3S91+Zz+jqB5BPoKX3MlqhMyZc7tIxqOL/KL59Ir1i4dwkzR9goE1vaMMJackxni
         5cNoyunEJZvqcJFP3XYZr4w6D60kyH2b0v7CRuhw=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v3 0/4] Add support for updated vmware hypercall instruction
Date:   Wed, 28 Aug 2019 10:03:49 +0200
Message-Id: <20190828080353.12658-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>

VMware has started using "vmcall" / "vmmcall" instead of an inl instruction
for the "backdoor" interface. This series detects support for those
instructions.
Outside of the platform code we use the "ALTERNATIVES" self-patching
mechanism similarly to how this is done with KVM.
Unfortunately we need two new x86 CPU feature flags for this, since we need
the default instruction to be "inl". IIRC the vmmouse driver is used by
other virtualization solutions than VMware, and those might break if
they encounter any of the other instructions.

v2:
- Address various style review comments
- Use mnemonics instead of bytecode in the ALTERNATIVE_2 macros
- Use vmcall / vmmcall also for the High-Bandwidth port calls
- Change the %edx argument to what vmcall / vmmcall expect (flags instead of
  port number). The port number is added in the default ALTERNATIVE_2 path.
- Ack to merge the vmmouse patch from Dmitry.
- Drop license update for now. Will get back with a freestanding patch.

v3:
- Address more style review comments
- Improve on documentation
- Remove an unnecessarily added include
- Ack to merge the vmwgfx patch from Dave.

