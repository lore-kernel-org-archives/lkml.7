Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E85C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D196F2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lnNs6bUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLSR5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:57:40 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:60872 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfLSR5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:57:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47f02q43Htz9vZvG
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VAgMhdx7sdm6 for <linux-kernel@vger.kernel.org>;
        Thu, 19 Dec 2019 11:57:39 -0600 (CST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47f02q2pgPz9vYxx
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 11:57:39 -0600 (CST)
Received: by mail-yb1-f199.google.com with SMTP id e11so4605925ybn.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwhEB9Dx/uNy1TVdO49rVoEq5ZejBIq7czTQQQLig8s=;
        b=lnNs6bUqQMHO46MODGi8ofRYuxKCRllWB9uUhsAii4PrWq7hDLXNvFVWddmE7b5fZM
         QMSDklstNrnK4/yQx7TvERwZxyaKKokRInOc60mcqaM6KxftlMUgQOStiTvK03hcteEr
         kMA9IcFyvBV8DBKy2/Iw+lB39gS9HQvsHzQzepVnt3bzSVzYK3/rG9PGm9oCXfubn3vR
         RZ8p+YaQ2Yf9GwgwCQ2kiD15kgrndZlyV5ReOSVUMHv7Ko/qC+4Mu/sKy+7lbzVhNiDS
         Hp/87ZOQXytfDuM7UKINhjo3pgrg2IsQ0Iptl5Z6P+wQ/IHi25NMJukl8m0Ov9zxJvu+
         NfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JwhEB9Dx/uNy1TVdO49rVoEq5ZejBIq7czTQQQLig8s=;
        b=qfY8KYIZZmUFq5PkBKyrC1dO/ZrSA2xDfIypG0XLBnjvi/qHee2sBaPg5QhANFdpN8
         kVKxus2lsk1mt4v4gJjXT2uRLqlNBwL7+rmcwd/6Y+wZRH4JcVm3KObKyl+UItnzQyVd
         XKjjIjgy7sh10s+iYIDUM7ESs4avEXiDuT+K0n/SoUnlPtW1BFPCAodOITsEw1ho3sXQ
         KfyNL0aa6Mgd39bm2y+Rzm2Aw2N0u68rez2uGPOAatX9Ovt/BIS/1tn8JUmy3jzJn5Aq
         7rDgZQ3e8mmievzywTZJ+NunkPdqDg3oo1QZMky8ZDzi2XTIJAce0K6OsMmUQGpXJ8UR
         X7Hw==
X-Gm-Message-State: APjAAAXhpb6T8DcKhaxXK00ydw2yA6mN0QTd+Wb8M9FO48TxUpbMrjUa
        CPr5Oo0puLkrrVeBdKW9NICEu9QYz59DPJ9N9Dv1og+o2cJ+r8hYThaWiVHDlWulWJvCnMeH8ZR
        DDiQ1yTdRYyMrTIaecMbTXOv0nIYf
X-Received: by 2002:a25:b90b:: with SMTP id x11mr6879863ybj.209.1576778258883;
        Thu, 19 Dec 2019 09:57:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWDaNWBG5H41EBU0zpbzx1n8BLa+vrYWT6O5GRRJeRzqsTKXTrWzE1ZCgYvEuQfNM14QrUaQ==
X-Received: by 2002:a25:b90b:: with SMTP id x11mr6879838ybj.209.1576778258545;
        Thu, 19 Dec 2019 09:57:38 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l39sm2831320ywk.36.2019.12.19.09.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:57:38 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] bpf: Remove unnecessary assertion on fp_old
Date:   Thu, 19 Dec 2019 11:57:35 -0600
Message-Id: <20191219175735.19231-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two callers of bpf_prog_realloc - bpf_patch_insn_single and
bpf_migrate_filter dereference the struct fp_old, before passing
it to the function. Thus assertion to check fp_old is unnecessary
and can be removed.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Remove the check on fp_old altogether, as suggested by
Daniel Borkmann and Alexei Starovoitov.
---
 kernel/bpf/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 49e32acad7d8..ca010b783687 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -222,8 +222,6 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 	u32 pages, delta;
 	int ret;
 
-	BUG_ON(fp_old == NULL);
-
 	size = round_up(size, PAGE_SIZE);
 	pages = size / PAGE_SIZE;
 	if (pages <= fp_old->pages)
-- 
2.20.1

