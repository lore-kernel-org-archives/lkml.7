Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C5BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E83A2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="wQkgV8Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfDMUxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:53:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42748 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:53:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so16429521wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wydhnicudlyGA2kSUfNcNEWI5wSdWDWozrduSmCBWgE=;
        b=wQkgV8YioP1+14DUuH39Creg+euZ/L6NRR35VMExSGpekuBxkO0ypkNzvDAZ5aO37+
         yK/oXzcux0Nff55VMniABpSKkoX+nkqtpnLP7ZDJ9SDSMPz4R+Ng/mVjF/4UnJQ+CrBe
         IOA+/h6z33i/I3DglIRQ2p1xkSJctf1eLkPzvgo5XcxqnL2kmTsPFQTYSOiCscd1+owz
         tZpPbJhBfEmt7829xNmZosdxZ5/YJuCICvZa/aM0TS1GBAGC3l4F9qE8t/rZH+NmDAMC
         XaHeoRwOlXvECnKTzAvD2rChDN7UE1hG5hE9bckD3ZMSKSovf+4rIsduiPQyWqs7BJXK
         CRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wydhnicudlyGA2kSUfNcNEWI5wSdWDWozrduSmCBWgE=;
        b=GKIGmZ9jRXvJmrspFXFc/T+WM1V5YE4uYm6QTkNTx//bbLSJouBcrI2l79xSVP3adV
         vmDZryePMwOVHIJwyOHt8Szx9NoCu+ler293cSIV9m/EPqaXK48b+BiNfcwRj8gkxTIk
         q8U4nG231NIaGwmuqk4rHGn4C6yNApARyO31Lk2r5DukeSw8dcPrPrDVGtGJcUTXk3fc
         qIOcFe61lu9wLOvxVPt47+aYJHGv9d/HhSwGFZ/v8eT7DF9yb9OFZ3PVI2c7DL6b/jas
         fUxegiiNFoybGKARoYlr9mz2Tsg2KVZjmiXA18gY+ceCSlfg8CGqQqHkHfw9xmc/I3FF
         8BuQ==
X-Gm-Message-State: APjAAAU3NkITp12BdmqSiHB40UZQZFc8XX0Y1pQ8osVTKMzjhRiJhzbV
        X7xMfQrP0APQGq39JDpg777sCA==
X-Google-Smtp-Source: APXvYqyKXo7rw/ZiOydJfFwCKyKyG+uFD8OvnkHCkejeFUEoz3qAN2w8Eq0LonlnSf1if0x+SJem0g==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr39577974wrn.90.1555188792774;
        Sat, 13 Apr 2019 13:53:12 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id p6sm36811204wrs.6.2019.04.13.13.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 13:53:12 -0700 (PDT)
Date:   Sat, 13 Apr 2019 22:53:11 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 17/24] net: dsa: sja1105: Add support for
 ethtool port counters
Message-ID: <20190413205311.GC2268@nanopsycho.orion>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-18-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-18-olteanv@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Apr 13, 2019 at 03:28:15AM CEST, olteanv@gmail.com wrote:
>Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>---
>Changes in v3:
>None.
>
>Changes in v2:
>None functional. Moved the IS_ET() and IS_PQRS() device identification
>macros here since they are not used in earlier patches.
>
> drivers/net/dsa/sja1105/Makefile              |   1 +
> drivers/net/dsa/sja1105/sja1105.h             |   7 +-
> drivers/net/dsa/sja1105/sja1105_ethtool.c     | 414 ++++++++++++++++++
> drivers/net/dsa/sja1105/sja1105_main.c        |   3 +
> .../net/dsa/sja1105/sja1105_static_config.h   |  21 +
> 5 files changed, 445 insertions(+), 1 deletion(-)
> create mode 100644 drivers/net/dsa/sja1105/sja1105_ethtool.c
>
>diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
>index ed00840802f4..bb4404c79eb2 100644
>--- a/drivers/net/dsa/sja1105/Makefile
>+++ b/drivers/net/dsa/sja1105/Makefile
>@@ -3,6 +3,7 @@ obj-$(CONFIG_NET_DSA_SJA1105) += sja1105.o
> sja1105-objs := \
>     sja1105_spi.o \
>     sja1105_main.o \
>+    sja1105_ethtool.o \
>     sja1105_clocking.o \
>     sja1105_static_config.o \
>     sja1105_dynamic_config.o \
>diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
>index 4c9df44a4478..80b20bdd8f9c 100644
>--- a/drivers/net/dsa/sja1105/sja1105.h
>+++ b/drivers/net/dsa/sja1105/sja1105.h
>@@ -120,8 +120,13 @@ typedef enum {
> int sja1105_clocking_setup_port(struct sja1105_private *priv, int port);
> int sja1105_clocking_setup(struct sja1105_private *priv);
> 
>-/* From sja1105_dynamic_config.c */
>+/* From sja1105_ethtool.c */
>+void sja1105_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
>+void sja1105_get_strings(struct dsa_switch *ds, int port,
>+			 u32 stringset, u8 *data);
>+int sja1105_get_sset_count(struct dsa_switch *ds, int port, int sset);
> 
>+/* From sja1105_dynamic_config.c */
> int sja1105_dynamic_config_read(struct sja1105_private *priv,
> 				enum sja1105_blk_idx blk_idx,
> 				int index, void *entry);
>diff --git a/drivers/net/dsa/sja1105/sja1105_ethtool.c b/drivers/net/dsa/sja1105/sja1105_ethtool.c
>new file mode 100644
>index 000000000000..c082599702bd
>--- /dev/null
>+++ b/drivers/net/dsa/sja1105/sja1105_ethtool.c
>@@ -0,0 +1,414 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/* Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
>+ */
>+#include "sja1105.h"
>+
>+#define SIZE_MAC_AREA		(0x02 * 4)
>+#define SIZE_HL1_AREA		(0x10 * 4)
>+#define SIZE_HL2_AREA		(0x4 * 4)
>+#define SIZE_QLEVEL_AREA	(0x8 * 4) /* 0x4 to 0xB */

Please use prefixes for defines like this. For example "SIZE_MAC_AREA"
sounds way too generic.

[...]


>+static void
>+sja1105_port_status_hl1_unpack(void *buf,
>+			       struct sja1105_port_status_hl1 *status)
>+{
>+	/* Make pointer arithmetic work on 4 bytes */
>+	u32 *p = (u32 *)buf;

You don't need to cast void *. Please avoid it in the whole patchset.

[...]


>+	if (!IS_PQRS(priv->info->device_id))
>+		return;
>+
>+	memset(data + k, 0, ARRAY_SIZE(sja1105pqrs_extra_port_stats) *
>+			sizeof(u64));
>+	for (i = 0; i < 8; i++) {

Array size instead of "8"?


>+		data[k++] = status.hl2.qlevel_hwm[i];
>+		data[k++] = status.hl2.qlevel[i];
>+	}

[...]


> 
>+#define IS_PQRS(device_id) \
>+	(((device_id) == SJA1105PR_DEVICE_ID) || \
>+	 ((device_id) == SJA1105QS_DEVICE_ID))
>+#define IS_ET(device_id) \
>+	(((device_id) == SJA1105E_DEVICE_ID) || \
>+	 ((device_id) == SJA1105T_DEVICE_ID))
>+/* P and R have same Device ID, and differ by Part Number */
>+#define IS_P(device_id, part_nr) \
>+	(((device_id) == SJA1105PR_DEVICE_ID) && \
>+	 ((part_nr) == SJA1105P_PART_NR))
>+#define IS_R(device_id, part_nr) \
>+	(((device_id) == SJA1105PR_DEVICE_ID) && \
>+	 ((part_nr) == SJA1105R_PART_NR))
>+/* Same do Q and S */
>+#define IS_Q(device_id, part_nr) \
>+	(((device_id) == SJA1105QS_DEVICE_ID) && \
>+	 ((part_nr) == SJA1105Q_PART_NR))
>+#define IS_S(device_id, part_nr) \

Please have a prefix for macros like this. "IS_S" sounds way too
generic...


>+	(((device_id) == SJA1105QS_DEVICE_ID) && \
>+	 ((part_nr) == SJA1105S_PART_NR))
>+
> struct sja1105_general_params_entry {
> 	u64 vllupformat;
> 	u64 mirr_ptacu;
>-- 
>2.17.1
>
