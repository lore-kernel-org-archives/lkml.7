Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FD6C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8C520673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122887;
	bh=o0TPlNlA6sE8SAGKH4X9ZsJIGV0LCZYH5UcKTwQ4ZXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOQaChRilnZsGmzGoBlx98yIotdCAvVb4n+1pN1tZpCff8OH114djL/IRFKQMhvkl
	 URzQy0MPwsKS605NidrmidURRxq7M7lZjh/6LoClfnRZSZiMV8KSbXoiW/LA1+AWdn
	 60k19+QNNfqNGxQ/mHtMQevGzVrl+BDsH7ypAutM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfJCQ0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391117AbfJCQ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:26:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D03F4222C2;
        Thu,  3 Oct 2019 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120001;
        bh=o0TPlNlA6sE8SAGKH4X9ZsJIGV0LCZYH5UcKTwQ4ZXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBq5OM7zwtd08hkdJqFdz5EOi6R+TTuIDF5qYE4kcig/ToXLocGGsfb1qE+OxW1mr
         5yBYfU7OHwy7EW4qoUKwzlqYGeGbSwwJMTJC1r24KNPTwL/IcNAnThK78Y8r72eYLZ
         GMSoSe2PlFn6PadLzVJO8DMCSQ5BczD+CPPFd6BQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 060/313] x86/apic: Soft disable APIC before initializing it
Date:   Thu,  3 Oct 2019 17:50:38 +0200
Message-Id: <20191003154538.921711368@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2640da4cccf5cc613bf26f0998b9e340f4b5f69c ]

If the APIC was already enabled on entry of setup_local_APIC() then
disabling it soft via the SPIV register makes a lot of sense.

That masks all LVT entries and brings it into a well defined state.

Otherwise previously enabled LVTs which are not touched in the setup
function stay unmasked and might surprise the just booting kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.068290579@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 67d1259e0f7c0..a18d6dd934e55 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1550,6 +1550,14 @@ static void setup_local_APIC(void)
 		return;
 	}
 
+	/*
+	 * If this comes from kexec/kcrash the APIC might be enabled in
+	 * SPIV. Soft disable it before doing further initialization.
+	 */
+	value = apic_read(APIC_SPIV);
+	value &= ~APIC_SPIV_APIC_ENABLED;
+	apic_write(APIC_SPIV, value);
+
 #ifdef CONFIG_X86_32
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
 	if (lapic_is_integrated() && apic->disable_esr) {
-- 
2.20.1



