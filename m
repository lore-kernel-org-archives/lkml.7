Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2934CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F342166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571928679;
	bh=MEaP5IL/IqooQRDNdNUcu8iypLi1gD3g0148DaXxsOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zSVwTo/Vh7EMEN/4C9Yz8puIZR8U6MK5l8oTX7E0TLAo7lYXnQLGtyRW677qkqiJE
	 E9zxQoT7NlJklhFylRx3yEYfPyYMTAE+pekNh6aarNRMdN8W85OvUaIwBbwkmhgu63
	 YbNbE/om9zUiI7hbZX+LC7tfXFtMlvx0pB80X/fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409508AbfJXOvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409497AbfJXOvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:51:18 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3597205F4;
        Thu, 24 Oct 2019 14:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571928676;
        bh=MEaP5IL/IqooQRDNdNUcu8iypLi1gD3g0148DaXxsOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AhLTlEblswmwrWUsuXYU6je5kiKbSEAz/M0zJZKKJ0DIQ60EIdRbWyrk5REfexOGm
         Oe4Ph5iPBlOcnF2uQ0YfG5vcfCeB+jCFaTgmE7IuBNtSLI7D7+S483zv39vG/VvGE/
         YHxedsM80fsfFCj4chEONOo9lXEDwHlLnhWbiK70=
Received: by mail-qt1-f181.google.com with SMTP id m15so38352940qtq.2;
        Thu, 24 Oct 2019 07:51:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXTuaOrKY8k7tl0wIDwXyQaCMwBhzyLj7F6xornI5ysT4P6BTqe
        SYH84T/DVBWUE0RR7FdLhR1mcEjHRUP+5tJYLQ==
X-Google-Smtp-Source: APXvYqyXI1R6tgkLf27Se2dMkBgfCAIms6JME3RgcEqcC6jce5AGFooEv86GX0hr06greCwOgnLCH683ZJIx8hx7MRM=
X-Received: by 2002:a0c:f792:: with SMTP id s18mr14841198qvn.20.1571928675962;
 Thu, 24 Oct 2019 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142211.GA29467@arm.com>
In-Reply-To: <20191024142211.GA29467@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 24 Oct 2019 09:51:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSSYdRyy=Hw4H613fWVyXM3ivFj8mgO6iwvXZQOr=9pA@mail.gmail.com>
Message-ID: <CAL_JsqJSSYdRyy=Hw4H613fWVyXM3ivFj8mgO6iwvXZQOr=9pA@mail.gmail.com>
Subject: Re: Question regarding "reserved-memory"
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 9:22 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
>
>
> Hi Folks,
>
> I have a question regarding "reserved-memory". I am using an Arm Juno
> platform which has a chunk of ram in its fpga. I intend to make this
> memory as reserved so that it can be shared between various devices
> for passing framebuffer.
>
> My dts looks like the following:-
>
> / {
>         .... // some nodes
>
>         tlx@60000000 {
>                 compatible = "simple-bus";
>                 ...
>
>                 juno_wrapper {
>
>                         ... /* here we have all the nodes */
>                             /* corresponding to the devices in the fpga */
>
>                         memory@d000000 {
>                                device_type = "memory";
>                                reg = <0x00 0x60000000 0x00 0x8000000>;
>                         };
>
>                         reserved-memory {
>                                #address-cells = <0x01>;
>                                #size-cells = <0x01>;
>                                ranges;
>
>                                framebuffer@d000000 {
>                                         compatible = "shared-dma-pool";
>                                         linux,cma-default;
>                                         reusable;
>                                         reg = <0x00 0x60000000 0x00 0x8000000>;
>                                         phandle = <0x44>;
>                                 };
>                         };
>                         ...
>                 }
>         }
> ...
> }
>
> Note that the depth of the "reserved-memory" node is 3.
>
> Refer __fdt_scan_reserved_mem() :-
>
>         if (!found && depth == 1 && strcmp(uname, "reserved-memory") == 0) {
>
>                 if (__reserved_mem_check_root(node) != 0) {
>                         pr_err("Reserved memory: unsupported node
> format, ignoring\n");
>                         /* break scan */
>                         return 1;
>                 }
>                 found = 1;
>
>                 /* scan next node */
>                 return 0;
>         }
>
> It expects the "reserved-memory" node to be at depth == 1 and so it
> does not probe it in our case.
>
> Niether from the
> Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>  nor from commit - e8d9d1f5485b52ec3c4d7af839e6914438f6c285,
> I could understand the reason for such restriction.
>
> So, I seek the community's advice as to whether I should fix up
> __fdt_scan_reserved_mem() so as to do away with the restriction or
> put the "reserved-memory" node outside of 'tlx@60000000' (which looks
>  logically incorrect as the memory is on the fpga platform).

For now, I'm going to say it must be at the root level. I'd guess the
memory@d000000 node is also just ignored (wrong unit-address BTW).

I think you're also forgetting the later unflattened parsing of
/reserved-memory. The other complication IIRC is booting with UEFI
does it's own reserved memory table which often uses the DT table as
its source.

Rob
