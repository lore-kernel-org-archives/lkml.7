Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6890C2D0CF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8657D20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="cSARCu8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLYG03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:26:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45889 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLYG03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:26:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so11658770pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 22:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jZH1Nd14C4y1v7M9e0zeyyhv8KS4mYmJ4ps3dkwUq6U=;
        b=cSARCu8BcGVOjjooyN/fRaiPim25pg5M7o5ewQm0qlByNomuX0rBXxUcybCA6+Wszz
         f9ZS6S4KC4vQppjoW1F6DAmhzRR5eykmx0Xwms22l9dy3Elb6/eg5MMTFkL6OyaOV2/F
         0cP7OD9MpXVx1ZAA5GoPLOh2hFcttQsk//tZcP11RJFgUAEx7o8+bS7olAGByQGr++Ex
         AevnWJO29QVfR2chIsJqXgC5XoZ17kyfsG0bvqsTFqJaJXyqkxfgHiDZjTrGHTNmgMoU
         isuvE1QTJ+MSVNeyehOh1kXQl4aAXnY+OYz1SNLa8UjuvN6ZAN7OQ0ZtENtbgw4HkoZP
         9C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jZH1Nd14C4y1v7M9e0zeyyhv8KS4mYmJ4ps3dkwUq6U=;
        b=FUcbAa8smVp6EY9TF6G1ctZZc42HvSybF57b6kA4T8JSsrFbg8eTg4QB+kcYRi3uOD
         D9rOrtlGSmih5qyTJy1MG25RBiqRHO1Lz3IWm3X9eFSZ75tSBxZBMDFXhD5ZPDHtdviK
         tTgPqilVpznNtsXWuXQPqWos7gpt15P2Lfi79u4cgPDnwbf+x3MlNV7EJGV/trChsyRc
         HLEpphuYqlC902BOFSWGFwNdpOZDpyOauRgMwxa7UExTwaX0GY1ltSP8NHuhUTmeMKBh
         gWftK51aekRf5REKT6KxTPAbfTivkYNmFNoAEuViUxhbb8La6iyU1PbAWibQYqacxvM7
         IXPg==
X-Gm-Message-State: APjAAAVTF3aZOCSijtInMr1SFTIDtSCflhPHo6U8OWeiU8s7mTJG0kXQ
        PgVLA6ADzN2yCiNpI28hMN2d3w==
X-Google-Smtp-Source: APXvYqw0fjpRsVmlvDAPhKnuWJ0kSbeo4g6EMdxN9ly15W+RkYOmVMSW6Cyqzp5iGcSkyhKwCdaD3Q==
X-Received: by 2002:a63:e954:: with SMTP id q20mr43060915pgj.204.1577255188578;
        Tue, 24 Dec 2019 22:26:28 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id j7sm30875474pgn.0.2019.12.24.22.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 22:26:28 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH v2 0/2] misc: pvpanic: add crash loaded event
Date:   Wed, 25 Dec 2019 14:26:20 +0800
Message-Id: <20191225062622.60453-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PVPANIC_CRASH_LOADED bit for pvpanic event, it means that guest
kernel actually hit a kernel panic, but the guest kernel wants to
handle by itself.

Suggested by Greg KH, move the bit definition to uapi header file
for the programs outside of kernel.

zhenwei pi (2):
  misc: pvpanic: move bit definition to uapi header file
  misc: pvpanic: add crash loaded event

 drivers/misc/pvpanic.c      | 12 +++++++++---
 include/uapi/misc/pvpanic.h |  9 +++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/misc/pvpanic.h

-- 
2.11.0

