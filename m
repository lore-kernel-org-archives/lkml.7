Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA6BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6FE205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAZ5IYVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfDZPtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:49:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42170 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDZPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:49:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so3544664eda.9;
        Fri, 26 Apr 2019 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAwdcNNwsHxSmWuLiJIrpPJgHydtjnCp4Y4NYOp8uI0=;
        b=aAZ5IYVJgBU0TKKoWVJAg4Ei1qp/FRc4xK7iHDR4Go7I7HBVLSX+zba/za4OFq8WCg
         qZPUU4lG+/l2u+OqBpla28f3jMHDcMHqrQZz7OGkPhQmu1BP+OL/c7cJ42bLLDU/W9yC
         JnaM+vV8SmbPcAZawX5qI8aW2nleYthwi/khjV/A0VO53BdL8qnDqo9aTM+A+flLOmFw
         M7/sOvuua5eZ8EkAiv+WzLJSYT6744qsiDM4/SgV/K1S8wRXo69hcLXctHnslXzB9m2k
         YkqSHpWWM/LCc+mYPTowxnEA9tHLluP8OlqCwgLvMz7CTMeY0HJ69fgcXtBs59qgBaZT
         /IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bAwdcNNwsHxSmWuLiJIrpPJgHydtjnCp4Y4NYOp8uI0=;
        b=QkOdd8ux4SeblAqeoEwllJkYzxjTn1NEAoXiJW7YV+n0SJbm5d/vsliHEgVPeYMBvc
         uYHaBHLxokQ77GJrfCRuJfTKhACvXAFR0aq7prSQzKdCBmLK+f6Qcjt9ggHs9+uCdsnb
         j8HwkqCDY+Aly6/1/Zr4ZymqPN7bDQRO8ceH+sLAtbhBsxuwZvtk9P3/3loj3rJHHzbN
         UHZrxQs7nMG83QBfY/9Cb/Ci5hlA3ZCY+Z6otch+Fk+nKCxWWafRTCVlNCD1iMkRjohS
         Wvct8+eutTm6mCWuqU/X+QociWw3hU0zGWjCbyWd3+LCVmOmMRJsIZqHOdhdHiDaiR9W
         hxIw==
X-Gm-Message-State: APjAAAX3aPX700YzMZceoBluGPmjKDTpDBtkaGSEWIHXGY1GZSqbIdWe
        dbNPGRAgujqCPG/9p8V/8UU=
X-Google-Smtp-Source: APXvYqywg+0xQ8gLQ3eQ/ykppuePdK4Kklh+JLKFcHzHb60NM5u/XTVSsnWYI87pS8HEdnd5UqOf0A==
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr28735831edx.279.1556293780571;
        Fri, 26 Apr 2019 08:49:40 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id f15sm4603002eja.39.2019.04.26.08.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:49:39 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v3 2/4] bpf: sync bpf.h to tools/ for bpf_sock_ops->netns*
Date:   Fri, 26 Apr 2019 17:48:46 +0200
Message-Id: <20190426154848.23490-2-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426154848.23490-1-alban@kinvolk.io>
References: <20190426154848.23490-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

The change in struct bpf_sock_ops is synchronised
from: include/uapi/linux/bpf.h
to: tools/include/uapi/linux/bpf.h

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v2:
- standalone patch for the sync (requested by Y Song)
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 704bb69514a2..eb56620a9d7a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3206,6 +3206,8 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	__u64 netns_dev;
+	__u64 netns_ino;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
-- 
2.20.1

