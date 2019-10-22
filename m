Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5532064B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="pXO9HhSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfJVUpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:45:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36281 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732207AbfJVUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:45:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so11383888pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQi/xJJwAqDZGEt9P00eL5cdkNEDylnd0lg9q6mQJHw=;
        b=pXO9HhSmD6xovUlEhY0LV4yCUtX33MQ1Wn1DWL/2qiereG48iqg8C1mmGc2vlujR+a
         TDBIAPtz309ZUIe5vY7r6+cJAuajEJD37Ebb9W6svo2VaftLgZPW8TAZSyeRJK/Pp2P2
         SHn7Pr4wIV2CNk2Urtv5a151FI4ZdfGVosVrWX3ioYuPb8vKm2wPMnZVvCHqnUTnamX3
         4Xj5QtKjII58x0mBefkmsPWbXysjM/VPB59grCp69k809dIS2INjD6XqWXBGPa6XyeSD
         VnJRQZNl3tKLlOk36+BMjBS6XT2KlB0VT3/lu5ayI5SDhkENXmRAXceVeEoraTV0NsKG
         p4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQi/xJJwAqDZGEt9P00eL5cdkNEDylnd0lg9q6mQJHw=;
        b=T5DMrADWqwQmSW4WRS8JpaNt1M/Q4qj9HevNQsGE2ken4XAo8TN6bcWm8YsdNJbKfe
         R3nf8L1EEIuAdol4tt5OcPV0XY+bdB3RAXU858M3498TWlXeRvyeIX5VLeRfUY7F/PVS
         iLykt4dLJffs2E2ZSwmR5NRqwrKwc10PXQyd5SLt5rezX0JlvsCpGw8FLsUfYni9BTH5
         57oKVES3kYscaKtr22RRo2Itk6528sBKuxjwjJemK2hu+vvy+n5iDr4AFpZpBirM3KGQ
         KwrxxduOvJ8785+IPhiuwLALZfIzNiLVzqJhJkAcmSaV0XI2NT/pvrjItwyhCSLEjvP8
         6KbQ==
X-Gm-Message-State: APjAAAU6Y8spVraj36Dq1e3Bprhb0B7syU9APJWo7JyGPmBaWp6iCOHe
        grDYw7MpPwAOl/8lEkXGPIDb3z6Zagegaw==
X-Google-Smtp-Source: APXvYqz7Lnbo1Tu208xh3nUpXQolvr6tWY9J/kPutn7UlzVjPZoPJnb5iaMDb1wW+Sv9LLRb5h4xvg==
X-Received: by 2002:aa7:9525:: with SMTP id c5mr6374626pfp.22.1571777101925;
        Tue, 22 Oct 2019 13:45:01 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id l184sm19810903pfl.76.2019.10.22.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:45:01 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v14 0/5] overlayfs override_creds=off & nested get xattr fix
Date:   Tue, 22 Oct 2019 13:44:45 -0700
Message-Id: <20191022204453.97058-1-salyzyn@android.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series:

Mark Salyzyn (5):
  Add flags option to get xattr method paired to __vfs_getxattr
  overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
  overlayfs: handle XATTR_NOSECURITY flag for get xattr method
  overlayfs: internal getxattr operations without sepolicy checking
  overlayfs: override_creds=off option bypass creator_cred

The first four patches address fundamental security issues that should
be solved regardless of the override_creds=off feature.

The fifth adds the feature depends on these other fixes.

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied for sepolicy, the
mounter's credentials might not overlap the credentials of the caller's
when accessing the overlayfs filesystem.  For example, a file that a
lower DAC privileged caller can execute, is MAC denied to the
generally higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/overlay_creds

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
v14:
- Rejoin, rebase and a few adjustments.

v13:
- Pull out first patch and try to get it in alone feedback, some
  Acks, and then <crickets> because people forgot why we were doing i.

v12:
- Restore squished out patch 2 and 3 in the series,
  then change algorithm to add flags argument.
  Per-thread flag is a large security surface.

v11:
- Squish out v10 introduced patch 2 and 3 in the series,
  then and use per-thread flag instead for nesting.
- Switch name to ovl_do_vds_getxattr for __vds_getxattr wrapper.
- Add sb argument to ovl_revert_creds to match future work.

v10:
- Return NULL on CAP_DAC_READ_SEARCH
- Add __get xattr method to solve sepolicy logging issue
- Drop unnecessary sys_admin sepolicy checking for administrative
  driver internal xattr functions.

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation, drop rationalizations.
- pr_warn message adjusted to report consequences.

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v4:
- spelling and grammar errors in text

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.


 Documentation/filesystems/locking.rst   |  10 +--
 Documentation/filesystems/overlayfs.txt |  23 +++++
 fs/9p/acl.c                             |  51 ++++++-----
 fs/9p/xattr.c                           |  19 ++--
 fs/afs/xattr.c                          | 112 +++++++++++-------------
 fs/btrfs/xattr.c                        |  36 ++++----
 fs/ceph/xattr.c                         |  17 ++--
 fs/cifs/xattr.c                         |  72 +++++++--------
 fs/ecryptfs/crypto.c                    |  20 +++--
 fs/ecryptfs/inode.c                     |  36 +++++---
 fs/ecryptfs/mmap.c                      |  39 +++++----
 fs/erofs/xattr.c                        |   8 +-
 fs/ext2/xattr_security.c                |  16 ++--
 fs/ext2/xattr_trusted.c                 |  15 ++--
 fs/ext2/xattr_user.c                    |  19 ++--
 fs/ext4/xattr_security.c                |  15 ++--
 fs/ext4/xattr_trusted.c                 |  15 ++--
 fs/ext4/xattr_user.c                    |  19 ++--
 fs/f2fs/xattr.c                         |  42 ++++-----
 fs/fuse/xattr.c                         |  23 ++---
 fs/gfs2/xattr.c                         |  18 ++--
 fs/hfs/attr.c                           |  15 ++--
 fs/hfsplus/xattr.c                      |  17 ++--
 fs/hfsplus/xattr_security.c             |  13 ++-
 fs/hfsplus/xattr_trusted.c              |  13 ++-
 fs/hfsplus/xattr_user.c                 |  13 ++-
 fs/jffs2/security.c                     |  16 ++--
 fs/jffs2/xattr_trusted.c                |  16 ++--
 fs/jffs2/xattr_user.c                   |  16 ++--
 fs/jfs/xattr.c                          |  33 ++++---
 fs/kernfs/inode.c                       |  23 +++--
 fs/nfs/nfs4proc.c                       |  28 +++---
 fs/ocfs2/xattr.c                        |  52 +++++------
 fs/orangefs/xattr.c                     |  19 ++--
 fs/overlayfs/copy_up.c                  |   2 +-
 fs/overlayfs/dir.c                      |  17 ++--
 fs/overlayfs/file.c                     |  20 ++---
 fs/overlayfs/inode.c                    |  66 +++++++-------
 fs/overlayfs/namei.c                    |  21 +++--
 fs/overlayfs/overlayfs.h                |   9 +-
 fs/overlayfs/ovl_entry.h                |   1 +
 fs/overlayfs/readdir.c                  |   4 +-
 fs/overlayfs/super.c                    |  75 +++++++++-------
 fs/overlayfs/util.c                     |  44 +++++++---
 fs/posix_acl.c                          |  23 +++--
 fs/reiserfs/xattr.c                     |   2 +-
 fs/reiserfs/xattr_security.c            |  22 +++--
 fs/reiserfs/xattr_trusted.c             |  22 +++--
 fs/reiserfs/xattr_user.c                |  22 +++--
 fs/squashfs/xattr.c                     |  10 +--
 fs/ubifs/xattr.c                        |  33 ++++---
 fs/xattr.c                              | 112 +++++++++++++++---------
 fs/xfs/libxfs/xfs_attr.c                |   4 +-
 fs/xfs/libxfs/xfs_attr.h                |   2 +-
 fs/xfs/xfs_xattr.c                      |  35 ++++----
 include/linux/xattr.h                   |  26 ++++--
 include/uapi/linux/xattr.h              |   7 +-
 mm/shmem.c                              |  21 +++--
 net/socket.c                            |  16 ++--
 security/commoncap.c                    |  29 ++++--
 security/integrity/evm/evm_main.c       |  13 ++-
 security/selinux/hooks.c                |  28 ++++--
 security/smack/smack_lsm.c              |  38 +++++---
 63 files changed, 852 insertions(+), 771 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

