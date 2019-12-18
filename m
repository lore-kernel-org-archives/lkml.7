Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C08C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18965227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699796;
	bh=hyyMtYEKhxzSeADhWhVSPTwVw+0j/nVaT1nPanMj+j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ROK6QS9nH0HYyH9EHfI2gfNa5oNBwoUWKfcCECmlpYhBq0FJZ03NURb5VcH82YeTj
	 HLG4BrKOQDUeyLRgXMvkj2/2akZy6Hb7DAoqOvrN7xxZO85V5sPCiLGMAlKVtc7kTd
	 7enjt7/oTI9P+D3536ocUQUo7fG0xWladsG/o4co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLRUJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:09:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfLRUJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:09:50 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41EFE24672;
        Wed, 18 Dec 2019 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576699790;
        bh=hyyMtYEKhxzSeADhWhVSPTwVw+0j/nVaT1nPanMj+j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pw3vmYA+s18rEXrjuBlxEtKHDmWBLGot+yMUmzX1vltxYqXmdP9LE9ZXMnAONhUKI
         kAQRDgOKhw4WVPYJ5gR9KKQwDHyCmK5y0RxS3GK2CybT2lu2OxXVk/g9TO6wRM2KV4
         4aSZLiyzX+mSHDidM7Fy5kwFoplid5QqPTHO54Rg=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: free sysfs kobject
Date:   Wed, 18 Dec 2019 12:09:47 -0800
Message-Id: <20191218200947.20445-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
In-Reply-To: <20191218200947.20445-1-jaegeuk@kernel.org>
References: <20191218200947.20445-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detected kmemleak.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 70945ceb9c0c..5963316f391a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -786,4 +786,5 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
 }
-- 
2.24.0.525.g8f36a354ae-goog

