Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C18C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B63206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411622;
	bh=0dNNeAS5L2z6Z9G9sIKN98KYoUTrlkNDFMAeiFajzPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2k/tzwnT7iYRyiTIQdPxwqi3nJVeHZjWW5omcHZ/mZJAoy6DjRABypi/P5zxx/yO
	 fc5mFQLW/QaCgUt/hjKWUzjWWo6O9p2m7XEp+N5LyuzSMuFHvSFdKZRugj1s2ugMY8
	 jc//hnGAYNsXo2ixXxUEidYKBH8ShUOAW7a5b8Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfCLR1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbfCLRRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:39 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BBA2087C;
        Tue, 12 Mar 2019 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411059;
        bh=0dNNeAS5L2z6Z9G9sIKN98KYoUTrlkNDFMAeiFajzPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lh0Ssx6rRhWlmNA+bTze0Ahl6Y3VyuwiinT7wV8dXJ1q2gL3Z3p2gjVdLQIOneyRL
         kcu6y1QVKRJD9LJDoVmB+4VOMjQeP5XgaT1EzPxI/MzBLH9l7aM1WfWO1nk5y3cHR2
         0AzX5+UggHCyQd8EK74P9T6qvRKk/IinMC/A7z6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.9 28/96] x86/CPU/AMD: Set the CPB bit unconditionally on F17h
Date:   Tue, 12 Mar 2019 10:09:46 -0700
Message-Id: <20190312171036.631047475@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

commit 0237199186e7a4aa5310741f0a6498a20c820fd7 upstream.

Some F17h models do not have CPB set in CPUID even though the CPU
supports it. Set the feature bit unconditionally on all F17h.

 [ bp: Rewrite commit message and patch. ]

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181120030018.5185-1-jiaxun.yang@flygoat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/amd.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -765,11 +765,9 @@ static void init_amd_bd(struct cpuinfo_x
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
-	/*
-	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
-	 * all up to and including B1.
-	 */
-	if (c->x86_model <= 1 && c->x86_stepping <= 1)
+
+	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
+	if (!cpu_has(c, X86_FEATURE_CPB))
 		set_cpu_cap(c, X86_FEATURE_CPB);
 }
 


