Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0273CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D52217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5/OED+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfCSVsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:48:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45097 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCSVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:48:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so408352ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgukY8lT5p9Nw4d48jYXktyHrXeiB2/AhSVZo1B6Klg=;
        b=Y5/OED+xMd9YAhSPLD7lRnJI5zT62S06ZU6HFVQ7vZl9MYTtOuS6zJ22+eflSK7ISm
         4ermxuBkRv+HdUpJFBaGDRCNHK+aR0mYFk03plOuSLZaxPbpfb3b1QqUTsXFt28T3UEe
         etwQeaYEXWioL4mDqiVc2ujHuU6rprqQStLRpvqaLjZb+bGzJ4gE2fPkFKE/TDE1VHjl
         v9e7XOzfDW9+0nPTpv45RU3tMqi1X8+dzYMZ3fgPvNcH+1w4Dokpe7TOkPaPJ6jyYPuN
         EBrQ/fWBxjSSFVOuymKtz0mNToo0eBNfo3DfiJT9JZHHIYmVylZGsAOJKEmBBNa4xkdv
         2KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgukY8lT5p9Nw4d48jYXktyHrXeiB2/AhSVZo1B6Klg=;
        b=F3J/nANQf2g11HNN0kcCCxdPxlkErO7xHBypNTrvHpQk9N6AgnDJyE6ybDMA6hgEU6
         W92iJXc1KT6khtVDO9QsDg0OjF+c/hosjhNHMfV2OOTHUXzhOAlO6z05M251zGaVKj+k
         8oPb9yN2tpDdyc+5VgnUqI1Wagce8FhoO5e4TKLgVzHildNQCNp1Oh48BXgTL/gPuOjw
         scMyt77PSNof9m1AStFtpz5TAI9LncZ+2ltCgIMpNk2egMy2M6ERho31NPQ2y5f7fQiv
         PZAKjHWIAhI6fWyhND8IzuElj9nV76O01vHoiBlJQXCsf4qju8lZgF+4EZm9zwiESvB/
         qwsg==
X-Gm-Message-State: APjAAAUepzi14MIpP0lM26zH2HqSGzxSYw+Cl4kYidvVpOM0gtsKo/yi
        2vBWCzHSATawjF64+BVbChU=
X-Google-Smtp-Source: APXvYqxr072BJclIsA5xsmCqq6Cbj3nw0vuJPOyGGjCXwBwVI5dDOsJ1wZMRmF1JXJsOfRjGcuBhpA==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr4410862ljk.176.1553032088644;
        Tue, 19 Mar 2019 14:48:08 -0700 (PDT)
Received: from localhost.localdomain ([31.41.177.37])
        by smtp.googlemail.com with ESMTPSA id g134sm8956lfg.74.2019.03.19.14.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:48:07 -0700 (PDT)
From:   Dominik Adamski <adamski.dominik@gmail.com>
Cc:     adamski.dominik@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: rtllib_rx.c remove multiple blank lines
Date:   Tue, 19 Mar 2019 22:47:13 +0100
Message-Id: <20190319214715.7258-1-adamski.dominik@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issue:
Please don't use multiple blank lines

Signed-off-by: Dominik Adamski <adamski.dominik@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index debc2e40af00..6e8010591d7e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -20,7 +20,6 @@
 
 ******************************************************************************/
 
-
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/if_arp.h>
@@ -162,7 +161,6 @@ rtllib_frag_cache_get(struct rtllib_device *ieee,
 	return skb;
 }
 
-
 /* Called only as a tasklet (software IRQ) */
 static int rtllib_frag_cache_invalidate(struct rtllib_device *ieee,
 					   struct rtllib_hdr_4addr *hdr)
@@ -326,7 +324,6 @@ rtllib_rx_frame_decrypt(struct rtllib_device *ieee, struct sk_buff *skb,
 	return res;
 }
 
-
 /* Called only as a tasklet (software IRQ), by rtllib_rx */
 static inline int
 rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
@@ -363,7 +360,6 @@ rtllib_rx_frame_decrypt_msdu(struct rtllib_device *ieee, struct sk_buff *skb,
 	return 0;
 }
 
-
 /* this function is stolen from ipw2200 driver*/
 #define IEEE_PACKET_RETRY_TIME (5*HZ)
 static int is_duplicate_packet(struct rtllib_device *ieee,
@@ -895,7 +891,6 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	return rxb->nr_subframes;
 }
 
-
 static size_t rtllib_rx_get_hdrlen(struct rtllib_device *ieee,
 				   struct sk_buff *skb,
 				   struct rtllib_rx_stats *rx_stats)
@@ -1579,7 +1574,6 @@ static int rtllib_verify_qos_info(struct rtllib_qos_information_element
 	return 0;
 }
 
-
 /* Parse a QoS parameter element */
 static int rtllib_read_qos_param_element(struct rtllib_qos_parameter_info
 							*element_param,
@@ -1634,7 +1628,6 @@ static int rtllib_read_qos_info_element(struct rtllib_qos_information_element
 	return ret;
 }
 
-
 /* Write QoS parameters from the ac parameters. */
 static int rtllib_qos_convert_ac_to_parameters(struct rtllib_qos_parameter_info *param_elm,
 					       struct rtllib_qos_data *qos_data)
@@ -1877,7 +1870,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 		}
 	}
 
-
 	if (*tmp_htinfo_len == 0) {
 		if (info_element->len >= 4 &&
 		    info_element->data[0] == 0x00 &&
@@ -1965,7 +1957,6 @@ static void rtllib_parse_mife_generic(struct rtllib_device *ieee,
 	    info_element->data[2] == 0x96)
 		network->cisco_cap_exist = true;
 
-
 	if (info_element->len >= 3 &&
 	    info_element->data[0] == 0x00 &&
 	    info_element->data[1] == 0x0a &&
@@ -2175,13 +2166,11 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 
 			network->dtim_data = RTLLIB_DTIM_VALID;
 
-
 			if (info_element->data[2] & 1)
 				network->dtim_data |= RTLLIB_DTIM_MBCAST;
 
 			offset = (info_element->data[2] >> 1)*2;
 
-
 			if (ieee->assoc_id < 8*offset ||
 			    ieee->assoc_id > 8*(offset + info_element->len - 3))
 				break;
@@ -2236,7 +2225,6 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 						 &tmp_htcap_len);
 			break;
 
-
 		case MFIE_TYPE_HT_INFO:
 			netdev_dbg(ieee->dev, "MFIE_TYPE_HT_INFO: %d bytes\n",
 				   info_element->len);
@@ -2426,7 +2414,6 @@ static inline int is_same_network(struct rtllib_network *src,
 		(dst->capability & WLAN_CAPABILITY_ESS)));
 }
 
-
 static inline void update_network(struct rtllib_device *ieee,
 				  struct rtllib_network *dst,
 				  struct rtllib_network *src)
@@ -2614,7 +2601,6 @@ static inline void rtllib_process_probe_response(
 		goto free_network;
 	}
 
-
 	if (!rtllib_legal_channel(ieee, network->channel))
 		goto free_network;
 
-- 
2.19.1

