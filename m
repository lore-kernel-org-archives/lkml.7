Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EC3C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2220D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639954;
	bh=r0zyQ/B7KH52Fb9qpYaua23yoj2J/TXEHxufZ/7v2fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qc+lXUD/LFMd71JncjEc+NHEcew70EiACJsXyq18zxdMXJy905+pHLvyvgUXY9vH2
	 WE1A9cBtV/QGlWz73HMvzcLCyXcO8NclBB3LMG7uQUkG4H1O1KxLTSkixsXqmHg2zt
	 PLwrihoxq9E41Je9pK6+H3k9OLuerzUsEHdorGTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403789AbfEWTak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403764AbfEWTae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:30:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CDE2133D;
        Thu, 23 May 2019 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639834;
        bh=r0zyQ/B7KH52Fb9qpYaua23yoj2J/TXEHxufZ/7v2fs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrpGWd0vzsnJwcNNJH+LVDx3FFMO05BvI3AVjkDcYXhl2v/93FDu6qq8beP8vSXjd
         IBVW0g8q9nA4iLPWWbBM/dJBZENEHtT0sXDav+FCLCYxkqhcAsNOXq/rj5A2Y/CKOh
         5AqWtx67zdsNfHsDcIrpKFSmT+SbJ3Jc8xFGMSY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Martin Wilck <mwilck@suse.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.1 109/122] dm mpath: always free attached_handler_name in parse_path()
Date:   Thu, 23 May 2019 21:07:11 +0200
Message-Id: <20190523181719.848604177@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

commit 940bc471780b004a5277c1931f52af363c2fc9da upstream.

Commit b592211c33f7 ("dm mpath: fix attached_handler_name leak and
dangling hw_handler_name pointer") fixed a memory leak for the case
where setup_scsi_dh() returns failure. But setup_scsi_dh may return
success and not "use" attached_handler_name if the
retain_attached_hwhandler flag is not set on the map. As setup_scsi_sh
properly "steals" the pointer by nullifying it, freeing it
unconditionally in parse_path() is safe.

Fixes: b592211c33f7 ("dm mpath: fix attached_handler_name leak and dangling hw_handler_name pointer")
Cc: stable@vger.kernel.org
Reported-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-mpath.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -882,6 +882,7 @@ static struct pgpath *parse_path(struct
 	if (attached_handler_name || m->hw_handler_name) {
 		INIT_DELAYED_WORK(&p->activate_path, activate_path_work);
 		r = setup_scsi_dh(p->path.dev->bdev, m, &attached_handler_name, &ti->error);
+		kfree(attached_handler_name);
 		if (r) {
 			dm_put_device(ti, p->path.dev);
 			goto bad;
@@ -896,7 +897,6 @@ static struct pgpath *parse_path(struct
 
 	return p;
  bad:
-	kfree(attached_handler_name);
 	free_pgpath(p);
 	return ERR_PTR(r);
 }


