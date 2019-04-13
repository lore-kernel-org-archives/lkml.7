Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D054FC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6920870
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEzgHkWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfDMV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:56:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43975 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfDMV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:56:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so12031871lja.10;
        Sat, 13 Apr 2019 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8aRVZE+vkmxua53iJHDKSM/xEco/FTj5uFLcAnfwB4=;
        b=ZEzgHkWfY0We17yApEjHHjooUAZONjJ0xXXQEFuvC5UVbdmtHLyJrlcBNNb2aHK1cg
         tfAXBtIt8tpEsbE51Uf3XGfu2JBVAzuW3T+xOK360DkMoI0qkwH8QHItFl65+B/6UBlH
         CmlCXdCZy0Vw1n3iALFJs5fJMQxvbqyq06PCQtSXFgAi/O9vLALFQYo6BcRzKisTcgHo
         6QSD6GPP9cGeTv/dsXvcGF6Nn7Paop02dEy0r/JKgZbOPFbSnNHrEHsTNmZ+u4AB3S6o
         bD0Kd0YwUT1UxUrNRyW8sooKnhcAZllqZvS7NqHZ4ZAJPGHYpJopkL8FZY2Fykref7Wj
         qtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8aRVZE+vkmxua53iJHDKSM/xEco/FTj5uFLcAnfwB4=;
        b=r72GTXUGHffbOG2VPzvlU2ZoPLgK8QPkDkVioyNSInCcFPY3MgISxjq5sifYvL731U
         gPHsC2pqG/WQa+AXpuf2Dm6JQUWh9YcfsFKa0lxCsGGsvlUBHDGdeRyOYOTaRt2FeHDK
         X3HfeLLrhl8l0qSV+WtNRnBI/zPB62VEvwMm18ucGvi1sg3HzD058XOOwKPec2vXl88o
         pCxfxqfv60QubSWav6rwpNWHVg4Kar3OaY8BlZlb43/4KZTX7Wuwrf2FvE2u/vCh4VRL
         KV4frEPM6DIknsjOasHLDURwxyWzE0hFqunlV/AMjAGQ2FzIEguDQX3hogHhivnrcdCq
         CKow==
X-Gm-Message-State: APjAAAVjo7FqZM7ikUUr+zpdMX0OeLDHa/mJGb14GN5ufIKdSC+2vKom
        XLSlY2T8LxN5UADrJt5OgjxmNOVgeGiKr3Dw3omUZVbM30g=
X-Google-Smtp-Source: APXvYqyuqpVTOhkapLWpMyX1gI9AYM6404kCZ9DNVVmRCT6LqllwEFJFB7aW0ISjfe3mpckf/elkCsef/5VAmZcpUCo=
X-Received: by 2002:a2e:96cb:: with SMTP id d11mr34128396ljj.157.1555192563511;
 Sat, 13 Apr 2019 14:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-18-olteanv@gmail.com>
 <20190413205311.GC2268@nanopsycho.orion>
In-Reply-To: <20190413205311.GC2268@nanopsycho.orion>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sun, 14 Apr 2019 00:55:52 +0300
Message-ID: <CA+h21hphrc0+H24zAjTNsrq4u-LgVBw630vpDgwoEXF96KrPkQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 17/24] net: dsa: sja1105: Add support for
 ethtool port counters
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019 at 23:53, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Sat, Apr 13, 2019 at 03:28:15AM CEST, olteanv@gmail.com wrote:
> >Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> >Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> >---
> >Changes in v3:
> >None.
> >
> >Changes in v2:
> >None functional. Moved the IS_ET() and IS_PQRS() device identification
> >macros here since they are not used in earlier patches.
> >
> > drivers/net/dsa/sja1105/Makefile              |   1 +
> > drivers/net/dsa/sja1105/sja1105.h             |   7 +-
> > drivers/net/dsa/sja1105/sja1105_ethtool.c     | 414 ++++++++++++++++++
> > drivers/net/dsa/sja1105/sja1105_main.c        |   3 +
> > .../net/dsa/sja1105/sja1105_static_config.h   |  21 +
> > 5 files changed, 445 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/net/dsa/sja1105/sja1105_ethtool.c
> >
> >diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
> >index ed00840802f4..bb4404c79eb2 100644
> >--- a/drivers/net/dsa/sja1105/Makefile
> >+++ b/drivers/net/dsa/sja1105/Makefile
> >@@ -3,6 +3,7 @@ obj-$(CONFIG_NET_DSA_SJA1105) += sja1105.o
> > sja1105-objs := \
> >     sja1105_spi.o \
> >     sja1105_main.o \
> >+    sja1105_ethtool.o \
> >     sja1105_clocking.o \
> >     sja1105_static_config.o \
> >     sja1105_dynamic_config.o \
> >diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
> >index 4c9df44a4478..80b20bdd8f9c 100644
> >--- a/drivers/net/dsa/sja1105/sja1105.h
> >+++ b/drivers/net/dsa/sja1105/sja1105.h
> >@@ -120,8 +120,13 @@ typedef enum {
> > int sja1105_clocking_setup_port(struct sja1105_private *priv, int port);
> > int sja1105_clocking_setup(struct sja1105_private *priv);
> >
> >-/* From sja1105_dynamic_config.c */
> >+/* From sja1105_ethtool.c */
> >+void sja1105_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
> >+void sja1105_get_strings(struct dsa_switch *ds, int port,
> >+                       u32 stringset, u8 *data);
> >+int sja1105_get_sset_count(struct dsa_switch *ds, int port, int sset);
> >
> >+/* From sja1105_dynamic_config.c */
> > int sja1105_dynamic_config_read(struct sja1105_private *priv,
> >                               enum sja1105_blk_idx blk_idx,
> >                               int index, void *entry);
> >diff --git a/drivers/net/dsa/sja1105/sja1105_ethtool.c b/drivers/net/dsa/sja1105/sja1105_ethtool.c
> >new file mode 100644
> >index 000000000000..c082599702bd
> >--- /dev/null
> >+++ b/drivers/net/dsa/sja1105/sja1105_ethtool.c
> >@@ -0,0 +1,414 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/* Copyright (c) 2018-2019, Vladimir Oltean <olteanv@gmail.com>
> >+ */
> >+#include "sja1105.h"
> >+
> >+#define SIZE_MAC_AREA         (0x02 * 4)
> >+#define SIZE_HL1_AREA         (0x10 * 4)
> >+#define SIZE_HL2_AREA         (0x4 * 4)
> >+#define SIZE_QLEVEL_AREA      (0x8 * 4) /* 0x4 to 0xB */
>
> Please use prefixes for defines like this. For example "SIZE_MAC_AREA"
> sounds way too generic.
>

What you propose sounds nice but then consistency would be a concern,
so I'd have to redo the entire driver. And then there are tables named
like "L2 Address Lookup Parameters Table", and as if
SIZE_L2_LOOKUP_PARAMS_DYN_CMD_ET wasn't long enough, a prefix would
top it off.
I don't think it's as much of an issue for the reader (for the
compiler it clearly isn't, as it's restricted to this C file only) as
it is for tools like ctags?

> [...]
>
>
> >+static void
> >+sja1105_port_status_hl1_unpack(void *buf,
> >+                             struct sja1105_port_status_hl1 *status)
> >+{
> >+      /* Make pointer arithmetic work on 4 bytes */
> >+      u32 *p = (u32 *)buf;
>
> You don't need to cast void *. Please avoid it in the whole patchset.
>

Ok.

> [...]
>
>
> >+      if (!IS_PQRS(priv->info->device_id))
> >+              return;
> >+
> >+      memset(data + k, 0, ARRAY_SIZE(sja1105pqrs_extra_port_stats) *
> >+                      sizeof(u64));
> >+      for (i = 0; i < 8; i++) {
>
> Array size instead of "8"?
>

Perhaps SJA1105_NUM_TC, since the egress queue occupancy levels are
per traffic class. The size of the array is 16.

>
> >+              data[k++] = status.hl2.qlevel_hwm[i];
> >+              data[k++] = status.hl2.qlevel[i];
> >+      }
>
> [...]
>
>
> >
> >+#define IS_PQRS(device_id) \
> >+      (((device_id) == SJA1105PR_DEVICE_ID) || \
> >+       ((device_id) == SJA1105QS_DEVICE_ID))
> >+#define IS_ET(device_id) \
> >+      (((device_id) == SJA1105E_DEVICE_ID) || \
> >+       ((device_id) == SJA1105T_DEVICE_ID))
> >+/* P and R have same Device ID, and differ by Part Number */
> >+#define IS_P(device_id, part_nr) \
> >+      (((device_id) == SJA1105PR_DEVICE_ID) && \
> >+       ((part_nr) == SJA1105P_PART_NR))
> >+#define IS_R(device_id, part_nr) \
> >+      (((device_id) == SJA1105PR_DEVICE_ID) && \
> >+       ((part_nr) == SJA1105R_PART_NR))
> >+/* Same do Q and S */
> >+#define IS_Q(device_id, part_nr) \
> >+      (((device_id) == SJA1105QS_DEVICE_ID) && \
> >+       ((part_nr) == SJA1105Q_PART_NR))
> >+#define IS_S(device_id, part_nr) \
>
> Please have a prefix for macros like this. "IS_S" sounds way too
> generic...
>

Ok, I can think of a more descriptive name, since there are under 5
occurrences of these macros after the reorg, now that I have the
sja1105_info structure which also holds per-revision function
pointers.

>
> >+      (((device_id) == SJA1105QS_DEVICE_ID) && \
> >+       ((part_nr) == SJA1105S_PART_NR))
> >+
> > struct sja1105_general_params_entry {
> >       u64 vllupformat;
> >       u64 mirr_ptacu;
> >--
> >2.17.1
> >


Thanks!
-Vladimir
