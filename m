Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3F9C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1242320863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dpkZ/BaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfFQSr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:47:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56298 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQSrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:47:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so486894wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyz6fqs53F/qDL0teIid/cZMh/h4MCVWeZnSY+AMCoY=;
        b=dpkZ/BaXFS1LG6+8QDEVPNUs8VTnwlkwRqxE2SkOPncRaIFYbT5UtO0rCbAE8wklPK
         A+pM4bjs042iCCS63cjDb5nKJp6db4RHvVWRUuKWSDEOVVnTbO7OWr8WYlCextQ0QimK
         hw4LLF1wNpVkzFD6V+ONmIlTnrY1+8k6e4TaZdpVoNDlKqkUuSqFVfBEQ+OJG1LDWSgP
         m75VIMcL0EguIzRlli+ULY88ePkc83ABPa3Xgx6PJVjcudVyRfDrhq7dPFSQXwt/+NkE
         589m46d9c9z40EJjutdnQmqYLs/FwabIdq2M/LnYeF6nxtc/3UfhKEjb+iwOPAalvC/K
         5BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jyz6fqs53F/qDL0teIid/cZMh/h4MCVWeZnSY+AMCoY=;
        b=BG6QyltCX3CRW4XzowVXXj9Mkr+93CnYNYwbNpCQP5WG1iAb5jaUAQoKfaKS4EuhA/
         VqXX2EbZyDJcKvKAsYrZ22YZVqx7tdJqiqp298zRxygEMHOPBlcAgKE/5CgIDtG/jcE7
         UYgzBvz/S6PK4qqpYGY9PwbqlsUa3Z9zfU9kHndnDWbHtwN36h9tAJicEw7pRzwsD2if
         eFlEpiyhtphokWWu/Y60NO7EYHEtYsqSQlGT0MfKxsXf9IzIFzI7jR9f0LF41ze7qk7w
         JrtdSI/DH/7m4cOkceVdIi5I6HddAmlbPCDH87lY2dWn+qaPUR3ch2DkGpyqrHa475iR
         uN/Q==
X-Gm-Message-State: APjAAAWWUfxtL4XyPCyjTjoW9/n0zW7tJY36N/hFOqt9UcG+IFPfOAxa
        p0Moy1ixssVi4wKc2f2wjcTnAA==
X-Google-Smtp-Source: APXvYqwCog0WuntJNECNO7CxMrilOnBpLe8UZEZ8fB1Xecu0XDTNFGjWT/QTVqbrRp87QTWwXnKxrA==
X-Received: by 2002:a1c:9a05:: with SMTP id c5mr63708wme.36.1560797243509;
        Mon, 17 Jun 2019 11:47:23 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id w23sm70389wmi.45.2019.06.17.11.47.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:47:22 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        stable@vger.kernel.org
Subject: [PATCH] fs/namespace: fix unprivileged mount propagation
Date:   Mon, 17 Jun 2019 20:47:11 +0200
Message-Id: <20190617184711.21364-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When propagating mounts across mount namespaces owned by different user
namespaces it is not possible anymore to move or umount the mount in the
less privileged mount namespace.

Here is a reproducer:

  sudo mount -t tmpfs tmpfs /mnt
  sudo --make-rshared /mnt

  # create unprivileged user + mount namespace and preserve propagation
  unshare -U -m --map-root --propagation=unchanged

  # now change back to the original mount namespace in another terminal:
  sudo mkdir /mnt/aaa
  sudo mount -t tmpfs tmpfs /mnt/aaa

  # now in the unprivileged user + mount namespace
  mount --move /mnt/aaa /opt

Unfortunately, this is a pretty big deal for userspace since this is
e.g. used to inject mounts into running unprivileged containers.
So this regression really needs to go away rather quickly.

The problem is that a recent change falsely locked the root of the newly
added mounts by setting MNT_LOCKED. Fix this by only locking the mounts
on copy_mnt_ns() and not when adding a new mount.

Fixes: 3bd045cc9c4b ("separate copying and locking mount tree on cross-userns copies")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: <stable@vger.kernel.org>
Tested-by: Christian Brauner <christian@brauner.io>
Acked-by: Christian Brauner <christian@brauner.io>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/namespace.c | 1 +
 fs/pnode.c     | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b26778bdc236..44b540e6feb9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2105,6 +2105,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
+		child->mnt.mnt_flags &= ~MNT_LOCKED;
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
diff --git a/fs/pnode.c b/fs/pnode.c
index 595857a1883e..d118106fa631 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -257,11 +257,10 @@ static int propagate_one(struct mount *m)
 		if (IS_MNT_SHARED(m))
 			type |= CL_MAKE_SHARED;
 	}
-		
+
 	child = copy_tree(last_source, last_source->mnt.mnt_root, type);
 	if (IS_ERR(child))
 		return PTR_ERR(child);
-	child->mnt.mnt_flags &= ~MNT_LOCKED;
 	mnt_set_mountpoint(m, mp, child);
 	last_dest = m;
 	last_source = child;
-- 
2.21.0

