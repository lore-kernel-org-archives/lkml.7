Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B35C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6732D2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVN7CoAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfC3Saa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:30:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39787 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbfC3SaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:30:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so4665069ljg.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5sQG+Tf/VdEu5HF//CktSQgqtzNV5xwUlC9bLlmokHY=;
        b=UVN7CoAZ2IKd+9gk7sLzy/YfiMk7hGb+A4iaFrsEMuXxolHWV4CTdKlLhn2sMWb4QY
         RmZqOIypeYNQfMyZq16n87P/RbTPbXd6hmF39RDzmacBHItch6mWZRePX1dwfyr0agkU
         oPSIhUjVr5OqDbZmP2sMTMDt/Hdg8eat1z5fO4OKW+/Rscav63iOJu16uq2oy1Kx/H8Y
         wliO8uT8xWY9t96P5JTMwyXaiB42/9lj6Nnp6myp/hbwd8tbTN1XzLtxBYvoIgLY2t4U
         17yjyg9AEqNnnFQr1+p3rel/Wz8f0LS//6e5Dr0M4DwWw7xWxM0LrXHRZcQ2wO7Y51JL
         ONQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5sQG+Tf/VdEu5HF//CktSQgqtzNV5xwUlC9bLlmokHY=;
        b=cZUSixc/K6yeogg1DZxi745X9v3KLPGgV/6Hh4qxhZ41ZbsS/zXS+4Cl1S5IRwWl6Z
         PbyQgPIUr43oi9Z67HTztqEQfLC635rKmcLV+fEGCbC6t3DbZmmYsOiqaDW4iyyz2E3c
         Pmo7C7/fLc/lOCySw+caM10oaOf0h6RRW4mxtiw6D9PNZbIkb0JMDew+kSsJflFcFmVe
         PI1zlleffEYvMs1Hvhukh2Gz3yOsZl3CIpkclYSVUBQ519/LehBEZXfPQJEe44wZoMP4
         stSjC3V4H6FZ0kAvEvTanrg/fXMcVEr0ZIp2oH/pnSoGs/2it/t16cvV4jtF/n7veAms
         yq/A==
X-Gm-Message-State: APjAAAVyjJO3Xum41EDrYTYhe/qjidnip083zyBmgdeBgQ0w0gQwpDxl
        xG1kIQHBmg0FN/20NJdClACU0m1N
X-Google-Smtp-Source: APXvYqxTJbbYXCwkdur/uAH2D5Fp4bbcWjCsgvby4Mx4tqA1+ZSJ4C7TGT1VvNUOKQdNM7DwOVSEKg==
X-Received: by 2002:a2e:9f05:: with SMTP id u5mr28128297ljk.183.1553970615403;
        Sat, 30 Mar 2019 11:30:15 -0700 (PDT)
Received: from localhost.localdomain (v902-731.aalto.fi. [130.233.10.238])
        by smtp.gmail.com with ESMTPSA id o7sm1060058ljj.23.2019.03.30.11.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:30:14 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 6/7] rslib: Update documentation
Date:   Sat, 30 Mar 2019 20:29:46 +0200
Message-Id: <20190330182947.8823-7-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com>
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

