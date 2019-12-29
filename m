Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1385C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E35206E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/a6FQPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfL2OhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 09:37:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45227 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2OhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:37:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so17098617pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 06:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4zwlw+odKSqE3aBhmsXGeIgNGWe/8QP8KYWJ0WS0T4=;
        b=H/a6FQPdDtwNA6IpBBIjiujGi46fekF4JBFJcCtTal8mYBJeWu7mHpBr64l3HveywM
         z2NJl27a7SXfqQ/yDmWhofXWIDphR9FfznfGny4KNfsRA8Zyh5HM+/kCGQGcUVjtZixg
         DoTZv5fKkKZa5MpOI8SNBjuMevy8CCjfZUVmhEp5z5okyt70tj5PId0cRWrP0c/WwG2j
         DeSutL/2HOO8ly8AKNL52VWUdw+x0gbpy0dNpX9/1amQDJhCMRos93wkPnuMDVPtHS2C
         apj2qt37Gn59+W21IVRtSnkVIN2fh5K4dHepb0ZgF4jXdI6Co6iLxcj2m6JSaf66B9YM
         M4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4zwlw+odKSqE3aBhmsXGeIgNGWe/8QP8KYWJ0WS0T4=;
        b=Q4R0q3J7nB4W+uZdqYmEyErKH1wHzNv4KvzU41w+VcL/jL1T4wm4ZWDuWGmOHMvkur
         DzTMQrAc/Vga8/TZmqv8CDmSFSUcOPXEbMIvj5FfZa8wP6O4PhFN4rItfOsEOAYRcqpC
         iP9izygbWvQmR+29BO5mi8OzfQhGhwz6EsE1wP7E7ZOyZENqpNXxo+RJqqdxcT5kW70+
         f8AK8K1lpaabLsXsLknWWpinsc8LhAJ40h5LUVka8+y/H+R1ttc46BDfevu6afqG6Jge
         HkMmIafOcC3HQnTt3Pl76e1RDaAc77YVN/6A2w9soiHCryFQGpej5Q70luI6RTIJLxS9
         u+qQ==
X-Gm-Message-State: APjAAAUy29XKOxkANdBF8EbUfFwjd18gRmkhSGMDYoTAWKCM3JIKEAdM
        qRuvri3wves0erDIfC8PadQ=
X-Google-Smtp-Source: APXvYqz3GsJY58S3hvbZ00NQUWpinbVYDH7+Zzz+T3z9m04BXZQRRk8RPlLWeE4iy5bKpBMOf/4aog==
X-Received: by 2002:a63:d94b:: with SMTP id e11mr66550963pgj.79.1577630222667;
        Sun, 29 Dec 2019 06:37:02 -0800 (PST)
Received: from xndcndeMac-mini.lan ([104.243.28.95])
        by smtp.gmail.com with ESMTPSA id i9sm47327622pfk.24.2019.12.29.06.36.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 29 Dec 2019 06:37:02 -0800 (PST)
From:   Xiong <xndchn@gmail.com>
Cc:     Xiong <xndchn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chris Paterson <chris.paterson2@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Sun, 29 Dec 2019 22:36:23 +0800
Message-Id: <20191229143626.51238-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some of the common spelling mistakes and typos that I've found
while fixing up spelling mistakes in the kernel. Most of them still exist
in more than two source files.

Signed-off-by: Xiong <xndchn@gmail.com>
---
 scripts/spelling.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 672b5931bc8d..e95aea25f975 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -39,6 +39,8 @@ accout||account
 accquire||acquire
 accquired||acquired
 accross||across
+accumalate||accumulate
+accumalator||accumulator
 acessable||accessible
 acess||access
 acessing||accessing
@@ -106,6 +108,7 @@ alogrithm||algorithm
 alot||a lot
 alow||allow
 alows||allows
+alreay||already
 alredy||already
 altough||although
 alue||value
@@ -241,6 +244,7 @@ calender||calendar
 calescing||coalescing
 calle||called
 callibration||calibration
+callled||called
 calucate||calculate
 calulate||calculate
 cancelation||cancellation
@@ -311,6 +315,7 @@ compaibility||compatibility
 comparsion||comparison
 compatability||compatibility
 compatable||compatible
+compatibililty||compatibility
 compatibiliy||compatibility
 compatibilty||compatibility
 compatiblity||compatibility
@@ -330,6 +335,7 @@ comunication||communication
 conbination||combination
 conditionaly||conditionally
 conditon||condition
+condtion||condition
 conected||connected
 conector||connector
 connecetd||connected
@@ -388,6 +394,8 @@ dafault||default
 deafult||default
 deamon||daemon
 debouce||debounce
+decendant||descendant
+decendants||descendants
 decompres||decompress
 decsribed||described
 decription||description
@@ -411,11 +419,13 @@ delare||declare
 delares||declares
 delaring||declaring
 delemiter||delimiter
+delievered||delivered
 demodualtor||demodulator
 demension||dimension
 dependancies||dependencies
 dependancy||dependency
 dependant||dependent
+dependend||dependent
 depreacted||deprecated
 depreacte||deprecate
 desactivate||deactivate
@@ -995,6 +1005,7 @@ peice||piece
 pendantic||pedantic
 peprocessor||preprocessor
 perfoming||performing
+perfomring||performing
 peripherial||peripheral
 permissons||permissions
 peroid||period
@@ -1166,6 +1177,8 @@ retreive||retrieve
 retreiving||retrieving
 retrive||retrieve
 retrived||retrieved
+retrun||return
+retun||return
 retuned||returned
 reudce||reduce
 reuest||request
-- 
2.19.1

