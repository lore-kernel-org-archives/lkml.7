Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22694C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EA421670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556583479;
	bh=1G+jxR4PLqdGYgDj+ZrKrL5wMiH25t6wGTiLpYv9Itg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LZBxMC64UfAYN+iXNNGew6Mol/oteB2eUDu+yn0aWQFuJXwmF0Vs4BbXzdBAjpG3F
	 Ozhnsn9+iMftRT0jFOSdnwneOeSZZ6DSASZHU2dqcq4Hj04ruJ1uwcga2wHFhgRrfJ
	 UhgDRxr0driT2EfewCavOz4t7LCi+o19FOa9yitw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfD3AR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:17:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55515 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729083AbfD3AR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:17:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 71FEE21B8C;
        Mon, 29 Apr 2019 20:17:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 20:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0NrpilVTqYAlFXUfv
        3lQHBY+SzSFgtIB0ZPKg5MhGSI=; b=UrVU4Qr0X26MjMZLPdgo4LaLwOUlilbKE
        555xsm1iXLM+nXxBq5wnalzaovcTuxUNFFxLOBHBhA9mFnggQfqzfCiJxxgvQJ1j
        A6C7RlJoVfw1QM/YEBs6zwO1mfIXhfHclBWlB5z94HAK7Nof753+eew/5o96o3Wf
        5hFS5/+q0KzVe87UhgY92pmjBcBog6IpSeUlNlYOUd94r+GzF/iS5ZqZ7vvCJGMQ
        F100sOI8jiA0FoG/wJQ8ICjxXzZL8zaJxL1jnxd/NlF+dv8acIG1L6WHxx8W80rE
        N+2Vj35r26GE3em2m8lUlct4KgX+cmudyZu/9n8er7WxmBkiYDq/Q==
X-ME-Sender: <xms:NJTHXLOLwT3dFDsGaRb0BreZ7Shty2ONkmLcJ1oQbWmHC9cJoCmX5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:NJTHXKzxomSrTYSj3ktdoEVfSCC0pAZkGJhlVM9mBmTYqX_2f6c4JA>
    <xmx:NJTHXMS_-a9Xh0hVXUsjAkbfc_CJ19esDBfZD4xbRloeV1kKsL7xYw>
    <xmx:NJTHXIynTcNEpJr3LunGVMqwzXVIuqynMPZB2fPE3HOaDvhUkuT5Eg>
    <xmx:NJTHXKVaQU_4Dg8D0iq67Yzky9KNEUCWptdtr5nRjk7y1plD3eJQqA>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id E0A2AE442F;
        Mon, 29 Apr 2019 20:17:53 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sched/cpufreq: Fix kobject memleak
Date:   Tue, 30 Apr 2019 10:17:17 +1000
Message-Id: <20190430001717.26533-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently error return from kobject_init_and_add() is not followed by a
call to kobject_put().  This means there is a memory leak.

Add call to kobject_put() in error path of kobject_init_and_add().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

Resend with SOB tag.

 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5c41ea367422..3638d2377e3c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -771,6 +771,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 	return 0;
 
 fail:
+	kobject_put(&tunables->attr_set.kobj);
 	policy->governor_data = NULL;
 	sugov_tunables_free(tunables);
 
-- 
2.21.0

