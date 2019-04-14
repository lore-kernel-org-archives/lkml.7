Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FA2C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6900206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 08:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="xPk76TwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDNIfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 04:35:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52799 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfDNIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 04:35:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so16500760wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MECGmecSBbeJdt4Hd3Q33DUXfxWNapOXysmBZS4vAQg=;
        b=xPk76TwJSLXqgPF5gyp8C2ldaSdpyiuUGkRHH+jLq5jF/7a/UtCVdCObp1/3ajn9h1
         1S2OJaFwakzjjVz09stK4mtdGldKl82atqXD95IY8M2C9dM4wrYiqSQ5rt+q5vXn4hJ8
         qoILg6gnbPwvAylcE1onSBCoYv7YlA29fSDcs8PafnTI7jjMAr7rR1cCEVKchOZk5Lcw
         PHRuIJtfwmy0bEQvmCkrlBc6LZHEXRghlaZnpijtdfBgKMQPOPLCly33dkcW8HPSpTcM
         JCXEz7TA4EAq+fA1eUfVD1bw3P2zccdPyHFUTmgsVbjeHxFOlvp5OTGzHJFBErZHZDEr
         +q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MECGmecSBbeJdt4Hd3Q33DUXfxWNapOXysmBZS4vAQg=;
        b=YZ6lLCiRtO30HYgo1WEfLgQ4qrbTmRj/EdIWOIURsHSvVCkolMOZa6axPTwTB+DKxO
         n+F+ueVlKlNE2V6xIxLWFqVPzgm6sPdWpRpv9ZixD4R1vfQTTyaS42kQlD9TXo7+p0JE
         8GpdbMpwDj4cvIs5G/KgbIvbiW9AB122OaeFidxMfUrNeX0sRn5v3bIsWEUcMaSeGJTr
         eErqsUboQdRrCeECLD2FNkSaV52SrQp6RexMq6ZT1w1nN6+rIsmn1pF6cIwSYR2IFRPu
         F+QzBkvvUoZILXK0e+/F//5TtkDFYnnvMi8UqyU5s389uuU8otHfMyuGKmIrLQDXyRTm
         xzGA==
X-Gm-Message-State: APjAAAUQvMFlxVy5DBMFi7l6QFhvzKSb3y0n0JtYO+6MyW0xXoDQ0V+P
        WG4nfA65uNGpmz31uTcWEZMorw==
X-Google-Smtp-Source: APXvYqy2hqg8K7j1Jq+sMvmQu2KHFmzi0NR3Yw+1RZnuTDrmS8XcQiqun4KQI29a2wxjgWUrBpUTAg==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr18352420wmd.59.1555230922429;
        Sun, 14 Apr 2019 01:35:22 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id m13sm11574801wmg.42.2019.04.14.01.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 01:35:22 -0700 (PDT)
Date:   Sun, 14 Apr 2019 10:35:21 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Subject: Re: [PATCH v3 net-next 20/24] net: dsa: sja1105: Error out if RGMII
 delays are requested in DT
Message-ID: <20190414083521.GB24144@nanopsycho.orion>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-21-olteanv@gmail.com>
 <20190413204737.GB2268@nanopsycho.orion>
 <CA+h21hpGCOb8Vrsp-WFz+8ts0eZ=RBTF0u3DqQ9DTJbsBSN+ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hpGCOb8Vrsp-WFz+8ts0eZ=RBTF0u3DqQ9DTJbsBSN+ZQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Apr 13, 2019 at 11:31:01PM CEST, olteanv@gmail.com wrote:
>On Sat, 13 Apr 2019 at 23:47, Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Sat, Apr 13, 2019 at 03:28:18AM CEST, olteanv@gmail.com wrote:
>> >Documentation/devicetree/bindings/net/ethernet.txt is confusing because
>> >it says what the MAC should not do, but not what it *should* do:
>> >
>> >  * "rgmii-rxid" (RGMII with internal RX delay provided by the PHY, the MAC
>> >     should not add an RX delay in this case)
>> >
>> >The gap in semantics is threefold:
>> >1. Is it illegal for the MAC to apply the Rx internal delay by itself,
>> >   and simplify the phy_mode (mask off "rgmii-rxid" into "rgmii") before
>> >   passing it to of_phy_connect? The documentation would suggest yes.
>> >1. For "rgmii-rxid", while the situation with the Rx clock skew is more
>> >   or less clear (needs to be added by the PHY), what should the MAC
>> >   driver do about the Tx delays? Is it an implicit wild card for the
>> >   MAC to apply delays in the Tx direction if it can? What if those were
>> >   already added as serpentine PCB traces, how could that be made more
>> >   obvious through DT bindings so that the MAC doesn't attempt to add
>> >   them twice and again potentially break the link?
>> >3. If the interface is a fixed-link and therefore the PHY object is
>> >   fixed (a purely software entity that obviously cannot add clock
>> >   skew), what is the meaning of the above property?
>> >
>> >So an interpretation of the RGMII bindings was chosen that hopefully
>> >does not contradict their intention but also makes them more applied.
>> >The SJA1105 driver understands to act upon "rgmii-*id" phy-mode bindings
>> >if the port is in the PHY role (either explicitly, or if it is a
>> >fixed-link). Otherwise it always passes the duty of setting up delays to
>> >the PHY driver.
>> >
>> >The error behavior that this patch adds is required on SJA1105E/T where
>> >the MAC really cannot apply internal delays. If the other end of the
>> >fixed-link cannot apply RGMII delays either (this would be specified
>> >through its own DT bindings), then the situation requires PCB delays.
>> >
>> >For SJA1105P/Q/R/S, this is however hardware supported and the error is
>> >thus only temporary. I created a stub function pointer for configuring
>> >delays per-port on RXC and TXC, and will implement it when I have access
>> >to a board with this hardware setup.
>> >
>> >Meanwhile do not allow the user to select an invalid configuration.
>> >
>> >Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>> >Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> >---
>> >Changes in v3:
>> >None.
>> >
>> >Changes in v2:
>> >Patch is new.
>> >
>> > drivers/net/dsa/sja1105/sja1105.h          |  3 ++
>> > drivers/net/dsa/sja1105/sja1105_clocking.c |  7 ++++-
>> > drivers/net/dsa/sja1105/sja1105_main.c     | 32 +++++++++++++++++++++-
>> > drivers/net/dsa/sja1105/sja1105_spi.c      |  6 ++++
>> > 4 files changed, 46 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
>> >index b7e745c0bb3a..3c16b991032c 100644
>> >--- a/drivers/net/dsa/sja1105/sja1105.h
>> >+++ b/drivers/net/dsa/sja1105/sja1105.h
>> >@@ -22,6 +22,8 @@
>> >
>> > struct sja1105_port {
>> >       struct dsa_port *dp;
>> >+      bool rgmii_rx_delay;
>> >+      bool rgmii_tx_delay;
>> >       struct work_struct xmit_work;
>> >       struct sja1105_skb_ring xmit_ring;
>> > };
>> >@@ -61,6 +63,7 @@ struct sja1105_info {
>> >       const struct sja1105_table_ops *static_ops;
>> >       const struct sja1105_regs *regs;
>> >       int (*reset_cmd)(const void *ctx, const void *data);
>> >+      int (*setup_rgmii_delay)(const void *ctx, int port, bool rx, bool tx);
>> >       const char *name;
>> > };
>> >
>> >diff --git a/drivers/net/dsa/sja1105/sja1105_clocking.c b/drivers/net/dsa/sja1105/sja1105_clocking.c
>> >index d40da3d52464..c02fec181676 100644
>> >--- a/drivers/net/dsa/sja1105/sja1105_clocking.c
>> >+++ b/drivers/net/dsa/sja1105/sja1105_clocking.c
>> >@@ -432,7 +432,12 @@ static int rgmii_clocking_setup(struct sja1105_private *priv, int port)
>> >               dev_err(dev, "Failed to configure Tx pad registers\n");
>> >               return rc;
>> >       }
>> >-      return 0;
>> >+      if (!priv->info->setup_rgmii_delay)
>> >+              return 0;
>> >+
>> >+      return priv->info->setup_rgmii_delay(priv, port,
>> >+                                           priv->ports[port].rgmii_rx_delay,
>> >+                                           priv->ports[port].rgmii_tx_delay);
>> > }
>> >
>> > static int sja1105_cgu_rmii_ref_clk_config(struct sja1105_private *priv,
>> >diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
>> >index e4abf8fb2013..5f7ddb1da006 100644
>> >--- a/drivers/net/dsa/sja1105/sja1105_main.c
>> >+++ b/drivers/net/dsa/sja1105/sja1105_main.c
>> >@@ -555,6 +555,21 @@ static int sja1105_static_config_load(struct sja1105_private *priv,
>> >       return sja1105_static_config_upload(priv);
>> > }
>> >
>> >+static void sja1105_parse_rgmii_delay(const struct sja1105_dt_port *in,
>> >+                                    struct sja1105_port *out)
>> >+{
>> >+      if (in->role == XMII_MAC)
>> >+              return;
>> >+
>> >+      if (in->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID ||
>> >+          in->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
>> >+              out->rgmii_rx_delay = true;
>> >+
>> >+      if (in->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID ||
>> >+          in->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
>> >+              out->rgmii_tx_delay = true;
>> >+}
>> >+
>> > static int sja1105_parse_ports_node(struct sja1105_private *priv,
>> >                                   struct sja1105_dt_port *ports,
>> >                                   struct device_node *ports_node)
>> >@@ -1315,13 +1330,28 @@ static int sja1105_setup(struct dsa_switch *ds)
>> > {
>> >       struct sja1105_dt_port ports[SJA1105_NUM_PORTS];
>> >       struct sja1105_private *priv = ds->priv;
>> >-      int rc;
>> >+      int rc, i;
>> >
>> >       rc = sja1105_parse_dt(priv, ports);
>> >       if (rc < 0) {
>> >               dev_err(ds->dev, "Failed to parse DT: %d\n", rc);
>> >               return rc;
>> >       }
>> >+
>> >+      /* Error out early if internal delays are required through DT
>> >+       * and we can't apply them.
>> >+       */
>> >+      for (i = 0; i < SJA1105_NUM_PORTS; i++) {
>> >+              sja1105_parse_rgmii_delay(&ports[i], &priv->ports[i]);
>> >+
>> >+              if ((priv->ports[i].rgmii_rx_delay ||
>> >+                   priv->ports[i].rgmii_tx_delay) &&
>> >+                   !priv->info->setup_rgmii_delay) {
>> >+                      dev_err(ds->dev, "RGMII delay not supported\n");
>> >+                      return -EINVAL;
>> >+              }
>> >+      }
>> >+
>> >       /* Create and send configuration down to device */
>> >       rc = sja1105_static_config_load(priv, ports);
>> >       if (rc < 0) {
>> >diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
>> >index 09cb28e9be20..e4ef4d8048b2 100644
>> >--- a/drivers/net/dsa/sja1105/sja1105_spi.c
>> >+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
>> >@@ -499,6 +499,7 @@ struct sja1105_info sja1105e_info = {
>> >       .part_no                = SJA1105ET_PART_NO,
>> >       .static_ops             = sja1105e_table_ops,
>> >       .dyn_ops                = sja1105et_dyn_ops,
>> >+      .setup_rgmii_delay      = NULL,
>> >       .reset_cmd              = sja1105et_reset_cmd,
>> >       .regs                   = &sja1105et_regs,
>> >       .name                   = "SJA1105E",
>> >@@ -508,6 +509,7 @@ struct sja1105_info sja1105t_info = {
>> >       .part_no                = SJA1105ET_PART_NO,
>> >       .static_ops             = sja1105t_table_ops,
>> >       .dyn_ops                = sja1105et_dyn_ops,
>> >+      .setup_rgmii_delay      = NULL,
>> >       .reset_cmd              = sja1105et_reset_cmd,
>> >       .regs                   = &sja1105et_regs,
>> >       .name                   = "SJA1105T",
>> >@@ -517,6 +519,7 @@ struct sja1105_info sja1105p_info = {
>> >       .part_no                = SJA1105P_PART_NO,
>> >       .static_ops             = sja1105p_table_ops,
>> >       .dyn_ops                = sja1105pqrs_dyn_ops,
>> >+      .setup_rgmii_delay      = NULL,
>> >       .reset_cmd              = sja1105pqrs_reset_cmd,
>> >       .regs                   = &sja1105pqrs_regs,
>> >       .name                   = "SJA1105P",
>> >@@ -526,6 +529,7 @@ struct sja1105_info sja1105q_info = {
>> >       .part_no                = SJA1105Q_PART_NO,
>> >       .static_ops             = sja1105q_table_ops,
>> >       .dyn_ops                = sja1105pqrs_dyn_ops,
>> >+      .setup_rgmii_delay      = NULL,
>> >       .reset_cmd              = sja1105pqrs_reset_cmd,
>> >       .regs                   = &sja1105pqrs_regs,
>> >       .name                   = "SJA1105Q",
>> >@@ -535,6 +539,7 @@ struct sja1105_info sja1105r_info = {
>> >       .part_no                = SJA1105R_PART_NO,
>> >       .static_ops             = sja1105r_table_ops,
>> >       .dyn_ops                = sja1105pqrs_dyn_ops,
>> >+      .setup_rgmii_delay      = NULL,
>> >       .reset_cmd              = sja1105pqrs_reset_cmd,
>> >       .regs                   = &sja1105pqrs_regs,
>> >       .name                   = "SJA1105R",
>> >@@ -545,6 +550,7 @@ struct sja1105_info sja1105s_info = {
>> >       .static_ops             = sja1105s_table_ops,
>> >       .dyn_ops                = sja1105pqrs_dyn_ops,
>> >       .regs                   = &sja1105pqrs_regs,
>> >+      .setup_rgmii_delay      = NULL,
>>
>> You don't need to set this to NULL. Please avoid that.
>>
>
>Hi Jiri, why not?

If you don't assign, it is already NULL. so the assignment to NULL is
pointless.


>
>Thanks,
>-Vladimir
>
>>
>> >       .reset_cmd              = sja1105pqrs_reset_cmd,
>> >       .name                   = "SJA1105S",
>> > };
>> >--
>> >2.17.1
>> >
