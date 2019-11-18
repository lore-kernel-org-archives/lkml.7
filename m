Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611DDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372392084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iW0UQYAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKRLY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36672 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfKRLYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id f7so13206447edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmzEwbR7z9MB2kX6E+hxPBjMMxkrgbCI0SqbDjInDjs=;
        b=iW0UQYAzkmH8Ll/M9PRrq939jlpUbSW0NRlVO9QY+D4clTNrJOZfMDBDFUbjyL4Cs7
         AafHw+ZYUyVMiRkn9UVwi3pQGytY4uNU4TxcdyErLNYAINbJRSnVaWhXPyXoBkVDZ0AE
         l3Fg7abGNnEPO4rdJFSDHZaKL7SSwwOkiiOlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmzEwbR7z9MB2kX6E+hxPBjMMxkrgbCI0SqbDjInDjs=;
        b=WftQ6Uf+oQob4RNRJUIO/pO+1mnnI7uGKIrcqvTntXmoBZ817VJYBHZP5SwoZ1mr0D
         rq6En8+//qjtGsggDlW/TIUbOTFVPBhd7o4kdT6TE9WRpEp/GQPccoRslj/HBo6gFCj7
         qkTBDxFr4pbBl2H8dG+EkBjizopkKSIqjbovq5F6gd5kPt7iqEMGxNtcTlG2vI7/GRyN
         eC3DDqwq5Y8+/fW6fd5UND/58prWwFrSIfuWrtdSAp7xwJnIGa7L+YJC2jAUfpVjUnQs
         bnl4+q6AEdVnhR4LV9cJSJX8UPPgi4TH3wJud6HNMbqptD+ga3iSTQJ9tSWM6gX3LSrX
         JWvA==
X-Gm-Message-State: APjAAAWG3x/Q6kyKNoBpM7kjToPf0z2t6ES8W6enB2XmrTAIHhmOgJwZ
        EMX4NEj1VFUYuBmA9Rh2DtI5p6QEp5vmnA==
X-Google-Smtp-Source: APXvYqx95kajCqCxz/PSbS8ItEnY/XM8/CDgL5w+eRk/tL2D6xJCZl9iTwQDhJviE4PdC/OwznLwrA==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr29937876wrv.247.1574076260319;
        Mon, 18 Nov 2019 03:24:20 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:19 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 37/48] soc: fsl: qe: make cpm_muram_free() ignore a negative offset
Date:   Mon, 18 Nov 2019 12:23:13 +0100
Message-Id: <20191118112324.22725-38-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows one to simplify callers since they can store a negative
value as a sentinel to indicate "this was never allocated" (or store
the -ENOMEM from an allocation failure) and then call cpm_muram_free()
unconditionally.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 962835488f66..48c77bb92846 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -176,6 +176,9 @@ void cpm_muram_free(s32 offset)
 	int size;
 	struct muram_block *tmp;
 
+	if (offset < 0)
+		return;
+
 	size = 0;
 	spin_lock_irqsave(&cpm_muram_lock, flags);
 	list_for_each_entry(tmp, &muram_block_list, head) {
-- 
2.23.0

