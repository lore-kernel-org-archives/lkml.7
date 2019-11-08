Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766BFFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4013A222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213639;
	bh=dBhYL/8fBTCGaEmqO7RyJD8piCm0z71coejeJpx+Kp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PsFL6OnPjbffbyCjzXPKraXKdJoI9kVu/hcWVvOfUpSR54o5/1XaEhFU+qXGE/2mN
	 fwmGLi6UbDsXRKz4KnxBZsxw81jJt55oIJXKg0IkBJ00xSQy6oGzDzyOF8xLDZASTy
	 9HbgSphzg26pNR39qYOCz+WruvDPirvW4IQ2+RSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391529AbfKHLrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391512AbfKHLrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:47:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78F32245A;
        Fri,  8 Nov 2019 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213634;
        bh=dBhYL/8fBTCGaEmqO7RyJD8piCm0z71coejeJpx+Kp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGhI5DcKIVqKZBJrHuER7PTTfuTSmgFd9mrMGYyxk/+C9jRYxkme3nP1QwQjYl2Y5
         iKGqkGxv4eyb2en9eq5LwcGWxaJ6aTuXE3U/8ZE1C448jc40RY0rZrcXUkTqINiWQ0
         lRpJoak3A/YO9z00YOEsYwO58vD+DSGBA+tIYzmA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 61/64] kernfs: Fix range checks in kernfs_get_target_path
Date:   Fri,  8 Nov 2019 06:45:42 -0500
Message-Id: <20191108114545.15351-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernd Edlinger <bernd.edlinger@hotmail.de>

[ Upstream commit a75e78f21f9ad4b810868c89dbbabcc3931591ca ]

The terminating NUL byte is only there because the buffer is
allocated with kzalloc(PAGE_SIZE, GFP_KERNEL), but since the
range-check is off-by-one, and PAGE_SIZE==PATH_MAX, the
returned string may not be zero-terminated if it is exactly
PATH_MAX characters long.  Furthermore also the initial loop
may theoretically exceed PATH_MAX and cause a fault.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/symlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 80317b04c84a2..e431a850f2f2b 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -63,6 +63,9 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 		if (base == kn)
 			break;
 
+		if ((s - path) + 3 >= PATH_MAX)
+			return -ENAMETOOLONG;
+
 		strcpy(s, "../");
 		s += 3;
 		base = base->parent;
@@ -79,7 +82,7 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 	if (len < 2)
 		return -EINVAL;
 	len--;
-	if ((s - path) + len > PATH_MAX)
+	if ((s - path) + len >= PATH_MAX)
 		return -ENAMETOOLONG;
 
 	/* reverse fillup of target string from target to base */
-- 
2.20.1

