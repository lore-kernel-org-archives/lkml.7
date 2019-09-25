Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F05EC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3B420673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeqkmrFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfIYWFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:05:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37481 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfIYWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:05:24 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so1042730iob.4;
        Wed, 25 Sep 2019 15:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/Y5ob5E+HD9UqjngBhzV+9l8IEWzzDfpFHErKIW6oKM=;
        b=oeqkmrFijiGnkgkJu+TWcXF3tUWBbSXG2Vf6UpyWTUP2baHSnmwk+L18eL7ihW7Yyc
         yidZ2QwykKAPSMHxJ1RbJAOgEAulS449VdM1+4sAO0YTVnT0vuC0jKid4Od7xDb8m0k4
         Y8vw8CVRftNfrrb4xQpe8RHA6FnH3nerkUELuldInT6AlH9UldG1mxgM1NIKLPe2sRa9
         +90g9PEoS9fS4AtTHOlXKAD19mEtn9KiBBVW5rQ0dLWVTf0JPU4Pa71MZ5ouYoKy41PQ
         zYatnnKWHRSL7a0XGVRcCaOPJTTBIc2eH692/UDWf9fqY1L3EN3LZrF/VWsFsnrU5JLo
         hnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Y5ob5E+HD9UqjngBhzV+9l8IEWzzDfpFHErKIW6oKM=;
        b=IKVOPictJ5zgIuoJA8Kk0xdezyIbTIrDHsK22ewFyy7CDSQc4aH333Wn9s0aSe4LOs
         C1OQxpHPWRaYd6d84kq+66w0xEDFyNfWHypZ2q1///1t6snHkdBCF0TXxNmWDezdkev1
         UA7AyXJIFVvhRgHpdG2WjruKJbGabAw7UNziUBrnb4BqxjRTGaMPX+J1dFfFVxANFsgH
         jA4CXdSkI7zE6spDfqRVatXeNh/BhRSDMkihYZS7CisgP3h5xGGiVKt/ggDFG5bPqgRA
         bms9RBAaVDp5i/sA0DnIv3gUNse+vR0TsqA8WdwhRwn+SI+z8ns1CZ63TkJ2htKGBkU3
         5G6w==
X-Gm-Message-State: APjAAAXGUqfQDG3HESJUbM+yHaRpprq5BS/2w2kS6NDUUl3ipWruVQ/+
        9pk8OY5ZX9NDAvLxcbW2piUclkotED8=
X-Google-Smtp-Source: APXvYqzKhOA60Y3ng9TmMNf3x7rwHS5IWVyMRFguYzq7sIK3eTDSkjOFvxn9x9uetf5Cpa2tmRi8WQ==
X-Received: by 2002:a5d:9714:: with SMTP id h20mr185720iol.294.1569448741769;
        Wed, 25 Sep 2019 14:59:01 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c6sm425824iom.34.2019.09.25.14.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:59:01 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/ncsi: prevent memory leak in ncsi_rsp_handler_gc
Date:   Wed, 25 Sep 2019 16:58:53 -0500
Message-Id: <20190925215854.14284-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ncsi_rsp_handler_gc if allocation for nc->vlan_filter.vids fails the
allocated memory for nc->mac_filter.addrs should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index d5611f04926d..f3f7c3772994 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -800,8 +800,10 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	nc->vlan_filter.vids = kcalloc(rsp->vlan_cnt,
 				       sizeof(*nc->vlan_filter.vids),
 				       GFP_ATOMIC);
-	if (!nc->vlan_filter.vids)
+	if (!nc->vlan_filter.vids) {
+		kfree(nc->mac_filter.addrs);
 		return -ENOMEM;
+	}
 	/* Set VLAN filters active so they are cleared in the first
 	 * configuration state
 	 */
-- 
2.17.1

