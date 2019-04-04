Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4905C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B315B214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369057;
	bh=H3zYd6LHv8vPWev23ZRMQ85KTBmETVrvz+AKsxpdCEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1pmaTWO/xgYL+iBnwROfCwkAlVs4MTztRBqzu4VM7DBL+BOkQ9jM/gHRCL8C+Hwvs
	 bvbi60Zj7WP8dzIQA80I8RMNHU04536OtVlT9Es5/y2BVZlPbKwGFeN83Jwlg4yj2l
	 BsovVoMt60t/hEsK7c6/qycPJYe1aqa3TO+Eph0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbfDDJKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732400AbfDDJKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6307820693;
        Thu,  4 Apr 2019 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369052;
        bh=H3zYd6LHv8vPWev23ZRMQ85KTBmETVrvz+AKsxpdCEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTsCyCQVySGneS87In+BT8+vITsu4Ugl0CuPpQlyp1jEicW1cOMewggPFbgG98orC
         H5yx8b5pEMkRlp8taOwgNLQ3xq8f6rdUii3H/WzMQOANXxW5wo8iEk8yFbEWKccSWZ
         26Yla6icubltucnY1RsTJLyB6YdyrqTaZQDfbImE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 065/246] tools/bpf: selftests: add map lookup to test_map_in_map bpf prog
Date:   Thu,  4 Apr 2019 10:46:05 +0200
Message-Id: <20190404084621.431369805@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9eca5083757b679b37f210092c871916c2c222d0 ]

The bpf_map_lookup_elem is added in the bpf program.
Without previous patch, the test change will trigger the
following error:
  $ ./test_maps
  ...
  ; value_p = bpf_map_lookup_elem(map, &key);
  20: (bf) r1 = r7
  21: (bf) r2 = r8
  22: (85) call bpf_map_lookup_elem#1
  ; if (!value_p || *value_p != 123)
  23: (15) if r0 == 0x0 goto pc+16
   R0=map_value(id=2,off=0,ks=4,vs=4,imm=0) R6=inv1 R7=map_ptr(id=0,off=0,ks=4,vs=4,imm=0)
   R8=fp-8,call_-1 R10=fp0,call_-1 fp-8=mmmmmmmm
  ; if (!value_p || *value_p != 123)
  24: (61) r1 = *(u32 *)(r0 +0)
   R0=map_value(id=2,off=0,ks=4,vs=4,imm=0) R6=inv1 R7=map_ptr(id=0,off=0,ks=4,vs=4,imm=0)
   R8=fp-8,call_-1 R10=fp0,call_-1 fp-8=mmmmmmmm
  bpf_spin_lock cannot be accessed directly by load/store

With the kernel fix in the previous commit, the error goes away.

Signed-off-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_map_in_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_map_in_map.c b/tools/testing/selftests/bpf/test_map_in_map.c
index ce923e67e08e..2985f262846e 100644
--- a/tools/testing/selftests/bpf/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/test_map_in_map.c
@@ -27,6 +27,7 @@ SEC("xdp_mimtest")
 int xdp_mimtest0(struct xdp_md *ctx)
 {
 	int value = 123;
+	int *value_p;
 	int key = 0;
 	void *map;
 
@@ -35,6 +36,9 @@ int xdp_mimtest0(struct xdp_md *ctx)
 		return XDP_DROP;
 
 	bpf_map_update_elem(map, &key, &value, 0);
+	value_p = bpf_map_lookup_elem(map, &key);
+	if (!value_p || *value_p != 123)
+		return XDP_DROP;
 
 	map = bpf_map_lookup_elem(&mim_hash, &key);
 	if (!map)
-- 
2.19.1



