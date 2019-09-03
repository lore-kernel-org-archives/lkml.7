Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23E2215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528077;
	bh=krAUKclN5zuG1oCarZQF52J+e248ke7MQqKEOMq6egk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ojm7jl/SBBXduZh2NsGk56ykOWyrej0J72mpJ3ywvRUu1R9BR4KqoG55YdSFV4gi0
	 2SHl9Ed+t8Mnh/bD2RuWw+IHNdKev17qcfeo6frUANH5n1O3Wrdbm/D9O3BHViQask
	 cGW2bysyTYtDbYQJ29j1wvKgO2lAqjvMqC+dfw9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfICQ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfICQ1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:27:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701D3238C6;
        Tue,  3 Sep 2019 16:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528069;
        bh=krAUKclN5zuG1oCarZQF52J+e248ke7MQqKEOMq6egk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS7PmZ9YH8yfjYHHeRe+aV4VqFPg6QQxiyde4g/BbA6OQdZ9DvvN6RYooZUsa54DW
         9C9r6o+dPk5AKQPQWkNmv3WKIaW5KZ/WD1Df8DOBX6FVSOvhi3TMDbkOB6XsH++ve3
         LFFk7xJAbmp92sqmE2sATw+plEpSWPJdO5z+tVO8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 083/167] drm: add __user attribute to ptr_to_compat()
Date:   Tue,  3 Sep 2019 12:23:55 -0400
Message-Id: <20190903162519.7136-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit e552f0851070fe4975d610a99910be4e9bf5d7bd ]

The ptr_to_compat() call takes a "void __user *", so cast
the compat drm calls that use it to avoid the following
warnings from sparse:

drivers/gpu/drm/drm_ioc32.c:188:39: warning: incorrect type in argument 1 (different address spaces)
drivers/gpu/drm/drm_ioc32.c:188:39:    expected void [noderef] <asn:1>*uptr
drivers/gpu/drm/drm_ioc32.c:188:39:    got void *[addressable] [assigned] handle
drivers/gpu/drm/drm_ioc32.c:529:41: warning: incorrect type in argument 1 (different address spaces)
drivers/gpu/drm/drm_ioc32.c:529:41:    expected void [noderef] <asn:1>*uptr
drivers/gpu/drm/drm_ioc32.c:529:41:    got void *[addressable] [assigned] handle

Cc: stable@vger.kernel.org
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190301120046.26961-1-ben.dooks@codethink.co.uk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_ioc32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
index 138680b37c709..f8672238d444b 100644
--- a/drivers/gpu/drm/drm_ioc32.c
+++ b/drivers/gpu/drm/drm_ioc32.c
@@ -185,7 +185,7 @@ static int compat_drm_getmap(struct file *file, unsigned int cmd,
 	m32.size = map.size;
 	m32.type = map.type;
 	m32.flags = map.flags;
-	m32.handle = ptr_to_compat(map.handle);
+	m32.handle = ptr_to_compat((void __user *)map.handle);
 	m32.mtrr = map.mtrr;
 	if (copy_to_user(argp, &m32, sizeof(m32)))
 		return -EFAULT;
@@ -216,7 +216,7 @@ static int compat_drm_addmap(struct file *file, unsigned int cmd,
 
 	m32.offset = map.offset;
 	m32.mtrr = map.mtrr;
-	m32.handle = ptr_to_compat(map.handle);
+	m32.handle = ptr_to_compat((void __user *)map.handle);
 	if (map.handle != compat_ptr(m32.handle))
 		pr_err_ratelimited("compat_drm_addmap truncated handle %p for type %d offset %x\n",
 				   map.handle, m32.type, m32.offset);
@@ -529,7 +529,7 @@ static int compat_drm_getsareactx(struct file *file, unsigned int cmd,
 	if (err)
 		return err;
 
-	req32.handle = ptr_to_compat(req.handle);
+	req32.handle = ptr_to_compat((void __user *)req.handle);
 	if (copy_to_user(argp, &req32, sizeof(req32)))
 		return -EFAULT;
 
-- 
2.20.1

