Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC83821670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624942;
	bh=dvAnglenaAPPEDdrNg0L+1ChK2siq9KNAMIzym/7tvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvxo/kBt97+Zqjj0WSXv0Ussd+jHYerb58G18RKpNFFZ2sYYD58muCr3iKDLDdfRO
	 NWejMJeW7wd/l5d96WlQDwvnC6bxun2Q3XNUln0g+nbfRXhZw+qN10eGIT476scHaB
	 0EAyfPFpklQ7TxL1P13GxJd5biC0ux/ElS+ku26k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfD3LtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbfD3Lsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:48:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9683A20449;
        Tue, 30 Apr 2019 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624934;
        bh=dvAnglenaAPPEDdrNg0L+1ChK2siq9KNAMIzym/7tvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cjmt9FTkaymuKw/cF4wfVQ4YLFebqQquqij+6EqCeNP15Q32GEUZesiV/sHxeFBEN
         GtL1Ofq24PgL7ImbmVqEZOg+q//JQ63pJLGb7nNogYCwfrJO6pvomzs/wDsQ5hBNzq
         9WNjYim6lujACTP/1iA4FBzlg3sYghl4rEbyT0Do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.0 28/89] ceph: ensure d_name stability in ceph_dentry_hash()
Date:   Tue, 30 Apr 2019 13:38:19 +0200
Message-Id: <20190430113611.284744685@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 76a495d666e5043ffc315695f8241f5e94a98849 upstream.

Take the d_lock here to ensure that d_name doesn't change.

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/dir.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1470,6 +1470,7 @@ void ceph_dentry_lru_del(struct dentry *
 unsigned ceph_dentry_hash(struct inode *dir, struct dentry *dn)
 {
 	struct ceph_inode_info *dci = ceph_inode(dir);
+	unsigned hash;
 
 	switch (dci->i_dir_layout.dl_dir_hash) {
 	case 0:	/* for backward compat */
@@ -1477,8 +1478,11 @@ unsigned ceph_dentry_hash(struct inode *
 		return dn->d_name.hash;
 
 	default:
-		return ceph_str_hash(dci->i_dir_layout.dl_dir_hash,
+		spin_lock(&dn->d_lock);
+		hash = ceph_str_hash(dci->i_dir_layout.dl_dir_hash,
 				     dn->d_name.name, dn->d_name.len);
+		spin_unlock(&dn->d_lock);
+		return hash;
 	}
 }
 


