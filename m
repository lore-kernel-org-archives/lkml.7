Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9D6C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3345D206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="S/y/UYFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJHKew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:34:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51282 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJHKew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:34:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so2578006wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=yhoP5CFY+Z1ghLZyUQcS4Xw0PBKTH2xNqhN5u2X2Zzc=;
        b=S/y/UYFIfK5H9H2HljRRWcBwJ8ElgkL7TyHzC4kXPvVwxvpRbnTaMm0R/RDTQW3QDo
         R2AQ0tHtXzOmzjcF0HBHdZsQfX+cem0hZzCB8bzwis0VRQHcKRLhy2nOtURawr/8sixL
         ZehQEUTJCwts6uZ4FqewNFSZIzqfeLrRp8RFdbAdmlRcaQ84u+RGwK7b20gClMNHFJTs
         8zazCsfJ8utaVe9grK31P0Q663c7Y2oVP5+SFdFI3aBl+q9wxuME/HS1rhiO6M1+1tzg
         aUUuBEfh1J0FIZ75a1foG5Cv9rreLhueg3K8gKSGkD+gnS6kPci613hhSFpvsIxTZhxc
         SaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=yhoP5CFY+Z1ghLZyUQcS4Xw0PBKTH2xNqhN5u2X2Zzc=;
        b=QxjfJ/YqzFA/vvQm3v5OInmJH5KajJMUaq89YAxcTcimQnbMbmwlxsmcB+uZutg816
         O0Xur+/loW9J5dE1Ewzt9gXdHf3iNCjHq6R69CQFrW/urWmyr9y5jZX/mXyJedqDlakL
         KTYu27woALrmmfljrrlNfnHUJj0rF4zc7n3+0e3J9bKSR5SRtLkQ+kk4f5pnkf0xpcA1
         AS/hIxKY0omL/WpDkiS+7FwhS8pQAOi5Kz4v8tU44dVHelV1Dok+SRIUJD6n5Qz7FX2M
         fGGAluZBttIvscWhiDM4CDgTSnhybhB/kazNKiHb+TAWQpxAqmAASxtEDY0wZuEMeovq
         GGLg==
X-Gm-Message-State: APjAAAWH1fAgbD0Hd5lpT4jM38fIT6iUPakWB4+RbyeayFOrHSOmZK6R
        YBqSz9uxVzNQ8ixEDlLCsKavgjH0F81fHvQb
X-Google-Smtp-Source: APXvYqxOtD4WlrE1pyD3uJ7bqFN11xNdK3t/H3wgvpDqFkTZ+Wb4TRhM7KwImXRCWbyD1sQHepAmKg==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr3029258wmc.136.1570530889569;
        Tue, 08 Oct 2019 03:34:49 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d15sm7310906wru.50.2019.10.08.03.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 03:34:48 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org
Subject: [PATCH] microblaze: Include generic support for MSI irqdomains
Date:   Tue,  8 Oct 2019 12:34:47 +0200
Message-Id: <aa6dd855474451ff4f2e82691d1f590f3a85ba68.1570530881.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuldeep Dave <kuldeep.dave@xilinx.com>

Enable msi.h generation for pci/pcie irq domain support.

The same change has been done by commit 251a44888183
("riscv: include generic support for MSI irqdomains").

Signed-off-by: Kuldeep Dave <kuldeep.dave@xilinx.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index e5c9170a07fc..83417105c00a 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -25,6 +25,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
+generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
-- 
2.17.1

