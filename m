Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF5FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5A7206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Dw+Wh5x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfDNIea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 04:34:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38098 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfDNIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 04:34:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so16139915wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZemPy8GK2vY84v+gMiAYLtC7lPQF8PPw6E5C3UmBwvg=;
        b=Dw+Wh5x3YcThRjMDOkmEIPN1+MFIKQcfxB48xH/1ZGD+33j7wJY6YqaLyHXSRWUzze
         OjI23wp1N6Hi/9StvBibs2NBNTOowYrgM0iAV6HjoMm3NL8sn4lF11wJBtBzEC4RkxWh
         33R0nGvoesu1fyEc175CD0D8r97gGlHrqWB9zZOXrTP6oFx2M7kS4Xgi672dDjn1XzMa
         ngUSU7SDbUZr0nvr1jU+h1WS21qFmTjcH0y0rWtSioik4UsJ+/Eunz63qeAE4amdK6Xl
         +d1lpWYk0vv3l432yiPd0uT6SRdXgUWqT/vV7u6zymluDJjerNOjdflfsNpxniZ9dwYO
         Ymqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZemPy8GK2vY84v+gMiAYLtC7lPQF8PPw6E5C3UmBwvg=;
        b=DgelHDpUHTk74K9MZRNCy4WR4nQe+gMt8H6yyQ7Aycy5CaoVljLVWx+XOxLwso6lNQ
         cpgIRr3+hzfjKyfr/V2mDpzucXFZFJWPdEnsCa6JaGrk1qLdsX6UjczbkZJZZuhljQPB
         QSaSBM1GreZ3mJJOrolChhxyBOt6zaq+B8XsjOoiyc6XXlp4/7UOrbJjGA4hqnbOTh0o
         O4dUFClfiN1mV1BeiCbSH533t/xZFyWfURCa/XcvD6ed4cV9meNs5drc1OPEfiHhZykn
         WdA00HGY37tOuwlwFu5bqRjvXYpIJytUtJ3kYEqZYazV9/pWXXTNgYZhVPnNMpHqZYqd
         /oOQ==
X-Gm-Message-State: APjAAAVUKdNx/UKOQrL4eNaq/fbVem5exm3MA1z1a2nb2d3Nsek1jBY9
        NY5mTiiBhHJTecWJ5tdEkMKljg==
X-Google-Smtp-Source: APXvYqyTZO3fJ01XdhKgdQnKhAIasLQA4U6/0xZDT53f6u+5MXiyRlvl/dGaNF5+wzHR9dZgBqfTZw==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr17681694wmj.31.1555230867523;
        Sun, 14 Apr 2019 01:34:27 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id h12sm44950634wrq.95.2019.04.14.01.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 01:34:27 -0700 (PDT)
Date:   Sun, 14 Apr 2019 10:34:26 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Subject: Re: [PATCH v3 net-next 17/24] net: dsa: sja1105: Add support for
 ethtool port counters
Message-ID: <20190414083426.GA24144@nanopsycho.orion>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-18-olteanv@gmail.com>
 <20190413205311.GC2268@nanopsycho.orion>
 <CA+h21hphrc0+H24zAjTNsrq4u-LgVBw630vpDgwoEXF96KrPkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hphrc0+H24zAjTNsrq4u-LgVBw630vpDgwoEXF96KrPkQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Apr 13, 2019 at 11:55:52PM CEST, olteanv@gmail.com wrote:
>On Sat, 13 Apr 2019 at 23:53, Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Sat, Apr 13, 2019 at 03:28:15AM CEST, olteanv@gmail.com wrote:
>> >Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>> >Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> >---
>> >Changes in v3:
>> >None.
>> >
>> >Changes in v2:
>> >None functional. Moved the IS_ET() and IS_PQRS() device identification
>> >macros here since they are not used in earlier patches.
>> >
>> > drivers/net/dsa/sja1105/Makefile              |   1 +
>> > drivers/net/dsa/sja1105/sja1105.h             |   7 +-
>> > drivers/net/dsa/sja1105/sja1105_ethtool.c     | 414 ++++++++++++++++++
>> > drivers/net/dsa/sja1105/sja1105_main.c        |   3 +
>> > .../net/dsa/sja1105/sja1105_static_config.h   |  21 +
>> > 5 files changed, 445 insertions(+), 1 deletion(-)
>> > create mode 100644 drivers/net/dsa/sja1105/sja1105_ethtool.c
>> >
>> >diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
>> >index ed00840802f4..bb4404c79eb2 100644
>> >--- a/drivers/net/dsa/sja1105/Makefile
>> >+++ b/drivers/net/dsa/sja1105/Makefile
>> >@@ -3,6 +3,7 @@ obj-$(CONFIG_NET_DSA_SJA1105) += sja1105.o
>> > sja1105-objs := \
>> >     sja1105_spi.o \
>> >     sja1105_main.o \
>> >+    sja1105_ethtool.o \
>> >     sja1105_clocking.o \
>> >     sja1105_static_config.o \
>> >     sja1105_dynamic_config.o \
>> >diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
>> >index 4c9df44a4478..80b20bdd8f9c 100644
>> >--- a/drivers/net/dsa/sja1105/sja1105.h
>> >+++ b/drivers/net/dsa/sja1105/sja1105.h
>> >@@ -120,8 +120,13 @@ typedef enum {
>> > int sja1105_clocking_setup_port(struct sja1105_private *priv, int port);
>> > int sja1105_clocking_setup(struct sja1105_private *priv);
>> >
>> >-/* From sja1105_dynamic_config.c */
>> >+/* From sja1105_ethtool.c */
>> >+void sja1105_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
>> >+void sja1105_get_strings(struct dsa_switch *ds, int port,
>> >+                       u32 stringset, u8 *data);
>> >+int sja1105_get_sset_count(struct dsa_switch *ds, int port, int sset);
>> >
>> >+/* From sja1105_dynamic_config.c */
>> > int sja1105_dynamic_config_read(struct sja1105_private *priv,
>> >                               enum sja1105_blk_idx blk_idx,
>> >                               int index, void *entry);
>> >diff --git a/drivers/net/dsa/sja1105/sja1105_ethtool.c b/drivers/net/dsa/sja1105/sja1105_ethtool.c
>> >new file mode 100644
>> >index 000000000000..c082599702bd
>> >--- /dev/null
>> >+++ b/drivers/net/dsa/sja1105/sja1105_ethtool.c
>> >@@ -0,0 +1,414 @@
>> >+// SPDX-License-Identifier: GPL-2.0
>> >+/* Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
>> >+ */
>> >+#include "sja1105.h"
>> >+
>> >+#define SIZE_MAC_AREA         (0x02 * 4)
>> >+#define SIZE_HL1_AREA         (0x10 * 4)
>> >+#define SIZE_HL2_AREA         (0x4 * 4)
>> >+#define SIZE_QLEVEL_AREA      (0x8 * 4) /* 0x4 to 0xB */
>>
>> Please use prefixes for defines like this. For example "SIZE_MAC_AREA"
>> sounds way too generic.
>>
>
>What you propose sounds nice but then consistency would be a concern,
>so I'd have to redo the entire driver. And then there are tables named

Yep


>like "L2 Address Lookup Parameters Table", and as if
>SIZE_L2_LOOKUP_PARAMS_DYN_CMD_ET wasn't long enough, a prefix would
>top it off.

It's a tradeoff. But most of the time, it is doable. Then the code is
easier to read.


>I don't think it's as much of an issue for the reader (for the
>compiler it clearly isn't, as it's restricted to this C file only) as
>it is for tools like ctags?
>
>> [...]
>>
>>
>> >+static void
>> >+sja1105_port_status_hl1_unpack(void *buf,
>> >+                             struct sja1105_port_status_hl1 *status)
>> >+{
>> >+      /* Make pointer arithmetic work on 4 bytes */
>> >+      u32 *p = (u32 *)buf;
>>
>> You don't need to cast void *. Please avoid it in the whole patchset.
>>
>
>Ok.
>
>> [...]
>>
>>
>> >+      if (!IS_PQRS(priv->info->device_id))
>> >+              return;
>> >+
>> >+      memset(data + k, 0, ARRAY_SIZE(sja1105pqrs_extra_port_stats) *
>> >+                      sizeof(u64));
>> >+      for (i = 0; i < 8; i++) {
>>
>> Array size instead of "8"?
>>
>
>Perhaps SJA1105_NUM_TC, since the egress queue occupancy levels are
>per traffic class. The size of the array is 16.
>
>>
>> >+              data[k++] = status.hl2.qlevel_hwm[i];
>> >+              data[k++] = status.hl2.qlevel[i];
>> >+      }
>>
>> [...]
>>
>>
>> >
>> >+#define IS_PQRS(device_id) \
>> >+      (((device_id) == SJA1105PR_DEVICE_ID) || \
>> >+       ((device_id) == SJA1105QS_DEVICE_ID))
>> >+#define IS_ET(device_id) \
>> >+      (((device_id) == SJA1105E_DEVICE_ID) || \
>> >+       ((device_id) == SJA1105T_DEVICE_ID))
>> >+/* P and R have same Device ID, and differ by Part Number */
>> >+#define IS_P(device_id, part_nr) \
>> >+      (((device_id) == SJA1105PR_DEVICE_ID) && \
>> >+       ((part_nr) == SJA1105P_PART_NR))
>> >+#define IS_R(device_id, part_nr) \
>> >+      (((device_id) == SJA1105PR_DEVICE_ID) && \
>> >+       ((part_nr) == SJA1105R_PART_NR))
>> >+/* Same do Q and S */
>> >+#define IS_Q(device_id, part_nr) \
>> >+      (((device_id) == SJA1105QS_DEVICE_ID) && \
>> >+       ((part_nr) == SJA1105Q_PART_NR))
>> >+#define IS_S(device_id, part_nr) \
>>
>> Please have a prefix for macros like this. "IS_S" sounds way too
>> generic...
>>
>
>Ok, I can think of a more descriptive name, since there are under 5
>occurrences of these macros after the reorg, now that I have the
>sja1105_info structure which also holds per-revision function
>pointers.
>
>>
>> >+      (((device_id) == SJA1105QS_DEVICE_ID) && \
>> >+       ((part_nr) == SJA1105S_PART_NR))
>> >+
>> > struct sja1105_general_params_entry {
>> >       u64 vllupformat;
>> >       u64 mirr_ptacu;
>> >--
>> >2.17.1
>> >
>
>
>Thanks!
>-Vladimir
