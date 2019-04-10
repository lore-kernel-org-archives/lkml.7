Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4060CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B30121841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgULYnct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDJA5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJA53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so771196wrx.10;
        Tue, 09 Apr 2019 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TSWC3NMcV3lLJbMzBocfQStrcRFVFF4vnY6b77qP7No=;
        b=HgULYnctW1jqXY1WgR9zkVr3uIGXXNyk3oN4xBzVKMNdvCeugGNV74QxI95vgDv7ax
         mBXfD4Uud9aje5FlIuMaKcJkKUE3aOu3mtAIQR9/TNPL3L0sLP/CSbqeY8Nw+mkDFhIm
         OyJ8LQasIjgl60Iy2HQ8gzAAatUzPjMFuLL9Weo6V5YSLAnwKDEVR15aBl+qXjOecJwb
         sxlu+Kw2lTvterndnLzYD3Imw03YmVNiTzWP6KoMjHqCdAMPYcKxL49IblsQGLK11xXk
         f6mFPYQTDeHDXQk6yYjq/mj0QZcbTISPLfwlVtiwJijyNBojcTA5VGnFFsgAnihMkM65
         GCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TSWC3NMcV3lLJbMzBocfQStrcRFVFF4vnY6b77qP7No=;
        b=BwymzRe35W20Irk3YY4eJftjWrGGx8x/EBRxNA/19r/itR85K875UOX4nCueN3Ug6c
         73PZekY8ZrIpqrZLgu1Q+cqH3x/c5CvvJCfa6WapBDWmR9QzmZFrcYLyVuD19giGRhhH
         Ed6agquZF+zrN1zlRcAnGrfiWKRgHjWnh57Fjta4vj+NJlbKIDmUoEHq014AcsXi0Nr6
         b2cb3sJjahnadGZa+s8bPndjaXET3toR186f/xShB/qBq/6Gl4LZo4cKetD8YI+CPCXD
         bkZ8Bdd4ACH56/C8MSp2frMZF94cnReEdMvW0pTC4K27yuxLzGQEM7FDQM9KkW5wO6Qe
         ck5A==
X-Gm-Message-State: APjAAAXYmz4YyRvnjpS3kP+oNwtAjGJqEggSvfeHXhcYbkePu0y2C87d
        rMnnikE1QM/sk0RlPFxr5Us=
X-Google-Smtp-Source: APXvYqw2jDpvD+ZcDSghViLGL47sQgtYcVIcUp0/xNJimmkic/iV4fPIhPmQqhpSL6RlqumVuU7XoA==
X-Received: by 2002:adf:e602:: with SMTP id p2mr5514394wrm.105.1554857847914;
        Tue, 09 Apr 2019 17:57:27 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:27 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 07/22] ether: Add dedicated Ethertype for pseudo-802.1Q DSA tagging
Date:   Wed, 10 Apr 2019 03:56:45 +0300
Message-Id: <20190410005700.31582-8-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the newly added DSA_TAG_PROTO_8021Q, switch devices that don't
support a native insertion/extraction header on the CPU port may still
enjoy the benefits of port isolation with a custom VLAN tag.

For this, they need to have a customizable TPID in hardware and a new
Ethertype to distinguish between real 802.1Q traffic and the private
tags used for port separation.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:
New patch.

 include/uapi/linux/if_ether.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 3a45b4ad71a3..3158ba672b72 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -109,6 +109,7 @@
 #define ETH_P_QINQ2	0x9200		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_QINQ3	0x9300		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_EDSA	0xDADA		/* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_DSA_8021Q	0xDADB		/* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_IFE	0xED3E		/* ForCES inter-FE LFB type */
 #define ETH_P_AF_IUCV   0xFBFB		/* IBM af_iucv [ NOT AN OFFICIALLY REGISTERED ID ] */
 
-- 
2.17.1

