Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B7C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180B12063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHSHLFL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfHOU4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:56:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35150 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbfHOU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:56:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so3425683lje.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=205QOW+yfCAbUC7sqLeSze+Vg1m2Bj7bh4Zpv9ddbPA=;
        b=aHSHLFL2ibBV/js7b7q+6nct87exfpVR8oXwxPxV1O3q6wd5IOfaorpO5msfvRyevT
         nYKoDnt9kqYmiQu9PjsrPREPSVxpT9OzKTUoF3JQdooYysuqXafyRNzG7iDVEFoE0IeS
         3ZoOHiiqJprJgUr8Tfrc/9AbsMPLPS0kBBA/XGerv/Vt/XOsD71F+/3fM9gEBNUCWZAk
         65kZb29OLfGg5zb6VfW7gyr4F/F42sB/LPn1fUg0usLHPPnJzxH+vgNnMrCd32OsCh0f
         AsVZGyYS1Hp9/Ychz/oDWhBSoli78rvDYq7YI7yYJHv7gCl/+GTOkq96i3FHnuHbFrLk
         kNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=205QOW+yfCAbUC7sqLeSze+Vg1m2Bj7bh4Zpv9ddbPA=;
        b=YVPGAuqtHCY/1+HiwVM1FD66FXFHE5Y0bGEmuJKap0at1o4Ckpm4D+JLBwOY1P92EH
         y2JeCx+ejotSvPAKnU4cUFbPE9OiybVGJnDAy5ePKYJcEX+rL/iA6cO70r5eRr430t0j
         zkQeisXkpABycY80e9pUs442kQ5qQeG2Eig4hZlp9lGHRTPwkYlk9gJl4n96xy6jCg/B
         43k3IYfuY3cK2v/qHH1tVu6nfPgiSQU6lefwVSIGAi+XW+tJqmDvHrRkhuWR3Bm5f/jH
         VrZpMPI1g+x8wsbUxK9zmC3TmlpHUle2tqk1sNYiZ7sYRvbxrWtQjoRQu4JpxLEZJRlr
         0z+A==
X-Gm-Message-State: APjAAAWgpocv5NBtILDovb1RIokqT2qokI2Ga7rA1DWw8J+P50AjbCT4
        JIaD6gv7ars4Jvk1+f83Rb2wL3WGkgo=
X-Google-Smtp-Source: APXvYqyuY8R61y7WvPEvbnEg7y6ACV3N9GK5MW1RpPiIpvbgr2NsI7s4+uvjBaACZ8Tx4DVi1QBdDA==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr3721390lji.174.1565902600461;
        Thu, 15 Aug 2019 13:56:40 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id j14sm651676ljc.67.2019.08.15.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 13:56:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     bjorn.topel@intel.com
Cc:     magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf 1/1] xdp: unpin xdp umem pages in error path
Date:   Thu, 15 Aug 2019 23:56:35 +0300
Message-Id: <20190815205635.6536-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix mem leak caused by missed unpin routine for umem pages.
Fixes: 8aef7340ae9695 ("commit xsk: introduce xdp_umem_page")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on bpf/master

 net/xdp/xdp_umem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 83de74ca729a..688aac7a6943 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -365,7 +365,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->pages = kcalloc(umem->npgs, sizeof(*umem->pages), GFP_KERNEL);
 	if (!umem->pages) {
 		err = -ENOMEM;
-		goto out_account;
+		goto out_pin;
 	}
 
 	for (i = 0; i < umem->npgs; i++)
@@ -373,6 +373,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 
 	return 0;
 
+out_pin:
+	xdp_umem_unpin_pages(umem);
 out_account:
 	xdp_umem_unaccount_pages(umem);
 	return err;
-- 
2.17.1

