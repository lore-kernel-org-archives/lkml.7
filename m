Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE23C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447B208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZL/I2MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfHLMom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:44:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40913 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfHLMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:44:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id e27so3002580ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CzrTbiHopzrJu+YLYHoIsujt53sT7XN4YE3jA26/XGg=;
        b=CZL/I2MFhnHG7WsGfil0Lhj0/vUbG22b1Ey4JJ+4mOZyN1TTt0k7l4o5BUszI4UGSt
         1n6tFYW9r96cIcKCqEuEC/X0AeIYX4H3btbse/XxA6HbmKV6iGxNC4/567RVUaDZR3nC
         HaBGbThoAuqSmKQ7S0HRYvg4C1CynhZlxF5TTej5/B6iJps7QKNTM4USoP9kAw899Z8y
         njUfwG3frFnuvYBLJG70NZ9gAM/sazFT3OtdhJd6YwKSg4tw6mibwBU/2nf6qJlB+PYs
         nEdfm2RkSbLQDJX7Q+RXVjY0XgH2jzOz2zIp+b1IMwxFfO6/cYmvcAAZd1PeK0vVqpsO
         voQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CzrTbiHopzrJu+YLYHoIsujt53sT7XN4YE3jA26/XGg=;
        b=D+0gQJMlHRUijCVotO4387HTxactd660g8m/p3UugMTpDpScgDb00Y0phWwBSUsdT6
         sGGIU9x/XOz/sY69147nRJiGRqer7c4DPfuXfkPypjp1vjOHRk/GqchQyYeXkKDSVu8D
         LyR2/dmUNC/nB3NZYGn1OWMMFQi/mCeldUJeZpJFsM2LX0kKemccNTXFy+5fHbMJzW2q
         CQbdcGTlEbCwmoTDe2feYTCSplWC4QDnT+HaoPDgxLfNSzfQwzuJm+6JgwoLgNhSVid+
         Q39QBF+5PgeDXcNJLGWo9KNU2PEueoEgskTY/xlxPBvJVN7KaMxTS2xPi2DY8GOPAUUD
         iGbA==
X-Gm-Message-State: APjAAAVYtsQWA7PPhVcSPw6ChbTTz0k/NOcOcH5STkFiZA/wMftdisV7
        gGOQ8k+kG0Oz8YRiRVY4qvQZBA==
X-Google-Smtp-Source: APXvYqwamKoAxWVn0ZtiV6XAfXemkV1C3L3E5zzwIiIeJc4CgQilmql9PxxJQosy2E9Ep5TEcoG4/g==
X-Received: by 2002:a2e:1459:: with SMTP id 25mr18650455lju.153.1565613878719;
        Mon, 12 Aug 2019 05:44:38 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id y25sm23432747lja.45.2019.08.12.05.44.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:44:38 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     bjorn.topel@intel.com, linux-mm@kvack.org
Cc:     xdp-newbies@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, ast@kernel.org,
        magnus.karlsson@intel.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 bpf-next] mm: mmap: increase sockets maximum memory size pgoff for 32bits
Date:   Mon, 12 Aug 2019 15:43:26 +0300
Message-Id: <20190812124326.32146-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812113429.2488-1-ivan.khoronzhuk@linaro.org>
References: <20190812113429.2488-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AF_XDP sockets umem mapping interface uses XDP_UMEM_PGOFF_FILL_RING
and XDP_UMEM_PGOFF_COMPLETION_RING offsets. The offsets seems like are
established already and are part of configuration interface.

But for 32-bit systems, while AF_XDP socket configuration, the values
are to large to pass maximum allowed file size verification.
The offsets can be tuned ofc, but instead of changing existent
interface - extend max allowed file size for sockets.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on bpf-next/master

v2..v1:
	removed not necessarily #ifdev as ULL and UL for 64 has same size

 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..578f52812361 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1358,6 +1358,9 @@ static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
 	if (S_ISBLK(inode->i_mode))
 		return MAX_LFS_FILESIZE;
 
+	if (S_ISSOCK(inode->i_mode))
+		return MAX_LFS_FILESIZE;
+
 	/* Special "we do even unsigned file positions" case */
 	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
 		return 0;
-- 
2.17.1

