Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CC22072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D116hLM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbgAIPYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:24:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42816 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732362AbgAIPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:24:24 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so6129825qtq.9;
        Thu, 09 Jan 2020 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWNCEr7Y0E2jpBWo5WW7zoI6piAesxsrYle93t+slgI=;
        b=D116hLM3lkHdbMP1J9dMKKWF+DlDf1lyaYiIVcZyHLzFs/K7HKLKji5e5waw159E3X
         oLH68GsILRsNso+tUPqy+I5vuPXaEPyF1mF2Oy3Dy8sa6ZaC8IAmfKpRN+G5yRuB3cWW
         RK0Gt1fI38mqnML7veBC3Nn3/AtM0SF43IWpxfuqsIFLjcJaiQZuv/0auUkXZkmPixoG
         brKOOzbvlwl6Hl0InzcnwyFTsQTYNNNltNa/hjhASZ2eZiRuxJDLx/0zrznCvEWzrV9A
         fBjVrhCsMfwA1I6KKFf4upmlVcbTYcdsDGJcK0+vL/RvgIcNHb56OTypYLuz9xkh5j0r
         zI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWNCEr7Y0E2jpBWo5WW7zoI6piAesxsrYle93t+slgI=;
        b=UPGEX2O9Orfzwjp5VvSeo0nF6qlFuJM7OK3hqQfbzrFDW8FrIcGMz/CtuMdH/7/aQB
         BuYc89EWnzF1hGxD0N16ZyjL+UGr8LJfHt1y6WsLXbkXzUAJdwyX3iqXzebgbRilNhMT
         ioQwz1lsbQtOytYpxrZPtx0y1Bq1yHhxJAvn6+Ocot7kSCnSeu0c28TqS7sNCv3yNYOF
         gAmP2haXRC5nUCISJq4NABgIohWi0pQopiaMTG+qVRt67LcZWhU0peZtl1wq8Kvg2usf
         hA0MVCPHWrR4z7KA9O5SwpuKGcIW0d5ab2Ok282WW9R3DOzxmTn3EpfPy6/e+d7qBOY+
         8Vxg==
X-Gm-Message-State: APjAAAXhfw/l2prfYqQSrTJdtIhetmsTmtgdnElL0P41CTG24UbsvRRh
        crMJSV6ot1hyl9Chg4DECoM=
X-Google-Smtp-Source: APXvYqwQiMpPoRQSE+6GVjiDdTHEnopuFTn2TSErNMH0LELVLEi+3ZQm1tRO9sbIbwDJBVwNXDssEQ==
X-Received: by 2002:ac8:36ab:: with SMTP id a40mr8600301qtc.181.1578583462979;
        Thu, 09 Jan 2020 07:24:22 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id w21sm3641361qth.17.2020.01.09.07.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:24:22 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab@kernel.org, sean@mess.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/1] Implement a DVB Dummy Tuner
Date:   Thu,  9 Jan 2020 12:24:07 -0300
Message-Id: <20200109152408.919325-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

This patch series should implement a dummy DVB tuner as part of ongoing work
on a virtual DVB test driver under the 2020 Spring Linux Kernel Mentorship Program.

as 
Daniel W. S. Almeida (1):
  media: dvb_dummy_tuner: implement driver skeleton

 drivers/media/tuners/Kconfig           |   7 ++
 drivers/media/tuners/Makefile          |   1 +
 drivers/media/tuners/dvb_dummy_tuner.c | 153 +++++++++++++++++++++++++
 drivers/media/tuners/dvb_dummy_tuner.h |  20 ++++
 4 files changed, 181 insertions(+)
 create mode 100644 drivers/media/tuners/dvb_dummy_tuner.c
 create mode 100644 drivers/media/tuners/dvb_dummy_tuner.h

-- 
2.24.1

