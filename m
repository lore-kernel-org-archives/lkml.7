Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B981CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872D420657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369650;
	bh=qLtmZxOIUwmQ3bVozFsayBKqyio9E0zXMLnehJDRsK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYJBj0S1lGnmHIqHbGYVYKFNWC34a2PnejvnxWEXCmj4Et6M70NJRmIjpwMFmSpGI
	 NssDxiiPlzPU3OsUlMzyiSGMy3K/mmRdRI/h4/ZJSWe++K5NE04k3cik/3ltTUFJtw
	 eNVnhuK5QNJWOjQ0WJ/XwNZrZPHOJW2+lnqezlOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfDDJUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388184AbfDDJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50BD9214AF;
        Thu,  4 Apr 2019 09:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369438;
        bh=qLtmZxOIUwmQ3bVozFsayBKqyio9E0zXMLnehJDRsK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkeC4xszYy5H1N6jogqcl9v6KspvUSt05LewaRiWQIzDVCxvdvePYzDBLoJOFP2oX
         wfCzDKhU6JD4lJC1S16+6SAcrwiMiC2kltgpl28wWKrJmarYSNpGL9yFVjeJSQIAv6
         tBhq4jOuUSvRy7d2bjFRc3kJZr4UdSOvetnLMrAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sheng Yong <shengyong1@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 208/246] f2fs: UBSAN: set boolean value iostat_enable correctly
Date:   Thu,  4 Apr 2019 10:48:28 +0200
Message-Id: <20190404084626.473385133@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ac92985864e187a1735502f6a02f54eaa655b2aa ]

When setting /sys/fs/f2fs/<DEV>/iostat_enable with non-bool value, UBSAN
reports the following warning.

[ 7562.295484] ================================================================================
[ 7562.296531] UBSAN: Undefined behaviour in fs/f2fs/f2fs.h:2776:10
[ 7562.297651] load of value 64 is not a valid value for type '_Bool'
[ 7562.298642] CPU: 1 PID: 7487 Comm: dd Not tainted 4.20.0-rc4+ #79
[ 7562.298653] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[ 7562.298662] Call Trace:
[ 7562.298760]  dump_stack+0x46/0x5b
[ 7562.298811]  ubsan_epilogue+0x9/0x40
[ 7562.298830]  __ubsan_handle_load_invalid_value+0x72/0x90
[ 7562.298863]  f2fs_file_write_iter+0x29f/0x3f0
[ 7562.298905]  __vfs_write+0x115/0x160
[ 7562.298922]  vfs_write+0xa7/0x190
[ 7562.298934]  ksys_write+0x50/0xc0
[ 7562.298973]  do_syscall_64+0x4a/0xe0
[ 7562.298992]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 7562.299001] RIP: 0033:0x7fa45ec19c00
[ 7562.299004] Code: 73 01 c3 48 8b 0d 88 92 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d dd eb 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 24
[ 7562.299044] RSP: 002b:00007ffca52b49e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 7562.299052] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa45ec19c00
[ 7562.299059] RDX: 0000000000000400 RSI: 000000000093f000 RDI: 0000000000000001
[ 7562.299065] RBP: 000000000093f000 R08: 0000000000000004 R09: 0000000000000000
[ 7562.299071] R10: 00007ffca52b47b0 R11: 0000000000000246 R12: 0000000000000400
[ 7562.299077] R13: 000000000093f000 R14: 000000000093f400 R15: 0000000000000000
[ 7562.299091] ================================================================================

So, if iostat_enable is enabled, set its value as true.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 0575edbe3ed6..f1ab9000b294 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -278,10 +278,16 @@ out:
 		return count;
 	}
 
-	*ui = t;
 
-	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
-		f2fs_reset_iostat(sbi);
+	if (!strcmp(a->attr.name, "iostat_enable")) {
+		sbi->iostat_enable = !!t;
+		if (!sbi->iostat_enable)
+			f2fs_reset_iostat(sbi);
+		return count;
+	}
+
+	*ui = (unsigned int)t;
+
 	return count;
 }
 
-- 
2.19.1



