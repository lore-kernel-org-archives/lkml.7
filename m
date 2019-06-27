Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B275C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B47216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khQH0XHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF0DZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:25:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43722 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0DZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:25:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so469906oif.10;
        Wed, 26 Jun 2019 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jqnuOLrtXSxBh9hzF7jl+szgxHyLui5g61Cb7nScCKA=;
        b=khQH0XHCz8+7FsjpBdLjGgP/cd3kzdgonClS6lPvKNmjTBIb/hCrTRB6vqh5zRbbXf
         l+ed1UvXS1vLNshz4JL78W2G/Bxj8ZAI8JXY3ub9zGYr7We9m2UJvOsKlrLszuMK8i5X
         GZ5KDu4oeuphPMv/FL/bJfpczk4P1HBBvMHOA6TZIgaWlbhMzuQeYbdSf+FVcmyTPi6W
         cTpAVx+R+ALQPnTK1CjhHX7YMBhBZVyh7LiKMIJoJyqqNHpm0k3UIq+39c4agNzgr30d
         e6HiFXxYbWg8+jiwGiU4usAHGyc90/tb1vwLfxgqcCL3dWd7yqOta+BcaZDAqEi6++Tj
         AMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jqnuOLrtXSxBh9hzF7jl+szgxHyLui5g61Cb7nScCKA=;
        b=b8hUV3x1HFYhUVMzte3sWXsFBSeIRGUDxClRliYs3sLrB8pYJuUD0TLc6VTDdh9Bhm
         aTbpDe6i0jjzI0mpTfKh/x5GE96561Ay+GEtlHckocWrKKM7Av/iYfRjhlf8dgeJoyHa
         Y7BSA6brsfU3BNBuR0Bfjfjubl43ZsVbabhBwmVHVo++9BebXp7psY2xB5lzv3PsP/5+
         gWES26SdyQD7E56pjwJVRSjQiJJuxv+aaHm53/i4uaAUsLuWESSI6Fh8eL+RXlNsjL/H
         rp3XYbU+D1bnWVN1oEFgi/boSdNfF7AQfGSOGsgsbvbs2/EdyPTB5XJu7xAzz6/NnHCg
         QG+w==
X-Gm-Message-State: APjAAAXJzfHIQPeWga5c/2vBI0gagWVsq/DGXoJrT1zMQtf17u/n/U3x
        8QYwHXIbpWUQooYDMNZYi28EbHwMNDw=
X-Google-Smtp-Source: APXvYqydDefPUVguW4Pn7BsgoC3UJk4Va2DkEJmeaREdw7qPXqUJD509CAsU7uyuev4RiFYf8mbonw==
X-Received: by 2002:aca:f003:: with SMTP id o3mr979227oih.59.1561605934928;
        Wed, 26 Jun 2019 20:25:34 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id y184sm417647oie.33.2019.06.26.20.25.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 20:25:34 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
Subject: [Linux-kernel-mentees][PATCH v2] packet: Fix undefined behavior in bit shift
Date:   Wed, 26 Jun 2019 22:25:30 -0500
Message-Id: <20190627032532.18374-2-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627010137.5612-1-c0d1n61at3@gmail.com>
References: <20190627010137.5612-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined.  Changing most
significant bit to unsigned.

Changes included in v2:
  - use subsystem specific subject lines
  - CC required mailing lists

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 include/uapi/linux/if_packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
index 467b654bd4c7..3d884d68eb30 100644
--- a/include/uapi/linux/if_packet.h
+++ b/include/uapi/linux/if_packet.h
@@ -123,7 +123,7 @@ struct tpacket_auxdata {
 /* Rx and Tx ring - header status */
 #define TP_STATUS_TS_SOFTWARE		(1 << 29)
 #define TP_STATUS_TS_SYS_HARDWARE	(1 << 30) /* deprecated, never set */
-#define TP_STATUS_TS_RAW_HARDWARE	(1 << 31)
+#define TP_STATUS_TS_RAW_HARDWARE	(1U << 31)
 
 /* Rx ring - feature request bits */
 #define TP_FT_REQ_FILL_RXHASH	0x1
-- 
2.22.0

