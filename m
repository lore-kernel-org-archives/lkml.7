Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0A5C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF28B2578A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190907;
	bh=B8VpFPkIPkWKz9v+KqmrEzAmj71mIytpEi7xojvd7bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZKxfdF3R786SYJCmNXmVQDca+o7Ccq6+/UEZKeEQtNQY7BdTa2cZ6HsDJZDEnCHe
	 LDzjMMqlBAmD2k7U13nc0XfVQ4WemJBubuYxpRh4PJas63hotCcWfLn8GFhzwe6VP+
	 Boe8SkoXpRiFwtUciKDv5R/rBnQv/LjEVLpR9f0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfE3DNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfE3DLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:25 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1781F244FC;
        Thu, 30 May 2019 03:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185885;
        bh=B8VpFPkIPkWKz9v+KqmrEzAmj71mIytpEi7xojvd7bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFNkYynbGu/W0nDZWvRXL/02GEhA7wrlUV7HFpe4xeVdE2JxeNzkx3J9fIvitekWO
         w1IrahFlYj/cATxJYOhHhxEsLV9aM6sgx6/kAettqjTqzfMZp7//e9LtfI2D5SJvRe
         8PUeguKNN8VwYEg3nRnrNTgTmvQ3QKzqTcl2vALQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        jolsa@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 195/405] perf/x86/intel/cstate: Add Icelake support
Date:   Wed, 29 May 2019 20:03:13 -0700
Message-Id: <20190530030550.868369852@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f08c47d1f86c6dc666c7e659d94bf6d4492aa9d7 ]

Icelake uses the same C-state residency events as Sandy Bridge.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Link: https://lkml.kernel.org/r/20190402194509.2832-10-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/cstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index d41de9af7a39b..6072f92cb8eaf 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -578,6 +578,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_X, glm_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
+
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.20.1



