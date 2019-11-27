Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6B9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74DB2158C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888284;
	bh=0kjC/bhYkd5uVA3EYta0Z8i5/4EmS3pkzPHQm41NAXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oXVS9RlEGHMVVRsIHcaA4jKoWEpCEdWi4FLskRxsdMXkRWf5Gb+ns4RW3lDDEJnrM
	 R8o2X42M89R1rb6HwWCJ0tM97l/zcFKGxskzE+0SpwpCBZzZZkZTLvSqR3XsA6NV9X
	 gA3bArPcopUT9Y5nLzGzKPqEmYgTa+sZLNFWbBvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfK0U6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbfK0U6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:58:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCDAB20862;
        Wed, 27 Nov 2019 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888280;
        bh=0kjC/bhYkd5uVA3EYta0Z8i5/4EmS3pkzPHQm41NAXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyXehrt5GjYtQcNn+fj3NQJ+2dep2WuOPkAAj87N7Yvrx27Na9yzAYTqdnkwf62jK
         1XMemnaKMcVoKCGu01xl2UfvJeLXF1GRqqhnhyD5WKRQDiMt0l00NrGEajlQJal2vC
         3t7Z7TgdClr+PAXzTuuWPBAfBBVDU7Q0GyiIh7dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/306] scsi: iscsi_tcp: Explicitly cast param in iscsi_sw_tcp_host_get_param
Date:   Wed, 27 Nov 2019 21:28:43 +0100
Message-Id: <20191127203120.176097617@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 20054597f169090109fc3f0dfa1a48583f4178a4 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/scsi/iscsi_tcp.c:803:15: warning: implicit conversion from
enumeration type 'enum iscsi_host_param' to different enumeration type
'enum iscsi_param' [-Wenum-conversion]
                                                 &addr, param, buf);
                                                        ^~~~~
1 warning generated.

iscsi_conn_get_addr_param handles ISCSI_HOST_PARAM_IPADDRESS just fine
so add an explicit cast to iscsi_param to make it clear to Clang that
this is expected behavior.

Link: https://github.com/ClangBuiltLinux/linux/issues/153
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/iscsi_tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index b025a0b743417..23354f206533b 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -800,7 +800,8 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
 			return rc;
 
 		return iscsi_conn_get_addr_param((struct sockaddr_storage *)
-						 &addr, param, buf);
+						 &addr,
+						 (enum iscsi_param)param, buf);
 	default:
 		return iscsi_host_get_param(shost, param, buf);
 	}
-- 
2.20.1



