Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E210C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127628;
	bh=6gW2yF/ZykvwWOf8F5efyXX5yz8fDo+X7RRGfMlsx3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OhX/36PUsFJSg2oWU8+ndXA+XL/mF0fOsEeCsRC32IlzkyGp23jiMO66aFaJwmElp
	 Ataez+H8GBqAfZ9kzpLso4dwkd5g88xjDJ+dbgpQb+jXKrHoDYfpgNIESnsXNEFiqf
	 z+0Dok3z8ZSr0yI8j7GT1jKVMXIq2qjna541Knr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392101AbfDXRk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392147AbfDXRhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:23 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CCC220675;
        Wed, 24 Apr 2019 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127442;
        bh=6gW2yF/ZykvwWOf8F5efyXX5yz8fDo+X7RRGfMlsx3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgDWGgl+asUqZ9IDRDqNsZd56Ma+36z6tLkbbSEASsJO+fcHF3QvgPHOpKIGs1JEU
         xMrE+KOvzYSmZhjr8R4MejrIKlyTrw1xaixtB9tpjQmGuqcQtbXrAZ+Js8Z43B1i14
         ojKGODFWjKOJZZGXLfxHtpQjN9KFDBCKaty38Ry0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 5.0 093/115] s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)
Date:   Wed, 24 Apr 2019 19:10:29 +0200
Message-Id: <20190424170930.275050595@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

commit 2d4ea4b95cae3133de6b18ec5d5a42ee824fa0ef upstream.

IS_ENABLED should generally use CONFIG_ prefaced symbols and
it doesn't appear as if there is a BLK_DEV_INITRD define.

Cc: <stable@vger.kernel.org> # 4.20
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/boot/mem_detect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/boot/mem_detect.c
+++ b/arch/s390/boot/mem_detect.c
@@ -25,7 +25,7 @@ static void *mem_detect_alloc_extended(v
 {
 	unsigned long offset = ALIGN(mem_safe_offset(), sizeof(u64));
 
-	if (IS_ENABLED(BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && INITRD_START && INITRD_SIZE &&
 	    INITRD_START < offset + ENTRIES_EXTENDED_MAX)
 		offset = ALIGN(INITRD_START + INITRD_SIZE, sizeof(u64));
 


