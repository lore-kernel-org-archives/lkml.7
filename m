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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292E9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F692070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjHUnmYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFTVKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:10:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44900 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFTVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:10:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so2342157pfe.11;
        Thu, 20 Jun 2019 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2SpWI1yibR3pZui+zsA5SWkFvXjKqrr9tlPiUDopnI=;
        b=QjHUnmYdROWMRYkxYVPmuYVPNDV1DbWvIZdcfWSL55ySQ0MctwPQ9kYZxtuXgqp1WN
         EiEtZTikp/OrBL78jp7ZsaUlGVGvvU2GhjHeSxPORWHhACye+nvo/3LszmRKEV9cA7Q5
         egtZ2bn2jLsOfpLFDWD43lWgiS4k0/U3ZcdpvfDAfhGWrr8/Q8G1uS/Lxe3zz5Xyk77b
         0rEmNWPpy1awuYwCEZ9j1MBHCK53Gcsqld1OOY6ErSXX5okAvXyKv/zAwFmK3J1iTJX0
         9xovg3LrnJ7ssWLnc1wdc5IdyFN3adPCq7qNSLjRYp4bDD6aT2HOWUVZ5fMChUYmNXvM
         WVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2SpWI1yibR3pZui+zsA5SWkFvXjKqrr9tlPiUDopnI=;
        b=RCEPSJnt5KolhyWgB/zVisQoopjWtcIu7WLs58uIKeFGEbFUoLN/BjrJlVRl5va/Wi
         jGbZd58bTIEs1cXYqfchdrOo32HMcfspVTx3YAwJw6zQe5V8Jc1HuQpZjLFXkmPLzGYw
         QrRtPFO3v3pxbeexW3q+UGdqA6nldlpAgen4cf/sJ9TEFYmdDRXK37kRfi4JyDihij+w
         OBn3vknX8HUg+Aqbis8FSN5F4b5w3BwB2hFLGR3h7Wc+hACPK+2RidCnrVGC1B2jVCa7
         j8dN1tTH2N7HL9ey79fQ0xyWolTp8c7FNngDgxx2V0+3nWPAN+P7+ktuA/KUcgM2/zt1
         927g==
X-Gm-Message-State: APjAAAWO0zgXTCqAOvgQd+G6cweMGB+WBsd7ZWkd7lQtqnT+R2rEz9fq
        cbJlbFIp1G3KpRzyez8lWz0JGrBp9WY=
X-Google-Smtp-Source: APXvYqyqTjMPZxbB9dUfZRknPAWnuMOyFhDiYUlVPyNhviWwjbGwPMxDXClY5RvgmUGxxVByRgYZCA==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr1775554pjh.58.1561065009830;
        Thu, 20 Jun 2019 14:10:09 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p1sm386805pff.74.2019.06.20.14.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:10:09 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/6] usb: bdc: driver runs out of buffer descriptors on large ADB transfers
Date:   Thu, 20 Jun 2019 17:09:46 -0400
Message-Id: <1561064991-16874-2-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version v1.0.40 of the Android host ADB software increased maximum
transfer sizes from 256K to 1M. Since the STB ADB gadget driver
requests only 16K at a time, the BDC driver ran out of buffer
descriptors (BDs) if the queuing happens faster than the incoming
16K transfers. This issue is fixed by doubling the number of BDs
that can be queued so that the entire 1M request can be queued
without running out of buffers.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index 6e1e881dc51e..ac75e25c3b6a 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -44,7 +44,7 @@
 #define NUM_SR_ENTRIES	64
 
 /* Num of bds per table */
-#define NUM_BDS_PER_TABLE	32
+#define NUM_BDS_PER_TABLE	64
 
 /* Num of tables in bd list for control,bulk and Int ep */
 #define NUM_TABLES	2
-- 
1.9.0.138.g2de3478

