Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43B2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04AD21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnV49YIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfDXSe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:34:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40736 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733024AbfDXSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:34:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id d46so16822438eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vo4c7hHRHk8/rcPioIrAzeAi8vbX3IpYXxPQXVqn3yo=;
        b=SnV49YIJuM3gX/SUprc5aWfdJqI/vJEvmfipvzNCEjiPGznk7DZ/I+35j0+u3QTdul
         I5B+EtNor4GvC/IAh2Yo7d1rQ5ewohVXLEHfEHEMowirCXqKliRvEKuHWKIIhR3pc4NO
         XBuAADmQQaBRQ0OsFqdcq29wDueF1q8Q3oP9bXLLz42ly4aqFuszrw/WhvC710HhdV/G
         avPOw6N8HhW+AUE10HyhVumLrTr/R9RRK8El5ukalZZQoGdyRGs4WzebXBeCpb31yX+e
         nQ5Hd2v5gWPaNd+xjn3mTQKU7OQoP8fnoZ0AB8aGKY3tE+/0H+G7f75TDbsXv1/sDbLq
         NghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vo4c7hHRHk8/rcPioIrAzeAi8vbX3IpYXxPQXVqn3yo=;
        b=hxNldolne38qoXgpqbPK8xXTUV6/ulCPa13O2aX71XTJwAP0pro4foy5+YxG0BLZBR
         0rna9By1Rhb3x3+KUBcd9819ADj5T1DafQIbHkk4ufZW7EbFD9nqv5AwzdDSS3MzKJ9M
         9OfJvr5zoYtJaqEJrOjHBLEDivTBGhSleN2HNOkmh/B0vswXSZ5ud3jRrYZBKL6LwLDe
         NnHlDinP6ICy3tW76AWAkG4EPWzzG7LVRODGyHMoV0DWPQwEuYFDxeggaWLZSqTOwH7y
         QGLO6XmR+zeMoUMXR0ZCg8dDDTCZ2y9V8iPCIV9eO8T71KYe3kDS36aS/YVzpQ2L603h
         NdMA==
X-Gm-Message-State: APjAAAUICGWy0xOtP5Y8YBTsetzcuJg2VIFveTYdtwy2q1o9BFcE6G0Q
        5oF5p+AaihLza77GfzW5UlI=
X-Google-Smtp-Source: APXvYqzkxy0poWASWVhct7xC5APxEnlxys6p+j3M7vZeoodS3D7IKhICGCm9u4aYiIE2lwKC/Ehh9g==
X-Received: by 2002:a50:f78c:: with SMTP id h12mr21017166edn.196.1556130895331;
        Wed, 24 Apr 2019 11:34:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id ay12sm3734401ejb.15.2019.04.24.11.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:34:54 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] thunderbolt: Make priority unsigned in struct tb_path
Date:   Wed, 24 Apr 2019 11:34:13 -0700
Message-Id: <20190424183413.13854-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/thunderbolt/tunnel.c:504:17: warning: implicit truncation from
'int' to bit-field changes value from 5 to -3
[-Wbitfield-constant-conversion]
        path->priority = 5;
                       ^ ~
1 warning generated.

The priority member in struct tb_path is only ever assigned a positive
number:

$ rg -n priority drivers/thunderbolt/path.c
drivers/thunderbolt/tunnel.c:99:        path->priority = 3;
drivers/thunderbolt/tunnel.c:308:       path->priority = 2;
drivers/thunderbolt/tunnel.c:323:       path->priority = 1;
drivers/thunderbolt/tunnel.c:504:       path->priority = 5;

Furthmore, that value is only assigned to an unsigned integer in
tb_path_activate (the priority member in struct tb_regs_hop).

Fixes: 44242d6c9703 ("thunderbolt: Add support for DMA tunnels")
Link: https://github.com/ClangBuiltLinux/linux/issues/454
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/thunderbolt/tb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 15d225dcb403..b12c8f33d89c 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -225,7 +225,7 @@ struct tb_path {
 	enum tb_path_port ingress_fc_enable;
 	enum tb_path_port egress_fc_enable;
 
-	int priority:3;
+	unsigned int priority:3;
 	int weight:4;
 	bool drop_packages;
 	bool activated;
-- 
2.21.0

