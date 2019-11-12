Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91758C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBD6206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkjoSmay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLF4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:56:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30890 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbfKLF4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573538190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4H1BAGawGahyIzPrHbrHyHMfWVwsFAeBKzU7Z42zAo=;
        b=AkjoSmayGVAAMhbnFjP0BTCOzo4XoUQg3jiWRBBBJ8WIEPNEH7CJJUDnq0H0KBNWVLSNT+
        H6TCpgbAtyB9COvbWfu7X479/aC2lKTw2/x1HPTZ4b0M5dUVOsdFW8OWGYH4AgLr9Lr2pH
        xMaC4I1fKEFSR3CRqy+KQWMx+kuuVeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-OfrAog8PPI22IT-AmCI-Nw-1; Tue, 12 Nov 2019 00:56:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3645800C61;
        Tue, 12 Nov 2019 05:56:24 +0000 (UTC)
Received: from localhost (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D2D860852;
        Tue, 12 Nov 2019 05:56:18 +0000 (UTC)
Date:   Mon, 11 Nov 2019 21:56:17 -0800 (PST)
Message-Id: <20191111.215617.1625420574702786179.davem@redhat.com>
To:     Mark-MC.Lee@mediatek.com
Cc:     sean.wang@mediatek.com, john@phrozen.org, matthias.bgg@gmail.com,
        andrew@lunn.ch, robh+dt@kernel.org, mark.rutland@arm.com,
        opensource@vdorst.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        jakub.kicinski@netronome.com
Subject: Re: [PATCH net,v2 1/3] net: ethernet: mediatek: Integrate GDM/PSE
 setup operations
From:   David Miller <davem@redhat.com>
In-Reply-To: <20191111065129.30078-2-Mark-MC.Lee@mediatek.com>
References: <20191111065129.30078-1-Mark-MC.Lee@mediatek.com>
        <20191111065129.30078-2-Mark-MC.Lee@mediatek.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OfrAog8PPI22IT-AmCI-Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: MarkLee <Mark-MC.Lee@mediatek.com>
Date: Mon, 11 Nov 2019 14:51:27 +0800

> +static void mtk_gdm_config(struct mtk_eth *eth, u32 config)
> +{
> +=09int i;
> +
> +=09for (i =3D 0; i < MTK_MAC_COUNT; i++) {
> +=09=09u32 val =3D mtk_r32(eth, MTK_GDMA_FWD_CFG(i));
> +
> +=09=09/* default setup the forward port to send frame to PDMA */
> +=09=09val &=3D ~0xffff;
> +
> +=09=09/* Enable RX checksum */
> +=09=09val |=3D MTK_GDMA_ICS_EN | MTK_GDMA_TCS_EN | MTK_GDMA_UCS_EN;
> +
> +=09=09val |=3D config;
> +
> +=09=09mtk_w32(eth, val, MTK_GDMA_FWD_CFG(i));
> +=09}
> +=09/*Reset and enable PSE*/

Please put spaces before and after the comment sentence, like:

=09/* Reset and enable PSE */

