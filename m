Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05E2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF41B21743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQrDmWwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfD3JDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:03:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34473 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3JDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:03:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so5554843pgt.1;
        Tue, 30 Apr 2019 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28WGuCBBFm21UZ3ZuAiDJTw/9QkSfSZcOBb9vRhxge4=;
        b=AQrDmWwpNT+T395B8Q9G4G5VWjsfcSlK0ptV8eLmSNUWJlydaj7dFw2aFVcLf9nz+Q
         LJ+Yd7QeX7DeJbSin61VEqmXYzMQpkK9UvpbklwKPwgl7aY/IL5LyQNpvXXLwpKXrwfV
         iuZ0Xns3XCEqKUAqFs2Y84JMvYuUHT6J0i39usAvPx6xkFe33KuOPoMrxZks5swRB83K
         khEssQHN/lBOUuWR7l/xqFALwKgNkWnCYFhYEyMUw0UpohJrqMC2U4OGUtclvIkBBvIg
         bwoVdu8o+hJFKdURNZ0oxR21Zvk5OqU5iKlFRm20Q6KR47Ty6mtbmfxkusNESRgsDf8l
         2lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28WGuCBBFm21UZ3ZuAiDJTw/9QkSfSZcOBb9vRhxge4=;
        b=cAHsFhi6EX/T2mA/cB/vGrxhgA2QX9Lio+gHDSTNtzgjQCruIrmFZENgwReNFOh0/z
         F+kYxQmCeqCuah5btmCj81xIr/iPsrWto4Qy4yP2G5NiYVFAZ+jmh/wj/QeBUpj3iBwl
         TFN01qWPxcjnWjJXHZWvF9m2PfX+VXwBZX4ToxWJ/sqqf4ieeMv8RAMAZPlbLpdx0TbD
         1uGj1O8tiYAn9ztGRyuYe/1Wv3q3zYT6nkVhwEAit7U3sith/xFDMaWvdDc80QIk+d40
         499uIJeEuj0WemPmoOzjfPfYrC445oLZud5F/Nx5O2m9QkBrfiwYRFPPg+uD8gghUht/
         O98A==
X-Gm-Message-State: APjAAAWfFQc3pipj4dpOMwDiBkVmuhyfKlwYQMM+kTJzPrS9GIb0vDEm
        BW22lW7escGnpBXDLXE7298=
X-Google-Smtp-Source: APXvYqzqAsQgtyWufMxSD/Apnr8EtqzXxFoda5uMAJZ2kpQWycUmF6FNEIzQ6E0tkUW4qSjR3gxUZA==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr63480562pgh.86.1556614983164;
        Tue, 30 Apr 2019 02:03:03 -0700 (PDT)
Received: from debian.net.fpt ([42.114.18.133])
        by smtp.gmail.com with ESMTPSA id a10sm46354308pfc.21.2019.04.30.02.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 02:03:02 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com,
        pantelis.antoniou@konsulko.com
Cc:     natechancellor@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] of: replace be32_to_cpu to be32_to_cpup
Date:   Tue, 30 Apr 2019 16:00:44 +0700
Message-Id: <20190430090044.16345-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cell is a pointer to __be32.
with the be32_to_cpu a lot of clang warning show that:

./include/linux/of.h:238:37: warning: multiple unsequenced modifications
to 'cell' [-Wunsequenced]
                r = (r << 32) | be32_to_cpu(*(cell++));
                                                  ^~
./include/linux/byteorder/generic.h:95:21: note: expanded from macro
'be32_to_cpu'
                    ^
./include/uapi/linux/byteorder/little_endian.h:40:59: note: expanded
from macro '__be32_to_cpu'
                                                          ^
./include/uapi/linux/swab.h:118:21: note: expanded from macro '__swab32'
        ___constant_swab32(x) :                 \
                           ^
./include/uapi/linux/swab.h:18:12: note: expanded from macro
'___constant_swab32'
        (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
                  ^

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index e240992e5cb6..1c35fc8f19b0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -235,7 +235,7 @@ static inline u64 of_read_number(const __be32 *cell, int size)
 {
 	u64 r = 0;
 	while (size--)
-		r = (r << 32) | be32_to_cpu(*(cell++));
+		r = (r << 32) | be32_to_cpup(cell++);
 	return r;
 }
 
-- 
2.21.0

