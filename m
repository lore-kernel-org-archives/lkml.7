Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F9AC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5658C207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmpT6AyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgAAW00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:26:26 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44786 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgAAW00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:26:26 -0500
Received: by mail-pl1-f175.google.com with SMTP id az3so17106740plb.11;
        Wed, 01 Jan 2020 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92F7+S3s3pR7N4YVpQd8gHKmnOtBDwBFFUoukwS5nac=;
        b=DmpT6AyIcRlv+x1yemQ28K/aJXTl2aAANuto0jK1UpyvJoc09GZjP8Dl1RJ1kb7eGm
         fA4z8/nnsB+yEYgfEaw3PYsVXKP/jKvK2IJkGtwG2j27n/9Zmt3MZAXxoxsn/44BT0Yk
         Xs9H93a3iAHjN9Z37/wZgPM6GA8/AEYeFOU2mFvFRIgYEBr7Zz+G3UG6uG2Q5m6zBSOR
         HZKwnwqC8gl4qiKm4qnSuG2frkRXnbFSB3xg1B16V0n3PkZ7JlEdmoZJebEPRJY7h/kK
         QSO5ZZpRI5AEGleWDbk7esA1mO/5zASwmkM0BXzMj95U1kUxNVT3uY50ihc1wKSblzG/
         BdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92F7+S3s3pR7N4YVpQd8gHKmnOtBDwBFFUoukwS5nac=;
        b=NBMrk3i5+sv7da8Qi1Cijwmk1k/h+SPLNNWPC6+dtOdXxuP8B8oQqnycRT4jCaev60
         bwEeB5Y9eDkKqSLDIP9ioCiTITgeY3ThuIyg7opotw3zGlqeNf9c3A+dEff+gzzUpYB/
         8UCyNeUprLF9NIhaQdMy3ocdWj1j8sK4QIIaNXKBQ/mcXdgnUxCUbsNd6gD50VEFRUPN
         Y8OFdLOaa419bNVS1mcXdFjVfhKLtSd7H4xQdI37foUon/Wy/5h5RKPrSSSpIZ+uID/6
         iZY5w8MFAUFDBM1T1OJ0w9NmTo9yuviaT70DASgyzYqqMcP48pbJZu2U3km93WXFceBZ
         dsfA==
X-Gm-Message-State: APjAAAVInRQ0ee12PDB32qVGZzuiPNVI3Z8CSpYYwFvG5cKimT91olMS
        QiMAjNhHAJ/TGh3KJsmguwg=
X-Google-Smtp-Source: APXvYqxIPUaYFN9DbDKtRjfRf6fE0HHW8N52j5B0Nj+9uIoRy2JnnKS1Bzhje87/5z4wxdqB+iid7g==
X-Received: by 2002:a17:902:6b42:: with SMTP id g2mr82869751plt.195.1577917585676;
        Wed, 01 Jan 2020 14:26:25 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id o2sm8601008pjo.26.2020.01.01.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:26:24 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 0/8] Documentation: nfs: Convert a few documents to RST and move them to admin-guide
Date:   Wed,  1 Jan 2020 19:26:07 -0300
Message-Id: <cover.1577917076.git.dwlsalmeida@gmail.com>
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

Changes in v3
-------------
Documentation: convert nfs.txt to ReST
	- Remove "#." syntax

Documentation: nfsroot.txt: convert to ReST
	- Remove stray backtick
	- Remove standalone "::"
	- Remove "#." syntax
	- Refill paragraph in a new commit to remove long lines

Documentation: nfs-rdma: convert to ReST
	- Add warning for obsolete content
	- CC nfs-rdma-devel@lists.sourceforge.net

Documentation: convert nfsd-admin-interfaces to ReST
	- Remove "#." syntax

Changes in v2
-------------
Also convert pnfs-block-server.txt, pnfs-scsi-server.txt and fault_injection.txt

Daniel W. S. Almeida (8):
  Documentation: nfsroot.txt: convert to ReST
  Documentation: nfsroot.rst: COSMETIC: refill a paragraph
  Documentation: nfs-rdma: convert to ReST
  Documentation: convert nfsd-admin-interfaces to ReST
  Documentation: nfs: idmapper: convert to ReST
  Documentation: nfs: convert pnfs-block-server to ReST
  Documentation: nfs: pnfs-scsi-server: convert to ReST
  Documentation: nfs: fault_injection: convert to ReST

 .../nfs/fault_injection.rst}                  |   5 +-
 Documentation/admin-guide/nfs/index.rst       |   7 +
 .../nfs/nfs-idmapper.rst}                     |  31 +-
 Documentation/admin-guide/nfs/nfs-rdma.rst    | 292 ++++++++++++++++++
 .../nfs/nfsd-admin-interfaces.rst}            |  19 +-
 .../nfs/nfsroot.rst}                          | 151 ++++-----
 .../nfs/pnfs-block-server.rst}                |  25 +-
 .../nfs/pnfs-scsi-server.rst}                 |   1 +
 Documentation/filesystems/nfs/nfs-rdma.txt    | 274 ----------------
 9 files changed, 424 insertions(+), 381 deletions(-)
 rename Documentation/{filesystems/nfs/fault_injection.txt => admin-guide/nfs/fault_injection.rst} (98%)
 rename Documentation/{filesystems/nfs/idmapper.txt => admin-guide/nfs/nfs-idmapper.rst} (81%)
 create mode 100644 Documentation/admin-guide/nfs/nfs-rdma.rst
 rename Documentation/{filesystems/nfs/nfsd-admin-interfaces.txt => admin-guide/nfs/nfsd-admin-interfaces.rst} (70%)
 rename Documentation/{filesystems/nfs/nfsroot.txt => admin-guide/nfs/nfsroot.rst} (80%)
 rename Documentation/{filesystems/nfs/pnfs-block-server.txt => admin-guide/nfs/pnfs-block-server.rst} (80%)
 rename Documentation/{filesystems/nfs/pnfs-scsi-server.txt => admin-guide/nfs/pnfs-scsi-server.rst} (97%)
 delete mode 100644 Documentation/filesystems/nfs/nfs-rdma.txt

-- 
2.24.1

