Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9969DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682D3206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520826;
	bh=nbAfZKHrZcSSt+GsVE2E1uxrIj9hr8EtpdPfmMdnG9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t+1PNyqn8ZkghkKBv1DBFn5N/Yeyu4kkYLD3KjzcHOPLvc8921+j9OexOgSXhNRzp
	 n1kMNZjJbAIF399bnYt4IcY7f3WsGg6NwIZKNnk7pM3SvWyh7oiVQJaEXwM8B+bKmp
	 ZaZTOvHbi6q6eLcbenbjbjWXDx3t/qd6aZT0W3gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfLPSQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731491AbfLPSQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77471206E0;
        Mon, 16 Dec 2019 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520173;
        bh=nbAfZKHrZcSSt+GsVE2E1uxrIj9hr8EtpdPfmMdnG9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9YKspUlIkFXCbuoQaWw4OVGp5aJy4ua24FFo3G4vd1Vx9sTYGklIIaSIG0uAbnI0
         nfPTTQKrSYjgFkbv0YQ4po0tmy5ObZxIQEl1v6W6GHdwOND4IGIRNn+OciZ05X8r01
         aYhNzFFFpNicicRMae0QqKydoR4T0KkCujAo+jrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 008/177] scsi: qla2xxx: Fix driver unload hang
Date:   Mon, 16 Dec 2019 18:47:44 +0100
Message-Id: <20191216174812.731377005@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

commit dd322b7f3efc8cda085bb60eadc4aee6324eadd8 upstream.

This patch fixes driver unload hang by removing msleep()

Fixes: d74595278f4ab ("scsi: qla2xxx: Add multiple queue pair functionality.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191105150657.8092-5-hmadhani@marvell.com
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9021,8 +9021,6 @@ int qla2xxx_delete_qpair(struct scsi_qla
 	struct qla_hw_data *ha = qpair->hw;
 
 	qpair->delete_in_progress = 1;
-	while (atomic_read(&qpair->ref_count))
-		msleep(500);
 
 	ret = qla25xx_delete_req_que(vha, qpair->req);
 	if (ret != QLA_SUCCESS)


