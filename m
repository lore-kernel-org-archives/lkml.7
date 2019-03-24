Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91090C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57786222BA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H76s6gSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfCXJsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:48:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39460 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 05:48:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so4367554pfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5S9ANngVr50RxuF+gMWGmWQT0JEK9TSqZIIW9WSZn4Y=;
        b=H76s6gSwe0/Nu3xtkxU0r34YW2nUJunaGQFXgAiFe0L9Tuo0K9hEOY+ySmuOb0SgZk
         n616bx5Cl+MP49Z5uGFj3LWbibYYgtMe0Rr/kAUhlCyi0NWsQZtL0rRQZmUu1eIfdIbA
         TlMZCIEdiIr+nJ52AzsMgioZDwB0T2aYVsZQylg+Px/vvUE/TByNq3H3aMCUSMT/WU3/
         fuSaqzmFfMQzswcB/aL82qZ8hFgj/LyWDSPdPtP7DOXAJMJ6ef9pRsbqU0AU19sIdU5s
         1aUmfC0JZeWEvPwolYOiEynwKui2WERTKu8KqTqS/qUjmPPk6YrYPMQzYEdKgs24k9Wz
         L87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5S9ANngVr50RxuF+gMWGmWQT0JEK9TSqZIIW9WSZn4Y=;
        b=YiKanqcpPxB6XVciLlUKD/I0eTMJ6qD81YrkzZblH4aO7pJ5jZwluI4KeRXCGvP120
         KBrx/9xDNkKo46qP3xAdDmSFJ4ZgRPnbB6Y0ZtGV1hJDeHXnvyICL7XZdW2FGsjKgXSM
         bPHWG7ntBzk4dcN2PjAYBOq3/5S0wbKn0moSn7z9dKoWGth0s98HOi2A3HAdStHGevln
         bUPyuVNGxTQaPLb8RRglzoEi/qT6w5Wwweap5Iw0AJdp1qd5w8QVeflSbV7a7v4mwAsC
         IuFWIUhtiK2zsxe/jir/oQT/YqYfVQ1bOW1Su1d3aFlNklL32MYdHlnJ3DgkK29L7QkA
         M/Uw==
X-Gm-Message-State: APjAAAWQ3P4kIfPztsgXZzUOsALdi12j/glUlmTcy3x+IuoQZVh1C+se
        mEWc3J36NgFOeHDAv+A+1aI=
X-Google-Smtp-Source: APXvYqznEmWeGtHKKZi9exIae6d/uU3b/pL9195sgLrR4oNHXO1q/4Pr3ulAomMFyktPMvq0hcFakw==
X-Received: by 2002:a63:c511:: with SMTP id f17mr17620943pgd.202.1553420888434;
        Sun, 24 Mar 2019 02:48:08 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.35])
        by smtp.gmail.com with ESMTPSA id k83sm41781243pfj.178.2019.03.24.02.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 02:48:07 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:18:03 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, daniela.mormocea@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: ralink-gdma: Change unsigned to unsigned int
Message-ID: <20190324094802.GA16189@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the checkpatch.pl warning: "Prefer unsigned to unsigned int"

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v1
	- Based this patch of the staging branch and not linus's branch
	  unlike the last patch.
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 04c551a..680ce02 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -164,7 +164,7 @@ static inline uint32_t gdma_dma_read(struct gdma_dma_dev *dma_dev,
 }
 
 static inline void gdma_dma_write(struct gdma_dma_dev *dma_dev,
-				  unsigned reg, uint32_t val)
+				  unsigned int reg, uint32_t val)
 {
 	writel(val, dma_dev->base + reg);
 }
-- 
2.7.4

