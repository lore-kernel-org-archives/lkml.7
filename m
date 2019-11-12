Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3937C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB178206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFTUytoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfKLFrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:47:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26665 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbfKLFrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573537626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBqjouGw3TH1iaQ7iP1CayKO4c2WZUu/AVL/DYGbLDM=;
        b=QFTUytoaPqSrw4YDgCusZzXtQvYzY3PaRYo4c8Hd97/Rdq3bkedp1X+GBzPQ3uH5yF1nGz
        RYMXJqoV20XaJbTOaOMxhU4Hr9ezuHXjrzSoQnMvfuOEBSVYYdsry9oMNzHv/Fj1wri4U/
        737210uAj5wrJ02wAvFM95qdcR0GNSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-jR0LROUlONuAV20I3GQI8Q-1; Tue, 12 Nov 2019 00:47:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82B98801E4F;
        Tue, 12 Nov 2019 05:47:01 +0000 (UTC)
Received: from localhost (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBD085C883;
        Tue, 12 Nov 2019 05:46:59 +0000 (UTC)
Date:   Mon, 11 Nov 2019 21:46:58 -0800 (PST)
Message-Id: <20191111.214658.1031500406952713920.davem@redhat.com>
To:     olof@lixom.net
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio-octeon: Fix pointer/integer casts
From:   David Miller <davem@redhat.com>
In-Reply-To: <20191111004211.96425-1-olof@lixom.net>
References: <20191111004211.96425-1-olof@lixom.net>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: jR0LROUlONuAV20I3GQI8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>
Date: Sun, 10 Nov 2019 16:42:11 -0800

> -static inline void oct_mdio_writeq(u64 val, u64 addr)
> +static inline void oct_mdio_writeq(u64 val, void __iomem *addr)
>  {
> -=09cvmx_write_csr(addr, val);
> +=09cvmx_write_csr((u64)addr, val);
>  }

I hate stuff like this, I think you really need to fix this from the bottom
up or similar.  MMIO and such addresses are __iomem pointers, period.

