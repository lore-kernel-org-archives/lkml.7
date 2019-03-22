Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51773C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B542082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256356;
	bh=X4jlv/otCQUp725+JLK80HZ8ACjGGQdcVVSH2U2NFWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x4KTn72MPCKgI6tcFq+KKT3qpMn1mZTcsfHww70KCALj4RS/fXJarSIm8LmekWJCf
	 94UgJl8HWf2epR6caD2m6oZj+uJXyyp81LcQx4ICNn6JCquhMb3CBVc9MwO1A6A51Q
	 fvl0MNjUCZagyRHAO/1ZsYcpoMUd3kaBjd5VcazE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbfCVMFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388210AbfCVMFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:05:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C56CF21929;
        Fri, 22 Mar 2019 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256347;
        bh=X4jlv/otCQUp725+JLK80HZ8ACjGGQdcVVSH2U2NFWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbkq2KGij1XLajQOyiglCyYAQnBdP9dXYWDocDbCO0obFqeoheKAb3XNMxI67N89h
         h2e8bRakaECNA4IVYTySDedOD55z5Is/CKAejlQsrPNh7q46VprUDxg8+L+iaPfVyM
         eoZqZvMmNHphszKacY4t7d9Q1H5Y8wAZLNvTbgMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 165/280] ovl: During copy up, first copy up data and then xattrs
Date:   Fri, 22 Mar 2019 12:15:18 +0100
Message-Id: <20190322111323.329929331@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivek Goyal <vgoyal@redhat.com>

commit 5f32879ea35523b9842bdbdc0065e13635caada2 upstream.

If a file with capability set (and hence security.capability xattr) is
written kernel clears security.capability xattr. For overlay, during file
copy up if xattrs are copied up first and then data is, copied up. This
means data copy up will result in clearing of security.capability xattr
file on lower has. And this can result into surprises. If a lower file has
CAP_SETUID, then it should not be cleared over copy up (if nothing was
actually written to file).

This also creates problems with chown logic where it first copies up file
and then tries to clear setuid bit. But by that time security.capability
xattr is already gone (due to data copy up), and caller gets -ENODATA.
This has been reported by Giuseppe here.

https://github.com/containers/libpod/issues/2015#issuecomment-447824842

Fix this by copying up data first and then metadta. This is a regression
which has been introduced by my commit as part of metadata only copy up
patches.

TODO: There will be some corner cases where a file is copied up metadata
only and later data copy up happens and that will clear security.capability
xattr. Something needs to be done about that too.

Fixes: bd64e57586d3 ("ovl: During copy up, first copy up metadata and then data")
Cc: <stable@vger.kernel.org> # v4.19+
Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/copy_up.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -501,6 +501,24 @@ static int ovl_copy_up_inode(struct ovl_
 {
 	int err;
 
+	/*
+	 * Copy up data first and then xattrs. Writing data after
+	 * xattrs will remove security.capability xattr automatically.
+	 */
+	if (S_ISREG(c->stat.mode) && !c->metacopy) {
+		struct path upperpath, datapath;
+
+		ovl_path_upper(c->dentry, &upperpath);
+		if (WARN_ON(upperpath.dentry != NULL))
+			return -EIO;
+		upperpath.dentry = temp;
+
+		ovl_path_lowerdata(c->dentry, &datapath);
+		err = ovl_copy_up_data(&datapath, &upperpath, c->stat.size);
+		if (err)
+			return err;
+	}
+
 	err = ovl_copy_xattr(c->lowerpath.dentry, temp);
 	if (err)
 		return err;
@@ -517,19 +535,6 @@ static int ovl_copy_up_inode(struct ovl_
 		if (err)
 			return err;
 	}
-
-	if (S_ISREG(c->stat.mode) && !c->metacopy) {
-		struct path upperpath, datapath;
-
-		ovl_path_upper(c->dentry, &upperpath);
-		BUG_ON(upperpath.dentry != NULL);
-		upperpath.dentry = temp;
-
-		ovl_path_lowerdata(c->dentry, &datapath);
-		err = ovl_copy_up_data(&datapath, &upperpath, c->stat.size);
-		if (err)
-			return err;
-	}
 
 	if (c->metacopy) {
 		err = ovl_check_setxattr(c->dentry, temp, OVL_XATTR_METACOPY,


