Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1590CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28D52083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999325;
	bh=5gQZPCiMtqTP1dZwAm2l6WVMXraWO4n0lPtCfSRhUSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q8tnfHF+sD3Bq0mhur48zR+zp9KzqZTQOcykXd3zeHAh1ZDx4CFwCoxM61EKz41kU
	 h0MTE6QFplmKC9XyvkX3ziwDRvpkzeeL4cU5sJi5Ww5JOEEU4NIYZNXseHBaK16mO0
	 sU/9WmG36lpVbaZ767rjL4uOwwWZSVxRFtH/T7Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392819AbfGXUPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:15:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37296 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbfGXUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:15:21 -0400
Received: by mail-io1-f66.google.com with SMTP id q22so92303077iog.4;
        Wed, 24 Jul 2019 13:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8CjyViUUMDogLJ5VWVPS6e/PwcUeKuF+6IP3/vGsBs=;
        b=LpEdL8FVEs2VmF4W0SFWTNmZR6UOR46fTdHShqvbAvKJqBpv6+v2fatbIFsgoCAqvO
         pcTVPvyIEmcNIHMD6DbH6I1g1JLZy6H5rE7GdEzVVNGRh+E1IcwB/98kAG6nt9LKF6uS
         Emg0+6LD3GfvYkauPlyCyjRXAiOCqMR6ZsIx/ac4eO5PXM6h8k76m2Ob38q76Gvj5Cba
         SmLtrpvYIsBQ+1snN5fU3+wtZP6ySonDfWgvgvgWpon325rdnQKhTPXQgUydIbxpKxHM
         XYM0K+o4/6uMW0O4IXEV79/J6ZCZqQJvDwbqKaH2DfwrWOqUD2CCEN9UbLGZfTYcyrTh
         g+BA==
X-Gm-Message-State: APjAAAVr220kpeDT0cwczIQlS2oB8s2AcRkTHEVpuZlnGJ3crWMy72pa
        FgIL5kCDHtbJAhlCgacBZw==
X-Google-Smtp-Source: APXvYqybRcRkXoHjkdesxQbBTM2QuHB/KR5mvS2bWaUpVJ+8PZzHrz+31LV30zjboYU8LvifX/teOw==
X-Received: by 2002:a6b:8e82:: with SMTP id q124mr68424936iod.68.1563999320721;
        Wed, 24 Jul 2019 13:15:20 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id v10sm41420293iob.43.2019.07.24.13.15.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:15:20 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:15:19 -0600
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
Subject: Re: [PATCH v4, 02/33] dt-bindings: mediatek: add ovl_2l description
 for mt8183 display
Message-ID: <20190724201519.GA18133@bogus>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
 <1562625253-29254-3-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562625253-29254-3-git-send-email-yongqiang.niu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 06:33:42 +0800, <yongqiang.niu@mediatek.com> wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,disp.txt    | 27 +++++++++++-----------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
