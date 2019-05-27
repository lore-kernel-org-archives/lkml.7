Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B10EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316A321479
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gXbrkZHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfE0SX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:23:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42213 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfE0SX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:23:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id i2so15511759otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAp05ZteI172+2ehJDHx5CjetukVgwIirAu6MSeV5Bc=;
        b=gXbrkZHeoUgjKSE7PIBXVYeuyn93nqDPVilRWjegA9vEdkVjJKpM5Dp8XcYoYu3P60
         2giEMyye9CnFMs4k6l4Zb8ONeJZofSJujLVuioZWKtcl9X3VDmaIGZR5jFWf8g2jWtyM
         PhtdgOcbrJeF0YCo4lC0xAWPDy68kwPqvx2RiPJ9cTUbePW7R/nMC2SBZfWf1qCsWPLo
         9XnAlOHhUd/ETM4QBLX8VZ9KK/SKJNZRDpuety3LopMHVSftzcyG2mOkncv0/K67gS2v
         VbrUy1W3wzKZzeBe7blRPay9GZeW5Pa2qc0ORlNgCdk0raPeD+fKgV++Qp/2LTYsrMWD
         xfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAp05ZteI172+2ehJDHx5CjetukVgwIirAu6MSeV5Bc=;
        b=uL2BkQPFQ5xT/K8QxAh99NHD/lL4CkJ/wxwH3Sb+j3JZXOPbwmwa+Xs3ksX8hiItdY
         YMqjIo8cNX3RM6X3bMLwWU1MAyvJys+7RcLC3QMpbsu12ToMppIzjCskkUWhvW8vLxWq
         9f7ueYHWdCXR6qCGJMhr5SR+ra5EIt/kHOcD1QnfFCZrKV/NHfVInoypdHGBKJ1qauqV
         RnCTiBgSMhbcerMOEBXgy2gQ9xhLIkgRjtmNvLi77wQAVjSTVIO+EsaOj4UYoNmkyJL3
         gaTbE6VYpmv9DvhsbOIsQ+RJ5vgx2eD416GvkENn+a2q6CvZoT8stP5TZGnPwW987rAv
         dQ+A==
X-Gm-Message-State: APjAAAVF7PG8wnjfO/gFmKHiSBbqkQB/bt/3rDTuilF1ziS3EPo9Q1LF
        Oa+TDLnF2D+yjq06xbCh1LP6nd0/3h+oDR5dNF8=
X-Google-Smtp-Source: APXvYqysIaOypAAttCGsEzcLi66R8e4Aznpcqh9wB/pRH/Lk/MVeM9y6pA18bswmjtVq11U5LXpfUShz+nKPjQWx0/Y=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr61348755otb.81.1558981436041;
 Mon, 27 May 2019 11:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com> <20190527132200.17377-7-narmstrong@baylibre.com>
In-Reply-To: <20190527132200.17377-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:23:45 +0200
Message-ID: <CAFBinCA=habC6ytrMG2HYw=e-ikmNNgy5jzUswZ-44K76r8LeQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] arm64: dts: meson-gxbb-vega-s95: add HDMI nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        christianshewitt@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add HDMI nodes to support graphics on Vega S95
>
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
just like on all other boards, so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
