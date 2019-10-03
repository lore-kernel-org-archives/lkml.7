Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7836DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414E520830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122957;
	bh=SAVbqIJhRYHkOPmJ45qk1R9z0FcxOwplAbdfGkY42Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y/80698Dbq8/xe0rg49HBzipakOHMfd4wjXfj/VvNAXuQaCp4lAQ3fFcSWVMuQup/
	 MAfdQwUczZANrw2hnMXL5R/bgc9T8aoKC3akg2BzqfaBM3GxjBsBb0fjXZsClrUJG/
	 R3fz4FY0U9WvWy5qwehTVw5xhcO8EOB+024lf4dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390877AbfJCQZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390430AbfJCQXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:23:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F5320867;
        Thu,  3 Oct 2019 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119780;
        bh=SAVbqIJhRYHkOPmJ45qk1R9z0FcxOwplAbdfGkY42Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yAEDHAFZwWkyOIuUE8SlvXNkDQkskt5PKaHiD0K/rqOUiaJ4ql8NdC9HIDC/X+EYW
         v1ctPZCrdkza8I8QEFbk/+zFpAnSH+yUDfyJyF2jUEW4uHi4k8eC7gRvNHoSb1phu9
         ZRULjYBhRFp3JD77ncgQBd/nl+gyKmhfZ8FRNByI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 189/211] ovl: filter of trusted xattr results in audit
Date:   Thu,  3 Oct 2019 17:54:15 +0200
Message-Id: <20191003154528.368762802@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Salyzyn <salyzyn@android.com>

commit 5c2e9f346b815841f9bed6029ebcb06415caf640 upstream.

When filtering xattr list for reading, presence of trusted xattr
results in a security audit log.  However, if there is other content
no errno will be set, and if there isn't, the errno will be -ENODATA
and not -EPERM as is usually associated with a lack of capability.
The check does not block the request to list the xattrs present.

Switch to ns_capable_noaudit to reflect a more appropriate check.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org # v3.18+
Fixes: a082c6f680da ("ovl: filter trusted xattr for non-admin")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -386,7 +386,8 @@ static bool ovl_can_list(const char *s)
 		return true;
 
 	/* Never list trusted.overlay, list other trusted for superuser only */
-	return !ovl_is_private_xattr(s) && capable(CAP_SYS_ADMIN);
+	return !ovl_is_private_xattr(s) &&
+	       ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 }
 
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)


