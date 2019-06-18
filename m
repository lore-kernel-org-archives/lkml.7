Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F87C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBDE20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="itPVTNwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfFRHTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:19:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39278 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRHTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:19:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so5319041pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zVZ8e/Dim6JDg+jaoDpXKYzIIskhjtm1CMlrUWeV9Y=;
        b=itPVTNwmUc18RRywOjbXTYCoYN5E9Rz7xn1o2D//JOvageoxeVd9YZbz+hFXc07lnZ
         kumqIdSUSDsfjEc720AP+HEfWgtwp43fcpUKqs1hpGgDtD8HOWnHjFm3ENuQmwLc7NPp
         izKa1K+jnMZJQakwzsERWIZ5wjg2TkffCtAfyGS5YOrYFRl3xvSvZtIQVv/mLvJf9zTh
         siRNbaFx71sGgTCWCRdTA2buH6D5MXTKvp3rZAM0s92/2AFLUPTWxMA2lyJ78KbxsOmN
         600eIkfbe30YwDnR7+lnatGCveqNoFXg9Ib1HnwvmS9jo3d++D6IyRK1lmsThVteQSsz
         g+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zVZ8e/Dim6JDg+jaoDpXKYzIIskhjtm1CMlrUWeV9Y=;
        b=tmxLYnlkte7mx2i4RWDZpegbGRQEkfn5Yz3O/pHfaJREEtbcYWvuweK0Aiofho7VNE
         nSoePxAyWmKBdNDjngzo4sjw88RpKUrMbx+lNWZS4dOpa49ZCiG5fKR5+OASe78y08JO
         ceqskoVVtBXVMJHadmPdPAnoQ959nz7vWw5TSNgK6jUeYgU7B2+TDFXQHLEk3CLxrGw5
         dkyE0Ktpa2YPWXdOsNL7PVpQXdjG4DkoOwbZEsc+YHPn/MdKkHp34/flvwKt37z5Arwe
         mDD37vQyWnQeg+09lkWhlEoLY7d3ZSwaOVxKm0S1pD8mWTYpHB6nRcGFsxCzPWSRGw2A
         9Eiw==
X-Gm-Message-State: APjAAAUzNL+b4+DiOb0nvP0R5BKKhkgo5xXVQuhbT1/S64Dk0IOKc1AG
        4Q8REKZsbpJYVK5KACwxgIZ7Tozqgetvy1+s
X-Google-Smtp-Source: APXvYqxMNYpPUmfHKiiRtpFEcWE3VSAMY/JmOzgFWYYl7QKfIBzoNZm4YMCi2t9w3MH1iIBlF4MlOw==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr84477436plb.46.1560835987882;
        Mon, 17 Jun 2019 22:33:07 -0700 (PDT)
Received: from localhost ([2601:647:5180:35d7::cf52])
        by smtp.gmail.com with ESMTPSA id h4sm945060pji.24.2019.06.17.22.33.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 22:33:07 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/atomics: Use sed(1) instead of non-standard head(1) option
Date:   Mon, 17 Jun 2019 22:33:06 -0700
Message-Id: <20190618053306.730-1-mforney@mforney.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX says the -n option must be a positive decimal integer. Not all
implementations of head(1) support negative numbers meaning offset from
the end of the file.

Instead, the sed expression '$d' has the same effect of removing the
last line of the file.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 scripts/atomic/check-atomics.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index cfa0c2f71c84..8378c63a1e09 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -22,7 +22,7 @@ while read header; do
 	OLDSUM="$(tail -n 1 ${LINUXDIR}/include/${header})"
 	OLDSUM="${OLDSUM#// }"
 
-	NEWSUM="$(head -n -1 ${LINUXDIR}/include/${header} | sha1sum)"
+	NEWSUM="$(sed '$d' ${LINUXDIR}/include/${header} | sha1sum)"
 	NEWSUM="${NEWSUM%% *}"
 
 	if [ "${OLDSUM}" != "${NEWSUM}" ]; then
-- 
2.20.1

