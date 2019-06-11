Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1A4C31E45
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB15207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406898AbfFKVDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406793AbfFKVDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:03:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FAC080F81;
        Tue, 11 Jun 2019 21:03:35 +0000 (UTC)
Received: from treble (ovpn-121-161.rdu2.redhat.com [10.10.121.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B93A860BF1;
        Tue, 11 Jun 2019 21:03:33 +0000 (UTC)
Date:   Tue, 11 Jun 2019 16:03:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Kairui Song <kasong@redhat.com>, Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190611210326.uebwhnesdjegyetv@treble>
References: <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
 <20190523172714.6fkzknfsuv2t44se@treble>
 <CACPcB9dHzht9v9G9_z6oe5AAwgxCTuswRLxTB29vhWphqBO5Ng@mail.gmail.com>
 <20190524232312.upjixcrnidlibikd@treble>
 <CACPcB9cFGQ6OU7Zk=q_c8V8ob6vg3HMaaXGaNjaKn8rvS-wg-g@mail.gmail.com>
 <145B7F65-2E06-4266-A816-A3445FE47638@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <145B7F65-2E06-4266-A816-A3445FE47638@fb.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 11 Jun 2019 21:03:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 04:04:48PM +0000, Song Liu wrote:
> Hi Josh, 
> 
> Have you got luck fixing the ORC side?

Here's the ORC fix.  It's needed in addition to the bpf frame pointer
fix (the previous patch).  I'll clean the patches up and post them soon.

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 33b66b5c5aec..a2337460b1a3 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -128,6 +128,16 @@ static struct orc_entry null_orc_entry = {
 	.type = ORC_TYPE_CALL
 };
 
+/* Fake frame pointer entry -- used as a fallback for generated code */
+static struct orc_entry orc_fp_entry = {
+	.type		= ORC_TYPE_CALL,
+	.sp_reg		= ORC_REG_BP,
+	.sp_offset	= 16,
+	.bp_reg		= ORC_REG_PREV_SP,
+	.bp_offset	= -16,
+	.end		= 0,
+};
+
 static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
@@ -392,8 +402,16 @@ bool unwind_next_frame(struct unwind_state *state)
 	 * calls and calls to noreturn functions.
 	 */
 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
-	if (!orc)
-		goto err;
+	if (!orc) {
+		/*
+		 * As a fallback, try to assume rbp is the frame pointer.  This
+		 * is useful for generated code like BPF.  Since this is a
+		 * guess, the rest of the unwind is no longer considered
+		 * reliable.
+		 */
+		orc = &orc_fp_entry;
+		state->error = true;
+	}
 
 	/* End-of-stack check for kernel threads: */
 	if (orc->sp_reg == ORC_REG_UNDEFINED) {
