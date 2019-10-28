Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C003CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306B920B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="buaiJ3wC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbfJ1IAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:00:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39747 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbfJ1IAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:00:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so6370646pgn.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Teb+nHfVj7QdEHZ6F94pdipxxAtosBBL8l+HZTtIm4A=;
        b=buaiJ3wCZ4lN8R+UyQC0KOVQoxUBt6E4y93SYARVuR1cEQmv/6DKg4GcFkpHRoxyuZ
         owizS5k3E6U2+4tNLCi2VzzTujDhbLZADv9SNpK6h5Mz6od8pwnNy7juEGYAPj9frn3F
         yMPdfWr/m297s++31zAjbgfMq5FEv0rtrzsAX4Y2BOTh+VgZTwFpHrM5maha5RYfJ28s
         i8vTW8T+L+PZ6mcbUUiC2fx9aHpoqrolWGKjjfqnrPFR5V91EuX3/bL3FfVDEPg26AcG
         iWZwa4z03A1Bx0nETUvG+uyojlpdadDnzPWailVA/qhmAwdUW2H8KxKlfpRvCsiEm6Iu
         D7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Teb+nHfVj7QdEHZ6F94pdipxxAtosBBL8l+HZTtIm4A=;
        b=ppy1mIYudWDh4gBaSXXMjekodoZ2p9MwCshWfWY56igw8WMC9VgjPwrXMqn1XRosLO
         SGz7ZIJZUF/gwzrIXschcL57Hou1yRr109yr0EoXtP59JWpWCmBP+fbQOYK3XbOfSriP
         /vncuHb61XsOC7lhurnMkSlT5QntiuCq7ZcLRhTuDUbB4OR60/tF8R13zyuq+CWdncZO
         aFb/pDDeL/Th2BKJyJe95mPml+vfc41+LuwXPkRdabSx+j0bWH2wkp76FB7IEc5bumXO
         li+4CGEcdveJDTufcRVZb9sQKBuw4lvqWID5xknNUoi30OYnndHCr2LOfjm2BrdaMMRX
         KGMQ==
X-Gm-Message-State: APjAAAXlV9KtbkdCzn0MhFvB5r4KoBjLbR9OVKYPDCmE9hM8OlP9pqUZ
        53CK+YmwNrCUpSg0W7dkkukTuA==
X-Google-Smtp-Source: APXvYqw5o9OQqVfoQBgItzsJbWV2pBxZDfEZpu9OM5nA5X7iLkchHyEIoGZfQuSvRNFLCJ9raZ6acA==
X-Received: by 2002:a62:77c2:: with SMTP id s185mr3990854pfc.129.1572249648961;
        Mon, 28 Oct 2019 01:00:48 -0700 (PDT)
Received: from localhost.localdomain (111-241-170-106.dynamic-ip.hinet.net. [111.241.170.106])
        by smtp.gmail.com with ESMTPSA id y36sm9504752pgk.66.2019.10.28.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 01:00:48 -0700 (PDT)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] MAINTAINERS: Add Green as SiFive PDMA driver maintainer
Date:   Mon, 28 Oct 2019 15:56:23 +0800
Message-Id: <20191028075658.12143-5-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028075658.12143-1-green.wan@sifive.com>
References: <20191028075658.12143-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS for SiFive PDMA driver.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..330fbd050059 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14782,6 +14782,12 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIFIVE PDMA DRIVER
+M:	Green Wan <green.wan@sifive.com>
+S:	Maintained
+F:	drivers/dma/sf-pdma/
+F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@sifive.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-- 
2.17.1

