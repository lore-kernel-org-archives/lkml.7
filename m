Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C43CC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3E6215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QS+X3oE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfJASdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:33:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45357 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJASdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:33:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id q7so10239567pgi.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jnSN9YmOheprwG21PrBNqfLBILdQ1P4B2+I4pJVgdBQ=;
        b=QS+X3oE3DUzVheGjAiwqzmPSjnwmJVy8eBf13WzMYBpv4X1VQcAQiqh5mSZHVWUmyM
         aBxcYpGy395FI8Hr6MxQZ/8DiXaGmAtjXHRFldeDH18KenofU7L2e5cskHjaI/FsdEuU
         3QV3HAi/nyWD3q4A28alHlne45zT8RpwxODNl+BvgyCGpovnZ/RF6Ck7NVATibodeVWB
         8WITWPN6TwWT2+hxz6e35rxv8L0yttp1QlMSZeIbRaJWW51KYzcQ5GTAyLBXckss+J6s
         VxELANTBueQ+W1cwLw2/b2Z1M1BF2K0Mr1ScKvyBlIVnzenVLFs04BiGA4/Xri4RR1Dm
         7rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jnSN9YmOheprwG21PrBNqfLBILdQ1P4B2+I4pJVgdBQ=;
        b=Ki6G+fs/hqRc4vw682IhW1sXCzXeVFLPUWFG8upRV0zRzUQeXI+miBSR+wb/zXIM8y
         8kylIuyWmyn8y5uEIuToMeIY10j2GWv/SNT7Z/GEiuMt0xihG5qVC5zHnfWP2A9tLuHQ
         A9ub6mWQvKSC+xT/OWMMf+HYgA367gO5Onj9aTO7Zr2rq5WXu7wYgLap94JaSF5WcRIH
         jJVfoAwOSczQN8MMq2CmE2hFrGFU6nZJy5Q7tp7auGNXTzRIk1iCVG64HQi8pvWWodIX
         6w3rqhW/HmxkvoWxL/WQbePLywMexThIeRcl50wJqmsYR87P1ZH1jnlk4lhcAkil/Q/6
         hPsw==
X-Gm-Message-State: APjAAAVV8pbING4ez9Vxsy7CTeAx8JyHWdNq/49egYGrqNBJME+ht5ly
        eJbCNg32VFVdiMFUQVNH3iMnPbEqhnw=
X-Google-Smtp-Source: APXvYqz6MsAdZSlHtUNRHakIXzpsW94dW14d/CK6CNmIMkvVJz5Y2T6j3L2nm6ELNanmgOYWKPsZuw==
X-Received: by 2002:a62:5cc3:: with SMTP id q186mr28882257pfb.15.1569954783854;
        Tue, 01 Oct 2019 11:33:03 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id bb15sm3094052pjb.2.2019.10.01.11.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Oct 2019 11:33:03 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, jgg@ziepe.ca,
        christophe.leroy@c-s.fr, thellstrom@vmware.com,
        galpress@amazon.com, palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] scatterlist: Comment on pages for sg_set_page()
Date:   Tue,  1 Oct 2019 11:32:50 -0700
Message-Id: <1569954770-11477-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Update the description of sg_set_page() to communicate current
requirements for the page pointer parameter.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 include/linux/scatterlist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6eec50fb36c8..6dda865893aa 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -112,6 +112,12 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
  *   of the page pointer. See sg_page() for looking up the page belonging
  *   to an sg entry.
  *
+ *   Scatterlist currently expects the page parameter to be a pointer to
+ *   a page that is backed by a page struct.
+ *
+ *   Page pointers derived from addresses obtained from ioremap() are
+ *   currently not supported since they require use of iomem safe memcpy.
+ *
  **/
 static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 			       unsigned int len, unsigned int offset)
-- 
2.7.4

