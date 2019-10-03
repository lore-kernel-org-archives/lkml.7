Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6236AC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B24C2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121678;
	bh=Zm2B1F/uU1HKxIqJj3bpcXBykbAxzVxXbPe7Q9uwm8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1Ud3ZwjLRP0ewNMh/NTJchoN6cEiKdq+tqTIy4xBOJpbdLAUmsMFYfHHsmCQyrG9
	 yQO4ehoZUdsz7M8hTsmgO+faEd9mOWuN2Jyqw8ClkgTg8Q1NCKNKQwfnlaQTUrmPlC
	 r2QvvWE+ecvU1IO7TQxUE7iTiFKD0OaNp9Ak2jdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406338AbfJCQxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406289AbfJCQxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:53:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57A320862;
        Thu,  3 Oct 2019 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121593;
        bh=Zm2B1F/uU1HKxIqJj3bpcXBykbAxzVxXbPe7Q9uwm8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPAs0EwLkl98Hy5RmrQC1jtZRJgoNfr4a4uTwSyZOtWkdW/3YYVztQ653T3m1l94L
         gaddYfeivQeia3Uatw3RsTignSjH1t7fFr4FpxzfkkfluSBLQ/uoYbf1E9ncS5Y37l
         SMeDxQF0CzsJSWyIbOfGiYVty4w5OB09/XXsmnj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murphy Zhou <jencce.kernel@gmail.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.3 335/344] CIFS: fix max ea value size
Date:   Thu,  3 Oct 2019 17:55:00 +0200
Message-Id: <20191003154611.681278704@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
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


