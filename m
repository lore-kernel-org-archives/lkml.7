Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFBCC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA92205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP6bPGly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfDYRsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:48:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35878 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:48:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so605546wru.3;
        Thu, 25 Apr 2019 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rl0JjKXh0YYqRBSZQrO5S0v5n/X6/3QU5poyjtVrKDY=;
        b=bP6bPGlyEx0DZtB6iXTYYeQQZnmK/dIdau/jEKCM1R75LW/5mCPWRazi5LqIMgsImF
         GWGPL7ea9HcgWFuuQkQp4Py6t2lYE275vtHZTfIimcr4v5xejiTTcF3VNkqaX9MNiTuK
         rbZeskufPAiRXsUPv5xowBx63XbYpKWfATpx4Brm1Pf9QxfZ4CFkPsg/fH11xBHYkIvt
         /QMFvbnoV9i0izC2eAaraTn1BmU2iC7YOgGbvijOCSOP7s9aPi59ZdRhHBdrFO2qhHij
         hEqEyvPJk70N6RWpa7mcMEf8nrdK55Alt+YsH5ULellX/LTHntuxvDYr2AlB7TkHxMys
         95iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rl0JjKXh0YYqRBSZQrO5S0v5n/X6/3QU5poyjtVrKDY=;
        b=BYZNLYRdSj75ZD7e1+EerBmIZpHkqejw1trsSu9Vp2rF9LHgExkDOzMvcVY3BxnuHA
         rYFUxAfrWjfWnh3C2809YQe2GQOSUWoE6JnElQRqNItnAwm0EuW1ou8kydhjP3KVsU6J
         WQPRrj79BOMQsZ4oiQ4n8GVHtRi5HN1LvDuDU5874KwPeRdgEYRbR3C6K2MVTBnk5qoa
         caHNd2l8PU0igD8tSrwXr/eaGrzbNQOsx1QoLNQFoKUNVUt1n7ds1+HzXkt1HACtuajb
         cplwYDmQUsDHAih9zAFJDMTIqqm46zEd5XFfG+4Rl5VotGAskjDlv/J+um9gfMBBiuDD
         mOKQ==
X-Gm-Message-State: APjAAAXwNjg+TYBJgTKqXry2VhjHBGK2IUkzoLu32JWoVWbFpsG236Zl
        te9WAzMSwU6JgrJIheoonc932o2zoXo=
X-Google-Smtp-Source: APXvYqznG/b0ScdYZjr4fQjQuOm1YU53pND/mD7vajEXB9gJMopI27YekpllD8q7kBl3iypC1UVfnQ==
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr26431645wrw.311.1556214489477;
        Thu, 25 Apr 2019 10:48:09 -0700 (PDT)
Received: from kwango.redhat.com (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id 62sm29221012wrm.18.2019.04.25.10.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:48:08 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.1-rc7
Date:   Thu, 25 Apr 2019 19:47:39 +0200
Message-Id: <20190425174739.27604-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.1-rc7

for you to fetch changes up to 37659182bff1eeaaeadcfc8f853c6d2b6dbc3f47:

  ceph: fix ci->i_head_snapc leak (2019-04-23 21:37:54 +0200)

----------------------------------------------------------------
dentry name handling fixes from Jeff and a memory leak fix from Zheng.
Both are old issues, marked for stable.

----------------------------------------------------------------
Jeff Layton (3):
      ceph: only use d_name directly when parent is locked
      ceph: ensure d_name stability in ceph_dentry_hash()
      ceph: handle the case where a dentry has been renamed on outstanding req

Yan, Zheng (1):
      ceph: fix ci->i_head_snapc leak

 fs/ceph/dir.c        |  6 ++++-
 fs/ceph/inode.c      | 16 +++++++++++-
 fs/ceph/mds_client.c | 70 +++++++++++++++++++++++++++++++++++++++++++---------
 fs/ceph/snap.c       |  7 +++++-
 4 files changed, 85 insertions(+), 14 deletions(-)
