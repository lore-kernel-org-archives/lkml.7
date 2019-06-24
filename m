Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D32DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F240920657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WapHHi8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfFXTcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:32:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34458 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfFXTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:32:11 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so1617373iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46YubdxCxrFPh8KrDchM0Ty2p47WTPPMVanoBQz+N5I=;
        b=WapHHi8N2f4HLGXe8Azqgnk2rXsYnSSwWeXoyTGoqptEniMQ7RI34LHdkfRxx+PTYJ
         6q8PlKhv4L+QPsNZCCEMml8wD0fIpbl5OiXhrEU0oePfqE5PupxtN+Plt9pm45DyQEdT
         xLv0d4d/GDSlQZxVi/VWkz/v0k08TuKOrnfCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46YubdxCxrFPh8KrDchM0Ty2p47WTPPMVanoBQz+N5I=;
        b=RROxUDMfF8kMtUS1qPwyboKYMTmbuOe5DYJTNUXWFMeJncZP4IVSh3T86gGNzEpKF6
         N1UchgYdg+Ag3TuBuba6gaKUx0CnIdWo4Pcv9592E0a1oPwNT5O2mXCyjUttopr/4zfo
         P84inPz6LuzVEagW+uT0ful04KGagw2KVfVtNFKmvdSFkX708mz8fdnzJqGWeQla/TPn
         CWNNOJZUB3GwTFl45ld1QR+Ndse71OS3a81SWuer61702jCc+5fPg5WfHm5ij/fBfkZq
         OEHRCSsxzg9mWe1+61LiCTLJ3dsYyHOvDGfRDZUzIJhi/VrLmFk+X05WyuAlmUbCwoRD
         zyRg==
X-Gm-Message-State: APjAAAXP0PQ2TzP7HQMk6IPPYyl6sefO9AFpYtCk7S70OMC5N/kDUUFu
        LIpoQ9VOUfsk0UW1aGqNe9uffOPiF98=
X-Google-Smtp-Source: APXvYqzermPzG/eunflNCAys2OdCAv5ImejvBhMgl35nuT8yTa8yNUxWghkwzgya/sGhRpHhqtaApw==
X-Received: by 2002:a02:b710:: with SMTP id g16mr34621566jam.88.1561404730355;
        Mon, 24 Jun 2019 12:32:10 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id h18sm17892953iob.80.2019.06.24.12.32.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:32:10 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id i10so74942iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:32:10 -0700 (PDT)
X-Received: by 2002:a02:aa1d:: with SMTP id r29mr14713662jam.127.1561404342590;
 Mon, 24 Jun 2019 12:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190621211346.1324-1-ezequiel@collabora.com> <20190621211346.1324-2-ezequiel@collabora.com>
In-Reply-To: <20190621211346.1324-2-ezequiel@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jun 2019 12:25:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UO8S_MHPKvpu-Uc1pTAv2NN_hf+U6_HCntRU0hzGQtWw@mail.gmail.com>
Message-ID: <CAD=FV=UO8S_MHPKvpu-Uc1pTAv2NN_hf+U6_HCntRU0hzGQtWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: rockchip: document VOP gamma
 LUT address
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 21, 2019 at 2:14 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Add the register specifier description for an
> optional gamma LUT address.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from v1:
> * Drop reg-names, suggested by Doug.
> ---
>  .../devicetree/bindings/display/rockchip/rockchip-vop.txt   | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
