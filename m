Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CE5205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414100;
	bh=Gv6TUmZ4OulDP+6ra1hCGi4Xts0aktHHfvz3yJNPpS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PSpnshdimzdZxDtEkQ1fvWBacEqaS9yk6idCggOOTMtRQes+df3tmlWVyg82AHNao
	 w+eNt1VatfvAtkA6OyqIuSKNUY1dmRlcEe8bcvvliU2bnWYfcQfMmgyxi1oEdNsFAa
	 wnA5RuWnpz1Ua+XqyBYR7LttgJuthaE23LqCWprk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfCLSIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfCLRMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:15 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0042217F4;
        Tue, 12 Mar 2019 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410734;
        bh=Gv6TUmZ4OulDP+6ra1hCGi4Xts0aktHHfvz3yJNPpS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tu9ZBClURyJwl8YkcR8xCeNUZqefahN2ifK1+l79M3EXuwLoMZwl2PyZkBm/OSHDO
         SWOPpblXvgUVuoszzRAIqkHoTDP7ntsW/if9qfE4LKvyoNVUOAWSi/1gjCU1Lq0uQz
         rnuv600nNbZEQfX0m0mne3dIW1xTkf4cHTRnlH4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 055/171] cifs: fix computation for MAX_SMB2_HDR_SIZE
Date:   Tue, 12 Mar 2019 10:07:15 -0700
Message-Id: <20190312170352.872809191@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 58d15ed1203f4d858c339ea4d7dafa94bd2a56d3 ]

The size of the fixed part of the create response is 88 bytes not 56.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 5671d5ee7f58..eaf39fb71f8b 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -84,8 +84,8 @@
 
 #define NUMBER_OF_SMB2_COMMANDS	0x0013
 
-/* 4 len + 52 transform hdr + 64 hdr + 56 create rsp */
-#define MAX_SMB2_HDR_SIZE 0x00b0
+/* 52 transform hdr + 64 hdr + 88 create rsp */
+#define MAX_SMB2_HDR_SIZE 204
 
 #define SMB2_PROTO_NUMBER cpu_to_le32(0x424d53fe)
 #define SMB2_TRANSFORM_PROTO_NUM cpu_to_le32(0x424d53fd)
-- 
2.19.1



