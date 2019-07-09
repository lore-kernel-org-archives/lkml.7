Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1899C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C862175B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636264;
	bh=ET6ZjW1e1B4T6US694K3uDYODb/ZhkODSk194SPpYkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IMTgLIlSrUoPreTq5U97hFqiWLIwb32xJOu7dem5uQlabUp911kniIG7zTLq2mlxM
	 TC9IVo4uFKy1PGC7dHLq961fbk5csRO3r4/nY6CbjLvCvcH20xR4HGAK4GRu/2kZj8
	 j44gHE0Tsi2hlQoTsL91Gn+39il71aKsvQhn9ckw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGIBhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:37:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33425 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIBhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:37:43 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so24706746iog.0;
        Mon, 08 Jul 2019 18:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rt46CmBrJxWpxaSmwKwGFBfR/eZrxQhs6asslQRNZ5w=;
        b=JYYUnoLqkCROw/v/js8hE5ubySmAiQH7s4P8VRcqAQeSi9tvfTWoGnQdkgxk5anZnU
         /pYCSBulemokvgWD52qtK7turbkvP9Cn83C8sf9bxvhmcwb+Q06JPEB8L+82uWxtiJxV
         /kOHO1+EhB2A2EmAuG2BxUL1gnIrsbC4tEPUhXeBQJZsYhVlFzFwJLU744MTBw8dWqw+
         xOSEOPZJFLBrMd5Dt7Kp9XfT3kXt2hqPX/OGOnHrKNs1jEL2pmRf4HSMqhg6rXAJzuWg
         mJlRNT1JmMCBMyyyAPR6gdN1tw3Ex4WUxgU1ZdD/AL4aaXQnoLc6hkAth0yuC/nUOQZg
         LGPQ==
X-Gm-Message-State: APjAAAWiJAcFGqGSmpl4HU3BXP0pYZXX+2xaFtP2VOX9WUKgiOUFR4TA
        e4HgU0tc59p1Q18CHeHqzw==
X-Google-Smtp-Source: APXvYqzPY/xWzmhADFj1fMhI/5R2iKDWY+q2CZ9P/YspzMA+qJZakBS+tSlpy3FD1YaXxAK/9OjWUQ==
X-Received: by 2002:a05:6638:627:: with SMTP id h7mr25308804jar.33.1562636262340;
        Mon, 08 Jul 2019 18:37:42 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i4sm25223321iog.31.2019.07.08.18.37.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:37:41 -0700 (PDT)
Date:   Mon, 8 Jul 2019 19:37:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     yongqiang.niu@mediatek.com
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: Re: [PATCH v3, 03/27] dt-bindings: mediatek: add ccorr description
 for mt8183 display
Message-ID: <20190709013741.GA29622@bogus>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
 <1559734986-7379-4-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559734986-7379-4-git-send-email-yongqiang.niu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 19:42:42 +0800, <yongqiang.niu@mediatek.com> wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
