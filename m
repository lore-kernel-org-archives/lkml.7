Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AB7C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D7920859
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sux2xyij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfDTAdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:33:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47330 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDTAdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:33:46 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3J8OhPS064730;
        Fri, 19 Apr 2019 03:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555662283;
        bh=2BcTRh2OlH2bDsIqds7rgbXDXhkpNvmzKs9G89ttX7A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sux2xyijJzYYqP/Y+eWCrSNESQlmPwBP/j8iGd6gV/4GfAs2GuUScgtZVcBIJG3kQ
         eEPnWWGxuZUJbS386hJbrhri/YF2iCail1CYyB9UZ0NLqFAkkwU6aLIUmT6DR3ZLti
         TAc4nR9EY6nbrPrg/iLG4X/7OCFcCmxewuJb+B9E=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3J8OhW3002607
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Apr 2019 03:24:43 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 19
 Apr 2019 03:24:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 19 Apr 2019 03:24:43 -0500
Received: from [172.22.188.35] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3J8OdZp087910;
        Fri, 19 Apr 2019 03:24:40 -0500
Subject: Re: [RFC PATCH 0/3] net: ethernet: ti: cpsw: Add XDP support
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ilias.apalodimas@linaro.org>,
        <hawk@kernel.org>, <xdp-newbies@vger.kernel.org>, <ast@kernel.org>,
        <aniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <john.fastabend@gmail.com>, "Nori, Sekhar" <nsekhar@ti.com>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <844a80e9-95fb-7afd-6be3-5e6a0be2ed00@ti.com>
Date:   Fri, 19 Apr 2019 11:24:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On 17.04.19 20:49, Ivan Khoronzhuk wrote:
> This patchset is RFC adding XDP support for TI cpsw driver that is
> based on page_pool allocator. It was verified with af_xdp sockets
> and on xdp drop. For XDP redirect to another interface it's under
> verification, still not sure about all cases that should be verified.
> Also regular tests with iperf2 were done in order to verify impact on
> regular netstack performance, compared with base commit from
> net-next/master: 432bc230700f86801cffa5e159e05dea6229f722
> 
> It was verified with following configs enabled:
> CONFIG_JIT=y
> CONFIG_BPFILTER=y
> CONFIG_BPF_SYSCALL=y
> CONFIG_XDP_SOCKETS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_HAVE_EBPF_JIT=y
> CONFIG_BPF_JIT=y
> CONFIG_CGROUP_BPF=y
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
> For af_xdp socket type verification several generic changes should be added
> that can be seen here (rough fixes, for samples related seems like last version
> of samples is more integrated with libbpf api, so should be rebased,
> witch I will send as RFC separately):
> https://github.com/ikhorn/af_xdp_stuff/tree/af_xdp_armv7
> 
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

Thanks for your patches. It's great to have XDP support.
I have no objection to this series in general, but i'm not xdp expert, so
it can be moved forward when you resolve comments from other reviewers.

-- 
Best regards,
grygorii
