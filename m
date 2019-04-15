Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EED3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C5320880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355326;
	bh=alvu8yXsL40D3/oWrozhqoH3ZUKn3MO5ypKF9biZPuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHvRYdfyG2rEdZP4bHfTOWFgjZIQRYjwPu1Lah4KnXdIy9OX+ilu36RzCWdwb38Sl
	 zLz/ASewafpnCNOU0+INKZvYe3LEE0IIM50xarz/YdOlZRNO1wnYrTnea//22E9pqI
	 WnCppEWlb7VanEJC2QsC6MBw96dDkqmwePFamVUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfDOTIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfDOTIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D981B2087C;
        Mon, 15 Apr 2019 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355320;
        bh=alvu8yXsL40D3/oWrozhqoH3ZUKn3MO5ypKF9biZPuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJBXVNmrNiQeLQySI254PT9pHm8Iu4zE99u6/9y4dxkAsqu+1Z/Hmogm9gBSeh8Ti
         0XVEPy3exzz7LMUzmoJNfMcYwuwOAlWjv5zaw7KNANu9lj0JI7P2t37k3ipb2wEuPJ
         e+c8xA6G4Wkpj6pWI21X8JrTZ40LOK7/qINkUDlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 094/101] dm: revert 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE")
Date:   Mon, 15 Apr 2019 20:59:32 +0200
Message-Id: <20190415183745.344840516@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 75ae193626de3238ca5fb895868ec91c94e63b1b upstream.

The limit was already incorporated to dm-crypt with commit 4e870e948fba
("dm crypt: fix error with too large bios"), so we don't need to apply
it globally to all targets. The quantity BIO_MAX_PAGES * PAGE_SIZE is
wrong anyway because the variable ti->max_io_len it is supposed to be in
the units of 512-byte sectors not in bytes.

Reduction of the limit to 1048576 sectors could even cause data
corruption in rare cases - suppose that we have a dm-striped device with
stripe size 768MiB. The target will call dm_set_target_max_io_len with
the value 1572864. The buggy code would reduce it to 1048576. Now, the
dm-core will errorneously split the bios on 1048576-sector boundary
insetad of 1572864-sector boundary and pass these stripe-crossing bios
to the striped target.

Cc: stable@vger.kernel.org # v4.16+
Fixes: 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1007,15 +1007,7 @@ int dm_set_target_max_io_len(struct dm_t
 		return -EINVAL;
 	}
 
-	/*
-	 * BIO based queue uses its own splitting. When multipage bvecs
-	 * is switched on, size of the incoming bio may be too big to
-	 * be handled in some targets, such as crypt.
-	 *
-	 * When these targets are ready for the big bio, we can remove
-	 * the limit.
-	 */
-	ti->max_io_len = min_t(uint32_t, len, BIO_MAX_PAGES * PAGE_SIZE);
+	ti->max_io_len = (uint32_t) len;
 
 	return 0;
 }


