Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA2C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3442084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="FTox2wbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfDMU60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:58:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35706 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfDMU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:58:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so16477299wrp.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=25KBPEUObWsjji6GYWI2t1NFx/KDJYcL6r+bAoPeMhY=;
        b=FTox2wbsDTT2wgMYtx6PP434IpJepk+nzdWEdqJE6bsH04/Y2sofZIqGpz+TBCQRmq
         l+WpmWMLNsWgn92sl3fq8Svocvwt691olQndgB7iY2mB09y8ZB29obR3QKtEcXUQZPny
         akMwPp1QLhu1uhx8ss2Hdq3G8oHMqa8iDDORAvjT2xb+0n5ibdAeQTf1u+dZooO9YYqY
         tWmEEybGl8Ns7mWu8GNi7sVAtMDf3tPkEO30PjgERcSDQee6JwCyqqJfSQsL0NCvgf9V
         rJYw2p7VzFGzu3YLBegM9yEunwg6vZfSJpOrIoF+yorkHi43BQnxGSrqh3ICxqhjGII8
         UCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=25KBPEUObWsjji6GYWI2t1NFx/KDJYcL6r+bAoPeMhY=;
        b=cjberAcTUDRR4Th9mYWOgeZhBBVmWrJzfXiPNOh2F2S8rOGwl1yval+QDSB1VfJI+m
         gwr9PzcbtESDMpEl8BVzDtCs5W8L1zYr5kloPlC2PjCO27kgPYQFNO/5TCO2IwVBLww4
         2kf4KghRIMd8k0Jk4seIBG2Yk7m4SGKw08rarcVbqkdX1b8GsRUXNDe0rmC/coxbaIKL
         64QG0cJZ8+Th7TMCybnIaq3pIHgxekhTWDVdU/8+f1jg0zDMq3wy9qIIFeM41Zx1kKPV
         c0inIgHN914sWLsgHtbNex/dB2qo8tRQWZ/Mob6i7w0wVaRWQA8NZ759bW+Hn/9UvPEk
         rSLQ==
X-Gm-Message-State: APjAAAWlrbf7Vhr+8XZVh5+jiySjBNRsX7w/z2JSNY4wkHyDis+l/2sG
        WJDNVrI+vnpUlsz5JrBx7/qE1A==
X-Google-Smtp-Source: APXvYqx3ZCn69UZokpDn/Ax1VoO4Jkt6oRu8WihOFmvvH7SDUqAs6MQUIsUndXXiBibhTFlDqSyMjQ==
X-Received: by 2002:a5d:618b:: with SMTP id j11mr38171321wru.123.1555189104922;
        Sat, 13 Apr 2019 13:58:24 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id f10sm54004513wrs.17.2019.04.13.13.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 13:58:24 -0700 (PDT)
Date:   Sat, 13 Apr 2019 22:58:23 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 15/24] net: dsa: sja1105: Add support for FDB
 and MDB management
Message-ID: <20190413205823.GE2268@nanopsycho.orion>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-16-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-16-olteanv@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Apr 13, 2019 at 03:28:13AM CEST, olteanv@gmail.com wrote:
>Currently only the (more difficult) first generation E/T series is
>supported. Here the TCAM is only 4-way associative, and to know where
>the hardware will search for a FDB entry, we need to perform the same
>hash algorithm in order to install the entry in the correct bin.
>
>On P/Q/R/S, the TCAM should be fully associative. However the SPI
>command interface is different, and because I don't have access to a
>new-generation device at the moment, support for it is TODO.
>
>Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>---
>Changes from v3:
>None
>
>Changes from v2:
>None
>
> drivers/net/dsa/sja1105/sja1105.h             |   2 +
> .../net/dsa/sja1105/sja1105_dynamic_config.c  |  40 ++++
> drivers/net/dsa/sja1105/sja1105_main.c        | 193 ++++++++++++++++++
> 3 files changed, 235 insertions(+)
>
>diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
>index ef555dd385a3..4c9df44a4478 100644
>--- a/drivers/net/dsa/sja1105/sja1105.h
>+++ b/drivers/net/dsa/sja1105/sja1105.h
>@@ -129,6 +129,8 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
> 				 enum sja1105_blk_idx blk_idx,
> 				 int index, void *entry, bool keep);
> 
>+u8 sja1105_fdb_hash(struct sja1105_private *priv, const u8 *addr, u16 vid);
>+
> /* Common implementations for the static and dynamic configs */
> size_t sja1105_l2_forwarding_entry_packing(void *buf, void *entry_ptr,
> 					   enum packing_op op);
>diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
>index 74c3a00d453c..0aeda6868c27 100644
>--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
>+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
>@@ -462,3 +462,43 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
> 
> 	return 0;
> }
>+
>+static u8 crc8_add(u8 crc, u8 byte, u8 poly)

Prefix please.


>+{
>+	int i;
>+
>+	for (i = 0; i < 8; i++) {
>+		if ((crc ^ byte) & (1 << 7)) {
>+			crc <<= 1;
>+			crc ^= poly;
>+		} else {
>+			crc <<= 1;
>+		}
>+		byte <<= 1;
>+	}
>+	return crc;
>+}

[...]


> 
>+#define fdb(bin, index) \
>+	((bin) * SJA1105ET_FDB_BIN_SIZE + (index))
>+#define is_bin_index_valid(i) \
>+	((i) >= 0 && (i) < SJA1105ET_FDB_BIN_SIZE)

Please use prefixes and sane names. Also, consider using functions
instead of macros.


[...]


>+
>+#undef fdb
>+#undef is_bin_index_valid

Odd.


