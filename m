Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED986C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEBA20862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557718384;
	bh=ET/nxc5T3hS4xHiJQN6H+m33XGRL+rwCE0JPxplu9mA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YVsDIU/rBfQevaSuHcxs/cm3N3lNs1Fmo2t9SUjRUY2Od1OBogdRuaYchSE1w1Tqk
	 skUHdeJaGTEcxY6mRcCOIzwtxqxy4/R8SqQMr/pP1hZX+gKnISaxzjb2UsTDUXfMPI
	 GDvNQ9+jZU+H4xV9uRcAC2MRV3V1noAyiUDIXhEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEMDdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 23:33:03 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46719 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfEMDdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:33:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 487102210C;
        Sun, 12 May 2019 23:33:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 12 May 2019 23:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KzQDTRHUGlP2t4118
        hjOq4x8DiBylDCwEn5gHvNCjD4=; b=fkWp6iAzsSQSLc1i5Vt20o71uCRAw931S
        1rkWHLSc6OSAfxLci18Ey+KOcDQB6oa+7tEC/0T2eXrQtSfY/buih4LWmGNsSQWm
        ALlraB9fYXjpymF9G1ha/E5L0zstBRH1ZJxHIHkiVhdnF1coESdFHmyF14jeb8lI
        F9hFrqztt6SLL8snC8u7b+/Qf6fu/UyPkz1TgGOsrQhsHTiD55aslyou6Brs9Q0f
        lKKTQYcxv1wDQ8vxap2/O87kOyKaxQ/yyhMxubsTKIGoO6YE1hpMA15X+8ilv3lR
        OzTPOd4KDWK+G9K06g0k07UJxlNeDa0IRPMCkel9EuNfIVMpmrOrw==
X-ME-Sender: <xms:beXYXIJv06QHrKsKULbDulmA5aKXgSoWdhUcbGynL5LwA7ol4S03nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleefgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvgedrudeiledrudeirddukeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:beXYXDSvgPBSeHFltfTu7RA--qVJvRN3dGnNfzi65w2l6xbS6vs6og>
    <xmx:beXYXPH30DI3NeIHfAgDJCpTehoF2TYRvcug5_HbmAay37GFk7Q5Yw>
    <xmx:beXYXAUIezQNS_6vJhp_uVefjTRgeGXHsopl6TW7bL7E4yWgy-JRhQ>
    <xmx:buXYXCrZfw_kxckadxokm1vaDiyapIWTW3pTkQlaP5wf9OaePYJ2KA>
Received: from eros.localdomain (124-169-16-185.dyn.iinet.net.au [124.169.16.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE4F910378;
        Sun, 12 May 2019 23:32:58 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Fix error path kobject memory leak
Date:   Mon, 13 May 2019 13:32:13 +1000
Message-Id: <20190513033213.2468-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a call to kobject_init_and_add() fails we must call kobject_put()
otherwise we leak memory.

Function always calls kobject_init_and_add() which always calls
kobject_init().

It is safe to leave object destruction up to the kobject release
function and never free it manually.

Remove call to kfree() and always call kobject_put() in the error path.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

Is it ok to send patches during the merge window?

Applies on top of Linus' mainline tag: v5.1

Happy to rebase if there are conflicts.

thanks,
Tobin.

 fs/gfs2/sys.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 1787d295834e..98586b139386 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -661,8 +661,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 	if (error)
 		goto fail_reg;
 
-	sysfs_frees_sdp = 1; /* Freeing sdp is now done by sysfs calling
-				function gfs2_sbd_release. */
 	error = sysfs_create_group(&sdp->sd_kobj, &tune_group);
 	if (error)
 		goto fail_reg;
@@ -687,10 +685,7 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 fail_reg:
 	free_percpu(sdp->sd_lkstats);
 	fs_err(sdp, "error %d adding sysfs files\n", error);
-	if (sysfs_frees_sdp)
-		kobject_put(&sdp->sd_kobj);
-	else
-		kfree(sdp);
+	kobject_put(&sdp->sd_kobj);
 	sb->s_fs_info = NULL;
 	return error;
 }
-- 
2.21.0

