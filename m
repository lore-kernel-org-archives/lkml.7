Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB0C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FD62173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563289695;
	bh=KJhKHD7WlwSPz/YtNQ78gwhQw1tnMo7KNHFxIFPMNTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q8rEwK1AkvzABrt6dqHnMf0+pLcf4qME87DgR2wV4gPlfgZmLapWYSreGsf12Myei
	 BEpwo17KlDGm57ziaMnRlkhocY9OWkHBD5hDPPsJlRl93/n47qkQ+6O/9BCV6K38BN
	 9MFikmq+pJwrhZTZq1ix2ZJPuydC+DYsWfpoYAm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfGPPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfGPPIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:08:14 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B44E2173C;
        Tue, 16 Jul 2019 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563289693;
        bh=KJhKHD7WlwSPz/YtNQ78gwhQw1tnMo7KNHFxIFPMNTA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v/wWP6CudN3LZ05a20mnKFBIGZbNnb/hXtgq8tq3n1lqPierjZLdSh1ugGYZMdlJo
         iLmsI7+T9j86zGKMrvwfi40H63QdIYP7a9/1RK5xVRn+qBwJPz2p66C5s1gPmyYa6m
         8vmQRNyzUohPEL6JvEv9V5sWOC/Zc+m4jNZg8hd0=
Received: by mail-qk1-f181.google.com with SMTP id s145so14839171qke.7;
        Tue, 16 Jul 2019 08:08:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXB4XtnPlJYYcjOWjionjj05n/SlOJPK5KvayhMGpYlsCvpWqZ+
        +KPa+2VXaWFzki8Nuw97dOUdtkpuboNDgh8A0A==
X-Google-Smtp-Source: APXvYqz5UF22FVhjr/olMVpSYsnaA/jqkKHMZ9iw0D7NDtGbXTHVkBbrbyHhvjWrTB3VdHeCTevV2u7jlIBsa3zOAy8=
X-Received: by 2002:a37:a010:: with SMTP id j16mr22559615qke.152.1563289692548;
 Tue, 16 Jul 2019 08:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235759.3615-1-robh@kernel.org>
In-Reply-To: <20190626235759.3615-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 16 Jul 2019 09:08:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKmovGLxZj5jOLgXLtYD1cRHjtrQZm27Nk8cRQR9tsidg@mail.gmail.com>
Message-ID: <CAL_JsqKmovGLxZj5jOLgXLtYD1cRHjtrQZm27Nk8cRQR9tsidg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: Limit cpus schema to only check RiscV
 'cpu' nodes
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@sifive.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 6:00 PM Rob Herring <robh@kernel.org> wrote:
>
> Matching on the 'cpus' node was a bad choice because the schema is
> incorrectly applied to non-RiscV cpus nodes. As we now have a common cpus
> schema which checks the general structure, it is also redundant to do so
> in the Risc-V CPU schema.
>
> The downside is one could conceivably mix different architecture's cpu
> nodes or have typos in the compatible string. The latter problem pretty
> much exists for every schema.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       | 143 ++++++++----------
>  1 file changed, 61 insertions(+), 82 deletions(-)

Paul, do you plan to apply this? I have several fixes to send to Linus
if you want me to include this.

Rob
