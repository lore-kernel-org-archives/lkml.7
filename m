Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC35C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444552053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154750;
	bh=SqD8OrZ7/sr4F+8A2XazlG09XH1CvAtt77rj9BDVjYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kqWYtwTvks6q0qtPrbdN8WaWRpY8pniGr99bCQGQk9ow6ajvX9i/gCcAFG6B/WCQO
	 JkocsRg9iLaX28bowot6mii83Q332Jgo1/J/8nnVPp2Q/zytAUickH17uYETYxp3Yy
	 ZAyeEMrJxFtb2rwGrbOtldjkmpPAvTTQfoCWcCHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEFO7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfEFOnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:43:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E185C21655;
        Mon,  6 May 2019 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153799;
        bh=SqD8OrZ7/sr4F+8A2XazlG09XH1CvAtt77rj9BDVjYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbqLv5ux0jyHBfwfog0ceFq+0q7ZCovlrQgovLqUcFqqeDSFdNhl0Yaol13rhnx3F
         Dwu9N47ONQAafuG4Dz/Vi0RlZMBnHE5jpCk5nYGOt5x+DLb5Smpv9NTu8rLI3RzhIb
         YT0F39v2Wm52PsTFUDZP3tiXy+qbVkCTtd4lzleA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Pu Wen <puwen@hygon.cn>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.19 93/99] x86/mce: Improve error message when kernel cannot recover, p2
Date:   Mon,  6 May 2019 16:33:06 +0200
Message-Id: <20190506143102.288742394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

commit 41f035a86b5b72a4f947c38e94239d20d595352a upstream.

In

  c7d606f560e4 ("x86/mce: Improve error message when kernel cannot recover")

a case was added for a machine check caused by a DATA access to poison
memory from the kernel. A case should have been added also for an
uncorrectable error during an instruction fetch in the kernel.

Add that extra case so the error message now reads:

  mce: [Hardware Error]: Machine check: Instruction fetch error in kernel

Fixes: c7d606f560e4 ("x86/mce: Improve error message when kernel cannot recover")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190225205940.15226-1-tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce-severity.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -165,6 +165,11 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
 		KERNEL
 		),
+	MCESEV(
+		PANIC, "Instruction fetch error in kernel",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
+		KERNEL
+		),
 #endif
 	MCESEV(
 		PANIC, "Action required: unknown MCACOD",


