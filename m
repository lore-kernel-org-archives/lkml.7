Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9CEC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A614C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565040571;
	bh=u+3SYBPVgv/FEIxWu9RLECxDzTwrB/RGyZBZnMDQAec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ep1pNbJ0JE6yKl9sb7yvLXvngB3k/sNfWXsUx6FnM43nnvyFpyH1is0xsdCCgSpF
	 QxRTRGJ0Fwk00rv13acynDz7UOWuOckXCo0+jOGv6zhEKbtve782/WGuNQLbcKsiIM
	 oNka0bNjwZNRQ4EScRMuWtLlzUZAwlu9JmDb0aBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfHEV3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbfHEV3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:29:13 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940BA216F4;
        Mon,  5 Aug 2019 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565040552;
        bh=u+3SYBPVgv/FEIxWu9RLECxDzTwrB/RGyZBZnMDQAec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jERS4ABosOx4Nh0Qu2Lfi1dqigzT8zM+tMPMVq2zw4+f7Z+9O1FXkt6rXMe23xDL+
         v+gizQCi+rDkwwvX6At/Am3eneEnSl9CoSiQfC37IPtAPtSPbDVW0kAaUT4b9ZNCq8
         N/hamxJdUghTGHeiSGCv1/60I3uA4e6UKmMySj1g=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [WIP 4/4] bpf: Allow creating all program types without privilege
Date:   Mon,  5 Aug 2019 14:29:05 -0700
Message-Id: <9e77ae06243555a96a3fd5e854f61d24823110c9.1565040372.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565040372.git.luto@kernel.org>
References: <cover.1565040372.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't let you *run* the programs except in test mode, so it should
be safe.  Famous last words.

This assumes that the check-privilege-to-call-privileged-functions
patch actually catches all the cases and that there's nothing else
that should need privilege lurking in the type-specific verifiers.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/bpf/syscall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 23f8f89d2a86..730afa2be786 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1649,8 +1649,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	    attr->insn_cnt > (capable(CAP_SYS_ADMIN) ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
 		return -E2BIG;
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
-	    type != BPF_PROG_TYPE_CGROUP_SKB &&
-	    !capable(CAP_SYS_ADMIN))
+	    type != BPF_PROG_TYPE_CGROUP_SKB)
 		return -EPERM;
 
 	bpf_prog_load_fixup_attach_type(attr);
-- 
2.21.0

