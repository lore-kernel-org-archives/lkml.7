Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A83C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E177217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEXCEEEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGQDOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 23:14:37 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33112 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfGQDOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:14:36 -0400
Received: by mail-pl1-f201.google.com with SMTP id f2so11275916plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 20:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=;
        b=MEXCEEEPk/KuaWu/bxTbcr5Sv+ljjVJ5OJVxaekxPizc/h96zVyZZfexEYA9SVYpCV
         mjNK6v82DvgDgHKwdyC4kOKNH2VJ/VJDJ+Y8EGV/S4OPONugktXp7uenWF6BpIWIsCSn
         gk3QV/pTD0f1Ot1c4jFr0WyU7r3ZDFKJwWEsD3c0beg4TGWOT/qN2B8YjkmGYp7ZfOmq
         VZNWdX98/zP1yYpmKExnU7XInexP5ArSxTe3Q8MMV4Xbp5bv4dbT2Sr0GFZ3Fhvphn9r
         fMeA8QrxkD9RtLezfb49TUuBcKK3TcBeIUT8g6TVdU4YZSjYdoI3P20T9kvbW+psLYnL
         0yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UEDqcbhewLjuqENwZ85B/xbrNZKpwQFH/0eCwyVdkGc=;
        b=ffq/gM+IqB/qcEV1U6uWfsmUDM0vuX0stGmgZ+G22pSdjge7eBAmYJABpJ5LA6pxPO
         /xuPOSbuJM22Ko3D3DQfjkypaupSoHFwxBK1NSORdxmOyb9cVHy9T4lcB8roPDFjGTWG
         eWTxugVepru4SjuEHlCzG4hfS1hND7T8xVZYOgcWTqGIJK+znUoT97ZKB1hz+KRehH4U
         5pu4A4Zvv29So1Q+Yf47JfJ6LldSJdU2mXtAIuNkMHq2UgqfkHTOsz39t0CE/0URImja
         GnhpekWv3O0gyHkYYwnQKcAnVvb5KEiIZDEtPODf6Ykm2CtS3UbKWL4zuy9klS/tXU4s
         jDCA==
X-Gm-Message-State: APjAAAUZ/YNgEx4ELVLuWj55WJb/rS8O4JHrgzldkzRe59wLTuCPVHQl
        3alpbFQu9aGbJEiDJ4L0JUw4Z+N0Eoc=
X-Google-Smtp-Source: APXvYqx7EouYm/UBart6k3P8SNvF4Tt8Vrp1xqHYavJUzIKt18aw8pMHkXoYXAv17A98VxuiVijQcGClnME=
X-Received: by 2002:a65:55c7:: with SMTP id k7mr6163284pgs.305.1563333275476;
 Tue, 16 Jul 2019 20:14:35 -0700 (PDT)
Date:   Tue, 16 Jul 2019 20:14:06 -0700
Message-Id: <20190717031408.114104-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v2 0/2] Casefolding in F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are largely based on the casefolding patches for ext4
v2: Rebased patches again master, changed f2fs_msg to f2fs_info/f2fs_err

Daniel Rosenberg (2):
  f2fs: include charset encoding information in the superblock
  f2fs: Support case-insensitive file name lookups

 fs/f2fs/dir.c           | 133 ++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h          |  24 ++++++--
 fs/f2fs/file.c          |  10 ++-
 fs/f2fs/hash.c          |  34 +++++++++-
 fs/f2fs/inline.c        |   6 +-
 fs/f2fs/inode.c         |   4 +-
 fs/f2fs/namei.c         |  21 +++++++
 fs/f2fs/super.c         |  86 ++++++++++++++++++++++++++
 include/linux/f2fs_fs.h |   9 ++-
 9 files changed, 303 insertions(+), 24 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

