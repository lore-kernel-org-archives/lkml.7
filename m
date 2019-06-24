Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F08BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727F02089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371077;
	bh=J9Hue6YfvcDTPTSK7iPUAfw6PKHk/04g+wdvgzhrqRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MoJM0PBRqoCz+CgdTjH1vTpwcfOGKTLPNEIqijczT+P9gH6uTzy7cykmzjt9VUILI
	 G+ohMTwjB7kQ1/piil7ixFOETRX5d/kl9kNi+f7R1PoyZRVMtLqP+suB80XN1oa6lY
	 NdxOKQdZHvO0CrIMLKqEKUoZR3PVs9rNvKulU2cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfFXKLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbfFXKLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:11:13 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE51205C9;
        Mon, 24 Jun 2019 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371072;
        bh=J9Hue6YfvcDTPTSK7iPUAfw6PKHk/04g+wdvgzhrqRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwJy7hxxetQWVhqWzy6/9flV7dEGcf6HZbppSrz1g+I8oCJjbYy6yCTOF+XAUDbD+
         ZKiAZzgnbKJrHWSp8W4UIwyVRh9wZEdU2Ed9M/iSDxdp61/q/wbdyuuooUs3Vh+byY
         81McBiFM/WK9iGU2FUQuuSOHORZoNgTv41r9/rkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Claudio Zumbo <claudioz@fb.com>,
        Claudio <claudiozumbo@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 059/121] kselftest/cgroup: fix incorrect test_core skip
Date:   Mon, 24 Jun 2019 17:56:31 +0800
Message-Id: <20190624092323.722052178@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f97f3f8839eb9de5843066d80819884f7722c8c5 ]

The test_core will skip the
test_cgcore_no_internal_process_constraint_on_threads test case if the
'cpu' controller missing in root's subtree_control. In fact we need to
set the 'cpu' in subtree_control, to make the testing meaningful.

./test_core
...
ok 4 # skip test_cgcore_no_internal_process_constraint_on_threads
...

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Claudio Zumbo <claudioz@fb.com>
Cc: Claudio <claudiozumbo@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cgroup/test_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index d78f1c5366d3..79053a4f4783 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -198,7 +198,7 @@ static int test_cgcore_no_internal_process_constraint_on_threads(const char *roo
 	char *parent = NULL, *child = NULL;
 
 	if (cg_read_strstr(root, "cgroup.controllers", "cpu") ||
-	    cg_read_strstr(root, "cgroup.subtree_control", "cpu")) {
+	    cg_write(root, "cgroup.subtree_control", "+cpu")) {
 		ret = KSFT_SKIP;
 		goto cleanup;
 	}
-- 
2.20.1



