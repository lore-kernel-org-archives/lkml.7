Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C019ECA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F4120578
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tLFK+PV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfJ3OU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:20:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44210 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfJ3OU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:20:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9UEKpqT099629;
        Wed, 30 Oct 2019 09:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572445251;
        bh=h6h3Qct4hHjh3WsRqxxeJYzZZhBniGFIESojv6iYpo4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tLFK+PV5UGf39undFQtz4JsZrh9rMrUSOJ0yJIB+T2x6ZkPtt82HXPunlXUkPQkdL
         +CB4ulmsBvCYrjiEPetCwDLMU4aLumsLO/jRw3LP8GcRaOjcARjU03Qap2/Sa1xKFV
         abgo5uxMhvbRhnMLOxgfAa4Ta5ipuKI6//0IfNdE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9UEKphm056166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Oct 2019 09:20:51 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 30
 Oct 2019 09:20:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 30 Oct 2019 09:20:38 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9UEKmD5011862;
        Wed, 30 Oct 2019 09:20:49 -0500
Subject: Re: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <felipe.balbi@linux.intel.com>, <pawell@cadence.com>,
        <peter.chen@nxp.com>, <nsekhar@ti.com>, <kurahul@cadence.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030121607.21739-1-rogerq@ti.com> <20191030133011.GA703854@kroah.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <56fb2de5-a017-e910-972f-532e33dfdbd6@ti.com>
Date:   Wed, 30 Oct 2019 16:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030133011.GA703854@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2019 15:30, Greg KH wrote:
> On Wed, Oct 30, 2019 at 02:16:07PM +0200, Roger Quadros wrote:
>> Take into account gadget driver's speed limit when programming
>> controller speed.
>>
>> Fixes: commit 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> 
> No need for "commit", doesn't the documentation say the correct format?
> I haven't looked in a while...
> 

Sorry, my bad.

> I can edit it out this time...

Thanks!
> 
> greg k-h
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
