Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2892070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ja2wLQeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439143AbfJYL3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:29:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436520AbfJYL3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tawb+nccujPimrWiHS9Aa32LfRsfrtEJbJYur7m9f88=;
        b=Ja2wLQeWVQJrin19JM6+yPFiicY0vegf5CZo5wOP8muVf8kf7gf/9QrSqltn47Bm28g3Si
        tqiQb6AUbcwifnrwrQqGp09meZdoAZ3WfDiSfpACz/bEyggZ3p4P4vGPCRtLtW4Fn2/ASn
        VZm1KyIeLl43sJtkJ/xezO5TXR3em/Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-pBW8gIx_Pk21ZreaPy6p_g-1; Fri, 25 Oct 2019 07:29:21 -0400
Received: by mail-wr1-f69.google.com with SMTP id 4so921568wrf.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LV2TveLTnx1fiN/bkmnJtZ0B+hWPbHsr/HLlAeKi1Y=;
        b=quJh8zmuQJYg+D9NqeYkzleFIx88sxUc9fcNv5mrm5/DgF4wKwLGHUB+hYgh0mCu8v
         aPyyFp1m0z9XdQHeSg3CMcgKzQmrr6XZN+LIoczqt6esuPuBtDvYzmIsAIqxheqzwYWt
         YQnlj+4mE7eWLA4+wxcMV99Q38x2fTv7C+0qXlP/Vlc8Ko/BvY8bqWcWBFN+h2HfNOgI
         Upfq3/MyGuhEDTsGTIVjwjvMqHJJJYbBQwsBOpptFeUGkOIVpVhOcyNRM/D8hnhZrPOn
         e1ThU/LlsgSwJ9lHUha8ST44YLC9Ep6ULjWybsfykA3kfNIpb/ZTgR8E84i5ZeGLWrHG
         0eIA==
X-Gm-Message-State: APjAAAUSvr+nxK9wwSTrDKLw/353cXC1bXaUxEO5lHYu82AIKAjfEJoM
        pcvRvJn5trbjSWBGVN2kmiRKK4ZiNsM6+RjW6xYpVXxYneHw8ijNt8pOPphx0FuOHFXRlD6ILw0
        lqRuATA6d0pkB2Go4ZKRQXykk
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr2546008wra.201.1572002960743;
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzq6KqqiDo1k9UizmtJKHpklyWh4CoC38j2QsAc29ZM9Kley/036A6fB9ibAZsda5ZgBfW13A==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr2545995wra.201.1572002960542;
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] allow unprivileged overlay mounts
Date:   Fri, 25 Oct 2019 13:29:12 +0200
Message-Id: <20191025112917.22518-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: pBW8gIx_Pk21ZreaPy6p_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Can you please have a look at this patchset?

The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
whether I'm correct in stating that this isn't going to introduce any
holes, or not...

Thanks,
Miklos

---
Miklos Szeredi (5):
  ovl: document permission model
  ovl: ignore failure to copy up unknown xattrs
  vfs: allow unprivileged whiteout creation
  ovl: user xattr
  ovl: unprivieged mounts

 Documentation/filesystems/overlayfs.txt | 44 +++++++++++++
 fs/char_dev.c                           |  3 +
 fs/namei.c                              | 17 ++---
 fs/overlayfs/copy_up.c                  | 34 +++++++---
 fs/overlayfs/dir.c                      |  2 +-
 fs/overlayfs/export.c                   |  2 +-
 fs/overlayfs/inode.c                    | 39 ++++++------
 fs/overlayfs/namei.c                    | 56 +++++++++--------
 fs/overlayfs/overlayfs.h                | 81 +++++++++++++++---------
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  5 +-
 fs/overlayfs/super.c                    | 53 +++++++++++-----
 fs/overlayfs/util.c                     | 82 +++++++++++++++++++++----
 include/linux/device_cgroup.h           |  3 +
 14 files changed, 298 insertions(+), 124 deletions(-)

--=20
2.21.0

