Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A977CC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84359206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FujUel+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfGZGEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:04:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52344 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZGEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:04:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6Q64evF046817;
        Fri, 26 Jul 2019 01:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564121080;
        bh=CUxqPox0uX06JCD6vGANt8OVjWmeI7cTyeQ3nqPOa/0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FujUel+pmaCvLTkgAXMhHWL+M+Nlswu/bHjkS1errglYmLdClnZpIh2vDbMyhXUfK
         qK7fPhWd0l8ItaSNyie/6HtHq30nGXii1C/zelZSB2OmPpaM95T0IBopi1qjZuKWz5
         wUuZPvfYfs4wEE7kGUzjj/Hb2EY1Br1rvbclWSxU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6Q64ehh077344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jul 2019 01:04:40 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Jul 2019 01:04:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Jul 2019 01:04:39 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6Q64ad4046027;
        Fri, 26 Jul 2019 01:04:37 -0500
Subject: Re: linux-next: Fixes tag needs some work in the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190726072752.2acb2149@canb.auug.org.au>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <14710d5e-7dfd-84e0-2ea1-712863c4e455@ti.com>
Date:   Fri, 26 Jul 2019 09:04:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726072752.2acb2149@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On 26/07/2019 0.27, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   9fcf9139a2fd ("ASoC: ti: davinci-mcasp: Fix clk PDIR handling for i2s master mode")
> 
> Fixes tag
> 
>   Fixes: 2302be4126f52 ("ASoC: davinci-mcasp: Update PDIR (pin direction) register handling")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean
> 
> Fixes: ca3d9433349e ("ASoC: davinci-mcasp: Update PDIR (pin direction) register handling")

Indeed this is the correct SHA1, looks like the 2302be4126f52 is on TI's
4.19-LTS branch and it got into the commit message because I have
validated first on that before moving on to linux-next.

Mark: can you either drop the patch and I'll send a new one with fixed
SHA1 or can you fix the commit message in place?

Sorry.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
