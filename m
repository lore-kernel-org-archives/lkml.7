Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AE2C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B75D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqAIQc1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfL3E4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 23:56:13 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38544 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfL3E4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 23:56:13 -0500
Received: by mail-pg1-f181.google.com with SMTP id a33so17437568pgm.5;
        Sun, 29 Dec 2019 20:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVpMyu8Fw0MXecqQ4gT1BLcDBkmAuorpSplnF3n4Kow=;
        b=qqAIQc1WcTrG7GhRA7fAVuFT3OMKm09P5JRZpiACaCOJKZrskmEovAJU7WdeN1Ugsw
         sKNiL3pTG6mEmyHzAjWDyMXMVchyogdABINc/q7a8ttwczl/goJ5/QVqLNCheYXF4i59
         LZN7lI09aHDqSaqaK0MBM77ZLwCZbYWV74LdDGsaY6wt0uR9PPhDx6kxqPMo6wfxwA+R
         GOK+6nnf43Tff9JoX+CVZDOiiImpsew0XRgqv1VIOsbqRpbui5kT4SPevT8WyQ5C2UNO
         Vkr0DUyvX427haKWq7DVk4xZBfj6wWJLitrGZw7XaTed7PxCNPJPmZgchXrisVjL0dmE
         EhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVpMyu8Fw0MXecqQ4gT1BLcDBkmAuorpSplnF3n4Kow=;
        b=Vy6QVR8eSpz/uxM1aK3p3ssuWeXoDgRcuOcKcNObkWVk3AJP1tXVSECNEoENxtoYtS
         gsbeXOUuW1+dKg8R/RAN2zhbQOE6VcoPCrvl9JKf1pF7zb/6fWRf80PGn5co9eGwmG3N
         d7X6XmVqZrvDJSkZb9X9j2ktk1CaOFcG9EDuoRjr5ZMQBatIDYT5ABD3Tl+gwmu2wH4c
         v5gTJG6L/p33VAOAN4Sdfo34d3NmiXv1xiv9f93rLus9M9hEQUS3LQx0Zlci3dKSQ3C8
         Do6Hqg2BjE6Q+gquPJAG5fW3ldl2goQkj4r7bBkYyVrzFH5y7q+zBTUVuw2JemU/rc5l
         7ImA==
X-Gm-Message-State: APjAAAV12ttBWuAmJiGS7GnY9NsZK/aZD0+5YtUNK6qlmrjoeQao4H5i
        /A6v/04Vn5KXJNlUVFPDTROMWL/sFDw=
X-Google-Smtp-Source: APXvYqzaSD2agHTs8zTCTxRqp0olWnCnWnOCwVT1fbYoaRRCutEBd86i43Vlu6eryjAGy/phDRhKvQ==
X-Received: by 2002:a63:3dc6:: with SMTP id k189mr68428892pga.396.1577681772284;
        Sun, 29 Dec 2019 20:56:12 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id b1sm22373189pjw.4.2019.12.29.20.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 20:56:11 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/8] Documentation: nfs: Convert a few documents to RST and move them to admin-guide
Date:   Mon, 30 Dec 2019 01:55:54 -0300
Message-Id: <cover.1577681164.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

This series converts a few docs in Documentation/filesystems/nfs to RST.
The docs were also moved into admin-guide because they contain information
that might be useful for system administrators

Most changes are related to aesthetics and presentation, i.e. the content
itself remains mostly untouched. The use of markup was limited in order
not to negatively impact the plain-text reading experience.

Changes in v2
-------------
Also convert pnfs-block-server.txt, pnfs-scsi-server.txt and fault_injection.txt


Daniel W. S. Almeida (8):
  Documentation: convert nfs.txt to ReST
  Documentation: nfsroot.txt: convert to ReST
  Documentation: nfs-rdma: convert to ReST
  Documentation: convert nfsd-admin-interfaces to ReST
  Documentation: nfs: idmapper: convert to ReST
  Documentation: nfs: convert pnfs-block-server to ReST
  Documentation: nfs: pnfs-scsi-server: convert to ReST
  Documentation: nfs: fault_injection: convert to ReST

 Documentation/admin-guide/index.rst           |   1 +
 .../nfs/fault_injection.rst}                  |   5 +-
 Documentation/admin-guide/nfs/index.rst       |  16 +
 .../nfs/nfs-client.rst}                       |  91 +++---
 .../nfs/nfs-idmapper.rst}                     |  31 +-
 Documentation/admin-guide/nfs/nfs-rdma.rst    | 290 ++++++++++++++++++
 .../nfs/nfsd-admin-interfaces.rst}            |  19 +-
 .../nfs/nfsroot.rst}                          | 140 +++++----
 .../nfs/pnfs-block-server.rst}                |  25 +-
 .../nfs/pnfs-scsi-server.rst}                 |   1 +
 Documentation/filesystems/nfs/nfs-rdma.txt    | 274 -----------------
 11 files changed, 475 insertions(+), 418 deletions(-)
 rename Documentation/{filesystems/nfs/fault_injection.txt => admin-guide/nfs/fault_injection.rst} (98%)
 create mode 100644 Documentation/admin-guide/nfs/index.rst
 rename Documentation/{filesystems/nfs/nfs.txt => admin-guide/nfs/nfs-client.rst} (72%)
 rename Documentation/{filesystems/nfs/idmapper.txt => admin-guide/nfs/nfs-idmapper.rst} (81%)
 create mode 100644 Documentation/admin-guide/nfs/nfs-rdma.rst
 rename Documentation/{filesystems/nfs/nfsd-admin-interfaces.txt => admin-guide/nfs/nfsd-admin-interfaces.rst} (70%)
 rename Documentation/{filesystems/nfs/nfsroot.txt => admin-guide/nfs/nfsroot.rst} (83%)
 rename Documentation/{filesystems/nfs/pnfs-block-server.txt => admin-guide/nfs/pnfs-block-server.rst} (80%)
 rename Documentation/{filesystems/nfs/pnfs-scsi-server.txt => admin-guide/nfs/pnfs-scsi-server.rst} (97%)
 delete mode 100644 Documentation/filesystems/nfs/nfs-rdma.txt

-- 
2.24.1

