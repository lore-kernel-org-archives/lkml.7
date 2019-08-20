Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4985AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A7022DCB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bx55f33S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfHTHnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:43:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43870 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTHnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:43:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so3728410qkd.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=S9BfCaCcjnrZTg8pwvBFIJa/79WcyMDlRnwOhM+do5w=;
        b=bx55f33SgGBAmLwuFK8/xzIDq47ECx9YckjIqY1DAkVBwvNu4bo2tA0VRL+XR9Hg2s
         XkFLTt0BbVXfpGyd/dJ6vSMlSD3ITzUQlni7OdwbFg6j/xaCHJzrIELtvzV84n4wXQe1
         si3UMNgrApcQgtMIyP02jwkEFbDxLTFzJ9csU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=S9BfCaCcjnrZTg8pwvBFIJa/79WcyMDlRnwOhM+do5w=;
        b=H5woCLZUwcWpHuuOJRNvCcZ1mTmTrpdxlqWrdZ0L5pQwFVAD1XJZnRa+eNSNkF0MYU
         Pt2WioQ9CHWhQnziBrGiAOTBgZBrOR+9m0k8zL98N0OXZ1jrXSOIBPm6B+cuUg66VLrz
         WJj4dDFvMgQSmRJYcOnSnxgpN8ugjIN5j9J60aFTbcuGJDE2dsA2D6+W5U68ek/FmyZP
         Ysb9462zZow58voZ2G42r2v2mME8Q3jxKHH+m3ZBZ+sA0Z+r19pOHrXqAzW6Oj2Bz/bG
         K6A0YXHcNXrzcCPZPaF8uMtvf0l2YDIvZ2Glm/d13G3tv2fHG3haVUFAIGec9uvBon3U
         L5Ow==
X-Gm-Message-State: APjAAAVrAXy4tW8nPZPLetv2Vap390p5k09Bzd+KOJfHz2VdPuVterr3
        zAh48r7a/+VrMHfa6BF4mPQivQBSVlID4vYoSm8EPg==
X-Google-Smtp-Source: APXvYqwA24yU/jmyxqzTB0F3DSWeTMOC1E3SNpe/Aj0iH0qAXzegQBrGnogbCNV8DHKmZc5s6stZEV41nc+8I6lPnvg=
X-Received: by 2002:a05:620a:16c3:: with SMTP id a3mr23640505qkn.315.1566286984047;
 Tue, 20 Aug 2019 00:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190819071602.139014-1-hsinyi@chromium.org> <20190819071602.139014-3-hsinyi@chromium.org>
 <20190819181349.GE10349@mit.edu>
In-Reply-To: <20190819181349.GE10349@mit.edu>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 20 Aug 2019 15:42:37 +0800
Message-ID: <CAJMQK-ghQ8weMerXW7t0DFZTAg_c5M80Yp5DTAtyY2LA7YpS1A@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] fdt: add support for rng-seed
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

Thanks for raising this question.

For UEFI based system, they have a config table that carries rng seed
and can be passed to device randomness. However, they also use
add_device_randomness (not sure if it's the same reason that they
can't guarantee _all_ bootloader can be trusted)
This patch is to let DT based system also have similar features, which
can make initial random number stronger. (We only care initial
situation here, since more entropy would be added to kernel as time
goes on )

Conservatively, we can use add_device_randomness() as well, which
would pass buffer to crng_slow_load() instead of crng_fast_load().
But I think we should trust bootloader here. Whoever wants to use this
feature should make sure their bootloader can pass valid (random
enough) seeds. If they are not sure, they can just don't add the
property to DT.
