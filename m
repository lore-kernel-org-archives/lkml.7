Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B889C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155492184C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055045;
	bh=9I0J9Q9BNRma8ZT/GTjIET7njTTlPZtA+u6Uyvd4U58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jGHQVE1sODwgYAOjsgmACXr2SU1ZYIrUJuJB692Wu1Dqljif6QEhLuOMTLTll5U15
	 2mL1BwzcbwKcPOs81+xmzcsFgIMXJPyW7wUUi3Z0uI+cViyRpVlCjl6ReoFEo06SrV
	 gzdAlq57snlEr8hzCl7C1B7GF4kl/ihiY+GM1GzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfGBIKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfGBIKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:10:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6C72186A;
        Tue,  2 Jul 2019 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562055039;
        bh=9I0J9Q9BNRma8ZT/GTjIET7njTTlPZtA+u6Uyvd4U58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hj+TVXScNuvQlsInqAudc+4D817ymrogxfh287X8X9R9c1HR2a/YFYmZCxJDzYu2o
         XljaJChw45n4BnTD+S4bjUstCjdXVztVx87qrRCrrZpu/Km8DBJ+UDlNcGwbBD5BKr
         4LAdhFgVw/i8YOZaXYoyhq2Cg21cDDJ8GEM73kPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.14 24/43] NFS/flexfiles: Use the correct TCP timeout for flexfiles I/O
Date:   Tue,  2 Jul 2019 10:02:04 +0200
Message-Id: <20190702080125.071813274@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

commit 68f461593f76bd5f17e87cdd0bea28f4278c7268 upstream.

Fix a typo where we're confusing the default TCP retrans value
(NFS_DEF_TCP_RETRANS) for the default TCP timeout value.

Fixes: 15d03055cf39f ("pNFS/flexfiles: Set reasonable default ...")
Cc: stable@vger.kernel.org # 4.8+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -18,7 +18,7 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
-static unsigned int dataserver_timeo = NFS_DEF_TCP_RETRANS;
+static unsigned int dataserver_timeo = NFS_DEF_TCP_TIMEO;
 static unsigned int dataserver_retrans;
 
 static bool ff_layout_has_available_ds(struct pnfs_layout_segment *lseg);


