Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F54FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B0921738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709737;
	bh=A5Qd/qoQDq+puJoe7DKuMyx5lfK7yWeS+7/3jmBGLnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oGG4wRwwlD4tjX+fXTMlxdY2cV9eX4ZM1b35VMn7DGWqhPPDLMh0pP+JpsjHqe8KO
	 4fV6VIQ8INMwvR38COimgBl38eJkHqyH0wQXgVTN2gjjlueLsgRE4BgwisIG7RmtwQ
	 sEV70bpI5cAQyCS3adYQXejZJNRnmBoPEBlUF9JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfC0SCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbfC0SCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0201221741;
        Wed, 27 Mar 2019 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709732;
        bh=A5Qd/qoQDq+puJoe7DKuMyx5lfK7yWeS+7/3jmBGLnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAQk6rQO5ApziWCLxxZKKNb7PoTFsDbT6tubegvA0fL+AaIhl5kKEoRLAF+oBvt8u
         nfSrj8SGaEfUdRwEkCPXrYW+nASAjxpiJFfvukvg1xydKMWT4Jqyu37eGEaqlmdNuz
         iV7aFGv/ZmjTHBkG5sFHrKnsJ99ooemsbjdKsSHI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 010/262] apparmor: fix double free when unpack of secmark rules fails
Date:   Wed, 27 Mar 2019 13:57:45 -0400
Message-Id: <20190327180158.10245-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit d8dbb581d4f86a2ac669c056fc71a28ebeb367f4 ]

if secmark rules fail to unpack a double free happens resulting in
the following oops

[ 1295.584074] audit: type=1400 audit(1549970525.256:51): apparmor="STATUS" info="failed to unpack profile secmark rules" error=-71 profile="unconfined" name="/root/test" pid=29882 comm="apparmor_parser" name="/root/test" offset=120
[ 1374.042334] ------------[ cut here ]------------
[ 1374.042336] kernel BUG at mm/slub.c:294!
[ 1374.042404] invalid opcode: 0000 [#1] SMP PTI
[ 1374.042436] CPU: 0 PID: 29921 Comm: apparmor_parser Not tainted 4.20.7-042007-generic #201902061234
[ 1374.042461] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[ 1374.042489] RIP: 0010:kfree+0x164/0x180
[ 1374.042502] Code: 74 05 41 0f b6 72 51 4c 89 d7 e8 37 cd f8 ff eb 8b 41 b8 01 00 00 00 48 89 d9 48 89 da 4c 89 d6 e8 11 f6 ff ff e9 72 ff ff ff <0f> 0b 49 8b 42 08 a8 01 75 c2 0f 0b 48 8b 3d a9 f4 19 01 e9 c5 fe
[ 1374.042552] RSP: 0018:ffffaf7b812d7b90 EFLAGS: 00010246
[ 1374.042568] RAX: ffff91e437679200 RBX: ffff91e437679200 RCX: ffff91e437679200
[ 1374.042589] RDX: 00000000000088b6 RSI: ffff91e43da27060 RDI: ffff91e43d401a80
[ 1374.042609] RBP: ffffaf7b812d7ba8 R08: 0000000000027080 R09: ffffffffa6627a6d
[ 1374.042629] R10: ffffd3af41dd9e40 R11: ffff91e43a1740dc R12: ffff91e3f52e8000
[ 1374.042650] R13: ffffffffa6627a6d R14: ffffffffffffffb9 R15: 0000000000000001
[ 1374.042675] FS:  00007f928df77740(0000) GS:ffff91e43da00000(0000) knlGS:0000000000000000
[ 1374.042697] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1374.042714] CR2: 000055a0c3ab6b50 CR3: 0000000079ed8004 CR4: 0000000000360ef0
[ 1374.042737] Call Trace:
[ 1374.042750]  kzfree+0x2d/0x40
[ 1374.042763]  aa_free_profile+0x12b/0x270
[ 1374.042776]  unpack_profile+0xc1/0xf10
[ 1374.042790]  aa_unpack+0x115/0x4e0
[ 1374.042802]  aa_replace_profiles+0x8e/0xcc0
[ 1374.042817]  ? kvmalloc_node+0x6d/0x80
[ 1374.042831]  ? __check_object_size+0x166/0x192
[ 1374.042845]  policy_update+0xcf/0x1b0
[ 1374.042858]  profile_load+0x7d/0xa0
[ 1374.042871]  __vfs_write+0x3a/0x190
[ 1374.042883]  ? apparmor_file_permission+0x1a/0x20
[ 1374.042899]  ? security_file_permission+0x31/0xc0
[ 1374.042918]  ? _cond_resched+0x19/0x30
[ 1374.042931]  vfs_write+0xab/0x1b0
[ 1374.042963]  ksys_write+0x55/0xc0
[ 1374.043004]  __x64_sys_write+0x1a/0x20
[ 1374.043046]  do_syscall_64+0x5a/0x110
[ 1374.043087]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 9caafbe2b4cf ("apparmor: Parse secmark policy")
Reported-by: Alex Murray <alex.murray@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy_unpack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 379682e2a8d5..f6c2bcb2ab14 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -579,6 +579,7 @@ static bool unpack_secmark(struct aa_ext *e, struct aa_profile *profile)
 			kfree(profile->secmark[i].label);
 		kfree(profile->secmark);
 		profile->secmark_count = 0;
+		profile->secmark = NULL;
 	}
 
 	e->pos = pos;
-- 
2.19.1

