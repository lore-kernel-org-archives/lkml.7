Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C10C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9772238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996885;
	bh=1Nh50vKEexZMWd+KixQL71kdPX+j490QmeNW7ODNh1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=acRDy4PhXPdtBc0xeXohzENiwGBWf3OLrNpMgibxTI5pPxvtXV782eF0IaUYXOEyw
	 lNjoM6h+HX04tz2ulILKmdfN9QoA+maLqg8sU/PJA1cb3hSQVWbfcHcHm2E1xBEyDy
	 1ZhG3BCT+cILJeAjM4WXVv/F/rTU2lZ2UMDAkOOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbfGXTeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389095AbfGXTem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:34:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9F720659;
        Wed, 24 Jul 2019 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996881;
        bh=1Nh50vKEexZMWd+KixQL71kdPX+j490QmeNW7ODNh1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHL0ZTmMvbx+Z3/v7xNDFeiEPzBAk8bOeFHmAADFxxAzMUOKRctkP2gFfJhU5GP6f
         aA/gXeRlqOVaI6Ed63A8CkikGGhNKVgQ7Ignv9qlM4Y9YAU6Qx1axoggrT/4ROujCr
         /VFZuGpclCY0nMm7lyQeaqCHN/f+dQnUKpZ3Ny7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 247/413] libbpf: fix another GCC8 warning for strncpy
Date:   Wed, 24 Jul 2019 21:18:58 +0200
Message-Id: <20190724191753.239368712@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 763ff0e7d9c72e7094b31e7fb84a859be9325635 ]

Similar issue was fixed in cdfc7f888c2a ("libbpf: fix GCC8 warning for
strncpy") already. This one was missed. Fixing now.

Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 8a7a05bc657d..ca272c5b67f4 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -562,7 +562,8 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		err = -errno;
 		goto out_socket;
 	}
-	strncpy(xsk->ifname, ifname, IFNAMSIZ);
+	strncpy(xsk->ifname, ifname, IFNAMSIZ - 1);
+	xsk->ifname[IFNAMSIZ - 1] = '\0';
 
 	err = xsk_set_xdp_socket_config(&xsk->config, usr_config);
 	if (err)
-- 
2.20.1



