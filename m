Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282452084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A2R6SpqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfDINZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:25:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36560 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfDINZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:25:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x39DPOKU061509;
        Tue, 9 Apr 2019 08:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554816324;
        bh=ElKsdCRAaFtyjy1zns63JULeahO75mzwOEbFIiHQ54E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A2R6SpqH1o/y4WIvM8ixXRfzVgaHDYf15X8KbS9yNBJtGww0zcZ2XhrBSXbPmyKWC
         EQTYTsFNMv/P41gkcClU0ojnNuDDehuBseWSAtwiaY7Ub8ICEsQcLzqpUbRjczcbeq
         JL6euvlA3iwOlOnCWsdBjKqI3nkXrP677FXiOx2M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x39DPOxM021212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 08:25:24 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 08:25:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 08:25:24 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x39DPLKG013036;
        Tue, 9 Apr 2019 08:25:22 -0500
Subject: Re: linux-next: manual merge of the rtc tree with the omap tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tony Lindgren <tony@atomide.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190409152226.5fecccd1@canb.auug.org.au>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <1e3bc22e-97b5-3f63-c202-e04cfad48222@ti.com>
Date:   Tue, 9 Apr 2019 18:55:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190409152226.5fecccd1@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/19 10:52 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rtc tree got a conflict in:
> 
>    drivers/rtc/rtc-omap.c
> 
> between commit:
> 
>    6256f7f7f217 ("rtc: OMAP: Add support for rtc-only mode")
> 
> from the omap tree and commit:
> 
>    35118b7a4ea0 ("rtc: omap: let the core handle range")
> 
> from the rtc tree.
> 
> I fixed it up (I used the latter resolution around tm2bcd() changes) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.


Thanks Stephen. I have tested with Latest next and rtc+ddr mode is 
functional with an additional fix that Tony is about to queue.

I also reviewed the rtc driver and looks fine.

> 
