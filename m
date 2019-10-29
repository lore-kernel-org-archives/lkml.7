Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06D7CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7663820874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NEqX9Fpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfJ2LIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:08:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52636 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJ2LIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:08:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9TB8pch043834;
        Tue, 29 Oct 2019 06:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572347331;
        bh=QzQe5kMCGczzhiNNF19B3lB3MNU4kTEvNCBCj+c52Cw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NEqX9FpnIMUF3554gQ0qCXtODGq6pVzBi9C+aytmEjm4c1nLXrlpepmBeMtapXOpl
         6Mq1W/gDejo3zoLTGaTR9i060L9IMU+TbrYP2BtLsGBz5M2qxtUeX+zO5xsrJLvQMj
         RgoMp4XIecys4hGAMDfucjXX4ZXtH0MZ/jCr953A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9TB8pcv055386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 06:08:51 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 06:08:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 06:08:38 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TB8kn5074904;
        Tue, 29 Oct 2019 06:08:48 -0500
Subject: Re: [PATCH v2] clk: Fix memory leak in clk_unregister()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>
References: <20191022185150.9B09B20B7C@mail.kernel.org>
 <20191029110618.7451-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <62547be1-18e0-90e5-f3bd-1bbd33d5172f@ti.com>
Date:   Tue, 29 Oct 2019 16:38:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029110618.7451-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 29/10/19 4:36 PM, Kishon Vijay Abraham I wrote:
> Memory allocated in alloc_clk() for 'struct clk' and
> 'const char *con_id' while invoking clk_register() is never freed
> in clk_unregister(), resulting in kmemleak showing the following
> backtrace.
> 
>   backtrace:
>     [<00000000546f5dd0>] kmem_cache_alloc+0x18c/0x270
>     [<0000000073a32862>] alloc_clk+0x30/0x70
>     [<0000000082942480>] __clk_register+0xc8/0x760
>     [<000000005c859fca>] devm_clk_register+0x54/0xb0
>     [<00000000868834a8>] 0xffff800008c60950
>     [<00000000d5a80534>] platform_drv_probe+0x50/0xa0
>     [<000000001b3889fc>] really_probe+0x108/0x348
>     [<00000000953fa60a>] driver_probe_device+0x58/0x100
>     [<0000000008acc17c>] device_driver_attach+0x6c/0x90
>     [<0000000022813df3>] __driver_attach+0x84/0xc8
>     [<00000000448d5443>] bus_for_each_dev+0x74/0xc8
>     [<00000000294aa93f>] driver_attach+0x20/0x28
>     [<00000000e5e52626>] bus_add_driver+0x148/0x1f0
>     [<000000001de21efc>] driver_register+0x60/0x110
>     [<00000000af07c068>] __platform_driver_register+0x40/0x48
>     [<0000000060fa80ee>] 0xffff800008c66020
> 
> Fix it here.
> 
> Fixes: fcb0ee6a3d331fb ("clk: Implement clk_unregister")
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Ignore the v2 of this patch. Sent this patch a bit early. Sorry for the noise.

Thanks
Kishon
> ---
>  drivers/clk/clk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 1c677d7f7f53..ecd647258c8f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3835,6 +3835,7 @@ static void clk_core_evict_parent_cache(struct clk_core *core)
>  void clk_unregister(struct clk *clk)
>  {
>  	unsigned long flags;
> +	struct clk_hw *hw;
>  
>  	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>  		return;
> @@ -3879,6 +3880,9 @@ void clk_unregister(struct clk *clk)
>  					__func__, clk->core->name);
>  
>  	kref_put(&clk->core->ref, __clk_release);
> +	hw = clk->core->hw;
> +	free_clk(clk);
> +	hw->clk = NULL;
>  unlock:
>  	clk_prepare_unlock();
>  }
> 
