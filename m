Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D24FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE7A207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264371;
	bh=OrPEpdqwd733jdhoGK9h+vv1s9G3mOo9wyJbXWHjDiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qH4k2CmdQLW2YNwytDsokM3mJb/sws+NeNoODkqwySmxzohhtVyHe8m/7uiFItui4
	 htl/0EChY39McctAr2ZfzKabOT9Q1Swlx2+FnqzCcNFYcWKTd6bxYw/gHApfO2Dr8u
	 AU2kuhkTJGzrxIF+98Ru8pvWHI/gkmnpEDVI0HfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404725AbfJPWTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437670AbfJPVyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:05 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2300221925;
        Wed, 16 Oct 2019 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262845;
        bh=OrPEpdqwd733jdhoGK9h+vv1s9G3mOo9wyJbXWHjDiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPayCzK0HKBRhciMlugwbN+VCcLkj53gVRMtdgJ/V+GtE09Q3FyQPxp09H2u8Jw2N
         wyLZ/EaiEX/XLgXtbSSxajkVd5Un7fNiH3DwWQdSjXzwS4ppvszHE0sq+wdHsWbq3z
         MW63+rTVkpenEcW3N1BHyFrvOZu7d8AVrDMyqoUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 4.9 03/92] s390/cio: avoid calling strlen on null pointer
Date:   Wed, 16 Oct 2019 14:49:36 -0700
Message-Id: <20191016214801.882895406@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

commit ea298e6ee8b34b3ed4366be7eb799d0650ebe555 upstream.

Fix the following kasan finding:
BUG: KASAN: global-out-of-bounds in ccwgroup_create_dev+0x850/0x1140
Read of size 1 at addr 0000000000000000 by task systemd-udevd.r/561

CPU: 30 PID: 561 Comm: systemd-udevd.r Tainted: G    B
Hardware name: IBM 3906 M04 704 (LPAR)
Call Trace:
([<0000000231b3db7e>] show_stack+0x14e/0x1a8)
 [<0000000233826410>] dump_stack+0x1d0/0x218
 [<000000023216fac4>] print_address_description+0x64/0x380
 [<000000023216f5a8>] __kasan_report+0x138/0x168
 [<00000002331b8378>] ccwgroup_create_dev+0x850/0x1140
 [<00000002332b618a>] group_store+0x3a/0x50
 [<00000002323ac706>] kernfs_fop_write+0x246/0x3b8
 [<00000002321d409a>] vfs_write+0x132/0x450
 [<00000002321d47da>] ksys_write+0x122/0x208
 [<0000000233877102>] system_call+0x2a6/0x2c8

Triggered by:
openat(AT_FDCWD, "/sys/bus/ccwgroup/drivers/qeth/group",
		O_WRONLY|O_CREAT|O_TRUNC|O_CLOEXEC, 0666) = 16
write(16, "0.0.bd00,0.0.bd01,0.0.bd02", 26) = 26

The problem is that __get_next_id in ccwgroup_create_dev might set "buf"
buffer pointer to NULL and explicit check for that is required.

Cc: stable@vger.kernel.org
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/ccwgroup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -369,7 +369,7 @@ int ccwgroup_create_dev(struct device *p
 		goto error;
 	}
 	/* Check for trailing stuff. */
-	if (i == num_devices && strlen(buf) > 0) {
+	if (i == num_devices && buf && strlen(buf) > 0) {
 		rc = -EINVAL;
 		goto error;
 	}


