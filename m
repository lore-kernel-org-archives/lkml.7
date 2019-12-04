Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FBAC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355E1215E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482943;
	bh=Bem4WhKsnLL+Ib474HsvJfup41+lAtVmwSQHdCk7+NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pa/ZGAE+eoy/yeKOnhxhR6dlW+8j6+1XK64LgcOocGQvGRlUczF6IvhRH6QOrHaN4
	 pewfItdItkuHyg9Ezk38SN9w5KI13/cHoEZQ5QOf9rkQg9X5SM3T7zIoLHjfKlr9a2
	 CS8VkuIT9W5XMyJU60eY0XqoSr1lcaAi/Z6n7Ozk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfLDSJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730966AbfLDSIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:08:51 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0989620674;
        Wed,  4 Dec 2019 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482930;
        bh=Bem4WhKsnLL+Ib474HsvJfup41+lAtVmwSQHdCk7+NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/791GsZ5k/T3+/fMliJsn0PT0rYlZPvR1J+s+ZHi41X61OmQoB+LRxWeQGDaFknB
         641AVV96jc70W5vCQVQWZ+0GSw5hW8DjzVNYcRQEmmcCRyDIINJeOhFb+kj5/5TSsN
         iZocjRIhsf+fJJH1w+ZmYvGeCPF3jZ6uXJ/tXTEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Coulson <chris.coulson@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 148/209] apparmor: delete the dentry in aafs_remove() to avoid a leak
Date:   Wed,  4 Dec 2019 18:56:00 +0100
Message-Id: <20191204175333.701301646@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Coulson <chris.coulson@canonical.com>

[ Upstream commit 201218e4d3dfa1346e30997f48725acce3f26d01 ]

Although the apparmorfs dentries are always dropped from the dentry cache
when the usage count drops to zero, there is no guarantee that this will
happen in aafs_remove(), as another thread might still be using it. In
this scenario, this means that the dentry will temporarily continue to
appear in the results of lookups, even after the call to aafs_remove().

In the case of removal of a profile - it also causes simple_rmdir()
on the profile directory to fail, as the directory won't be empty until
the usage counts of all child dentries have decreased to zero. This
results in the dentry for the profile directory leaking and appearing
empty in the file system tree forever.

Signed-off-by: Chris Coulson <chris.coulson@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index dd746bd69a9b2..c106988c1b254 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -363,6 +363,7 @@ static void aafs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.20.1



