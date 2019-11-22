Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE7EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F520706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420387;
	bh=Ic/ThZASihVe9m0Cw4VZvzcaHxILVDuvsrUKP9b9wYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w7TdYloopnBdv+5CKvY7BlXMDsjAOKbJziMY2f9BkpywxXjsrndOhyOiJ1Vf7m+oF
	 QbZDhE297X+EQErLgDkPkPl9OsNA0g3XsusQref9z0vay99Fp/BVYAhTtF5DozMacb
	 Pyrv3cMW47i7OHTBe8HZ6TInpsTf5gCwASYQVWRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfKVK7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbfKVK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:59:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF512073F;
        Fri, 22 Nov 2019 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420383;
        bh=Ic/ThZASihVe9m0Cw4VZvzcaHxILVDuvsrUKP9b9wYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vhz9Kk7z2ZGUrZRUErk7yA45VDALfURyazIJ6c9Ze67sfT+ndAFP5H+wVKi6QubJ
         Z5OlOTNeBlv5qQuakez455TdaQFApvhCIFXpDxMVRBKWMPFSdqDr4zpCsKLb+IIR+v
         Q2TFizi1xkM217i5oQvcj+K8pYPwtkmA+Ur/YzV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/220] IB/mlx4: Avoid implicit enumerated type conversion
Date:   Fri, 22 Nov 2019 11:27:34 +0100
Message-Id: <20191122100919.031788785@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit b56511c15713ba6c7572e77a41f7ddba9c1053ec ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
type 'enum ib_qp_create_flags' [-Wenum-conversion]
                qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
                                                    ~ ^~~~~~~~~~~~~~~~~~~~~~~

drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
type 'enum ib_qp_create_flags' [-Wenum-conversion]
                qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
                                                    ~ ^~~~~~~~~~~~~~~~~

The type mlx4_ib_qp_flags explicitly provides supplemental values to the
type ib_qp_create_flags. Make that clear to Clang by changing the
create_flags type to u32.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index f3d475024d376..54e4d1fd21f8f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1147,7 +1147,7 @@ struct ib_qp_init_attr {
 	struct ib_qp_cap	cap;
 	enum ib_sig_type	sq_sig_type;
 	enum ib_qp_type		qp_type;
-	enum ib_qp_create_flags	create_flags;
+	u32			create_flags;
 
 	/*
 	 * Only needed for special QP types, or when using the RW API.
-- 
2.20.1



