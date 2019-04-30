Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FDC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF1220449
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624619;
	bh=9pHvpcKgOX608CuYZV0lk0tPUwVrFtVe9H1Tma0SJGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLuLaAHTySx4nCPQSa0G+fN/CEBEGkAl04kCktQydixnfZx4x4H90jeaKUAz85e/7
	 ZpuSJuZ59/+adVK5VF9j2ENzbhJDhAqcvp9CWLfo2NKdjcb/QkmTaN95/Fp3BkeQJR
	 qzZp2diPh/bA8bROka8kdORGxpnZIIA8OqDGH3h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfD3Lnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfD3Lnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:43:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA8521670;
        Tue, 30 Apr 2019 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624612;
        bh=9pHvpcKgOX608CuYZV0lk0tPUwVrFtVe9H1Tma0SJGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyko1YFOW0OPcx3Hwze3CU3kQ2BQcGjBMDWICgKM9ov5hONiwzeOolGG02GpiYzzm
         hd6VKDd+OVioHMghCdELGmyKcoT+AR3KIJaELq5KqqbH1eV0nIo72JDSJE2o9bfOGq
         /g9OhL2l9v9OJu+CgU6TPwkNhi3youLx1F7fv0XE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 39/53] dm integrity: change memcmp to strncmp in dm_integrity_ctr
Date:   Tue, 30 Apr 2019 13:38:46 +0200
Message-Id: <20190430113557.982220951@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 0d74e6a3b6421d98eeafbed26f29156d469bc0b5 upstream.

If the string opt_string is small, the function memcmp can access bytes
that are beyond the terminating nul character. In theory, it could cause
segfault, if opt_string were located just below some unmapped memory.

Change from memcmp to strncmp so that we don't read bytes beyond the end
of the string.

Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-integrity.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2917,17 +2917,17 @@ static int dm_integrity_ctr(struct dm_ta
 				goto bad;
 			}
 			ic->sectors_per_block = val >> SECTOR_SHIFT;
-		} else if (!memcmp(opt_string, "internal_hash:", strlen("internal_hash:"))) {
+		} else if (!strncmp(opt_string, "internal_hash:", strlen("internal_hash:"))) {
 			r = get_alg_and_key(opt_string, &ic->internal_hash_alg, &ti->error,
 					    "Invalid internal_hash argument");
 			if (r)
 				goto bad;
-		} else if (!memcmp(opt_string, "journal_crypt:", strlen("journal_crypt:"))) {
+		} else if (!strncmp(opt_string, "journal_crypt:", strlen("journal_crypt:"))) {
 			r = get_alg_and_key(opt_string, &ic->journal_crypt_alg, &ti->error,
 					    "Invalid journal_crypt argument");
 			if (r)
 				goto bad;
-		} else if (!memcmp(opt_string, "journal_mac:", strlen("journal_mac:"))) {
+		} else if (!strncmp(opt_string, "journal_mac:", strlen("journal_mac:"))) {
 			r = get_alg_and_key(opt_string, &ic->journal_mac_alg,  &ti->error,
 					    "Invalid journal_mac argument");
 			if (r)


