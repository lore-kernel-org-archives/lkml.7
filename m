Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380FBC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FD12085B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="j7ccFO9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfHKXzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 19:55:11 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.130]:31892 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726655AbfHKXzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 19:55:10 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id B638717A44D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 18:55:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wxg5hWOz43Qi0wxg5hEikC; Sun, 11 Aug 2019 18:55:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yKwbRY2mzkRaJ05KgpOoqO2JTy1EKQ64ZrdyRyqRkM8=; b=j7ccFO9QZypPjQRoMtoJIfjAZR
        7zJ7WUNAzwhixXYm3tR3Fcf0LU/ZSw/7IcF3SQLgAkz4APb0e23Yab0fYiQH+L9nT2xDDWdMwdQHf
        Z3K+eNfMR62JKvEQsbqPvWjoDtO/s8limUAlMq1jXbmN0RwMzaBXYLCR5wcS2TPUwaXQqeKUkK2ns
        Mdt7NVJJjAdnBGRaFMBK3QoJ6PFzM1FlfOr5gA0MkVjsHxfut8kICDpPUPsr7cPJ7VH9oSdG6OTZv
        vAPAThh3fyiy5SMNFhmIRrt36YXw2LydxWiThy+70zfdSDoGQhxeNccwcjAaf8tSrDNZcazSggRd5
        5oqGOV0w==;
Received: from [187.192.11.120] (port=51864 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hwxg4-002Qg0-ID; Sun, 11 Aug 2019 18:55:08 -0500
Date:   Sun, 11 Aug 2019 18:55:07 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ima: ima_modsig: Fix use-after-free bug in
 ima_read_modsig
Message-ID: <20190811235507.GA9587@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hwxg4-002Qg0-ID
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:51864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdr is being freed and then dereferenced by accessing hdr->pkcs7_msg

Fix this by copying the value returned by PTR_ERR(hdr->pkcs7_msg) into
automatic variable err for its safe use after freeing hdr.

Addresses-Coverity-ID: 1485813 ("Read from pointer after free")
Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/integrity/ima/ima_modsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index c412e31d1714..e681d4326145 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -91,8 +91,9 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 
 	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
 	if (IS_ERR(hdr->pkcs7_msg)) {
+		int err = PTR_ERR(hdr->pkcs7_msg);
 		kfree(hdr);
-		return PTR_ERR(hdr->pkcs7_msg);
+		return err;
 	}
 
 	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
-- 
2.22.0

