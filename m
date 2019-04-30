Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC4C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B3120652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMo4Nruz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfD3O6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:58:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44265 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfD3O6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:58:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id l2so4083089plt.11;
        Tue, 30 Apr 2019 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TlQh7TuHnwgDKn+cKJqDNJnLA4TH+HrHgME+WMuJCQ8=;
        b=iMo4NruzSXdZLDvRy1SULFuYbkHUqToq3CpWLKDDse9ce/N5xyHJZhwIPl4yQ6mnOu
         qtPuzvt37+rccDpw+GQydZUw0AbPAexMeq9GMuqHyayFij3ZsMZCKDCgLt3v3c9MaupF
         /7h6FfaMqNym/DxVuNWSaY/yQoA4BrKfzIcU35EewLwI9rrRZcXah2pq4Yp6IAEDBDBr
         mfb30ztiAjmMEn/4Dj77V6X/17nkbEg4OyJIiLLrs6m+toLCuTD/UQik9kTUSz9S86yt
         Ny7SlWtFQHunplzgc/Eyil0TfeE6hBDMvCGCKCGIwyZkykCTK5pFM5Lme/6Cvi1VSFQE
         HKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TlQh7TuHnwgDKn+cKJqDNJnLA4TH+HrHgME+WMuJCQ8=;
        b=D9nGUUIqs11of3OAbArrjr6rCdZxKQFxQ0Ye/+m8knxWTbH0Maz5j/OTESmFiSmiTU
         0MJXeZuh4CQpl2vnoVP12oqVUWhIq8On4dEN186+JE7/2QMi+OKML4lRUqs+zlN+/aJf
         NFKcWaO28SI19+uI5UvHf241Hr17mczBy2kRX0lVN36kOYHQi/mA7y3Gxdh4ZANGlC9d
         fb854wUIZ0nFrtwyk1S9XR0NHiApnSZeGEQuJc0KmoPa4PqJ50t3m/B+mI2H4zsvS+BE
         rQeUcQitBdjupn9S3mSIUjarkUvFPwKOhzWyMthD2g6m4E6aV7JR0+7HXD6Ceu2XfTre
         VyRA==
X-Gm-Message-State: APjAAAWRx1lDd7wH4JlkRW3TDBUEWdmqwB6BlcqU4PMVJSlS5l7Pr7WE
        +F/kcqNoPBLvi7EK43R64LKcC2KEFRUWDQ==
X-Google-Smtp-Source: APXvYqzClbZ318/jZlabqQbsSCtg10ds86Zfqg1MOh3hs10FHdjl8t6O0NBWwfMiUHTsv2gmGRMRHQ==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr70229857pls.39.1556636322642;
        Tue, 30 Apr 2019 07:58:42 -0700 (PDT)
Received: from debian.net.fpt ([42.114.18.133])
        by smtp.gmail.com with ESMTPSA id n67sm4570723pfn.22.2019.04.30.07.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 07:58:41 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com,
        pantelis.antoniou@konsulko.com
Cc:     David.Laight@ACULAB.COM, hch@infradead.org,
        ndesaulniers@google.com, natechancellor@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V2] of: fix clang -Wunsequenced for be32_to_cpu()
Date:   Tue, 30 Apr 2019 21:56:24 +0700
Message-Id: <20190430145624.30470-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com>
References: <46b3e8edf27e4c8f98697f9e7f2117d6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, make the loop explicit to avoid clang warning.

./include/linux/of.h:238:37: warning: multiple unsequenced modifications
to 'cell' [-Wunsequenced]
                r = (r << 32) | be32_to_cpu(*(cell++));
                                                  ^~
./include/linux/byteorder/generic.h:95:21: note: expanded from macro
'be32_to_cpu'
                    ^
./include/uapi/linux/byteorder/little_endian.h:40:59: note: expanded
from macro '__be32_to_cpu'
                                                          ^
./include/uapi/linux/swab.h:118:21: note: expanded from macro '__swab32'
        ___constant_swab32(x) :                 \
                           ^
./include/uapi/linux/swab.h:18:12: note: expanded from macro
'___constant_swab32'
        (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
                  ^

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 include/linux/of.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index e240992e5cb6..71ca25ac01f6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -234,8 +234,8 @@ extern struct device_node *of_find_all_nodes(struct device_node *prev);
 static inline u64 of_read_number(const __be32 *cell, int size)
 {
 	u64 r = 0;
-	while (size--)
-		r = (r << 32) | be32_to_cpu(*(cell++));
+	for(; size--; cell++)
+		r = (r << 32) | be32_to_cpu(*cell);
 	return r;
 }
 
-- 
2.21.0

