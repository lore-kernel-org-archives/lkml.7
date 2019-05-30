Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B2C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A876624CAB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188397;
	bh=q69LJDTEivun6th6wybJQZt18d5jFsWdI9UWHbSf3Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdCexLsnzUk5OwRjGRmgk22L4PRFTh99sV4fh+LeZCgvnCP9GgK8zim1YI2VV0A4N
	 Gz2K1qLUXXVKIv0kIKgZEOUCM1TeNJpYZUzH/8ISEaI15ZcJfslEFhw4GKhzvvy0jK
	 120U18Zyme9wfZVh1B4oB5gLn8zym9+dV8COwm5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbfE3DxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbfE3DTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:19:32 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5899824872;
        Thu, 30 May 2019 03:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186371;
        bh=q69LJDTEivun6th6wybJQZt18d5jFsWdI9UWHbSf3Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqYSvaUZqGkWsc0pi4A6n0OWlgZfosdO4omGNYgmKO0zS4KS7frMIaiR+ok+Gn+rZ
         bi1XXvC/n2NWvn1Wv8+3bSDS5xx9O4RO9uD0WeOg75jm2bI5qH65oeiezxuKmsWpdz
         TgAVi4a9UzT+1MjT3WoDn9kuqRV/wCHqvCizYh94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 128/193] x86/microcode: Fix the ancient deprecated microcode loading method
Date:   Wed, 29 May 2019 20:06:22 -0700
Message-Id: <20190530030506.320367482@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 24613a04ad1c0588c10f4b5403ca60a73d164051 ]

Commit

  2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")

added the new define UCODE_NEW to denote that an update should happen
only when newer microcode (than installed on the system) has been found.

But it missed adjusting that for the old /dev/cpu/microcode loading
interface. Fix it.

Fixes: 2613f36ed965 ("x86/microcode: Attempt late loading only when new microcode is present")
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com>
Link: https://lkml.kernel.org/r/20190405133010.24249-3-bp@alien8.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/microcode/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 387a8f44fba1e..b6b44017cf164 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -418,8 +418,9 @@ static int do_microcode_update(const void __user *buf, size_t size)
 		if (ustate == UCODE_ERROR) {
 			error = -1;
 			break;
-		} else if (ustate == UCODE_OK)
+		} else if (ustate == UCODE_NEW) {
 			apply_microcode_on_target(cpu);
+		}
 	}
 
 	return error;
-- 
2.20.1



