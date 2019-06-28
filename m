Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CBBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9687F2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1v+QcQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfF1GBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:01:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39764 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF1GBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:01:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so4905250wrt.6;
        Thu, 27 Jun 2019 23:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuUMir4cdKZVUvRsNPY5rqLX7yjSzNVBKmDh7MZE8Aw=;
        b=H1v+QcQE2qtDu3J2jSKMehj/p++gMENcAu082mD3tiqG3g1yXY+IEbr2VQ+QI84q9c
         pThBfRO6NDWHe3Y0AuE3Q4HMEyFGvjVMAjz5Al24e9w0Wdl8w67nl7I4aAKxAEk/7lIH
         3q3NHzPAHPjstjhJLLnlzuJkOsFHcTxE+3cvtqNy8DCtEquRC1mtn3xa4SuhHPytfB8t
         /fMBYny+fN2pJW+gt0eiEhGcg4yynzd7pj1S9Ehlmk/mKSDOXps0/jQ8OqkYafpTUF4F
         QW3j7LstTBBtGAq0nIoUOzLoTAyYqLC7ehkW5RnzSouhVmtkF+T9W0XEpPZtruhvLw1V
         bWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuUMir4cdKZVUvRsNPY5rqLX7yjSzNVBKmDh7MZE8Aw=;
        b=LyoBCeV9xyRfNJByCdhA0A+oQN5CzFuFdRgixyj3vTgjqsW8dPBPrD7B2GFeGpKRHz
         RbxkSTGcGT+c792kqN36wYlvAHTbjzPt+JJbvU6XvXBILUIW4ujul/u/OxnoQDNScGFV
         35+5jdSN7YVA6WobtqrS2Ikx4W+2d6Qy79lTQIElY2m61mx3huIxZqSMoeQYYasnlM9S
         wFyMweSMQoVFuYm3VCFUHiL9i2rka754+z7Nn9pqzSTYRlguPLnOTIjyPXSTA6hH1RgA
         5bJpG9lO1cokTdVoKepp0rLNcAddkrNxRoYl6zZ3Ort0cbkAUkSZtkdZvDueMD/+O0yZ
         vRRw==
X-Gm-Message-State: APjAAAUqn3n5P9ZAiDyjc/17LpM+gZ/2pX9ZYkV/dzzVsNa0spUsJZv3
        UDVxbbe9FYDqkIeKFI4PPXY=
X-Google-Smtp-Source: APXvYqzinfybbEVtbH0doIFwzBk11J7MqZvbTTR/G2+E0jAKdeONo0mMEorviqYsiZpycttNDKXNHA==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr6348964wrq.28.1561701697998;
        Thu, 27 Jun 2019 23:01:37 -0700 (PDT)
Received: from localhost.localdomain ([41.220.75.172])
        by smtp.gmail.com with ESMTPSA id 5sm1094487wmg.42.2019.06.27.23.01.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 23:01:37 -0700 (PDT)
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org,
        Sheriff Esseson <sheriffesseson@gmail.com>
Subject: [PATCH] Doc : doc-guide : Fix a typo
Date:   Fri, 28 Jun 2019 07:01:11 +0100
Message-Id: <20190628060111.24851-1-sheriffesseson@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the disjunction by replacing "of" with "or".

Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index f96059767..192c36af3 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -359,7 +359,7 @@ Domain`_ references.
   ``monospaced font``.
 
   Useful if you need to use special characters that would otherwise have some
-  meaning either by kernel-doc script of by reStructuredText.
+  meaning either by kernel-doc script or by reStructuredText.
 
   This is particularly useful if you need to use things like ``%ph`` inside
   a function description.
-- 
2.22.0

