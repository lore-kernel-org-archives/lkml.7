Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF9AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605BB215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889987;
	bh=mUCR23AAMHP7FiMfk5lBhT3X/eTAIhQFLugWPOV1dys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d+ZAZTM9d8SmeMptQ04pVTW3BQaPDUpMGo4C7Zow2Zma3o3oNtgqlBnCkbjFwdRbE
	 hBrSQKSivUEPFU7dTsms5p6rLIoGBJ6b/tXyYBOp6AH5i5iXydKl7j+TQ5dKyn0mq0
	 CoPx7CNNK7YH5YBBmfYFDTpw3puP7j/nMUGX+kUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfK0VAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfK0VAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:00:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474E82158A;
        Wed, 27 Nov 2019 21:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888440;
        bh=mUCR23AAMHP7FiMfk5lBhT3X/eTAIhQFLugWPOV1dys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Ch633NNAyYgvijYkeEB+b1kNo5Xlmw8d/i/o0yxeXyYckEyVrut+6s+QCtBGH+JO
         SNhykguY+Wtv3AXdbqQMetV2TDYtWdUNKzI8LKsCs21pKgEuHAfmckCLU7LW89vRie
         4pbs/o5Z1c2MgzCaZQCEtfF1vEV+8vvdf9tp/Ws0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 134/306] selftests/ftrace: Fix to test kprobe $comm arg only if available
Date:   Wed, 27 Nov 2019 21:29:44 +0100
Message-Id: <20191127203124.854258005@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
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
index d026ff4e562f3..92ffb3bd33d82 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -78,8 +78,11 @@ test_badarg "\$stackp" "\$stack0+10" "\$stack1-10"
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



