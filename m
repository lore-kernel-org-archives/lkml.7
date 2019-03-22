Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3008CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BC7218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259113;
	bh=4V6VNYuJw8MAPLpKtwwTLmBGr3vw6nL5a3WY3y3yi3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tJNEIHKQlG57wF7FojOahLrHgdUJFaf/rg5OjR6Fr/QGgbOEYJe7SAh+HtkQKbO8K
	 Kk6sg2TvquEjj0ZWt0Amou9TKEB/jSFjcDN3BG6+uYIPE274rL+WC0MYWIG6O8EbPl
	 +/CKOSI2zQ9lJFToyUt77Hr00lMprMyy+qsPTcow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfCVMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732779AbfCVLyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB372192C;
        Fri, 22 Mar 2019 11:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255647;
        bh=4V6VNYuJw8MAPLpKtwwTLmBGr3vw6nL5a3WY3y3yi3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X51iUNh6+6sGS3gXuIuIyoR/fqqIOtACZqa7mTTQU/F4mLctaB37Mb2flA/VE9f2I
         d3tWsa/tlWsWZmNW/SCNESzubzgmeCxj+ef2o4dzohxSNgnUng3sREcHcr2nXlLT+Z
         sWilccs4BbPoO4BXQ03OMHSm+4Uvn0xYXVVJ2FBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.14 137/183] security/selinux: fix SECURITY_LSM_NATIVE_LABELS on reused superblock
Date:   Fri, 22 Mar 2019 12:16:05 +0100
Message-Id: <20190322111251.684562973@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1000,8 +1000,11 @@ static int selinux_sb_clone_mnt_opts(con
 	BUG_ON(!(oldsbsec->flags & SE_SBINITIALIZED));
 
 	/* if fs is reusing a sb, make sure that the contexts match */
-	if (newsbsec->flags & SE_SBINITIALIZED)
+	if (newsbsec->flags & SE_SBINITIALIZED) {
+		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context)
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		return selinux_cmp_sb_context(oldsb, newsb);
+	}
 
 	mutex_lock(&newsbsec->lock);
 


