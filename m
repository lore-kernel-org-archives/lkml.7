Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE64FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABB523402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612709;
	bh=zPGuwjDYDiMDQS1Q5oFy7DwqvLOrtR8i3MQgAW0T9QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RAYZjPv4t+HdIB5qgX3mFf70XkrI520ntyMwsA2ZRdpzKKiLhgR4DCl0Ltj96yct9
	 vzW58q91ELCgOQ5RkOc1IZjJ6FBWi4tWErxFc3Lw6q8l75xRdWGlTEPE4+a5rPbpLx
	 8N1xQIg4M8IQ6DjLn/bx79cvcP3vFxbbx1KBB+DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfIDP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731971AbfIDP60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:58:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7677A23784;
        Wed,  4 Sep 2019 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612705;
        bh=zPGuwjDYDiMDQS1Q5oFy7DwqvLOrtR8i3MQgAW0T9QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKNNxd3ogGDSav2oWFgFyq0S6rfib36Ia4ByObVHaj/xRiUy22D5DLfzIgRoV3UBy
         /PzfXiY+jgyEE4Iu8Vx803+QgZYRdPp8P41/k/c+ej84CPhw4QVmJLSJsbfgS0Wjj4
         WUF6g36Etpa/nVgNHlCLV/GF5t10H2zJI90cDEHo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 32/94] selftests/bpf: add config fragment BPF_JIT
Date:   Wed,  4 Sep 2019 11:56:37 -0400
Message-Id: <20190904155739.2816-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 0604409df9e04cdec7b08d471c8c1c0c10b5554d ]

When running test_kmod.sh the following shows up

 # sysctl cannot stat /proc/sys/net/core/bpf_jit_enable No such file or directory
 cannot: stat_/proc/sys/net/core/bpf_jit_enable #
 # sysctl cannot stat /proc/sys/net/core/bpf_jit_harden No such file or directory
 cannot: stat_/proc/sys/net/core/bpf_jit_harden #

Rework to enable CONFIG_BPF_JIT to solve "No such file or directory"

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index f7a0744db31e1..5dc109f4c0970 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -34,3 +34,4 @@ CONFIG_NET_MPLS_GSO=m
 CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_IPV6_SIT=m
+CONFIG_BPF_JIT=y
-- 
2.20.1

