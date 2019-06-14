Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E59C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AD8217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd/s2jGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFNRtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:49:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFNRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:49:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so3469791qtl.3;
        Fri, 14 Jun 2019 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWmxPayc+YnENrxC4+6/G0mrxeXGoOdzCLuhCGNpnB4=;
        b=Kd/s2jGVdmnVLNfcOhHsrV2y/tcKOHfr/NsoriihRBpVzPMaJ/Qda9BLewQ9++0jOg
         xg1vOyoI/jW1FOPMLnLlnR3w3XGuMZzP+v0HNdJJzDAKhzEOwJrgtBKomqnDahD10/LK
         lN3Ou6hUo7Ht0xw/JwOqkoFv6yRs2pDT6vSkoj+f+zHp2icxyi0WSidfjZsKRGYJ9pjr
         A7iEoc4ft4RLCOJoXwWbvZGKLXU36i/yAvNJtOuqTiz9jjORUiWglcy7FYqqDvfT2XJQ
         SC4xqLuNAf73vTpuCCpxi6N0+Ai2KBfridI3MqckloDmwdRTx0vLM1TySW+vIJwZDNJp
         5a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWmxPayc+YnENrxC4+6/G0mrxeXGoOdzCLuhCGNpnB4=;
        b=fTa/IaU0RCgnjwWfYgk21f2cUhTA2N7bDz/7x7EjESTyCNwE+gAdQUaVY4wRjffOWo
         l3waprUvVuWwgTMwmRCJy+tuh/LLvsqLruImk2l8jl4a7Hv99UIHEXFAYeFVjE2nsi8h
         kKUKynA4NbenpXCWajH0SdOBlE2CH1ie2EDM662TEPOeXUoywzquNg/B6sFIyJCvWCg0
         uXgz+y7HhBZy9L7e8OKIZAZ9dfz9qsnspoUEaTSspIbqhYXtf13o8+1AQx+C8UcQwFWh
         As9cmhG3e9uq9NeCDDA2oa6+lofGcZjc40CBffWj7QtdJaIH14ZhStnX2qEoJPllc4GA
         xRmQ==
X-Gm-Message-State: APjAAAV2d6iavT4/SE00v+fxvnuN9UV1ZNDnF64WgGDX2ACUrYwqGkel
        djTvzEoo2ph5D5yG5ocWDuDjvHB3xz0=
X-Google-Smtp-Source: APXvYqwRhJWZXTwkuV6heL4a0gdKgz8BaNgLwGdfdZlj2Glz0zXp0lyUj9P4R+/A9wHMDd6LxfThIQ==
X-Received: by 2002:ac8:5485:: with SMTP id h5mr79526217qtq.253.1560534570806;
        Fri, 14 Jun 2019 10:49:30 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id t187sm1834028qkh.10.2019.06.14.10.49.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 10:49:30 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, f.fainelli@gmail.com,
        andrew@lunn.ch
Subject: [PATCH net-next v2 1/4] net: dsa: do not check orig_dev in vlan del
Date:   Fri, 14 Jun 2019 13:49:19 -0400
Message-Id: <20190614174922.2590-2-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614174922.2590-1-vivien.didelot@gmail.com>
References: <20190614174922.2590-1-vivien.didelot@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current DSA code handling switchdev objects does not recurse into
the lower devices thus is never called with an orig_dev member being
a bridge device, hence remove this useless check.

At the same time, remove the comments about the callers, which is
unlikely to be updated if the code changes and thus will be confusing.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/port.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 585b6b9a9433..d2b65e8dc60c 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -336,9 +336,6 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 		.vlan = vlan,
 	};
 
-	/* Can be called from dsa_slave_port_obj_add() or
-	 * dsa_slave_vlan_rx_add_vid()
-	 */
 	if (!dp->bridge_dev || br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
 
@@ -354,12 +351,6 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 		.vlan = vlan,
 	};
 
-	if (vlan->obj.orig_dev && netif_is_bridge_master(vlan->obj.orig_dev))
-		return -EOPNOTSUPP;
-
-	/* Can be called from dsa_slave_port_obj_del() or
-	 * dsa_slave_vlan_rx_kill_vid()
-	 */
 	if (!dp->bridge_dev || br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
 
-- 
2.21.0

