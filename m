Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05067C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C526120693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947512;
	bh=DDRBfrNOnnNyPPEaw7z11TCRBuBCJY42KwC9RympBBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yURVwCr917uyvtBFns6mB7LxYNwjsfcRrLu1c7xX+fOCadonhm6b3PA+3m2/IXuPY
	 p75iA2Hv2o3+L9vSJPj04a9VgwwyreQ1QmsKtn2CGkqV41gNMoqKQ31mutc2i305ne
	 RVewJgKotAyCb7T/e2vycbyc9NKiY9Qi7tS084DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfIHM6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfIHMrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:47:06 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1611218AF;
        Sun,  8 Sep 2019 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946826;
        bh=DDRBfrNOnnNyPPEaw7z11TCRBuBCJY42KwC9RympBBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9smrZ7DlNUm2bPDAqtrBDenVJmd0gR3tHL3OstFPcO+4iCO9mU/ns7O9PopOnhRB
         Ihn1nHy2yS9oUTcxp2wbaox/B2NGT9kjWSI6YhoAlwwB2zDT/pFxRcBg15Yay6/hSZ
         0xE2DM59xzQxHMdf5HwAVQap19iKvzuops132aXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/57] tools: bpftool: fix error message (prog -> object)
Date:   Sun,  8 Sep 2019 13:41:39 +0100
Message-Id: <20190908121131.936905876@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b3e78adcbf991a4e8b2ebb23c9889e968ec76c5f ]

Change an error message to work for any object being
pinned not just programs.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index fcaf00621102f..be7aebff0c1e5 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -238,7 +238,7 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
 
 	fd = get_fd_by_id(id);
 	if (fd < 0) {
-		p_err("can't get prog by id (%u): %s", id, strerror(errno));
+		p_err("can't open object by id (%u): %s", id, strerror(errno));
 		return -1;
 	}
 
-- 
2.20.1



