Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1645C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DD92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355716;
	bh=BcNvGjFBZ+Y8wDYg0lU0haPKSLlVNuMeOWSxsvhXEW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vtxTXTFk2eas+ch43iaeLz7wsRfgja+ZM9Ejp9ds0s8FXira6XaPXIrAQqXIHgxbH
	 1xbSbYR71zxiIlRL19WjHBqxzx23OWwFwNIzqOQE0UbD/hZK9611D8W4GEV9gYER7O
	 ER6kwPtNk7gSFOc6w7xATH3qDcPL8izyomzKWbk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfDOTPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbfDOTOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C82218FC;
        Mon, 15 Apr 2019 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355658;
        bh=BcNvGjFBZ+Y8wDYg0lU0haPKSLlVNuMeOWSxsvhXEW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByaIu3i4uMwsP5ADSQ/Sdgxqzus+zSbfsZWkBFCZS8hqx2nu00XMRmin3sDe3rGh+
         W9yOXsvbfLM6Dw2HTmKOwpJY2z2ofaU1P3N111e8eA2eQDox+kOV9ccr/8Ag96gCLE
         nsaU9+v+7qbonXAkXkN9fQHCZBig6X/wEiFuxsuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.0 111/117] dm: revert 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE")
Date:   Mon, 15 Apr 2019 21:01:21 +0200
Message-Id: <20190415183750.396263755@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
@@ -1060,15 +1060,7 @@ int dm_set_target_max_io_len(struct dm_t
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


