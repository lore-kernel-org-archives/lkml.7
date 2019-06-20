Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1973620679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmqkXCli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbfFTOLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:11:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36441 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732064AbfFTOK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so2856875ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5sQG+Tf/VdEu5HF//CktSQgqtzNV5xwUlC9bLlmokHY=;
        b=YmqkXClicvVzXJIojhfwWJg+SDueLC8Y6YRPoBFhOQxvPFN+3P7iP/frhMOhnINea1
         7BqyWv4kQ+qHg2SAJPH2asaf9ONUY2X9iIfuL8JeuYn2Rhku5/i+QwfEq19ou6flWMc6
         Jq1GdPS03V3xuehgvsitenUEkUiQlnNOaXPZZqKR5Zf8epNhdASIKYfVTf1oDrxbOK4K
         6xP2+nlkctafF5SXzv1G6VYvhh3s1X2vkdMzBhLC0p4nMVyPRLPoRxwZS8XsuMKdiLpN
         8I55lg1joWJh6LbMgKnpTLeG3mia02palgIT2WC5nesz0tbxvsLsEjVXDnjKwKuXeO2P
         b8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5sQG+Tf/VdEu5HF//CktSQgqtzNV5xwUlC9bLlmokHY=;
        b=r1Oe0Cc+2w9FlF7EbLhv9coAX1UZdgyqOkUQ1SlgzoNnK17M25Ese3FN08Apn7uBDS
         a912lTd4zO3ustavNBbbL5pPLr/X0vMy8x1HBo7bpmJUPrjdowKAqQh+VAGBr9hoEU4G
         5/snOixfS+3S/A8s4EmZAjXHI+hm2X9mWnvB0lrG9SP6i1dCSVYkSMOErYaVT536P+DE
         /PccfYElwOOr5+/rBQ1oRDz4vpu52jzLPJdXzL1a3KfRaS2FM4rOhThTSmP6AS4zMIl7
         qYRTDh0FiTOG8TI9GVqoePrNe0HdQ8ftK1AckVm9Z4JlTOzZHcUHv2st2pp98g7sveBk
         e41g==
X-Gm-Message-State: APjAAAW+IIoRZNi70qQ/vQFqRN3fJAcRk5I+TMwWxsckn7ePhXZ05/PT
        I9fdL1FkwMF96+N8FucTRWBN0u7H
X-Google-Smtp-Source: APXvYqyo51+PZBFOnfutJV2tlA61v6p+dt4nSMCjaGZGYOphlJIKjQJvSdtKjGJgn7a9gJqoTxezGg==
X-Received: by 2002:a2e:8345:: with SMTP id l5mr1035531ljh.18.1561039855661;
        Thu, 20 Jun 2019 07:10:55 -0700 (PDT)
Received: from localhost.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id 27sm3524684ljw.97.2019.06.20.07.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:10:54 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 6/7] rslib: Update documentation
Date:   Thu, 20 Jun 2019 17:10:38 +0300
Message-Id: <20190620141039.9874-7-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder returns the number of corrected symbols, not bits.
The caller provided syndrome must be in index form.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/reed_solomon.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index e5fdc8b9e856..bbc01bad3053 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -340,7 +340,8 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @s: 	syndrome data field, must be in index form
+ *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
  *  @invmsk:	invert data mask (will be xored on data, not on parity!)
@@ -354,7 +355,8 @@ EXPORT_SYMBOL_GPL(encode_rs8);
  *  decoding, so the caller has to ensure that decoder invocations are
  *  serialized.
  *
- *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
+ *  Returns the number of corrected symbols or -EBADMSG for uncorrectable
+ *  errors. The count includes errors in the parity.
  */
 int decode_rs8(struct rs_control *rsc, uint8_t *data, uint16_t *par, int len,
 	       uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
@@ -391,7 +393,8 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  @data:	data field of a given type
  *  @par:	received parity data field
  *  @len:	data length
- *  @s:		syndrome data field (if NULL, syndrome is calculated)
+ *  @s: 	syndrome data field, must be in index form
+ *		(if NULL, syndrome is calculated)
  *  @no_eras:	number of erasures
  *  @eras_pos:	position of erasures, can be NULL
  *  @invmsk:	invert data mask (will be xored on data, not on parity!)
@@ -403,7 +406,8 @@ EXPORT_SYMBOL_GPL(encode_rs16);
  *  decoding, so the caller has to ensure that decoder invocations are
  *  serialized.
  *
- *  Returns the number of corrected bits or -EBADMSG for uncorrectable errors.
+ *  Returns the number of corrected symbols or -EBADMSG for uncorrectable
+ *  errors. The count includes errors in the parity.
  */
 int decode_rs16(struct rs_control *rsc, uint16_t *data, uint16_t *par, int len,
 		uint16_t *s, int no_eras, int *eras_pos, uint16_t invmsk,
-- 
2.17.2

