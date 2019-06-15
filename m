Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14FEC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85B12184B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 18:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9DMJRao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfFOSqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 14:46:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38076 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfFOSqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 14:46:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so2399916plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Q9xlD/PMmlRpTb0ClhryMiAZbh/ulahVS83HmPg/ll0=;
        b=f9DMJRaoP422r3TGdX0uSeRtbGx1LPK+2y6lr/3+UjelE6sQdpsqigsJyqbLi2dp+0
         BQJfJ54nZQKUvbRQLAvhvCccIv059jlCKg3pm5iCxXTr0dIZ60a1qSxJFflbVKV+4VsA
         4Wd0k+O+l/qGeJQ7WFCwVNUZU9tgQ5YUdXRBHZhe7El3jgrJVpxEFswtor5s/DVuOAIC
         kIVkMzUXIR/J/6qS0pJm0Zt2IDvJT1lAQfPdXWpaNf2iHxxksf4n6rXC/COKjil4V4/n
         hcAgLNB7fhptlcaaDVbnU5ZBJsHYmOEXugajBmuKiH/wzDK0zpXrMCK+aHsJMIknJVbf
         l7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q9xlD/PMmlRpTb0ClhryMiAZbh/ulahVS83HmPg/ll0=;
        b=CkeQpp/jkrtjIOYgQoN++YgVDvUQKYhw1u0ncqQxRa1qquSsoFCA6OgHX1MwOTxAc3
         a3nMOaNNh9gPQd9ctks3lnP3rhKmpVjIMdp4yQsxuRAEq+x8WTPmOm8JN0cqJCVgdEui
         XYtwm0YcorLERDUMZbpaaL+70peVyNh4Er+jodOa1yeLXiLwZPNFxTWA5xqKbp9JYGJO
         dBHBNuw5FeHlymrurXRGLSFoROHJ4ltNsclWpvB1WuGG8Wpj9KX07ptLrI0nv6ziro94
         /QdgJHEEexQ1AoO3awiTyLuNF8pFMGF/11C5qK+aQJvbVjOzuZdHEeFBLmzN16siwQVU
         HH5g==
X-Gm-Message-State: APjAAAX9xFOyO2j7owqdVhbZvJNQLa6sP/6RFUVazXUqXieXEuC3jOIE
        2yuEXiTZuUf7IPJqpwNoBy2PJj05aiM=
X-Google-Smtp-Source: APXvYqwof/KsTSgkJK+UHE5W1/WJWDmcbF7iZNu03WZhoyF6SCt9d5fX/4h9xflcy6Ja/WDgMMjqXQ==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr100910157pla.172.1560624376144;
        Sat, 15 Jun 2019 11:46:16 -0700 (PDT)
Received: from ahmlpt0706 ([106.222.0.33])
        by smtp.gmail.com with ESMTPSA id e127sm6904708pfe.98.2019.06.15.11.46.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 11:46:15 -0700 (PDT)
Date:   Sun, 16 Jun 2019 00:16:05 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] staging: android: fix style problem
Message-ID: <20190615184605.GA7671@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch reported "WARNING: line over 80 characters".
This patch fixes it by aligning function arguments.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
Changes in v1:
* Updated as per review comment. Now function arguments
  uses two lines, one less line than previous submission.

 drivers/staging/android/ion/ion_chunk_heap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 3cdde9c1a717..1e869f4bad45 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -107,7 +107,8 @@ static struct ion_heap_ops chunk_heap_ops = {
 	.unmap_kernel = ion_heap_unmap_kernel,
 };
 
-struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size)
+struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size,
+				       size_t chunk_size)
 {
 	struct ion_chunk_heap *chunk_heap;
 	int ret;
-- 
2.20.1

