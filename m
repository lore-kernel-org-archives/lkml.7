Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B18AC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C4A21D7A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569615054;
	bh=b7udfW27kUSAKzBz/klbWlqHmts0w2AZWPzY+ISPsnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DXkccDMSQ3wpMxmiW6qu4DyzBWs4mb9HxOUfMvDx6LaT5VpA0totvc8KShpdI//Xp
	 kyf4JS1vdLVMZwhJUS92Ino+Q+1Q0ERL23XSdQ/rnU1hGgxu/E6UASGPMQgB/sVK5G
	 1bkAh1DbGboWphOGjs5vLRRJdSF9nDXQgTlnntSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfI0UKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0UKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:10:53 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B693321655;
        Fri, 27 Sep 2019 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569615048;
        bh=b7udfW27kUSAKzBz/klbWlqHmts0w2AZWPzY+ISPsnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CHnc0vRGRCkhh6nfZRCObkOauHnm908L8O4k82Ewh33NujxymLEmDc2uRZj1FOI+O
         br/tBVj0/IipUySKwpM0V2oHoaP+UU9KGRbNaeEFxDhY+wRlQSxdmYXYxrA6vSqpt+
         FtBQtbLt5MFvnEY6w7vnWSi0OAGQ+5DJaO3QnBtk=
Received: by mail-qk1-f172.google.com with SMTP id p10so2997286qkg.8;
        Fri, 27 Sep 2019 13:10:48 -0700 (PDT)
X-Gm-Message-State: APjAAAW96wR6EZ7lMBCYQS93AXAryHqxgQ9COITAdwAeHDJA3CB+GNNG
        HzMCKemnB62YRZN4Wwj4rYoLscaJy6fgflvbSA==
X-Google-Smtp-Source: APXvYqxKy/HEii2/OoHYOAb41fJRQion1dSlPGS5FdM1aP8Lr6iCqSO+cRGGzikOzCqBYhvNXRHDJuLbTpEBmBQ5OGI=
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr6292676qkb.119.1569615047714;
 Fri, 27 Sep 2019 13:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com> <1569411888-98116-2-git-send-email-jian.hu@amlogic.com>
In-Reply-To: <1569411888-98116-2-git-send-email-jian.hu@amlogic.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 27 Sep 2019 15:10:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8r-8J_bSaQax3cJkOUL8D7P+6_PcCqaC1k8=zS18moQ@mail.gmail.com>
Message-ID: <CAL_JsqL8r-8J_bSaQax3cJkOUL8D7P+6_PcCqaC1k8=zS18moQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: meson: add A1 clock controller bindings
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 6:45 AM Jian Hu <jian.hu@amlogic.com> wrote:
>
> Add the documentation to support Amlogic A1 clock driver,
> and add A1 clock controller bindings.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../devicetree/bindings/clock/amlogic,a1-clkc.yaml |  65 +++++++++++++
>  include/dt-bindings/clock/a1-clkc.h                | 102 +++++++++++++++++++++
>  2 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> new file mode 100644
> index 0000000..f012eb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */

(GPL-2.0-only OR BSD-2-Clause) please.

Rob
