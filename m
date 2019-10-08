Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6D3ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 05:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05EE206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 05:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0eWcMBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfJHFCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 01:02:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34053 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfJHFCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 01:02:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so15362413qke.1;
        Mon, 07 Oct 2019 22:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VS/97quD98V2h0tZIjlCRDTl61AK8RjARzV2zJwGIuQ=;
        b=J0eWcMBxorRAPrt08192cxQDi+jb74iq4Gsnv4MOSRtrsG+/JShLhfLa9et3NUrNt/
         vt5gij1gmW/rxGXwA+qdGaWLvC9z7nl7afgO/gweOchUIVsrkUwcLS1e0/MCTCnfu8bS
         +kkSa16m+InYaXmSxpbeo5UKGHjr1FIF1WJu7XoVXB2LvuS5lzqplM4rxgeg89PiVN40
         WJ+WF0JMGOlBrhm8jN2vhNcG1Cc94kXdO7lU88OK0UvptswJxt6RkxAU1RU9ofRZAmJB
         J6Rsa6rqGiTnehkPzcoR+YumU7jFMgfqvGE83FBQRqPHiXAlKOfdCv+f1eyYYFBkcBng
         /aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VS/97quD98V2h0tZIjlCRDTl61AK8RjARzV2zJwGIuQ=;
        b=XZaf8NUYcvJTH+vUoPzgtb5qNweqyEbYpigDmdfC66u1VDUIjwAz3c06ct1COlh9mm
         y6VKmZaICpLl0s+eF+ng4d+DBisIP5KiCUpihfwSEfEwok1QVMVNUGMHdPoBMHVVBCbM
         JgLDrC0DeuKBik4Skx47H1Da8rAWChPIVmnx3+caiZryOjTkcX44SSsrRZXutnxdWln0
         jKeE2NdfDwhHtpJRMbTjPGS54I9x2vu5DSHGC/F77Tdf2JmWAXThWy9LWAkNi0r6XPSu
         hJ1wRJgMaegB1YQbyCqmIB3PUH5zlH4UOckHeVmgHVk5TJg3tnxaqxT/ryr5Jje6F4ve
         ZeVw==
X-Gm-Message-State: APjAAAWGSz1t0vqhhkP+E62NxL9ZLujI0QVKbQGydDi5BVGF9HV5Uzq8
        w5xyS8SzZM8pidpYVb/4mxDKSwzvKO0=
X-Google-Smtp-Source: APXvYqwFCeB2WLn+3G0N/u7740/6dyFKkU65P5R/gXR6Q8WJA7kAhjY2C5qJHRd6l45fjw/ueCXPtw==
X-Received: by 2002:a37:c448:: with SMTP id h8mr4852603qkm.72.1570510924488;
        Mon, 07 Oct 2019 22:02:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t17sm13264259qtt.57.2019.10.07.22.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 22:02:03 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 63F4F21240;
        Tue,  8 Oct 2019 01:02:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 08 Oct 2019 01:02:02 -0400
X-ME-Sender: <xms:SRicXQE6jkOjQ9nsfFO7CQYJGxJhhYXUNVI63dqAkjSGbiUKJ26tmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheekgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepuddtuddrke
    eirdegfedrvddtieenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunheppehfihigmhgvrdhnrghmvgesfhhigihmvgdrnhgrmhgvnecuvehluhhs
    thgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ShicXUzmLTHNmGxZkELTVlMSjxZCG0IWAOjGCaym47130hlfBeoqKQ>
    <xmx:ShicXdppbuvbJcrnlvsStNuPCqbCTuOHSB2ou1-8_lFj9bYkKp9SmQ>
    <xmx:ShicXWjUQS3wKY361l-NIpF2KvU6QcrYGFVAMtV2D4JP8YTF89R6gg>
    <xmx:ShicXbXJqLUxpUqEpsRqhkGCW_C5S8_zdiWD2Vyq4DbrUzSDIWr4UQ>
Received: from localhost (unknown [101.86.43.206])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7BA42D6005A;
        Tue,  8 Oct 2019 01:02:00 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH] rcu: Avoid to modify mask_ofl_ipi in sync_rcu_exp_select_node_cpus()
Date:   Tue,  8 Oct 2019 13:01:40 +0800
Message-Id: <20191008050145.4041702-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mask_ofl_ipi" is used for iterate CPUs which IPIs are needed to send
to, however in the IPI sending loop, "mask_ofl_ipi" along with another
variable "mask_ofl_test" might also get modified to record which CPU's
quiesent state can be reported by sync_rcu_exp_select_node_cpus(). Two
variables seems to be redundant for such a propose, so this patch clean
things a little by solely using "mask_ofl_test" for recording and
"mask_ofl_ipi" for iteration. This would improve the readibility of the
IPI sending loop in sync_rcu_exp_select_node_cpus().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_exp.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 69c5aa64fcfd..212470018752 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -387,10 +387,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		}
 		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
 		put_cpu();
-		if (!ret) {
-			mask_ofl_ipi &= ~mask;
+		/* The CPU responses the IPI, and will report QS itself */
+		if (!ret)
 			continue;
-		}
+
 		/* Failed, raced with CPU hotplug operation. */
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if ((rnp->qsmaskinitnext & mask) &&
@@ -401,13 +401,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			schedule_timeout_uninterruptible(1);
 			goto retry_ipi;
 		}
-		/* CPU really is offline, so we can ignore it. */
-		if (!(rnp->expmask & mask))
-			mask_ofl_ipi &= ~mask;
+		/* CPU really is offline, and we need its QS to pass GP. */
+		if (rnp->expmask & mask)
+			mask_ofl_test |= mask;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 	/* Report quiescent states for those that went offline. */
-	mask_ofl_test |= mask_ofl_ipi;
 	if (mask_ofl_test)
 		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
 }
-- 
2.23.0

