Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3511DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018FF208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlECP3AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfGSADa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:03:30 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35401 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:03:29 -0400
Received: by mail-qk1-f201.google.com with SMTP id 5so24809717qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=;
        b=jlECP3AShHax5jtmkNgXohpyfl7vU5w7VHrgYsRWrEm2m4hlw/rYhIrWcKnQsgM/dy
         OZKUI6y+AIE/8YlhSPji2idKxN0l15EnM8rzrdMLZV0TLJnOlEsSZXi2fPES3upK7XOP
         P6Fu8zpLaXcgEM3opBWpKQlDf9WiVxWgEuUtKWlVO+u6rMYKgmPr9aRAZf59izPvrH50
         P2eNvCymoJmAshBV+K5iW9R/VnFb0MSoMnaF9QL2N6ZCJF1ZEOrMKEF0NoPv34W3YyUn
         QvkwFcFGXXB2EJ8HkYnTFjdiARmGNnuoUjeWQCsOvq9hLKU7Q6n//i3scNYe1DmFLOqQ
         8r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=;
        b=VXUFCMX/RAH6V3OiqllST2peRFvOBsgx6qsEmnl6QkuXpEmxVsGRFa8JK7x3RNNIVr
         QF30y2MgNN50gy5mxeUhcqp5jItuPAR+hHjR3qRJO+Uw0muwnNAXhRvmD0M6pxnacJci
         IilafvPAjvln+kIMjBgRoOAyckrTkyOJ3N0/p8Y4O5Z0kiUFK2l/xmbEsBJgnazhhanw
         J0WkIhdhVc5V2jRcfbTGa7BPQWXvMhj9fqgfcm6wIcEkytKEGdLPgzj+j8wnsJR8EADE
         u3Ufx+x1GlBuaGd29Hct2n/05+4azHcm00NDsQG1l/10I6I75ZMZAXhMxBe2Qt+gIIJ9
         U0Dg==
X-Gm-Message-State: APjAAAWz7fJCX+aM2NQAMvqfMoa4Dc8kW8GYsAt/1pg0WiDZFGUDayuf
        f6WHrb3ANwIubKIebpIn5evuPwMa17U=
X-Google-Smtp-Source: APXvYqwRtX2YZ4Wg80vezuYYq+k1K3TfOAWAb15xfWjTiHcPsAy8V60Fafp8iP5EMk8uQaIB6Ld5vnGMWuw=
X-Received: by 2002:ac8:2642:: with SMTP id v2mr32821422qtv.333.1563494608664;
 Thu, 18 Jul 2019 17:03:28 -0700 (PDT)
Date:   Thu, 18 Jul 2019 17:03:20 -0700
Message-Id: <20190719000322.106163-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v3 0/2] Casefolding in F2FS
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

v3: Addressed feedback, apart from F2FS_CASEFOLD_FL/FS_CASEFOLD_FL
    Added sysfs file "encoding" to see the encoding set on a filesystem
v2: Rebased patches again master, changed f2fs_msg to f2fs_info/f2fs_err

Daniel Rosenberg (2):
  f2fs: include charset encoding information in the superblock
  f2fs: Support case-insensitive file name lookups

 fs/f2fs/dir.c           | 126 ++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h          |  21 ++++++-
 fs/f2fs/file.c          |   9 +++
 fs/f2fs/hash.c          |  35 ++++++++++-
 fs/f2fs/inline.c        |   4 +-
 fs/f2fs/inode.c         |   4 +-
 fs/f2fs/namei.c         |  21 +++++++
 fs/f2fs/super.c         | 100 +++++++++++++++++++++++++++++++
 fs/f2fs/sysfs.c         |  23 ++++++++
 include/linux/f2fs_fs.h |   9 ++-
 10 files changed, 334 insertions(+), 18 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog

