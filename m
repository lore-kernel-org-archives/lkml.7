Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C03C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDBD21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9V3FeUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZP7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:59:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42061 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfFZP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:59:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id x144so1928425lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w3F+tqbuCaIkVEmb3xZOgqKho6J48v4zfZ9zqPryVN8=;
        b=g9V3FeUtFTWjdbosHMyZt4xm7w+kP7xwYdEacmzFkudE1y+O7N4jJ0o1485yPZ2KkV
         nE+9UENFAt22ikKN4VKWQsipR+VEnTM7ixoyzwPP0V6SnB1WMndNPVu0YtEYpWTyiSxW
         aDDIJ+QdEVHzhEbSwqWwItJ1ePptdzA73s771bAn8LtrY1GVRVbI5jK7isj2UJjeM01x
         pZXuRDiQpNPRezH1rd5nGe2EDGLrPqomN9gmggQCsn6kydp+UC530gotK5JtrcUOZPTv
         Z5narCZ1IsA10kj13uHoOyheyRkC638s8UVM6Nwguobhli26k3OUWn5HLVpXt/iyT/5c
         YJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w3F+tqbuCaIkVEmb3xZOgqKho6J48v4zfZ9zqPryVN8=;
        b=i6JylFgu8gAO8+G63HKYqbPCJyQFDe2dglhFMdbRHH5Igr6s41cd3aMcqdp6FLPCyD
         nl3+cxwrRPDaxZOyRQDkDJQ47bKgBYToUnA/1m3lTzPLQvYAz8sLemPcvBp/4hZ0MLWH
         EM2pYDDIWGkvSp9DIa5HX4I8eW85GmpxqEWYy7Rc4f1ytPi3h/vjmFwIKBrGl7I/YRO7
         HQkGdDlYB/ne+QGvQ3fSz9iN8yNpKBDNfy30pOUI008S+mKEBUr3xuCJxAH9/aBPyvWl
         k654OdV/Z+EwsqB6sxGYQbO7lUb1wKn1IYclrKr0OBiOEI20vpSb34KUcpw7yhq59jWt
         pEwQ==
X-Gm-Message-State: APjAAAWd9tbBJNKFTr1wRMTHv1bZcqVLqLGH1Z+DnsbQJ4zxG3zRIXs2
        skKVup0v6oLX4TMrxAKfqs92dg==
X-Google-Smtp-Source: APXvYqwxPGGkHGeCrj0vxlOHZFHSZuMOUZLSiXgf7NgyB/aIkSZ03HweWLPeu8yjUokOOKyyRr1TDw==
X-Received: by 2002:a19:4f50:: with SMTP id a16mr3070485lfk.24.1561564755631;
        Wed, 26 Jun 2019 08:59:15 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id p27sm2504052lfo.16.2019.06.26.08.59.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:59:15 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        davem@davemloft.net
Cc:     ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next] xdp: xdp_umem: fix umem pages mapping for 32bits systems
Date:   Wed, 26 Jun 2019 18:59:11 +0300
Message-Id: <20190626155911.13574-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmap instead of page_address as it's not always in low memory.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/xdp/xdp_umem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 9c6de4f114f8..d3c1411420fd 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -169,6 +169,14 @@ static void xdp_umem_clear_dev(struct xdp_umem *umem)
 	}
 }
 
+static void xdp_umem_unmap_pages(struct xdp_umem *umem)
+{
+	unsigned int i;
+
+	for (i = 0; i < umem->npgs; i++)
+		kunmap(umem->pgs[i]);
+}
+
 static void xdp_umem_unpin_pages(struct xdp_umem *umem)
 {
 	unsigned int i;
@@ -210,6 +218,7 @@ static void xdp_umem_release(struct xdp_umem *umem)
 
 	xsk_reuseq_destroy(umem);
 
+	xdp_umem_unmap_pages(umem);
 	xdp_umem_unpin_pages(umem);
 
 	kfree(umem->pages);
@@ -372,7 +381,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	}
 
 	for (i = 0; i < umem->npgs; i++)
-		umem->pages[i].addr = page_address(umem->pgs[i]);
+		umem->pages[i].addr = kmap(umem->pgs[i]);
 
 	return 0;
 
-- 
2.17.1

