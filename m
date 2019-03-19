Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A750B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J1pCtsv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfCSMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:45:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55950 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfCSMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:45:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JCirfK119909;
        Tue, 19 Mar 2019 07:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552999493;
        bh=1nCz+zBEJJLp/3V6LnnXkFgSsvr1JCa5L2/qJ1wZIFQ=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=J1pCtsv4Tv7DqwBFtFCJrhQVNMAXiRcNLcqeEBVGOZkKC3qfuJaSfDrgMkkSFhw2V
         2OWpunlI29cUxq30KaErSffl9JuD4yXF1rKv6yq7NLXc7zBqjP6xbBoBQApClzaAKV
         zAVAefYcp4O0ied8/xfYEmbLYISxKsMTvbp9+wzw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JCirLv127682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 07:44:53 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 07:44:53 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 07:44:53 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JCinNv002828;
        Tue, 19 Mar 2019 07:44:49 -0500
Subject: Re: [PATCH v5 06/10] irqchip: ti-sci-intr: Add support for Interrupt
 Router driver
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, <tglx@linutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-7-lokeshvutla@ti.com>
 <20190218155217.5195f118@why.wild-wind.fr.eu.org>
 <1c2f2610-2be4-c145-4786-eabf3a07bc47@ti.com>
Message-ID: <799cd61d-e73b-d979-f5e0-9f4ce1de7d03@ti.com>
Date:   Tue, 19 Mar 2019 18:14:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1c2f2610-2be4-c145-4786-eabf3a07bc47@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

[..snip..]

> 
>> suggested to investigate the x86 two phase allocation mechanism for the
>> INTA driver.
> 
> Sorry, Ill try to explore this path. Any pointers to the doc/code will be really
> helpful :)

I have been trying hard to get some information on this for past few days but I
can't find anything in kernel. Can you point me to some doc/code for the x86 two
phase allocation of irqs?

Thanks and regards,
Lokesh
