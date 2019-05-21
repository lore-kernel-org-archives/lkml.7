Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F26C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C1921783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fga00DVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfEUEKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:10:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46373 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfEUEKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:10:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so10180013qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 21:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c0mICKtbz9dmZs4lKO7VlxYBdZCjLhKgi8dII9aBDM=;
        b=fga00DVFQ2rLWeSRJzJKwLNxC0I6eXztpercaXApCXecXBaXVYRj/ffbIXLN7qkcUm
         z0QED+pOSGl4rtpJhkCuOdCL4ERfaM98h+1igjL6yi39+MS6XW6CJoQDoTYD+5NXaJq5
         y4Nv018qVocLknq+UU5q4SAxHg2HvqQ43q/OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c0mICKtbz9dmZs4lKO7VlxYBdZCjLhKgi8dII9aBDM=;
        b=DhrKYPPykpuaQ3a9a2BAwjJjogRUoQIaQgN3/XvVGIJlIbeif1Plr7/b5RoYvGtIIu
         ycs4fEkdVlJmiKzEqt6pXsDyrbW2iL2pFLprHTDerYmbYojctfA9TZRi/PcTpLEeJuQ3
         oSQx9mgNP/7dei+aNXZxEiiby/tpiwpU2GvgErYPjxNBlHhbLMs6DSR2i0GAzIajegGr
         wjtejBCtswu6+Efkufg/6pRVcX5Ud+6JQJPS6z2MyZgj49+KTmR89zTjNFPss45049+X
         xQFZeKf1uqpeIRw7TmwnDGrQUXk84u1BLLaEy6sUPiFkLcMl6iEM2l5NhZbkpFw/0tOB
         K7ug==
X-Gm-Message-State: APjAAAV2Orr7VYuzeryj77WrcS/AR+Ci3DrpJ+8L3KfmantveutCXFog
        lfvtbcZ2VU4MxNSSyvkSNVCnKOaey6OWyJj6jy5IAg==
X-Google-Smtp-Source: APXvYqza/UClcXjYIWYoBB8uNlk4hI6crkUxv0oq3+toM0hl9yBc/8eEZE9CMyiwgn5NUtkwXeONUDDNEx/tvWkBtqE=
X-Received: by 2002:a37:6044:: with SMTP id u65mr3960843qkb.146.1558411805476;
 Mon, 20 May 2019 21:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190519160446.320-1-hsinyi@chromium.org> <20190519160446.320-2-hsinyi@chromium.org>
 <CANMq1KB7sh=UXaM4sMm_THjZ_wV3Thgr6_ona-TJFqA2QQHALA@mail.gmail.com>
In-Reply-To: <CANMq1KB7sh=UXaM4sMm_THjZ_wV3Thgr6_ona-TJFqA2QQHALA@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 21 May 2019 12:09:39 +0800
Message-ID: <CAJMQK-iZRHO6HBkycPt0yz_vndmmmqFL0duHOcQ8EFSdhhFZcQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fdt: add support for rng-seed
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
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

On Mon, May 20, 2019 at 7:54 AM Nicolas Boichat <drinkcat@chromium.org> wrote:

> Alphabetical order.
Original headers are not sorted, should I sort them here?
>

>
> I'm a little bit concerned about this, as we really want the rng-seed
> value to be wiped, and not kept in memory (even if it's hard to
> access).
>
> IIUC, fdt_delprop splices the device tree, so it'll override
> "rng-seed" property with whatever device tree entries follow it.
> However, if rng-seed is the last property (or if the entries that
> follow are smaller than rng-seed), the seed will stay in memory (or
> part of it).
>
> fdt_nop_property in v2 would erase it for sure. I don't know if there
> is a way to make sure that rng-seed is removed for good while still
> deleting the property (maybe modify fdt_splice_ to do a memset(.., 0)
> of the moved chunk?).
>
So maybe we can use fdt_nop_property() back?
