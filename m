Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21881C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE04A21883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJVOP6eI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfICJDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:03:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:03:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id g7so16602970wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iRZYV2jQbw58rMj7DAq5Wvs++ZRaIMgknRuE7IFEBSk=;
        b=mJVOP6eIXiqapqeQMVh9Zok4qxKrjv3ROmSorrRGqpMeSu4B8NvoZ0/sICho1SAhKM
         0HRfuJ5HD0TnfsJnvIqpQBaGSLVjjC+FQmqD5l5oJhPHhpcrVE65uZrNddzxMnOqogwx
         H+znpTxDv2oKIZlCVU0MRuVlQF9EofgWXDWDaMThKHY0vRyDqqwqPf+gM/E/bfvvVgjn
         Dzc/GQK04amg5o9sW57jTrMLeyEmy292dmgisEdAgtoEllxKoEOSXLXhXGsvJlQHmhQ1
         z2HTLfUhJZrLJLuKrfbcRs09FE9+aePUxv7G47OddJuvSewVAoVTx7bMxWlKkMe+jJr3
         n6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iRZYV2jQbw58rMj7DAq5Wvs++ZRaIMgknRuE7IFEBSk=;
        b=AiumhOFv1vEl/RIYpVtRKkH7JbMs/5zNbxJq+X4JpZF0m6xkhaasyTXxmZGkdiHlkO
         EqY/XeOZZ1BrSdufPgQnXaXQgbdzgo+nWvzHHZW9QFVhUI/hLLueqMYhg3vtI4QDcUSH
         CyHlUO+xJPRMM+ZsXwr6HgHAZT9cqjIAPII735OnMmgA3+DIZCCUvN40Ctxu5Ky5flof
         iDHmA5Te5DBxs5Zlr8L0tlfEkROyi0pj/Lj3NBcf+aMZmzmgAMoKoBSm/LBGFFGUEex5
         sMr/G16DUo5cP44loZ1pYAZV99VePctwX+3vTHudrtIlH0wEZtoypCv/ViVo+SKBN8/k
         OE/A==
X-Gm-Message-State: APjAAAVrStDzLO6Bdi0OCWIThftpfPGwwFs986TVug3VGFKRvdcciSyT
        /NTjNQgmYgIslOLXe9tJ+iwh6o4Y
X-Google-Smtp-Source: APXvYqwt/DCj5OvOb+BOVYd6KGi4wUKWFHZrI4H1FCjcKlNUY+OF4UBfmArRyGUCQrYTrsIRbLmT0A==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr43827762wrs.56.1567501389057;
        Tue, 03 Sep 2019 02:03:09 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id a192sm22218669wma.1.2019.09.03.02.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 02:03:08 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: correctly cast variable to __le32
Date:   Tue,  3 Sep 2019 12:03:06 +0300
Message-Id: <20190903090306.11724-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the macro le32_to_cpu(x), we need to correctly convert x to be
__le32 in case it is defined as u32 variable.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index c39e07d665c4..75862be53c60 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1107,13 +1107,13 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 		mb(); \
 		(val) = *((u32 *) (uintptr_t) (addr)); \
 		if (mem_written_by_device) \
-			(val) = le32_to_cpu(val); \
+			(val) = le32_to_cpu(*(__le32 *) &(val)); \
 		if (cond) \
 			break; \
 		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
 			(val) = *((u32 *) (uintptr_t) (addr)); \
 			if (mem_written_by_device) \
-				(val) = le32_to_cpu(val); \
+				(val) = le32_to_cpu(*(__le32 *) &(val)); \
 			break; \
 		} \
 		if (sleep_us) \
-- 
2.17.1

