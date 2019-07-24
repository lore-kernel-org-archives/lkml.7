Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85597214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997951;
	bh=XmCRhcluBrgdEiU7UeiEbvGV8BMAeUoxjrvsNuNatGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=abwoqjRhAonDa4IGUBY4T2DL4N+Mkiusd22vJQn/ZFbeGxBdfM5mUIZESQpJfiT4L
	 IgzyZoIGdQBU6XQTDlSUFfRTJ9NvGHzd1dpZX2cBLUyelq3wLLC17q3dIE/ELGl+B0
	 vqagx7tkd29xcygnPKmovuFv35iOkkwqfEXZZgpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404135AbfGXTwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391725AbfGXTw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:52:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4AC720665;
        Wed, 24 Jul 2019 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997946;
        bh=XmCRhcluBrgdEiU7UeiEbvGV8BMAeUoxjrvsNuNatGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOLbEmnCmIBjTdOiUYZ7fWAwamCMyLjq9IioOUWxL1YYt69cjS7aPzcB10JpQrPHA
         19gm71y/I+KE12XESWXXRXZGhTSbzxdTDCMCRRvuc4BbD84sv2Dw3u5CZvMgGC5Ndq
         iF4Dq/phKGkb80EVjT6AmG3Wsugj5iqMe/Fi0SbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 196/371] libbpf: fix GCC8 warning for strncpy
Date:   Wed, 24 Jul 2019 21:19:08 +0200
Message-Id: <20190724191739.560671136@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cdfc7f888c2a355b01308e97c6df108f1c2b64e8 ]

GCC8 started emitting warning about using strncpy with number of bytes
exactly equal destination size, which is generally unsafe, as can lead
to non-zero terminated string being copied. Use IFNAMSIZ - 1 as number
of bytes to ensure name is always zero-terminated.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index af5f310ecca1..1fe0e1eec738 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -336,7 +336,8 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
 
 	channels.cmd = ETHTOOL_GCHANNELS;
 	ifr.ifr_data = (void *)&channels;
-	strncpy(ifr.ifr_name, xsk->ifname, IFNAMSIZ);
+	strncpy(ifr.ifr_name, xsk->ifname, IFNAMSIZ - 1);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
 	err = ioctl(fd, SIOCETHTOOL, &ifr);
 	if (err && errno != EOPNOTSUPP) {
 		ret = -errno;
-- 
2.20.1



