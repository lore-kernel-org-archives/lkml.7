Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6B120848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfCAUAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:00:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfCAUAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:00:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9856CA0A21;
        Fri,  1 Mar 2019 20:00:45 +0000 (UTC)
Received: from cervelo.rdu.redhat.com (dhcp129-79.rdu.redhat.com [10.13.129.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3700E19C58;
        Fri,  1 Mar 2019 20:00:45 +0000 (UTC)
From:   William Cohen <wcohen@redhat.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
Cc:     William Cohen <wcohen@redhat.com>
Subject: [PATCH] arm64/stacktrace: Export save_stack_trace_regs()
Date:   Fri,  1 Mar 2019 15:00:41 -0500
Message-Id: <20190301200041.31305-1-wcohen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 01 Mar 2019 20:00:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM64 implements the save_stack_trace_regs function, but it is
unusable for any diagnostic tooling compiled as a kernel module due
the missing EXPORT_SYMBOL_GPL for the function.  Export
save_stack_trace_regs() to align with other architectures such as
s390, openrisc, and powerpc. This is similar to the ARM64 export of
save_stack_trace_tsk() added in git commit e27c7fa015d6.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 arch/arm64/kernel/stacktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 1a29f2695ff2..d908b5e9e949 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -143,6 +143,7 @@ void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
+EXPORT_SYMBOL_GPL(save_stack_trace_regs);
 
 static noinline void __save_stack_trace(struct task_struct *tsk,
 	struct stack_trace *trace, unsigned int nosched)
-- 
2.20.1

