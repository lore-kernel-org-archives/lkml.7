Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF5CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FC7222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="SsF4ZbqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439523AbfJRNlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:41:10 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:37454 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392320AbfJRNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id CF66C3F867;
        Fri, 18 Oct 2019 15:41:07 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=SsF4ZbqW;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TOTufyBBa0V2; Fri, 18 Oct 2019 15:41:04 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 45F6F3F7F6;
        Fri, 18 Oct 2019 15:41:04 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C66A6360591;
        Fri, 18 Oct 2019 15:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571406063; bh=gGaWHO4KvUf91pQm6umckHTl12QmRAuYU6HJ9fAM6fU=;
        h=From:To:Cc:Subject:Date:From;
        b=SsF4ZbqWje6RizrLxTyQMT92ptjr6gRwqIXdD9hUUFujuA41PVa7zh4zPIxM68BbK
         EZwfg2h+hTRdzj0I+1OTyCWw5BXC88tbzLuZgIRG26EmlcH1Ipt1tu7/noxLZWwRC2
         6v7jR+JeYLC0c+7GUGJyv7lkLKFGw5X1/fbqnE/o=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 0/2] x86/cpu/vmware: Fixes for 5.4
Date:   Fri, 18 Oct 2019 15:40:50 +0200
Message-Id: <20191018134052.3023-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Two fixes for recently introduced regressions:

Patch 1 is more or less idential to a previous patch fixing the VMW_PORT
macro on LLVM's assembler. However, that patch left out the VMW_HYPERCALL
macro (probably not configured for use), so let's fix that also.

Patch 2 fixes another VMW_PORT run-time regression at platform detection
time
