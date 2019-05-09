Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF9AC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08CD2084E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EMv/t0mJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEISJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:09:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfEISJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:09:31 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 125891EC0AB1;
        Thu,  9 May 2019 20:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=mduwd8VPwCT+8HAKZuwZeDzsg6qp6pIE8pJGHr6OqNg=;
        b=EMv/t0mJcoZ2lY7XLwkfgReYWYwB8dF2UmQ68gP2iuv7kI/sKiRwvATgcikgkrdE9MSmPu
        BfLojZO1asnetnj8/vOVCGxrNCHblySQTvJ02dKKUnRfcoFKuK2114LtBqs2kMXbvyuhk3
        hSiiMDVJ6z6hjCOVSfc9JKa0pkpAWPk=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/11] RAS/CEC: Fixes and cleanups
Date:   Thu,  9 May 2019 20:09:15 +0200
Message-Id: <20190509180926.31932-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here are a bunch of fixes and cleanups to the correctable errors
collector which we've been working on in the recent weeks.

Thx.

Borislav Petkov (9):
  RAS/CEC: Fix binary search function
  RAS/CEC: Fix pfn insertion
  RAS/CEC: Check count_threshold unconditionally
  RAS/CEC: Do not set decay value on error
  RAS/CEC: Fix potential memory leak
  RAS/CEC: Sanity-check array on every insertion
  RAS/CEC: Rename count_threshold to action_threshold
  RAS/CEC: Dump the different array element sections
  RAS/CEC: Add copyright

Cong Wang (1):
  RAS/CEC: Convert the timer callback to a workqueue

Tony Luck (1):
  RAS/CEC: Add CONFIG_RAS_CEC_DEBUG and move CEC debug features there

 arch/x86/ras/Kconfig |  10 ++
 drivers/ras/cec.c    | 216 +++++++++++++++++++++++++------------------
 2 files changed, 135 insertions(+), 91 deletions(-)

-- 
2.21.0

