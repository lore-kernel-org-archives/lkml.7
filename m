Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27056C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CB4222A2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141488;
	bh=ij0fpTMs+VIPq+Mtv/Rltj5I1qlhRyELJ2VMzh8RZxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EqjBNPhYma/fpRWGqY1S1QF7l1IF1wu3ET4ueB8qxX11GxqcZCLhDJrPhJ2cCHn8T
	 jBk6BDxmGurjK/1y0/HjbHH2uUVg4RoPJWXFF9ZpZ0i370t63XVxOT6iiobHbfh4bo
	 59GEhCQTjC3vPx7EnopcMyWzNjMgz4uZycd+5DbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfKSFb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbfKSFbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:31:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B9621939;
        Tue, 19 Nov 2019 05:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141483;
        bh=ij0fpTMs+VIPq+Mtv/Rltj5I1qlhRyELJ2VMzh8RZxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2i6043sMOyRKRtlGQXNfzlk7s/ReVQe4hkFhJ1kGKiUrCErILx4khyBi0NNGUXb99
         Fufur/poFOOKnvMc+Vb8KY7B4Kymj9FOdI65o/fp2M+50uksBao3MJ3LeHJKMlvZGd
         Y+KeH5PKSDWoOuRaXUb0lhR/JHGqjc9NsBCEHJV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 175/422] scsi: qla2xxx: Fix port speed display on chip reset
Date:   Tue, 19 Nov 2019 06:16:12 +0100
Message-Id: <20191119051409.774823299@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 5d74c87a20adcc77b19753c315ad9c320b2288be ]

Clear port speed value on chip reset.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 8f502505aa796..653d535e3052f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -6502,6 +6502,7 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 	if (!(IS_P3P_TYPE(ha)))
 		ha->isp_ops->reset_chip(vha);
 
+	ha->link_data_rate = PORT_SPEED_UNKNOWN;
 	SAVE_TOPO(ha);
 	ha->flags.rida_fmt2 = 0;
 	ha->flags.n2n_ae = 0;
-- 
2.20.1



