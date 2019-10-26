Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF014CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 22:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE2520863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 22:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjxPHJRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfJZWY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 18:24:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37792 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfJZWY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 18:24:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id g50so8926625qtb.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ckFFNPjTqoIV9NtKmwbFlYYqSItNgTJwWUgtTUGHSxk=;
        b=AjxPHJRsbcMH2/yFR06YkVU6csiJTZ6l9KnCXkdhc+NmED9nLh+t3MhvGP+hwKwVbc
         xIcwTJUTNncG2HowAbSXiRokyvVtAfBpd3d1gh+xXC0zLTkNf/hjYkr52j9q6xgS09rW
         6JaeZKEbbFx8mNpGP9Um3Le1q7vTAIvRXyXWa43GOy6tIFG2TxX/gKndQ6nLhu8qOrQq
         C//IEr0XuQOSWEFPapyQDI2ViWzTPTiFWyIpvbApmtgnSVPSM6+LIdgTjdCrMbmzAYup
         /oDLF35L1hzW9FFtEABWmUreWI7aXs7JaF4Dn5Bi83v0UB/PYB5snwGyQeFeQ4Fh+cfu
         W4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ckFFNPjTqoIV9NtKmwbFlYYqSItNgTJwWUgtTUGHSxk=;
        b=T7TXqPJ0VQOWzo6Urwah1W6ezp/KJn5vm1NVacwP9zsYWnNhKcRtf9XCuay4WRl4Gh
         fo6dCokQn+/Akw737oM/pVidj/hg7XJ5uCUt076k5nHFTpEoiuWv3644PjnZol4pdPlP
         trtFqa4Yulrt1RvTcNUKReoAUzlZeocsy3eRzI36JlIwdN9v57F2hNFpfq/lb6fMNuCL
         I6xGWbBhKeVtIP1M0r/fVmUglOSDxf3mlTgxLER2y0dql1k529lKqVazb1ReAKGWGXnC
         0+E13TNk6ICE+5nBCTV1fDG5J+QTjkobChkN2V3EiZxmpcAugryHlnffHB+JyptCn8LU
         Ey8w==
X-Gm-Message-State: APjAAAX4vmlbtMHIQyHcUPmUBxdgonitZuxG1h3mgq2mzUhsyLX/iI4T
        hcuagNI7Y/vQzhitnzpL4hc=
X-Google-Smtp-Source: APXvYqzMgODqERj9LojX/pC6WbVr8Y8PFFc4BiKrZkuW6qnCSyBuhlmTyLrl3G+3rrw3lN8yMaSzQA==
X-Received: by 2002:ac8:d6:: with SMTP id d22mr10473557qtg.290.1572128698141;
        Sat, 26 Oct 2019 15:24:58 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id c204sm2606120qkb.90.2019.10.26.15.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 15:24:57 -0700 (PDT)
Date:   Sat, 26 Oct 2019 19:24:53 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: Remove unneeded variable
Message-ID: <20191026222453.GA14562@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable used to store return value. Issue found by
coccicheck.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index b07f5e2..d53bd801 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1387,9 +1387,7 @@ static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
 {
-	cvmx_pko_status_t ret = 0;
-
-	return ret;
+	return 0;
 }
 
 static inline void cvmx_wqe_set_port(struct cvmx_wqe *work, int port)
-- 
2.7.4

