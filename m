Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3C2C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D93206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000390;
	bh=9199/2c0C0Q/3wQySMZfVrJHSf8dw7tU+Zrq49t6lHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e89KrtKGOxg9ondmvcQMxSviSkJZNh3lN2o5rBz/xjav+H0tOX1fN98V5b82zE6Id
	 8UTWqefYz1yCpW6hdpBWY3ScpY9VAous1SegYM5ZmmeqBym09iXXruqvT/5ini/pQO
	 wLJemkZvQVqaszNWqJfuoxxr3IZUk5OCL4ioWVdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbfGXT2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbfGXT2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF9D218EA;
        Wed, 24 Jul 2019 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996488;
        bh=9199/2c0C0Q/3wQySMZfVrJHSf8dw7tU+Zrq49t6lHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LE90IFfBXB0kpk0ZMf9RODCs5YR3jyHsDtyOhCRVLditTwTADJ5rb66BfZbR1Q4cf
         y8keMlrVlkHvD38OaRPDPW7ogahSSuKNwkJm/Ud4Nh0aj/axRXZUkJ3B+4/MWIvrNY
         FnHZxbc7JbPTM/zpLPAT/8GeGIqiet2U+UJCZg40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 113/413] integrity: Fix __integrity_init_keyring() section mismatch
Date:   Wed, 24 Jul 2019 21:16:44 +0200
Message-Id: <20190724191743.405361665@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c655784e2cf59cb6140759b8b546d98261d1ad9 ]

With gcc-4.6.3:

    WARNING: vmlinux.o(.text.unlikely+0x24c64): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys()
    The function __integrity_init_keyring() references
    the function __init set_platform_trusted_keys().
    This is often because __integrity_init_keyring lacks a __init
    annotation or the annotation of set_platform_trusted_keys is wrong.

Indeed, if the compiler decides not to inline __integrity_init_keyring(),
a warning is issued.

Fix this by adding the missing __init annotation.

Fixes: 9dc92c45177ab70e ("integrity: Define a trusted platform keyring")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/digsig.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 4582bc26770a..868ade3e8970 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -69,8 +69,9 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 	return -EOPNOTSUPP;
 }
 
-static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
-				    struct key_restriction *restriction)
+static int __init __integrity_init_keyring(const unsigned int id,
+					   key_perm_t perm,
+					   struct key_restriction *restriction)
 {
 	const struct cred *cred = current_cred();
 	int err = 0;
-- 
2.20.1



