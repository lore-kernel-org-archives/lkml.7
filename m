Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E21C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425632186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="CpGXoKvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfDENaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:30:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38182 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfDENaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:30:21 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84AC21EC0104;
        Fri,  5 Apr 2019 15:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554471020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=0IDY4TGg5bYuEm9UhCig0Oh1WxEz0p1tIJr6uiwYJgY=;
        b=CpGXoKvrUthHe0+SMA0yheb7Tvpb0Sb+ny+cAV8ADcu7U+0M1e/kuGE78V2/4JsZoYsvSk
        k7MMEFN3Aasmf4TdNHiN+wqpApZ3YCuoiuVzNYgN/EmTC/bCF0ogXnTyhf8UszWQGvfesJ
        9Wb78zeami7mrQAED5UUvg7qdKzi+4U=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>
Subject: [PATCH 0/3] x86/microcode: Some fixes
Date:   Fri,  5 Apr 2019 15:30:07 +0200
Message-Id: <20190405133010.24249-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here is a nice cleanup from Jann along with a long overdue deprecation
of /dev/cpu/microcode. So overdue that it was broken for more than a
year and it went unnoticed. A very good sign that it can safely go to
the eternal fields of dead electrons.

Thx.

Borislav Petkov (2):
  x86/microcode: Fix the ancient deprecated microcode loading method
  x86/microcode: Deprecate MICROCODE_OLD_INTERFACE

Jann Horn (1):
  x86/microcode/intel: Refactor Intel microcode blob loading

 arch/x86/Kconfig                      | 10 +++-
 arch/x86/kernel/cpu/microcode/core.c  |  3 +-
 arch/x86/kernel/cpu/microcode/intel.c | 71 ++++++++++++++-------------
 3 files changed, 47 insertions(+), 37 deletions(-)

-- 
2.21.0

