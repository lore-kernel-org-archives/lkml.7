Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D898C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DB52073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a43LZDav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFNTmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:42:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44257 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfFNTmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:42:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so1400980plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iOo7ovvaSmJUe1owVhwhdiFkGRwgIV4cXbraxhrxLvs=;
        b=a43LZDav76Pb80xF7UQV0HQJoGsXYknT/1qYhUhtsCsOwM7QPyo6l2hml7sibRTCHf
         BRspBc6UPwynf6+ymZCg0iGOCnQZ9KvYL2snFre65WQQ2vsrUyvniUzsyFeD2BnRMmbJ
         Y5zTEw3DzYOnDYIPetwDny/Y/t8nJLYif1fi2YGdn5h8ub4YGdflFG2+xD4IA95L4sLh
         dGM96uB2Iah+a0I2mP2EhcEMIlcme7e851qq9UT++heZg+Ce7DlaJOPqBR10K7kP3l6r
         zk8A6o7TIM1Ys83Pfe74DK3Vf54dqWSZbE31dRp9ElMaJxz3MTl4LfxKle+ydIm+C1+Z
         SQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iOo7ovvaSmJUe1owVhwhdiFkGRwgIV4cXbraxhrxLvs=;
        b=brSkrsw12O0mKuaBvDa/iKLpuwfPB29X1czLhTbM/sVd7yIEf9Ax4K0tUQIpg3sEh+
         dUVKWH4feA8xZDXoTZNjspbD+0nIABf0Y8ygUdfTp/R7CRK2QXrgkoAnJofdkoC78CRq
         VbjtxQPUnhExBAnrrAmXH99cP4nnXh0eTXtI2XUH7sz/XvrZbE45wyu2GgeJtdEO9Xuo
         Beey8ZFRI2Ff7YHLA/pb0nA0ueaGG42Pf7bpQiTHMQdPRnNWXrOZS/zzthPd2ZiE8M3i
         XjwP9X8d3JUt5rUX5ynRwhdgUlDzD9eW5fgQH7SwOLY1cs9LHwYF2ktHMO+NzFFcf+64
         AA1g==
X-Gm-Message-State: APjAAAUhEu1hmlvQ1FyqAvsZjiEgzw2cE59ApHVLMYxREE4Cyj1vihHl
        YvK+24mXHSjjA8wD5tGLauGIcbC4eNk=
X-Google-Smtp-Source: APXvYqxMcUPKHuqr7vT0eG64kedh2H/zqPy8ECIXTE/ZICLTtW5A7MVGYkvapCcgbXDvYNBjh0mX/Q==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr58012891pld.16.1560541329341;
        Fri, 14 Jun 2019 12:42:09 -0700 (PDT)
Received: from ahmlpt0706 ([106.222.0.33])
        by smtp.gmail.com with ESMTPSA id c133sm3657278pfb.111.2019.06.14.12.42.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 12:42:08 -0700 (PDT)
Date:   Sat, 15 Jun 2019 01:11:56 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH] staging: android: fix style problem
Message-ID: <20190614194156.GA21401@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch reported "WARNING: line over 80 characters". This
patch fixes it by aligning function arguments.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/staging/android/ion/ion_chunk_heap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 3cdde9c1a717..6aceab2e77e4 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -107,7 +107,9 @@ static struct ion_heap_ops chunk_heap_ops = {
 	.unmap_kernel = ion_heap_unmap_kernel,
 };
 
-struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size)
+struct ion_heap *ion_chunk_heap_create(phys_addr_t base,
+				       size_t size,
+				       size_t chunk_size)
 {
 	struct ion_chunk_heap *chunk_heap;
 	int ret;
-- 
2.20.1

