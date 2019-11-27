Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0603F207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574834209;
	bh=gu2X0WNJdhA3w0Ambt+LbL8y0naoQCMYirELsEbZETo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TVekVfmIDi2vjuo9INE5RkniHCiS63lKOc7QyfXKhvzHC9Pdp55uvttyaFALuxFnS
	 eFZmxe0B9fbvdTJ8OAxy/sQrBcENgoGpIDTfQoOpxd7gnmpwBCal2j5m8LfUqMNYOP
	 qmBwJjwCdeY+eQsi9aHRQ90RTcetOTVlv3C/5IXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfK0F4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0F4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:56:47 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980D220684;
        Wed, 27 Nov 2019 05:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574834206;
        bh=gu2X0WNJdhA3w0Ambt+LbL8y0naoQCMYirELsEbZETo=;
        h=From:To:Cc:Subject:Date:From;
        b=PAymuJ4cAwN4ZCIUvlvPyJ1ANCFqKHO5SJFOK2l9iW5Z+LQN+wMjd64uKPz7/nqkz
         jgw+OkABMvWGkUDw+1R/F3MWu3tBRchUG6DnXSlZ1E8ojzlKpxWPzyDXIedwxLwmT6
         3A69mC74gEIgrFNtIPNB6OK4xzueqgmW4g3/XQ+I=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org, alexei.starovoitov@gmail.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip 0/2] x86/kprobes: Fix 2 issues related to text_poke_bp and optprobe
Date:   Wed, 27 Nov 2019 14:56:41 +0900
Message-Id: <157483420094.25881.9190014521050510942.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the patches which I've faced while testing ftracetest
without function tracer. While investigating I found there were
2 different bugs there.

The 1st bug is a timing bug caused by wrong global variable
update and syncing in text_poke_bp_batch(). This can cause a
kernel panic if we hit int3 in between bp_patching.vec = NULL
and bp_patching.nr_entries = 0. This is actually a wrong order
and no synchronization. Steve suggested we can fix it with
reordering and adding sync_core() between them.

The 2nd bug is in the optprobe, which is caused by wrong flag
update order. Currently kprobes update optimized flag before
unoptimizing code. But if the kprobe is hit unoptimizing
intermediate state, it can go back from int3 to the middle of
modified instruction and cause a kernel panic. This can be
fixed by updating flag after unoptimized code. 

Thank you,

---

Masami Hiramatsu (2):
      x86/alternative: Sync bp_patching update for avoiding NULL pointer exception
      kprobes: Set unoptimized flag after unoptimizing code


 arch/x86/kernel/alternative.c |    8 +++++++-
 kernel/kprobes.c              |    4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
