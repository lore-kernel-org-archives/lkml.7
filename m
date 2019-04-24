Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D71C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02738218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0pJK/mN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfDXLAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:00:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38667 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDXLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:00:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id v1so1843089lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YRGgWTohXnMfcL9nci2E69BE0uvlRvf4VZptzNj7KV4=;
        b=N0pJK/mNpOAkkBYxO//qiSUDQKUtutmRVGrwaK9+rm+AaAs5NbiN3THSVgPjQ5km+Z
         SP+/903kQuVEAZhFVoLF0ofGxWqHtS48izeny2d32MSo3Rp0qDlURh6lokWnaSgzHFUG
         lBCtbywYyaeROII/Io991SdDoZfrQvJvAgg9e9XelDiAnRtQ1ozhdR1GNMIoceWYziC5
         loLMMJj0iDxv026vc7oqfaikFYLE58ivgZsekulipKv1YaFbs4DOIYvrmR72JDENA09e
         rKCD3oEzeMODPt0SyrzIygkBD4dY0m7ancpC8I1WZcMnAb8j2xiCFNu83fR7X9gC0b9Y
         A9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YRGgWTohXnMfcL9nci2E69BE0uvlRvf4VZptzNj7KV4=;
        b=NZgNcKuerRCSv4g+X46gKOziB8cWK5LvixcxORsJVh6qiAasyMBgPuq9oBblIKDOqh
         eRIOag1xhnlYXLhu++vxU+QZkCAdEjLPh0UAkx4g4PLtbNDCWVsFbsqWuvq7ux78BeOR
         paUc0TKxVh8VXTEQ3vwJaQmJWuFFnEljP37dyvAMlD8E6/32zTdiCrenmhHh7F6DxNBc
         uDwup/9RhPv9Bo2JH1Yx5swt3ZzVbjC7KRgv3biV1z3aCt9+4K7iR0fDtP8ZEFN8eneZ
         ABGRgy2YYeuLAbY+Bxj7rWHnUh9CAscMcPOJstjmpre4SYvG1ndd48Bu+OcYrio79DN6
         oG2A==
X-Gm-Message-State: APjAAAViaic0aC7yCD5LAqtIrz06+MpXJ2fBGITZdZtJkduT83MOUrES
        i0pGwwHHTCLYj7FLhMl3fNCeTw==
X-Google-Smtp-Source: APXvYqy3smMo/UZTaFSGVhuUKAzrZkXNVA+joc7vdeyB1Ls4gu9JpGovK8xepNqk7B+HYYPSovi0zA==
X-Received: by 2002:a19:7702:: with SMTP id s2mr17927489lfc.102.1556103621801;
        Wed, 24 Apr 2019 04:00:21 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u11sm3892137ljh.80.2019.04.24.04.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 04:00:21 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:00:19 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 11/19] net: ethernet: ti: cpsw: fix allmulti cfg
 in dual_mac mode
Message-ID: <20190424110017.GA4373@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Murali Karicheri <m-karicheri2@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:09:02PM +0300, Grygorii Strashko wrote:
>Now CPSW ALE will set/clean Host port bit in Unregistered Multicast Flood
>Mask (UNREG_MCAST_FLOOD_MASK) for every VLAN without checking if this port
>belongs to VLAN or not when ALLMULTI mode flag is set for nedev. This is
>working in non dual_mac mode, but in dual_mac - it causes
>enabling/disabling ALLMULTI flag for both ports.
>
>Hence fix it by adding additional parameter to cpsw_ale_set_allmulti() to
>specify ALE port number for which ALLMULTI has to be enabled and check if
>port belongs to VLAN before modifying UNREG_MCAST_FLOOD_MASK.
>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
> drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++++++--
> drivers/net/ethernet/ti/cpsw_ale.h |  2 +-
> 3 files changed, 20 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>index fe3d145846d2..c497992f01f7 100644
>--- a/drivers/net/ethernet/ti/cpsw.c
>+++ b/drivers/net/ethernet/ti/cpsw.c
>@@ -793,12 +793,17 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
>
> static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
> {
>-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
>+	struct cpsw_priv *priv = netdev_priv(ndev);
>+	struct cpsw_common *cpsw = priv->cpsw;
>+	int slave_port = -1;
>+
>+	if (cpsw->data.dual_emac)
>+		slave_port = priv->emac_port + 1;
>
> 	if (ndev->flags & IFF_PROMISC) {
> 		/* Enable promiscuous mode */
> 		cpsw_set_promiscious(ndev, true);
>-		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI);
>+		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, slave_port);
> 		return;
> 	} else {
> 		/* Disable promiscuous mode */
>@@ -806,7 +811,8 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
> 	}
>
> 	/* Restore allmulti on vlans if necessary */
>-	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
>+	cpsw_ale_set_allmulti(cpsw->ale,
>+			      ndev->flags & IFF_ALLMULTI, slave_port);
>
> 	/* add/remove mcast address either for real netdev or for vlan */
> 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
>diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>index 83ccb422dddd..f7369982ae33 100644
>--- a/drivers/net/ethernet/ti/cpsw_ale.c
>+++ b/drivers/net/ethernet/ti/cpsw_ale.c
>@@ -468,11 +468,11 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
> 	return 0;
> }
>
>-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
>+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port)
> {
> 	u32 ale_entry[ALE_ENTRY_WORDS];
>-	int type, idx;
> 	int unreg_mcast = 0;
>+	int type, idx;
>
> 	/* Only bother doing the work if the setting is actually changing */
> 	if (ale->allmulti == allmulti)
>@@ -482,10 +482,18 @@ void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
> 	ale->allmulti = allmulti;
Should ale->allmulti be removed? as "set" is per port now.

>
> 	for (idx = 0; idx < ale->params.ale_entries; idx++) {
>+		int vlan_members;
>+
> 		cpsw_ale_read(ale, idx, ale_entry);
> 		type = cpsw_ale_get_entry_type(ale_entry);
> 		if (type != ALE_TYPE_VLAN)
> 			continue;
>+		vlan_members =
>+			cpsw_ale_get_vlan_member_list(ale_entry,
>+						      ale->vlan_field_bits);
>+
>+		if (port != -1 && !(vlan_members & BIT(port)))
>+			continue;
>
> 		unreg_mcast =
> 			cpsw_ale_get_vlan_unreg_mcast(ale_entry,
>diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
>index 4777d626fac8..8a0d25950dc1 100644
>--- a/drivers/net/ethernet/ti/cpsw_ale.h
>+++ b/drivers/net/ethernet/ti/cpsw_ale.h
>@@ -109,7 +109,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
> int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
> 			int reg_mcast, int unreg_mcast);
> int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port);
>-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti);
>+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port);
>
> int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control);
> int cpsw_ale_control_set(struct cpsw_ale *ale, int port,
>-- 
>2.17.1
>

-- 
Regards,
Ivan Khoronzhuk
