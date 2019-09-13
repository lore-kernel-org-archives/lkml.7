Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A3C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99722171F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380704;
	bh=hR2M/dFU7q9mS8Hanp2YcelqgRGYy0EO55qfTzIOR1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JnK6pfvBf9c3UyWvPfYkAxkuqSPHTUVYdn2MU9a3WsItOXbNan/Kr490gLqIRSwA+
	 e27DR0JRWchc0rxYGGK1vJqYyLZZWLf63XgYvxEM2wo3HlkF4hebznkNyqZ//g+4oL
	 jys7N8cJtk/72fydEfSWOETZMnQ5gYd378BPZd8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbfIMNSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390188AbfIMNSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:18:18 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14229206BB;
        Fri, 13 Sep 2019 13:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380697;
        bh=hR2M/dFU7q9mS8Hanp2YcelqgRGYy0EO55qfTzIOR1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ku+fKwnOCJI7wOzYWrcC+I81buU+pUXqlKQkdNRSs6/gTmDQ9zxoNi3v9JldpNCip
         T5rjqoqM+KO9JSsYIup75rADoQHITDuACo0nIfN1j9Y1GiTWmzT5b3X8+D4INEIAEJ
         2sAkk1Oo9+/1KlycpOCYGBut+xc/5NKTh/e0jaso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 148/190] scsi: zfcp: fix request object use-after-free in send path causing wrong traces
Date:   Fri, 13 Sep 2019 14:06:43 +0100
Message-Id: <20190913130611.803597120@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 106d45f350c7cac876844dc685845cba4ffdb70b ]

When tracing instances where we open and close WKA ports, we also pass the
request-ID of the respective FSF command.

But after successfully sending the FSF command we must not use the
request-object anymore, as this might result in an use-after-free (see
"zfcp: fix request object use-after-free in send path causing seqno
errors" ).

To fix this add a new variable that caches the request-ID before sending
the request. This won't change during the hand-off to the FCP channel,
and so it's safe to trace this cached request-ID later, instead of using
the request object.

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Fixes: d27a7cb91960 ("zfcp: trace on request for open and close of WKA port")
Cc: <stable@vger.kernel.org> #2.6.38+
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/scsi/zfcp_fsf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 3c86e27f094de..aff073a5b52bf 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1594,6 +1594,7 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 {
 	struct zfcp_qdio *qdio = wka_port->adapter->qdio;
 	struct zfcp_fsf_req *req;
+	unsigned long req_id = 0;
 	int retval = -EIO;
 
 	spin_lock_irq(&qdio->req_q_lock);
@@ -1616,6 +1617,8 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 	hton24(req->qtcb->bottom.support.d_id, wka_port->d_id);
 	req->data = wka_port;
 
+	req_id = req->req_id;
+
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
 	if (retval)
@@ -1623,7 +1626,7 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	if (!retval)
-		zfcp_dbf_rec_run_wka("fsowp_1", wka_port, req->req_id);
+		zfcp_dbf_rec_run_wka("fsowp_1", wka_port, req_id);
 	return retval;
 }
 
@@ -1649,6 +1652,7 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 {
 	struct zfcp_qdio *qdio = wka_port->adapter->qdio;
 	struct zfcp_fsf_req *req;
+	unsigned long req_id = 0;
 	int retval = -EIO;
 
 	spin_lock_irq(&qdio->req_q_lock);
@@ -1671,6 +1675,8 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 	req->data = wka_port;
 	req->qtcb->header.port_handle = wka_port->handle;
 
+	req_id = req->req_id;
+
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
 	if (retval)
@@ -1678,7 +1684,7 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	if (!retval)
-		zfcp_dbf_rec_run_wka("fscwp_1", wka_port, req->req_id);
+		zfcp_dbf_rec_run_wka("fscwp_1", wka_port, req_id);
 	return retval;
 }
 
-- 
2.20.1



