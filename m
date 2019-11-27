Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A2921555
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574891120;
	bh=G+bUnZIIGo0TF/ZYi61/DRntB0hbkjdnF5/2+ThSJ3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmaEMRsCHsyG4oWL3ROeIL8ZanC+5vd7UvnwoNbaybtmq9nwNR8s6/7RkRa5hKi25
	 JamzA4s/6hMOa8sghZobdpkQSAZY4NnMQxoc3zcIYZiAuF81MATyl1zRKi7g8JVEqK
	 L7G+XjYISa9DS6hExO+wpe1ZNngeM+trHcQbB3Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfK0VpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfK0UgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:36:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9D521582;
        Wed, 27 Nov 2019 20:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886960;
        bh=G+bUnZIIGo0TF/ZYi61/DRntB0hbkjdnF5/2+ThSJ3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJS1H+dB3acjZXJlbCiDUfgfLyQBfCum0KtkMzzFCGchU+EyEGbOe8PsucpCTX1p9
         IqPTZXlfTI1/17myBx8wOSyVEdVxng/wALxtI6hclBJMH7nIE/15yYS4NizBAy/PWB
         DgeWaYwwUd178tVvzkto1Anzl+yk35D6yXfcB7tM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 058/132] selftests/ftrace: Fix to test kprobe $comm arg only if available
Date:   Wed, 27 Nov 2019 21:30:49 +0100
Message-Id: <20191127202957.777602143@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 2452c96e617a0ff6fb2692e55217a3fa57a7322c ]

Test $comm in kprobe-event argument syntax testcase
only if it is supported on the kernel because
$comm has been introduced 4.8 kernel.
So on older stable kernel, it should be skipped.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 231bcd2c4eb59..1e7ac6f3362ff 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -71,8 +71,11 @@ test_badarg "\$stackp" "\$stack0+10" "\$stack1-10"
 echo "r ${PROBEFUNC} \$retval" > kprobe_events
 ! echo "p ${PROBEFUNC} \$retval" > kprobe_events
 
+# $comm was introduced in 4.8, older kernels reject it.
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
 : "Comm access"
 test_goodarg "\$comm"
+fi
 
 : "Indirect memory access"
 test_goodarg "+0(${GOODREG})" "-0(${GOODREG})" "+10(\$stack)" \
-- 
2.20.1



