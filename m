Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32794217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892696;
	bh=tpTGIhEqxp+KBGaDmFcATKiHYBPcEXPJInHvTwLE9V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zzv9S1x2y+anbh48JVg7xrpyuMRcbfeeP5w4f5l3d5+npPeQICQk9lIS4UTa2A1lA
	 b/+ky82Ol5GNOj6PmhInAz7emImscTt/BJQKBLhzSjYLMV/DAhRl3L89XHfEon3JHU
	 K5RTY/BneqBJoO8Znq/LAWgU1dfp5Z9GQu8IOC3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfH0H6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbfH0H6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:58:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6723720828;
        Tue, 27 Aug 2019 07:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892686;
        bh=tpTGIhEqxp+KBGaDmFcATKiHYBPcEXPJInHvTwLE9V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CccCQxZCTrYk8I2ZjEUMThGYwfsnSf6qOQQ1Mb7AcdOq7ZcYKQo1PF4uGhpW4/v5Q
         47EUdOEGYQvawoLdIWFA2ZwvjKqO+d1YwIZqlTCUDBL9+lhWRYq+WVphtbANiEtQzl
         HIid7JRObAjiq5jglJLx6nq8Z5LcYHfSA+0WIETo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 78/98] dm raid: add missing cleanup in raid_ctr()
Date:   Tue, 27 Aug 2019 09:50:57 +0200
Message-Id: <20190827072722.218327181@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
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
@@ -3199,7 +3199,7 @@ static int raid_ctr(struct dm_target *ti
 			  */
 			r = rs_prepare_reshape(rs);
 			if (r)
-				return r;
+				goto bad;
 
 			/* Reshaping ain't recovery, so disable recovery */
 			rs_setup_recovery(rs, MaxSector);


