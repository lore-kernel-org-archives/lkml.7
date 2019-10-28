Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998CACA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646752184C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT52vDaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfJ1GHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:07:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44499 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731716AbfJ1GHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:07:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id q16so4813908pll.11;
        Sun, 27 Oct 2019 23:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N3AnrnW8m8clFq9XuX9N6KUkxKYhGl3KT2G9TPIKHEM=;
        b=bT52vDaGBuwdvyDqaSD1/IYjhM9gTx5GKu0rpFGpTnEp+vUUEry3qL26DvF4gTll+C
         Tsg6NIxfTMU8UPtxYojqJlAet/oJktqwY9hMv/NDujzqn4f9kiDSME3+3Y5hsnAZS8LH
         b96WrKIg58YXA5n6e3vcYIbyRDeSKZ0L2Ueus/iaZ2zqkrsVtUx4BWc40Kh+ilZ4/LNZ
         EHGZjbFwgKMJDf4C1WMnZJvA9ZFBV9yCqGpVsiTi/9XlEinuePMUleGRp0TX/bTtKGZR
         at4sGrNQYyv/v9eiv0dUdUzNvwDMCVD0p2bAAbiJ5bcTyZQFuRRYux5r5cjpnTLJKQcZ
         z2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N3AnrnW8m8clFq9XuX9N6KUkxKYhGl3KT2G9TPIKHEM=;
        b=pRc47WoXAgvhq2dvxWUadAteefh1aYHeiuNIMlnx7HRZL9XB2WbWrIIAYFk+6AKdGT
         Vp0z2L6FIbpxRUwwnZiMstadnbGDW4lEVfTI7E8Uy2xDpgjqNd4VYLPmVsW9lqs+TrDc
         lwmXzIEhxR6BXAJh9FZjWxP1JPJQZ4A5g0o7s/I90OwVlSBZQAhEryooGTI0psd9+ot4
         rZJtm/RC8pjVNSo7CiA5A2Vhf7p/sbliBihKu1qBee4KQxeCK7BMXpFTsdzcgrl6qiTr
         Tk4ZTclS39i8LW0n/O8i4SAmF6povxovY71HOuz/F1Ib9utha55TuAQqnnZ7MVzKasHR
         aU+w==
X-Gm-Message-State: APjAAAUewOKAVeyYLaK88d82EMhSLtvlDR351DQWr+3me+pJzzF2bUCx
        jQycC6ldHumFJu4q6QXStq8=
X-Google-Smtp-Source: APXvYqzUSnrIvw+xmNvs6HOdzZLoYxHxyluQ5VYTuyR6cYdBdKLk+sZRLjYcH4wWEmk0/9YY5QsZZw==
X-Received: by 2002:a17:902:347:: with SMTP id 65mr16901116pld.161.1572242844300;
        Sun, 27 Oct 2019 23:07:24 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:539:cf3b:393e:2dcf:24de:b4fb])
        by smtp.gmail.com with ESMTPSA id 70sm746781pfw.160.2019.10.27.23.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 23:07:23 -0700 (PDT)
From:   madhuparnabhowmik04@gmail.com
To:     corbet@lwn.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Documentation: driver-api: index: Removed non-existing document driver-api/sgi-ioc4 from the toctree.
Date:   Mon, 28 Oct 2019 11:37:10 +0530
Message-Id: <20191028060710.15154-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patches fixes the WARNING: toctree contains reference
to nonexisting document u'driver-api/sgi-ioc4'by removing
it from the toctree in the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 Documentation/driver-api/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 38e638abe3eb..6d46ceeb62c4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -93,7 +93,6 @@ available subsections can be seen below.
    pwm
    rfkill
    serial/index
-   sgi-ioc4
    sm501
    smsc_ece1099
    switchtec
-- 
2.17.1

