Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A93A214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211136;
	bh=3qfJsiNblWsRinUOR5rWmnopr316m0llNbLn03h1SLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPiE0wzm9b9AbUuAO9fCsuHGlXMK+kQLPpIL+AFeuevktMXVK+gBUbGdbAe52dy/W
	 p0MufCsJHU4u2OdsijnrPFi2tEYGPw6DwNLpVWGVoXghXE0wfx67sF5E6GMl9EEaZU
	 XAeLxeuNGQMTvgFbO2ftXAwpBuF3SeQi7C/BfgcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfJ0VSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbfJ0VSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:18:52 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCC8205C9;
        Sun, 27 Oct 2019 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211131;
        bh=3qfJsiNblWsRinUOR5rWmnopr316m0llNbLn03h1SLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0aHjfY8mCA/jTTMVYyto5BNJgUGm5j+sSOJ+yKCI0SUS+3mqKCCFXl3U76rEF1ek
         cSbuh3xg2vjQA/0C3i7gBcnD+rW4QbWqrSkgA3eEq4RbauoZbgLyNae1BNsEvWXQYY
         UcJ6Vp/6R3zqEop3niZDb08Utj05J1VoNhEjQpuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 008/197] scsi: qla2xxx: Silence fwdump template message
Date:   Sun, 27 Oct 2019 21:58:46 +0100
Message-Id: <20191027203352.134337588@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit 248a445adfc8c33ffd67cf1f2e336578e34f9e21 ]

Print if fwdt template is present or not, only when
ql2xextended_error_logging is enabled.

Link: https://lore.kernel.org/r/20190912180918.6436-2-hmadhani@marvell.com
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index afcd9a8858845..3fbe909744a8f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3268,7 +3268,7 @@ qla2x00_alloc_fw_dump(scsi_qla_host_t *vha)
 
 		for (j = 0; j < 2; j++, fwdt++) {
 			if (!fwdt->template) {
-				ql_log(ql_log_warn, vha, 0x00ba,
+				ql_dbg(ql_dbg_init, vha, 0x00ba,
 				    "-> fwdt%u no template\n", j);
 				continue;
 			}
-- 
2.20.1



