Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D8EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FBA21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257303;
	bh=f6MNwqqsvFWkwlw19tmD6cAon5HftrQYIF3CUYoejPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UKGM6gnyOQZ+7DTcPqwHeiu3gwDHiuakU2UlFKQSY5uIaJUNfa80axWKgMbyMZgZ1
	 fNoq0ephTNXkNbakFhdq4Dqg+27a833dOoQG5jlVDRk2BB6yf45r09ykHs97Gks/Hg
	 qqfHnpWfFmxL7ejp7TG+Ayxa+PBpDfO8AJEMpAt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390661AbfCVMTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390642AbfCVMTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF4B32082C;
        Fri, 22 Mar 2019 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257179;
        bh=f6MNwqqsvFWkwlw19tmD6cAon5HftrQYIF3CUYoejPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAe0JyozQjfLDo/Cy99uqgWu46ALeH/QXQJVKvv9Gu5GKT/VxGpn39xw91ivp7bNL
         T1oByE06/lvWz+MMTeaAhd5VS4WxSfiCrcEH3NHE80gYQkCH0IztPijeWF/ae3VtxY
         jsdpGp3wKy7npsLBwp+G3pkZs71jh2YFZkrIuBqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.0 155/238] security/selinux: fix SECURITY_LSM_NATIVE_LABELS on reused superblock
Date:   Fri, 22 Mar 2019 12:16:14 +0100
Message-Id: <20190322111307.469507918@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit 3815a245b50124f0865415dcb606a034e97494d4 upstream.

In the case when we're reusing a superblock, selinux_sb_clone_mnt_opts()
fails to set set_kern_flags, with the result that
nfs_clone_sb_security() incorrectly clears NFS_CAP_SECURITY_LABEL.

The result is that if you mount the same NFS filesystem twice, NFS
security labels are turned off, even if they would work fine if you
mounted the filesystem only once.

("fixes" may be not exactly the right tag, it may be more like
"fixed-other-cases-but-missed-this-one".)

Cc: Scott Mayhew <smayhew@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 0b4d3452b8b4 "security/selinux: allow security_sb_clone_mnt_opts..."
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -959,8 +959,11 @@ static int selinux_sb_clone_mnt_opts(con
 	BUG_ON(!(oldsbsec->flags & SE_SBINITIALIZED));
 
 	/* if fs is reusing a sb, make sure that the contexts match */
-	if (newsbsec->flags & SE_SBINITIALIZED)
+	if (newsbsec->flags & SE_SBINITIALIZED) {
+		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context)
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		return selinux_cmp_sb_context(oldsb, newsb);
+	}
 
 	mutex_lock(&newsbsec->lock);
 


