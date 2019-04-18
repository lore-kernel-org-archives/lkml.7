Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AD9218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ud/mXT5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbfDRSGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33163 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391480AbfDRSG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so1558777pgh.0;
        Thu, 18 Apr 2019 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=1LISubmMWYiiRI8EKD/jaqxerxKaeN3ae56N3InZo08=;
        b=ud/mXT5ShMhO+EiuLV0AoC9WtmPDhiPdTljt+4032YFvfXo9ORUk37fhQeSl0JKSeC
         v8aR0Zxrbxpa4tVKMv4iX2Yh6wTek0d3aug05ZzofKosOYG8gLwvSozGN2Fm/IMUAnAc
         DblAPYIQignHDr0HhQ7XHGiRH2uzaXJTdMEFRxKZ2WfxUmKLIw6siIC+LoqHi+m6nAlg
         7PFP+kklaMCyrs3h2CvbG+6pHYkZW5q131QGiufnMNmOoglre9zUB3MEdElfmKxhPept
         vfbw4Rg3wNyF8XsYmkSJ12wDttwCN790XT6dlLWPfjfdvmnq3qMLPmvee6qZGOIVNGbr
         S8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=1LISubmMWYiiRI8EKD/jaqxerxKaeN3ae56N3InZo08=;
        b=iagDLMCKWJVlne08iD6t56Dk41LIlyLeOi6gJlJBKwGNluf2Yl0qM9cay68/n1QxuG
         XKdvGZ2w+8idN5STZu3t6OR6AyaFmPvq2Ul6Nku75JBb8BEe513ETAA87WE7TdaC5Y9W
         3sB2geCtXOEldg2ElwclK1F2oSjU4wBq5pXZOkLC1FHTrLaJ2uMk7seVNjJszOLfPaaf
         N9SWtLYbqZc3fVBVZykKnzaReas1XiTuJRfdFsqQihXRHEw9HwRsR/dPShe+PWpevY/8
         d6tEWizp0Tp5vL63YUer0UbuVWC2HmhPEk+p6q89yzOkRLKPip82fB+wHh6TTWFGna5b
         o+Vw==
X-Gm-Message-State: APjAAAU7J0eetXSKJKQrpcvyplOW0XdzTYPDnIWto2yv8bZqE/mgPZvV
        9Hj8xSgwD3hJCOhn0KHo23KgjFo5
X-Google-Smtp-Source: APXvYqz9G+P39z4INOWscutoy7qsBWrupdLB5iFwsVc7bxaRa0rCAZmQutJZ+zhigOagGv09shZRKQ==
X-Received: by 2002:a63:243:: with SMTP id 64mr89505318pgc.214.1555610788039;
        Thu, 18 Apr 2019 11:06:28 -0700 (PDT)
Received: from udknight.localhost ([59.57.228.71])
        by smtp.gmail.com with ESMTPSA id j6sm3493950pfe.107.2019.04.18.11.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 11:06:27 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id x3II8fIl005029;
        Fri, 19 Apr 2019 02:08:41 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id x3II8emh005025;
        Fri, 19 Apr 2019 02:08:40 +0800
Date:   Fri, 19 Apr 2019 02:08:40 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi:libc-compat.h: Correct the comment about the value of
 __UAPI_DEF_FOO
Message-ID: <20190418180840.GB4863@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reality, when the userspace libc header has been included first, we need
to set the value of guard macros to 0, and set the value of guard macros to
1 when uapi header comes first.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 include/uapi/linux/libc-compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 8254c93..ba10eede 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -25,8 +25,8 @@
  *     userspace libc header has been included first.
  *
  * (c) If the userspace libc header has been included first define a set of
- *     guard macros of the form __UAPI_DEF_FOO and set their values to 1, else
- *     set their values to 0.
+ *     guard macros of the form __UAPI_DEF_FOO and set their values to 0, else
+ *     set their values to 1.
  *
  * (d) Back in the UAPI header with the conflicting definitions, guard the
  *     definitions with:
-- 
1.8.5.6.2.g3d8a54e.dirty
