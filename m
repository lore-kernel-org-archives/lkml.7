Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12ACC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9039123AFA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfE2Pjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:39:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfE2Pjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:39:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id t5so1934212wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wA/ZRCMpAdjeog1co5RlW0FUMxyaCyOeXXfAXJGss50=;
        b=Snh9C/TPoZPrg5dP2dC/KhnENooBDyMobALuII1lFma9XzwlUgGCua6Kf4NvxDxvK2
         gP/AS2rpIBK/9Bf4YbUO2MVbfglFUVxg0ObGpkzkgzFClPwACnaYfliCtgCW/jJaCNjl
         O9YCADaZgXzW3DqeYdsecabw1qJLsI+OkYDuoQhGDomO9UyKJaPBk2oxLVMcV2TMKqqf
         phCwKuWc3ryQV0AsfCymtWqZ6sFItvmftWXYJdhVvyEljoiRxhdfzyCOutun/vGNIW4q
         yF9WYSWdGPSjJWkOTb5pgyaDxe+7TvV2JKpw6eUzXVTmgpQLZb7aktYTTT3rAZicS/vX
         yU2Q==
X-Gm-Message-State: APjAAAUnqYsUDNilJfMunamr87NOUboe9WTpfZO1p/V2V0xwqoY5jAXT
        I9CLnXT9c4gP/s3oRWDXKFiYsA==
X-Google-Smtp-Source: APXvYqwC4XJkSlH1vBwyBMcl2V4EaDp3bQES1Qhw9BlkRjb62OKPLc4S/uhGd3XVYDZ2W4pbF1MGIg==
X-Received: by 2002:a1c:a002:: with SMTP id j2mr7184902wme.131.1559144383296;
        Wed, 29 May 2019 08:39:43 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.dsl.teletu.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id d26sm4930371wmb.4.2019.05.29.08.39.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 08:39:42 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] sctp: deduplicate identical skb_checksum_ops
Date:   Wed, 29 May 2019 17:39:41 +0200
Message-Id: <20190529153941.12166-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same skb_checksum_ops struct is defined twice in two different places,
leading to code duplication. Declare it as a global variable into a common
header instead of allocating it on the stack on each function call.
bloat-o-meter reports a slight code shrink.

add/remove: 1/1 grow/shrink: 0/10 up/down: 128/-1282 (-1154)
Function                                     old     new   delta
sctp_csum_ops                                  -     128    +128
crc32c_csum_ops                               16       -     -16
sctp_rcv                                    6616    6583     -33
sctp_packet_pack                            4542    4504     -38
nf_conntrack_sctp_packet                    4980    4926     -54
execute_masked_set_action                   6453    6389     -64
tcf_csum_sctp                                575     428    -147
sctp_gso_segment                            1292    1126    -166
sctp_csum_check                              579     412    -167
sctp_snat_handler                            957     772    -185
sctp_dnat_handler                           1321    1132    -189
l4proto_manip_pkt                           2536    2313    -223
Total: Before=359297613, After=359296459, chg -0.00%

Reviewed-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 include/net/sctp/checksum.h | 12 +++++++-----
 net/sctp/offload.c          |  7 +------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
index 314699333bec..5a9bb09f32b6 100644
--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -43,19 +43,21 @@ static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
 						   (__force __u32)csum2, len);
 }
 
+static const struct skb_checksum_ops sctp_csum_ops = {
+	.update  = sctp_csum_update,
+	.combine = sctp_csum_combine,
+};
+
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
 	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
-	const struct skb_checksum_ops ops = {
-		.update  = sctp_csum_update,
-		.combine = sctp_csum_combine,
-	};
 	__le32 old = sh->checksum;
 	__wsum new;
 
 	sh->checksum = 0;
-	new = ~__skb_checksum(skb, offset, skb->len - offset, ~(__wsum)0, &ops);
+	new = ~__skb_checksum(skb, offset, skb->len - offset, ~(__wsum)0,
+			      &sctp_csum_ops);
 	sh->checksum = old;
 
 	return cpu_to_le32((__force __u32)new);
diff --git a/net/sctp/offload.c b/net/sctp/offload.c
index edfcf16e704c..dac46dfadab5 100644
--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -103,11 +103,6 @@ static const struct net_offload sctp6_offload = {
 	},
 };
 
-static const struct skb_checksum_ops crc32c_csum_ops = {
-	.update  = sctp_csum_update,
-	.combine = sctp_csum_combine,
-};
-
 int __init sctp_offload_init(void)
 {
 	int ret;
@@ -120,7 +115,7 @@ int __init sctp_offload_init(void)
 	if (ret)
 		goto ipv4;
 
-	crc32c_csum_stub = &crc32c_csum_ops;
+	crc32c_csum_stub = &sctp_csum_ops;
 	return ret;
 
 ipv4:
-- 
2.21.0

