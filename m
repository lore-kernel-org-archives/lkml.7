Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65A8CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AFD21850
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904287;
	bh=x6vR3NQ+bGrQ/ymKfMGPZ1eXkd7tZ1So3e3ueerPjaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oEP/z7BpA0+bg9VGNCZfmz2F42a6uj6hggjUyOiiIxBFatcCKn7a2KqzxRL5+XeAj
	 p1TdP4FhvsPYirYqa+3j2IW5lnAU5bnivMGq6SvUGxAWd162XdOLWYg9nNJn5/pXKa
	 DrXGFXf59KwsLdHrmR4nLUbNZaOHFpGpd4O58SaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfKDVv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730057AbfKDVvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:51:20 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA01B21929;
        Mon,  4 Nov 2019 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904279;
        bh=x6vR3NQ+bGrQ/ymKfMGPZ1eXkd7tZ1So3e3ueerPjaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELsVVh0c9XxX/1r8nNhq8UnNgzeMQ2aDRxoX4rnZF8hi68nR1zxl3M3PY/Ar5+R8H
         NnExMALBGo3vCz9X37N+G3NlsjbcHmzr/93ziKkQ2I2UDXaxRxgWlPcAFOjMqFlzbl
         SRUPSR5TjGGVAElz9wr5RtMgO8wF3MdF2JqeCj9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yihui Zeng <yzeng56@asu.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 4.9 48/62] s390/cmm: fix information leak in cmm_timeout_handler()
Date:   Mon,  4 Nov 2019 22:45:10 +0100
Message-Id: <20191104211951.474918795@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211901.387893698@linuxfoundation.org>
References: <20191104211901.387893698@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yihui ZENG <yzeng56@asu.edu>

commit b8e51a6a9db94bc1fb18ae831b3dab106b5a4b5f upstream.

The problem is that we were putting the NUL terminator too far:

	buf[sizeof(buf) - 1] = '\0';

If the user input isn't NUL terminated and they haven't initialized the
whole buffer then it leads to an info leak.  The NUL terminator should
be:

	buf[len - 1] = '\0';

Signed-off-by: Yihui Zeng <yzeng56@asu.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
[heiko.carstens@de.ibm.com: keep semantics of how *lenp and *ppos are handled]
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/mm/cmm.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -306,16 +306,16 @@ static int cmm_timeout_handler(struct ct
 	}
 
 	if (write) {
-		len = *lenp;
-		if (copy_from_user(buf, buffer,
-				   len > sizeof(buf) ? sizeof(buf) : len))
+		len = min(*lenp, sizeof(buf));
+		if (copy_from_user(buf, buffer, len))
 			return -EFAULT;
-		buf[sizeof(buf) - 1] = '\0';
+		buf[len - 1] = '\0';
 		cmm_skip_blanks(buf, &p);
 		nr = simple_strtoul(p, &p, 0);
 		cmm_skip_blanks(p, &p);
 		seconds = simple_strtoul(p, &p, 0);
 		cmm_set_timeout(nr, seconds);
+		*ppos += *lenp;
 	} else {
 		len = sprintf(buf, "%ld %ld\n",
 			      cmm_timeout_pages, cmm_timeout_seconds);
@@ -323,9 +323,9 @@ static int cmm_timeout_handler(struct ct
 			len = *lenp;
 		if (copy_to_user(buffer, buf, len))
 			return -EFAULT;
+		*lenp = len;
+		*ppos += len;
 	}
-	*lenp = len;
-	*ppos += len;
 	return 0;
 }
 


