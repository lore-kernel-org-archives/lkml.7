Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5242C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A533F20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640744;
	bh=7uXs0Hd9BHczWfI9QjqAQuZuSbC0kbYMC9PdSh6KVRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A0AoZdUqPB3Epg3sNMKoTN5FiuISML5tOEcOKiE7i4c70rC6p2cCWS6PKQV/ltkS4
	 YNqokY32QhkQ8SbLaT+ZnKOQ5P4KPUJAL15bscAel1NAQXFZy5/lo48sgcda3aJDY6
	 NhgmecaHEPShrasBYdSjj5N6SjyJ3ted2rTeolNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbfEWTPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388918AbfEWTPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:15:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60ED520863;
        Thu, 23 May 2019 19:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638913;
        bh=7uXs0Hd9BHczWfI9QjqAQuZuSbC0kbYMC9PdSh6KVRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGV2yy0J2vzn1OWzGb6Q27/X9N4UIyh43rXAe2m65Paxhap+ODSUvE/tGrWcuABD/
         XZ2XfwL/rOmPKJpBqt1dx/z+dOLHmoMUUHXIfCQnnkLasHzpNggDFyc8+dpMhdYxW5
         gs9HkXWlsV4KTQjcpNQmsBj62/OkJryRRtT55HaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        NeilBrown <neilb@suse.com>, Yufen Yu <yuyufen@huawei.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.19 027/114] md: add mddev->pers to avoid potential NULL pointer dereference
Date:   Thu, 23 May 2019 21:05:26 +0200
Message-Id: <20190523181734.327465301@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

commit ee37e62191a59d253fc916b9fc763deb777211e2 upstream.

When doing re-add, we need to ensure rdev->mddev->pers is not NULL,
which can avoid potential NULL pointer derefence in fallowing
add_bound_rdev().

Fixes: a6da4ef85cef ("md: re-add a failed disk")
Cc: Xiao Ni <xni@redhat.com>
Cc: NeilBrown <neilb@suse.com>
Cc: <stable@vger.kernel.org> # 4.4+
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2860,8 +2860,10 @@ state_store(struct md_rdev *rdev, const
 			err = 0;
 		}
 	} else if (cmd_match(buf, "re-add")) {
-		if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1) &&
-			rdev->saved_raid_disk >= 0) {
+		if (!rdev->mddev->pers)
+			err = -EINVAL;
+		else if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1) &&
+				rdev->saved_raid_disk >= 0) {
 			/* clear_bit is performed _after_ all the devices
 			 * have their local Faulty bit cleared. If any writes
 			 * happen in the meantime in the local node, they


