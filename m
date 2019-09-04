Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9CC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3020A206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620664;
	bh=zdgH72ya1dL2WshHd/bMi1BX7Kc3ulLxtT8YqhWU8rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uY7cLJRG20DwUxIjICnkNGCrvOqzy6/rTl8b0Rz/rFr37qceaiQcKE1eEN5zIrdsG
	 V5XXCKhgF9N2n0YbHCFVJ0f6/od88GNdTGFdSgCEbojIGYPNaP2ys4iCVLccoRrkuy
	 4D1mtuXsnt238fUMEWyjK9VtZYFUDCTBNiI0HtyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbfIDSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389449AbfIDSLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61BA32339E;
        Wed,  4 Sep 2019 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620659;
        bh=zdgH72ya1dL2WshHd/bMi1BX7Kc3ulLxtT8YqhWU8rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1d8YR/mj4M6Osk6X1jtYiui09zainnptukIfZobhB3ZX/xzRPClszAsDVHB6KoVk
         daQE9qlRjLLB20hKwfT7fCH/aRjai1EHQkobGHwq76Kq9fqKSV0s2JieyhU/kgOjjn
         S/kfIJ81V3zJtzc+NkzC0QdgXsT4jYK/+CcE7WVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 046/143] selftests/bpf: install files test_xdp_vlan.sh
Date:   Wed,  4 Sep 2019 19:53:09 +0200
Message-Id: <20190904175315.871092488@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3035bb72ee47d494c041465b4add9c6407c832ed ]

When ./test_xdp_vlan_mode_generic.sh runs it complains that it can't
find file test_xdp_vlan.sh.

 # selftests: bpf: test_xdp_vlan_mode_generic.sh
 # ./test_xdp_vlan_mode_generic.sh: line 9: ./test_xdp_vlan.sh: No such
 file or directory

Rework so that test_xdp_vlan.sh gets installed, added to the variable
TEST_PROGS_EXTENDED.

Fixes: d35661fcf95d ("selftests/bpf: add wrapper scripts for test_xdp_vlan.sh")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b9e88ccc289ba..adced69d026e5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -61,7 +61,8 @@ TEST_PROGS := test_kmod.sh \
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
 	tcp_client.py \
-	tcp_server.py
+	tcp_server.py \
+	test_xdp_vlan.sh
 
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_libbpf_open test_sock_addr test_skb_cgroup_id_user \
-- 
2.20.1



