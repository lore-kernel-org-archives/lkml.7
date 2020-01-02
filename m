Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57ABC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6DF20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005443;
	bh=oOeQ4Kf/UQMKZ0eDLAFhI8krS8HYeMHYiaxRSnwd178=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QDal4ZLOq/EF0kxkelpMjsNmA1B7TGCLTD2/fJkhg6WMusdVX/6jjxB5VFt+K3qia
	 oGQVoNUlWYZWbD2YmUcXdiOi040eZzF5V2yZMRn0vDvmk03RjFJr7L9I37/p0XLI4D
	 iDd8NP81nNy1lIwNrbizaynD9xaSqwUMHUcGDnlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgABWum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgABWZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:25:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450E321D7D;
        Thu,  2 Jan 2020 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003908;
        bh=oOeQ4Kf/UQMKZ0eDLAFhI8krS8HYeMHYiaxRSnwd178=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1w8TblLL7u8aeSPY4+uCpZSQwLuMESikc6C/5mFg5kVHzjMb1K1jvx0bdwJRfAgM
         8CRhhjr9zSu6cf1l0huPe+zcE/INoO6p4An1mX3cXLSOrQ2dllJsZdt4DCRpUA+cLL
         rqr+7ADpzhwkAHf2EJaO/bd/czhJUcEO9ttfjZOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 49/91] s390/zcrypt: handle new reply code FILTERED_BY_HYPERVISOR
Date:   Thu,  2 Jan 2020 23:07:31 +0100
Message-Id: <20200102220436.759078807@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 6733775a92eacd612ac88afa0fd922e4ffeb2bc7 ]

This patch introduces support for a new architectured reply
code 0x8B indicating that a hypervisor layer (if any) has
rejected an ap message.

Linux may run as a guest on top of a hypervisor like zVM
or KVM. So the crypto hardware seen by the ap bus may be
restricted by the hypervisor for example only a subset like
only clear key crypto requests may be supported. Other
requests will be filtered out - rejected by the hypervisor.
The new reply code 0x8B will appear in such cases and needs
to get recognized by the ap bus and zcrypt device driver zoo.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/zcrypt_error.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_error.h b/drivers/s390/crypto/zcrypt_error.h
index 9499cd3a05f8..02a936db0092 100644
--- a/drivers/s390/crypto/zcrypt_error.h
+++ b/drivers/s390/crypto/zcrypt_error.h
@@ -75,6 +75,7 @@ struct error_hdr {
 #define REP82_ERROR_EVEN_MOD_IN_OPND	    0x85
 #define REP82_ERROR_RESERVED_FIELD	    0x88
 #define REP82_ERROR_INVALID_DOMAIN_PENDING  0x8A
+#define REP82_ERROR_FILTERED_BY_HYPERVISOR  0x8B
 #define REP82_ERROR_TRANSPORT_FAIL	    0x90
 #define REP82_ERROR_PACKET_TRUNCATED	    0xA0
 #define REP82_ERROR_ZERO_BUFFER_LEN	    0xB0
@@ -105,6 +106,7 @@ static inline int convert_error(struct zcrypt_queue *zq,
 	case REP82_ERROR_INVALID_DOMAIN_PRECHECK:
 	case REP82_ERROR_INVALID_DOMAIN_PENDING:
 	case REP82_ERROR_INVALID_SPECIAL_CMD:
+	case REP82_ERROR_FILTERED_BY_HYPERVISOR:
 	//   REP88_ERROR_INVALID_KEY		// '82' CEX2A
 	//   REP88_ERROR_OPERAND		// '84' CEX2A
 	//   REP88_ERROR_OPERAND_EVEN_MOD	// '85' CEX2A
-- 
2.20.1



