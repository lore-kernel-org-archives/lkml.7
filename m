Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF92CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CD121A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NCfTLHjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408256AbfJXTvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:51:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35568 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438129AbfJXTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:50:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so21745828oig.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obOaJfYPGUFMBdJ+GFQAYWd7jIJzRz2RvyNeFwhCwqc=;
        b=NCfTLHjlbgJYN9lpItCC3wyK0gNVuM4U9DSlxbPK0EpUIoR4v5tAhulLLZtiiIO7Sf
         6VOOfxx4kF7UZCx0vTa8gWHltGDFLyzVVSKJWoNH5Yc4+G99eA8vVCVCi7bH2TW0CF+U
         BQPpM8M5NsvjEUV31BQMA2SQL9JeKZy3fpGrrDkl9ZdCCO0NX61tJi1OW4NgJNJM2lZa
         LBAGeN7fNx3FUeS3GP+/TAbus4kdH5sCNx5FbueK9qM4weHgda+EVFJ2dIY8VpZeeJuo
         AGU77VNP8VPk8VEe8qzdOSFPnOL/oHOqwmsGtSpDEEFpZSPk2ImzImmCD1suJLEEYjQP
         9e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obOaJfYPGUFMBdJ+GFQAYWd7jIJzRz2RvyNeFwhCwqc=;
        b=VTFUszrVCctVY7+KVtHAP7+lKLuslbcBu/LR6svFOYA+25jmcAmgSfkkWahOVg2yJc
         +O1+D15mYdpg6diqgi9szDknfjCUAVkEZNgBQyVHdkAg+E+ZAHIiwJaBY4E3yIWt/Ugj
         38c3JBWoEcMQmn6n/E/65gHIipG8jV2fS3gU6VQs2ys1oO5FtJ+kdre/kBReYJAp0pXJ
         kohayFThkzy4HMbS/hAfC/oAGy4hys5b2+GKvQJEdJV3KNII4sHEorsUC9siZomlJM1Z
         N6GCVOqLGobJh8oznhIFomoypuM2O+KWl+Tubb2gwWzGndvkibfggqQwc7ZMVhaAvzDG
         xnCw==
X-Gm-Message-State: APjAAAVx+ETmfp9G2ub1qE5XQ6sA1iHCk1hS9ykmGp+95mzkXVWBl0T2
        NQ3Ma81M+TYXFcEzj8b1uvfuxYxzHYL5oaKDRRE=
X-Google-Smtp-Source: APXvYqxQGKa/dRUXVPSOSFXXQKDj8etCne7ZHnOYBVb6ZrUtCaweeYFBd5Yj1la5eq8jLWjRNlFy65R3H8uw+cSuBYM=
X-Received: by 2002:aca:dd02:: with SMTP id u2mr954574oig.39.1571946647940;
 Thu, 24 Oct 2019 12:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191021142904.12401-1-narmstrong@baylibre.com>
In-Reply-To: <20191021142904.12401-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 24 Oct 2019 21:50:36 +0200
Message-ID: <CAFBinCD7NzK8EphtVTx77aSQxRytm4F8JhzbJMZ1aXfaQyFVMg@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm64: dts: meson: new fixes following YAML bindings
 schemas conversion
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Oct 21, 2019 at 4:29 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This is the first set of DT fixes following the first YAML bindings conversion
> at [1], [2], [3] and [4] and v5.4-rc1 bindings changes.
>
> These are only cosmetic changes, and should not break drivers implementation
> following the bindings.
>
> [1] https://patchwork.kernel.org/patch/11202077/
> [2] https://patchwork.kernel.org/patch/11202183/
> [3] https://patchwork.kernel.org/patch/11202207/
> [4] https://patchwork.kernel.org/patch/11202265/
>
> Neil Armstrong (5):
>   arm64: dts: meson-g12a: fix gpu irq order
>   arm64: dts: meson-gxm: fix gpu irq order
>   arm64: dts: meson-g12b-odroid-n2: add missing amlogic,s922x compatible
>   arm64: dts: meson-gx: cec node should be disabled by default
>   arm64: dts: meson-gx: fix i2c compatible
for the whole series:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Thank you!

Martin
