Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B596C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1161B206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565993179;
	bh=YaPFdB/PzhgOhILKwU27iMJ3Cfa34h/GLBwHOm914ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yW/j2EnXux4L+vC6Go2BPYa9XKrnMKSd+3Tyw8S+BE6+GhOYCQ4pGZlhQo/o5TuEu
	 jNUrLehMMlsjrhlkmt8FzlTWHg5C/1KJTp0Zc/Ikbom6+PSMqD1XUqkXk6bZT0zZrV
	 e11Kvx8/N9sve23WAq5lk4ZfLvNV1wDvnMb8epAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfHPWGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:06:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35181 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfHPWGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:06:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id g17so10153692otl.2;
        Fri, 16 Aug 2019 15:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c1XuEJXK9FfUQuWikaiU8aAHVF82tM2Ux510YBrnxGM=;
        b=mb0JGqcgelEa8GHXRLlQYRP4akTiCuozRiktSEftppI4RC8pREPQAem0oBU7+ZytQV
         C+0A3mjmOWdqz0BDvfRE41acw6tDYdIGhRu2pSMuGbEc0WrFY3Q0zShBf8TQ9ROuZXca
         OoEbdRaPMOdhA80x1M29CAw7YS76B7tCDutZeuYYYKyIWvKjonEMNCS2qEJCw3JwmYJn
         rsEf1rO6dahULDxzYVSVwa3lEJ9p3NYdMFW9AR1J3OHLs3Q+Ife6tcDu7y5bGVgOtYtw
         7SYveWBmIGytexOpJbwuQMOMsYK9ad1zRgeWTl+dtIl3yk+5QhGvJRoN8393hN1ZanUw
         sAEQ==
X-Gm-Message-State: APjAAAVJOvffz+xEwt3O/a3mjeFE79lFzydBc9b+D5g5JYovebPG+Gsx
        fvUMB02E1Cb3XYxgCRYVHA==
X-Google-Smtp-Source: APXvYqzw+Cf+orS/G1HpiqFSkUwStTCMNUUOQ8ef5IhY/yKp8zTACJfDvod1DpPnqwCAmF6Bewtc/w==
X-Received: by 2002:a9d:5a82:: with SMTP id w2mr9825613oth.104.1565993177035;
        Fri, 16 Aug 2019 15:06:17 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdf:eef6:c125:340:5598:396e])
        by smtp.gmail.com with ESMTPSA id i63sm1909093oih.18.2019.08.16.15.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 15:06:16 -0700 (PDT)
Date:   Fri, 16 Aug 2019 17:06:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK HU <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        ginny.chen@mediatek.com, Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: Re: [PATCH v11 03/12] dt-binding: gce: add binding for gce client
 reg property
Message-ID: <20190816220615.GA25142@bogus>
References: <20190729070106.9332-1-bibby.hsieh@mediatek.com>
 <20190729070106.9332-4-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729070106.9332-4-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 15:00:57 +0800, Bibby Hsieh wrote:
> cmdq driver provide a function that get the relationship
> of sub system number from device node for client.
> add specification for #subsys-cells, mediatek,gce-client-reg.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt      | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
