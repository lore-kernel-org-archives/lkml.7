Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D7AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE7922CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149232;
	bh=fYofRxGW5Rg/TBgOqQHdABkErQqUi+VKEe9wA/nIADM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+Cu+Lz/+fBosbQXiCh7i0lYo325fGs0EBwkMk/BUle9E/e2lbmoqe2y626fjnR9z
	 fMNkQE2ZpYViTk1m0ZAybiiD3NGoO1rv+x35cpo1ATN/F9VVEy9GNUULOItZi3tyy0
	 7ZGQHn7UJxsw/wi6V6b8jHFDkcD8BSieySSJN/VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfGZNxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbfGZNnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6086222CD0;
        Fri, 26 Jul 2019 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148595;
        bh=fYofRxGW5Rg/TBgOqQHdABkErQqUi+VKEe9wA/nIADM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m73vuro5psNnBkElygt2JEGtIqFIinp7ALfcFCTC+g7FFdbdWe1h1rmKxK5P3X8eF
         10FKlt+k46e2Ljp53qIjjzL91iZEybQzJLKK0W7V3nfr8tdvnpKsUogk8hlIbGZ53x
         kILf5j0UhWU04trOSyqIC2mJW0xzO3FYXP2Oc3gQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Greg KH <greg@kroah.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 37/47] drivers/pps/pps.c: clear offset flags in PPS_SETPARAMS ioctl
Date:   Fri, 26 Jul 2019 09:42:00 -0400
Message-Id: <20190726134210.12156-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit 5515e9a6273b8c02034466bcbd717ac9f53dab99 ]

The PPS assert/clear offset corrections are set by the PPS_SETPARAMS
ioctl in the pps_ktime structs, which also contain flags.  The flags are
not initialized by applications (using the timepps.h header) and they
are not used by the kernel for anything except returning them back in
the PPS_GETPARAMS ioctl.

Set the flags to zero to make it clear they are unused and avoid leaking
uninitialized data of the PPS_SETPARAMS caller to other applications
that have a read access to the PPS device.

Link: http://lkml.kernel.org/r/20190702092251.24303-1-mlichvar@redhat.com
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Cc: Greg KH <greg@kroah.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pps/pps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 8febacb8fc54..0951564b6830 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -166,6 +166,14 @@ static long pps_cdev_ioctl(struct file *file,
 			pps->params.mode |= PPS_CANWAIT;
 		pps->params.api_version = PPS_API_VERS;
 
+		/*
+		 * Clear unused fields of pps_kparams to avoid leaking
+		 * uninitialized data of the PPS_SETPARAMS caller via
+		 * PPS_GETPARAMS
+		 */
+		pps->params.assert_off_tu.flags = 0;
+		pps->params.clear_off_tu.flags = 0;
+
 		spin_unlock_irq(&pps->lock);
 
 		break;
-- 
2.20.1

