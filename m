Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5F7C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3F21721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWK4A8gU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfDMVbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:31:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43981 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:31:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so12006507lja.10;
        Sat, 13 Apr 2019 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArcFT6ul1Wf4Ke2Qp/uZbQBMa8mUmxKNlFJ24/G8A8U=;
        b=PWK4A8gUsbVb15T0ndnFSWN+T3jyg7AJ20UX0jxe2s7dIXAmiROr+QWXr+uHfKB24J
         ytlaEVRSs2CIo3MfqZAx67Dq9fvGrFRRboGYttOXNhWE+A7rneQWIqYYx8pB90nDUy9i
         0k9SbZInGPRLoUYmyF9oXVhZoZbm4Qzcy04wk8tOJBV0vollE2FBkTLw1LcqfeD1Sxfe
         RuBLirG1+ncTpmq0PMbtz/LrY+bNSkhiIZdTt6aKYOp1amQvDuPBc+QGQ6LyH273ENhu
         zZVp6EdNRGs5vpPUnUxhMxog8B+uHbWLQGwF83bmabYWfhR0d5R4x1l4c8fXSEgEwpgJ
         PEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArcFT6ul1Wf4Ke2Qp/uZbQBMa8mUmxKNlFJ24/G8A8U=;
        b=skSQiy3+bm+Z8Vfii5AB49gDxa/xETuzlgQA95VjSqPKJe4UnJQpLoXNhTOHJnI0V8
         5D2nDVs8lVSZUBez4gJWtjPzD6A3fj1HnlsyFnD1yKX/g/zeJCKmyFn6wS1O5ED4Q87h
         qkupJxt2qqGB9bTGxDIQb5a7/V1RlkyHMqtoUjdtj5Tezr2QB1SgWeRMmanpU0QWh4Kb
         cSKbD+ltuomYroMWjhfR5kyJzwRi0FryMsnWI+a+WQI54edeQKdCgGkxIkSLkRy7sQsq
         Relzov9hkObnrDpirWPufZPFV6aj4A2SczDhcVd8q7tvj7GBjjEHmmz54VzO/zdAWM4e
         yvJg==
X-Gm-Message-State: APjAAAW3ZAtrVfLnQg1qC30EyYKMbiFnpPLf9vDg+Uw6Kd4eq2+NEcMr
        XcpPI2H2VIHeG/RSDObUvzIqWetHO7b5ai9EtkQ=
X-Google-Smtp-Source: APXvYqyb9b9Ny5UEBJq6c7cVGZpXdQGpgaz4oPJ5FAhpsSmIy4+3s6Z8aUhex7bywvtl+u3vOaoRmqqY3YFEUw9hrio=
X-Received: by 2002:a2e:864f:: with SMTP id i15mr37074416ljj.99.1555191072736;
 Sat, 13 Apr 2019 14:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-21-olteanv@gmail.com>
 <20190413204737.GB2268@nanopsycho.orion>
In-Reply-To: <20190413204737.GB2268@nanopsycho.orion>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sun, 14 Apr 2019 00:31:01 +0300
Message-ID: <CA+h21hpGCOb8Vrsp-WFz+8ts0eZ=RBTF0u3DqQ9DTJbsBSN+ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 20/24] net: dsa: sja1105: Error out if RGMII
 delays are requested in DT
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

On Sat, 13 Apr 2019 at 23:47, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Sat, Apr 13, 2019 at 03:28:18AM CEST, olteanv@gmail.com wrote:
> >Documentation/devicetree/bindings/net/ethernet.txt is confusing because
> >it says what the MAC should not do, but not what it *should* do:
> >
> >  * "rgmii-rxid" (RGMII with internal RX delay provided by the PHY, the MAC
> >     should not add an RX delay in this case)
> >
> >The gap in semantics is threefold:
> >1. Is it illegal for the MAC to apply the Rx internal delay by itself,
> >   and simplify the phy_mode (mask off "rgmii-rxid" into "rgmii") before
> >   passing it to of_phy_connect? The documentation would suggest yes.
> >1. For "rgmii-rxid", while the situation with the Rx clock skew is more
> >   or less clear (needs to be added by the PHY), what should the MAC
> >   driver do about the Tx delays? Is it an implicit wild card for the
> >   MAC to apply delays in the Tx direction if it can? What if those were
> >   already added as serpentine PCB traces, how could that be made more
> >   obvious through DT bindings so that the MAC doesn't attempt to add
> >   them twice and again potentially break the link?
> >3. If the interface is a fixed-link and therefore the PHY object is
> >   fixed (a purely software entity that obviously cannot add clock
> >   skew), what is the meaning of the above property?
> >
> >So an interpretation of the RGMII bindings was chosen that hopefully
> >does not contradict their intention but also makes them more applied.
> >The SJA1105 driver understands to act upon "rgmii-*id" phy-mode bindings
> >if the port is in the PHY role (either explicitly, or if it is a
> >fixed-link). Otherwise it always passes the duty of setting up delays to
> >the PHY driver.
> >
> >The error behavior that this patch adds is required on SJA1105E/T where
> >the MAC really cannot apply internal delays. If the other end of the
> >fixed-link cannot apply RGMII delays either (this would be specified
> >through its own DT bindings), then the situation requires PCB delays.
> >
> >For SJA1105P/Q/R/S, this is however hardware supported and the error is
> >thus only temporary. I created a stub function pointer for configuring
> >delays per-port on RXC and TXC, and will implement it when I have access
> >to a board with this hardware setup.
> >
> >Meanwhile do not allow the user to select an invalid configuration.
> >
> >Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> >Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> >---
> >Changes in v3:
> >None.
> >
> >Changes in v2:
> >Patch is new.
> >
> > drivers/net/dsa/sja1105/sja1105.h          |  3 ++
> > drivers/net/dsa/sja1105/sja1105_clocking.c |  7 ++++-
> > drivers/net/dsa/sja1105/sja1105_main.c     | 32 +++++++++++++++++++++-
> > drivers/net/dsa/sja1105/sja1105_spi.c      |  6 ++++
> > 4 files changed, 46 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
> >index b7e745c0bb3a..3c16b991032c 100644
> >--- a/drivers/net/dsa/sja1105/sja1105.h
> >+++ b/drivers/net/dsa/sja1105/sja1105.h
> >@@ -22,6 +22,8 @@
> >
> > struct sja1105_port {
> >       struct dsa_port *dp;
> >+      bool rgmii_rx_delay;
> >+      bool rgmii_tx_delay;
> >       struct work_struct xmit_work;
> >       struct sja1105_skb_ring xmit_ring;
> > };
> >@@ -61,6 +63,7 @@ struct sja1105_info {
> >       const struct sja1105_table_ops *static_ops;
> >       const struct sja1105_regs *regs;
> >       int (*reset_cmd)(const void *ctx, const void *data);
> >+      int (*setup_rgmii_delay)(const void *ctx, int port, bool rx, bool tx);
> >       const char *name;
> > };
> >
> >diff --git a/drivers/net/dsa/sja1105/sja1105_clocking.c b/drivers/net/dsa/sja1105/sja1105_clocking.c
> >index d40da3d52464..c02fec181676 100644
> >--- a/drivers/net/dsa/sja1105/sja1105_clocking.c
> >+++ b/drivers/net/dsa/sja1105/sja1105_clocking.c
> >@@ -432,7 +432,12 @@ static int rgmii_clocking_setup(struct sja1105_private *priv, int port)
> >               dev_err(dev, "Failed to configure Tx pad registers\n");
> >               return rc;
> >       }
> >-      return 0;
> >+      if (!priv->info->setup_rgmii_delay)
> >+              return 0;
> >+
> >+      return priv->info->setup_rgmii_delay(priv, port,
> >+                                           priv->ports[port].rgmii_rx_delay,
> >+                                           priv->ports[port].rgmii_tx_delay);
> > }
> >
> > static int sja1105_cgu_rmii_ref_clk_config(struct sja1105_private *priv,
> >diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
> >index e4abf8fb2013..5f7ddb1da006 100644
> >--- a/drivers/net/dsa/sja1105/sja1105_main.c
> >+++ b/drivers/net/dsa/sja1105/sja1105_main.c
> >@@ -555,6 +555,21 @@ static int sja1105_static_config_load(struct sja1105_private *priv,
> >       return sja1105_static_config_upload(priv);
> > }
> >
> >+static void sja1105_parse_rgmii_delay(const struct sja1105_dt_port *in,
> >+                                    struct sja1105_port *out)
> >+{
> >+      if (in->role == XMII_MAC)
> >+              return;
> >+
> >+      if (in->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID ||
> >+          in->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
> >+              out->rgmii_rx_delay = true;
> >+
> >+      if (in->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID ||
> >+          in->phy_mode == PHY_INTERFACE_MODE_RGMII_ID)
> >+              out->rgmii_tx_delay = true;
> >+}
> >+
> > static int sja1105_parse_ports_node(struct sja1105_private *priv,
> >                                   struct sja1105_dt_port *ports,
> >                                   struct device_node *ports_node)
> >@@ -1315,13 +1330,28 @@ static int sja1105_setup(struct dsa_switch *ds)
> > {
> >       struct sja1105_dt_port ports[SJA1105_NUM_PORTS];
> >       struct sja1105_private *priv = ds->priv;
> >-      int rc;
> >+      int rc, i;
> >
> >       rc = sja1105_parse_dt(priv, ports);
> >       if (rc < 0) {
> >               dev_err(ds->dev, "Failed to parse DT: %d\n", rc);
> >               return rc;
> >       }
> >+
> >+      /* Error out early if internal delays are required through DT
> >+       * and we can't apply them.
> >+       */
> >+      for (i = 0; i < SJA1105_NUM_PORTS; i++) {
> >+              sja1105_parse_rgmii_delay(&ports[i], &priv->ports[i]);
> >+
> >+              if ((priv->ports[i].rgmii_rx_delay ||
> >+                   priv->ports[i].rgmii_tx_delay) &&
> >+                   !priv->info->setup_rgmii_delay) {
> >+                      dev_err(ds->dev, "RGMII delay not supported\n");
> >+                      return -EINVAL;
> >+              }
> >+      }
> >+
> >       /* Create and send configuration down to device */
> >       rc = sja1105_static_config_load(priv, ports);
> >       if (rc < 0) {
> >diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
> >index 09cb28e9be20..e4ef4d8048b2 100644
> >--- a/drivers/net/dsa/sja1105/sja1105_spi.c
> >+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
> >@@ -499,6 +499,7 @@ struct sja1105_info sja1105e_info = {
> >       .part_no                = SJA1105ET_PART_NO,
> >       .static_ops             = sja1105e_table_ops,
> >       .dyn_ops                = sja1105et_dyn_ops,
> >+      .setup_rgmii_delay      = NULL,
> >       .reset_cmd              = sja1105et_reset_cmd,
> >       .regs                   = &sja1105et_regs,
> >       .name                   = "SJA1105E",
> >@@ -508,6 +509,7 @@ struct sja1105_info sja1105t_info = {
> >       .part_no                = SJA1105ET_PART_NO,
> >       .static_ops             = sja1105t_table_ops,
> >       .dyn_ops                = sja1105et_dyn_ops,
> >+      .setup_rgmii_delay      = NULL,
> >       .reset_cmd              = sja1105et_reset_cmd,
> >       .regs                   = &sja1105et_regs,
> >       .name                   = "SJA1105T",
> >@@ -517,6 +519,7 @@ struct sja1105_info sja1105p_info = {
> >       .part_no                = SJA1105P_PART_NO,
> >       .static_ops             = sja1105p_table_ops,
> >       .dyn_ops                = sja1105pqrs_dyn_ops,
> >+      .setup_rgmii_delay      = NULL,
> >       .reset_cmd              = sja1105pqrs_reset_cmd,
> >       .regs                   = &sja1105pqrs_regs,
> >       .name                   = "SJA1105P",
> >@@ -526,6 +529,7 @@ struct sja1105_info sja1105q_info = {
> >       .part_no                = SJA1105Q_PART_NO,
> >       .static_ops             = sja1105q_table_ops,
> >       .dyn_ops                = sja1105pqrs_dyn_ops,
> >+      .setup_rgmii_delay      = NULL,
> >       .reset_cmd              = sja1105pqrs_reset_cmd,
> >       .regs                   = &sja1105pqrs_regs,
> >       .name                   = "SJA1105Q",
> >@@ -535,6 +539,7 @@ struct sja1105_info sja1105r_info = {
> >       .part_no                = SJA1105R_PART_NO,
> >       .static_ops             = sja1105r_table_ops,
> >       .dyn_ops                = sja1105pqrs_dyn_ops,
> >+      .setup_rgmii_delay      = NULL,
> >       .reset_cmd              = sja1105pqrs_reset_cmd,
> >       .regs                   = &sja1105pqrs_regs,
> >       .name                   = "SJA1105R",
> >@@ -545,6 +550,7 @@ struct sja1105_info sja1105s_info = {
> >       .static_ops             = sja1105s_table_ops,
> >       .dyn_ops                = sja1105pqrs_dyn_ops,
> >       .regs                   = &sja1105pqrs_regs,
> >+      .setup_rgmii_delay      = NULL,
>
> You don't need to set this to NULL. Please avoid that.
>

Hi Jiri, why not?

Thanks,
-Vladimir

>
> >       .reset_cmd              = sja1105pqrs_reset_cmd,
> >       .name                   = "SJA1105S",
> > };
> >--
> >2.17.1
> >
