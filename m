Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38DDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A920700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119248;
	bh=Zm2B1F/uU1HKxIqJj3bpcXBykbAxzVxXbPe7Q9uwm8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PPCY7sOkACoqh11d/rsJiOgvvm6KAbQ0KbVNtRtyitQ5iVBiVcX0SwzlsS9mQUiji
	 SrvjExaGAhTOH8+jv506owawc9HvVHfSlp62oxh4D7JjIaeVMpGGC4r8wsqeErY+U4
	 lk1rEoxQd5mhFNzLSr/HsHUrRLxNDGehOER9/GLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfJCQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388504AbfJCQOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:14:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3A12054F;
        Thu,  3 Oct 2019 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119244;
        bh=Zm2B1F/uU1HKxIqJj3bpcXBykbAxzVxXbPe7Q9uwm8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6NxIMTrcgvK0Z+LUC5fD4QYXWBMEIJKma1QkynENeWpJ0qWqfHQjmViIjykPMmoV
         0Fco4dG/tEdyDFR/56laGuE7hoKOT5e0LCzJtlTfIMAsvG7mVfJyoMk6eQqrgL8s/r
         kWXYo9ZbSgGLcbZO3HXWBEA9XK3ROHEwBBjhx9+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murphy Zhou <jencce.kernel@gmail.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.14 180/185] CIFS: fix max ea value size
Date:   Thu,  3 Oct 2019 17:54:18 +0200
Message-Id: <20191003154521.934504196@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murphy Zhou <jencce.kernel@gmail.com>

commit 63d37fb4ce5ae7bf1e58f906d1bf25f036fe79b2 upstream.

It should not be larger then the slab max buf size. If user
specifies a larger size, it passes this check and goes
straightly to SMB2_set_info_init performing an insecure memcpy.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -31,7 +31,7 @@
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
 
-#define MAX_EA_VALUE_SIZE 65535
+#define MAX_EA_VALUE_SIZE CIFSMaxBufSize
 #define CIFS_XATTR_CIFS_ACL "system.cifs_acl"
 #define CIFS_XATTR_ATTRIB "cifs.dosattrib"  /* full name: user.cifs.dosattrib */
 #define CIFS_XATTR_CREATETIME "cifs.creationtime"  /* user.cifs.creationtime */


