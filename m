Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C35C31E40
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 02:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0A12073D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 02:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWH0xTg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfHDCsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 22:48:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44383 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbfHDCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 22:48:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so37951374pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=//GfN3Tbw0iv5naNbxPygrhfLkS7hy9vXqEmA+ERuTo=;
        b=jWH0xTg/65qp8vQiXDVhWNKmPIRchShll3kyPuLJ0T1HSLWmsqStAdcfAFEJbQGPJB
         TRbV2ehDZ1w+s4qtip8bQt32gi+URtuRkaRz79e/Epp4XCKc7GeL0axSdAwMauM7Mi7/
         PoB5LboeDtzanpCpTIhVxGcN4BQUVfbpUMHPaixfaDFHUYXo4dR+WLHaM2J9Dww1bmwa
         wWKvH/FjMS4BgtzWiO7VlPlN9PcyadiRE7OpIj7jrIR3EbT5/VSfaZ42HLMk/jqDNvL6
         o+Sp89FIyJoXr2NKo/W6NrAV9GA/VV7GdclMVFEajjekO25ZJJpXq12OKbaqYnF/aPbd
         SpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=//GfN3Tbw0iv5naNbxPygrhfLkS7hy9vXqEmA+ERuTo=;
        b=Gl2HEzSE1KI7YLlXy984DVaOQDajWUmCeRalCrQ8CU+TXgMp07uYKuxsvW1+3qllrT
         aUsDj7TgWg7TN8mbqAGkWSTbNC4YZFYxnzqMkrSj2iUq5QDTxsmdYsL7nS96EXmNHcH6
         oK1707qNw3uHVmwNz+bjkVeAvZ1e91IBcFKmUM0dnc3dOi1GuaXkb0nfSQYPGIDYk545
         94a/9IJdS0azGV/Ro3QQuoqXiKtMebhBroLP64Bx48+my2dMxggi1jy4rLxIBpxfCvzI
         L7tfr7MbQTF/nR36Wrqm30/gKovkyYfbu5axWOk7clsObb+f/ocb2kVW+gC1hl8fC6XK
         YP+A==
X-Gm-Message-State: APjAAAXrWY0Uc/23etUhZhJOsHF6ddKfrgfyiLrDPrPurJl00Zre0Muj
        jaqzby4cgOREGcjphSSTsT8=
X-Google-Smtp-Source: APXvYqxkqMIr3gd1UerXuwiuO6nIs3V0SevBtiYxmIFJNu9y3PmizlMcRVTekpQOlTtIydziFx/nIg==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr11734655pjc.63.1564886917381;
        Sat, 03 Aug 2019 19:48:37 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id u128sm90686772pfu.48.2019.08.03.19.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 19:48:36 -0700 (PDT)
Date:   Sun, 4 Aug 2019 08:18:32 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     joe@perches.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Michiel Schuurmans <michielschuurmans@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8192e: Make use kmemdup
Message-ID: <20190804024832.GA14352@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As kmemdup API does kmalloc + memcpy . We can make use of it instead of
calling kmalloc and memcpy independetly.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v2 - remove the netdev_info() uses for allocation failures

 drivers/staging/rtl8192e/rtllib_softmac.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e29e8d6..f2f7529 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1382,15 +1382,10 @@ rtllib_association_req(struct rtllib_network *beacon,
 	ieee->assocreq_ies = NULL;
 	ies = &(hdr->info_element[0].id);
 	ieee->assocreq_ies_len = (skb->data + skb->len) - ies;
-	ieee->assocreq_ies = kmalloc(ieee->assocreq_ies_len, GFP_ATOMIC);
-	if (ieee->assocreq_ies)
-		memcpy(ieee->assocreq_ies, ies, ieee->assocreq_ies_len);
-	else {
-		netdev_info(ieee->dev,
-			    "%s()Warning: can't alloc memory for assocreq_ies\n",
-			    __func__);
+	ieee->assocreq_ies = kmemdup(ies, ieee->assocreq_ies_len, GFP_ATOMIC);
+	if (!ieee->assocreq_ies)
 		ieee->assocreq_ies_len = 0;
-	}
+
 	return skb;
 }
 
@@ -2259,17 +2254,12 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 			ieee->assocresp_ies = NULL;
 			ies = &(assoc_resp->info_element[0].id);
 			ieee->assocresp_ies_len = (skb->data + skb->len) - ies;
-			ieee->assocresp_ies = kmalloc(ieee->assocresp_ies_len,
+			ieee->assocresp_ies = kmemdup(ies,
+						      ieee->assocresp_ies_len,
 						      GFP_ATOMIC);
-			if (ieee->assocresp_ies)
-				memcpy(ieee->assocresp_ies, ies,
-				       ieee->assocresp_ies_len);
-			else {
-				netdev_info(ieee->dev,
-					    "%s()Warning: can't alloc memory for assocresp_ies\n",
-					    __func__);
+			if (!ieee->assocresp_ies)
 				ieee->assocresp_ies_len = 0;
-			}
+
 			rtllib_associate_complete(ieee);
 		} else {
 			/* aid could not been allocated */
-- 
2.7.4

