Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99B4C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8039E214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2TYWoAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbfDRGMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:12:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33604 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfDRGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:12:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so1044828qtb.0;
        Wed, 17 Apr 2019 23:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lz7yWPtSXVpxhOY8cfs/80Rx7F34AkV4n5jke7TRbt8=;
        b=h2TYWoAHxO616ZQ2BdKSBzs4X9muR3zWIeuDAJIC0MPaax17S08JB5oCMcgXUmbhTe
         g1v6chhH7UT7iunt51gl6SkQFP+sQgQjrv8Yo7uQZuIktAzsYg7KX6wpofjkQFVQTPzv
         m45zix5UjD7h4lr8v5MPTXWJHr09uY40BaNMxP0PMW7eLce0QKFDwFc8wvBfB+evOMqa
         chSyNXildOXmpH3bdzpodAsxNs9aRY779vjfPiCP4dQm1YLnSCYinf735a6wlq9OQ/Hc
         HfM6SNePAp1xzdBFBS+CQ8brt1zLoBpR5WbtWLxbCRjF4icTJozy+KK7rpO+ucu6d98c
         aSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lz7yWPtSXVpxhOY8cfs/80Rx7F34AkV4n5jke7TRbt8=;
        b=twQqYEHaA36Ryk/iBBWkpvhymAtZZCmfDWMuqVmAdo6Iqb8ZJeg7HTkrzXnBzWMB2G
         trgCN3IkCkqCnjIVqjLhdnz27SzHp7Cjd/lL3otralJgC9GMjZcUIXI0S0dj7ADio3/h
         wOh+kNROKeb5xE+4a4PbJyABvpugC1VbeeBblAeRNCDmItnGNVF2yt3cIDKi1KlmrN8w
         kVtiBVX4gRiVSWPdHKkJC+62YwpraTjma3s/MqKv6YRYgqD30ZaFBf/i1hSEU221LYS6
         qbVIqDSG33ReJ5ZN6li37yCwWyo/famELEa4OGD8ziZ7908P/mzQRzURo+3/i4cOcXpw
         BRGg==
X-Gm-Message-State: APjAAAXR2vYfZBEw9RmW4fX0KfUewH4KGG0ksSiyaFr8/5zQe1T/tM6f
        oXsRfbBegEol8JiIzZUys0yYm9RTql95mWfsNOU=
X-Google-Smtp-Source: APXvYqzzhBRyaTN3npQGwC0YGc594OByx917OgZEEew4cdP/gscj2LzzZROc3TCINR/EtnPSR5Hz1LzI6o/wMjP/EF0=
X-Received: by 2002:ac8:950:: with SMTP id z16mr73716350qth.16.1555567938960;
 Wed, 17 Apr 2019 23:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
In-Reply-To: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 18 Apr 2019 08:12:06 +0200
Message-ID: <CAJ+HfNhzBMgQwan-x1KV48V_z0jVQgWnAD+HDxvYLyCmTxAJbw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] net: ethernet: ti: cpsw: Add XDP support
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        hawk@kernel.org, Xdp <xdp-newbies@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, aniel@iogearbox.net,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 at 19:51, Ivan Khoronzhuk
<ivan.khoronzhuk@linaro.org> wrote:
>
> This patchset is RFC adding XDP support for TI cpsw driver that is
> based on page_pool allocator. It was verified with af_xdp sockets
> and on xdp drop. For XDP redirect to another interface it's under
> verification, still not sure about all cases that should be verified.
> Also regular tests with iperf2 were done in order to verify impact on
> regular netstack performance, compared with base commit from
> net-next/master: 432bc230700f86801cffa5e159e05dea6229f722
>
> It was verified with following configs enabled:
> CONFIG_JIT=3Dy
> CONFIG_BPFILTER=3Dy
> CONFIG_BPF_SYSCALL=3Dy
> CONFIG_XDP_SOCKETS=3Dy
> CONFIG_BPF_EVENTS=3Dy
> CONFIG_HAVE_EBPF_JIT=3Dy
> CONFIG_BPF_JIT=3Dy
> CONFIG_CGROUP_BPF=3Dy
>
> iperf2 UDP RX summary (packet size / Mbps):
> +--------------------------------------------------------------+
> | pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
> |---------------+------+------+------+------+------+-----+-----|
> | base commit   | 561  | 470  | 796  |  35  | 70.1 | 281 | 140 |
> |---------------+------+------+------+------+------+-----+-----|
> | XDP patched   | 563  | 455  | 808  |  35  | 70.2 | 282 | 141 |
> +--------------------------------------------------------------+
>
> iperf2 UDP TX summary (packet size / Mbps):
> +--------------------------------------------------------------+
> | pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
> |---------------+------+------+------+------+------+-----+-----|
> | base commit   | 555  | 666  | 736  | 34.5 | 70.3 | 281 | 140 |
> |---------------+------+------+------+------+------+-----+-----|
> | XDP patched   | 558  | 696  | 759  | 35.2 | 69.2 | 279 | 140 |
> +--------------------------------------------------------------+
>
> iperf2 TCP summary (window size / Mbps):
> +------------------------------------------------------------+
> | window size/rate |  16  |  32  |  64  |  128 |  8   | 256  |
> |------------------+------+------+------+------+------+------|
> | base commit      | 753  | 887  | 931  | 932  | 676  | 932  |
> |------------------+------+------+------+------+------+------|
> | XDP patched      | 823  | 888  | 932  | 933  | 669  | 933  |
> +------------------------------------------------------------+
>
> For af_xdp socket type verification several generic changes should be add=
ed
> that can be seen here (rough fixes, for samples related seems like last v=
ersion
> of samples is more integrated with libbpf api, so should be rebased,
> witch I will send as RFC separately):
> https://github.com/ikhorn/af_xdp_stuff/tree/af_xdp_armv7
>

More XDP support, yay!

As for mmap/AF_XDP on 32-bit systems; Instead of hacking the if_xdp.h,
mmap2 should be used. Have a look at the libbpf code here [1]


Bj=C3=B6rn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/t=
ools/lib/bpf/xsk.c#n81


> Ivan Khoronzhuk (3):
>   net: ethernet: ti: davinci_cpdma: add dma mapped submit
>   net: ethernet: ti: davinci_cpdma: return handler status
>   net: ethernet: ti: cpsw: add XDP support
>
>  drivers/net/ethernet/ti/Kconfig         |   1 +
>  drivers/net/ethernet/ti/cpsw.c          | 552 +++++++++++++++++++++---
>  drivers/net/ethernet/ti/davinci_cpdma.c | 117 +++--
>  drivers/net/ethernet/ti/davinci_cpdma.h |   6 +-
>  drivers/net/ethernet/ti/davinci_emac.c  |  18 +-
>  5 files changed, 591 insertions(+), 103 deletions(-)
>
> --
> 2.17.1
>
