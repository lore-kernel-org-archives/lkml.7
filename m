Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D47E2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893160;
	bh=tTrZxMYoqC07ZPrlgKy4JgO054yo/Agsz0/dz95U5iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmyiLsXkaaJ4pNPlE4TkgLJ5+tXS3TJAyihBis7Udm14S7WoUFygQenaRRjbSgdq7
	 ah0Xh7fTCCkVEPmbY9a0D7vctlVu/kDL1dmj2TiIMmqSM6gVD0DLIlYHtZQZyKvQn2
	 OgGsIeIFlxruJM0V4HUemajhupmL2Oks0UFHaVF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbfH0IF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731751AbfH0IF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:05:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C03E22173E;
        Tue, 27 Aug 2019 08:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893157;
        bh=tTrZxMYoqC07ZPrlgKy4JgO054yo/Agsz0/dz95U5iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAb+pU9vQelOd6L8yQI6EE9maUcUZd/HCKB1MO3y4zSpqK4hTqDj6vgzCvJJtXivf
         ouSbSD/GOg+27nYNvSeRzC68Yl5HrRuaRUUvbxavI1Tw0JW1o2v/L8P3ODIjXKmHsX
         V570hehXexKCH7Qz3YnTjsMTlCnAoA199CFWI4+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.2 139/162] dm raid: add missing cleanup in raid_ctr()
Date:   Tue, 27 Aug 2019 09:51:07 +0200
Message-Id: <20190827072743.469175217@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit dc1a3e8e0cc6b2293b48c044710e63395aeb4fb4 upstream.

If rs_prepare_reshape() fails, no cleanup is executed, leading to
leak of the raid_set structure allocated at the beginning of
raid_ctr(). To fix this issue, go to the label 'bad' if the error
occurs.

Fixes: 11e4723206683 ("dm raid: stop keeping raid set frozen altogether")
Cc: stable@vger.kernel.org
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-raid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3194,7 +3194,7 @@ static int raid_ctr(struct dm_target *ti
 			  */
 			r = rs_prepare_reshape(rs);
 			if (r)
-				return r;
+				goto bad;
 
 			/* Reshaping ain't recovery, so disable recovery */
 			rs_setup_recovery(rs, MaxSector);


