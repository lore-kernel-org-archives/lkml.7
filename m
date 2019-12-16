Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD6620726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519313;
	bh=SLLA6soTRudvRmoUb9fkFaD2Y3fKHbuYA00w0PGg8UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZElUQNXgMK0cMTR6zL8h6LcLdJJilDmRdZxVEEkGY8Wj/iVbD/Q9r0su/k0GdecdM
	 JY8nfcelhD3m3p0yAAaVMGxCvd/fI+MSkmR+fVVC/8fWe9xM6muUGXPuiiHckv7yB5
	 hP4PWka1iS1fquEupJdMg4dgzfJdWSYSgRQD5GoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfLPSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbfLPSBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:01:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6192620726;
        Mon, 16 Dec 2019 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519308;
        bh=SLLA6soTRudvRmoUb9fkFaD2Y3fKHbuYA00w0PGg8UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cPHoQCVk5nvuCRIPE3mcbT9NPvqOYJhFD5FqUXKwdq2Z93J/8nVXGqTkiGDtklckt
         WvthY+17xVaIvCDJGS4GifzGKyAalmp4AQhx7plJks6+B/dsYZA+tiBWYQJ06enyap
         m1kn4zL0TkiGDVE8SBSWHmI8XIPxrDzRSmslzPmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.19 006/140] USB: uas: heed CAPACITY_HEURISTICS
Date:   Mon, 16 Dec 2019 18:47:54 +0100
Message-Id: <20191216174750.071033306@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 335cbbd5762d5e5c67a8ddd6e6362c2aa42a328f upstream.

There is no need to ignore this flag. We should be as close
to storage in that regard as makes sense, so honor flags whose
cost is tiny.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191114112758.32747-3-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -845,6 +845,12 @@ static int uas_slave_configure(struct sc
 		sdev->fix_capacity = 1;
 
 	/*
+	 * in some cases we have to guess
+	 */
+	if (devinfo->flags & US_FL_CAPACITY_HEURISTICS)
+		sdev->guess_capacity = 1;
+
+	/*
 	 * Some devices don't like MODE SENSE with page=0x3f,
 	 * which is the command used for checking if a device
 	 * is write-protected.  Now that we tell the sd driver


