Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3BBC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F69206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfETIDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:03:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39178 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfETIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:03:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id e24so22444456edq.6;
        Mon, 20 May 2019 01:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiVgtLJVaSK+kBnj7Ae+LR1x0hOyccWrwqfEKZcrZlk=;
        b=RIxtaAxaQX/+uUdcE71QpfR2HyBgnK5Mr0bj5/7vyq8NLekFSaOPwrcTQldOmx/wvm
         6q5Xny9vkB05dxlOlFeXfU+3+kvbCdXE1BB5GGdC2gm0UpSnbFKvNU74gj+Q0f0DnzyZ
         hHwXreebaNncBrruaT5y8SNJpPihArrYb2NTiz5W0qSR7EkDcT17ue5Wi58KifO7GSdi
         SDPBeDJs8t/8ka3PsZyDmJscsiOMM8OJfblH+ZgPfWJNJXxIc4scIvDdNWS6NJnAb6If
         GUsoZa66JVr5Pvb28hoJ7yh1GLUogY8JTupPs9PVXSt/PLRkO24k9cyNixUVMZjTK2ke
         KKoA==
X-Gm-Message-State: APjAAAWlPPHtuEjFARkyQqv+IPWFxnpugrq0uKjJm2VY7+GkD6+jjVWO
        NoCGj/Oy9BFKK40EOUEL+5/RkDmHScM=
X-Google-Smtp-Source: APXvYqxRFI05G003Nokm9VLzZDqyjqdh9m4BaMvaGzc2GgDxferoMzid2vsay8Sc8EUyvV3qlHSP7g==
X-Received: by 2002:a50:87b5:: with SMTP id a50mr71788047eda.118.1558339432080;
        Mon, 20 May 2019 01:03:52 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id r14sm3019734eja.77.2019.05.20.01.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:03:51 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id w8so13424030wrl.6;
        Mon, 20 May 2019 01:03:51 -0700 (PDT)
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr41065855wrn.201.1558338984633;
 Mon, 20 May 2019 00:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190516154943.239E668B05@newverein.lst.de> <20190516155139.E6EE568C65@newverein.lst.de>
In-Reply-To: <20190516155139.E6EE568C65@newverein.lst.de>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 20 May 2019 15:56:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v64xKk1r1iqSVm5pVvHVkyQ175MUFB7JPUkvQX9ecOZDDQ@mail.gmail.com>
Message-ID: <CAGb2v64xKk1r1iqSVm5pVvHVkyQ175MUFB7JPUkvQX9ecOZDDQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: DTS: allwinner: a64: Enable audio on Teres-I
To:     Torsten Duwe <duwe@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:52 PM Torsten Duwe <duwe@lst.de> wrote:
>
> From: Harald Geyer <harald@ccbib.org>
>
> The TERES-I has internal speakers (left, right), internal microphone
> and a headset combo jack (headphones + mic), "CTIA" (android) pinout.
>
> The headphone and mic detect lines of the A64 are connected properly,
> but AFAIK currently unsupported by the driver.
>
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Looks good to me.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
