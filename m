Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93960C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66551217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cUTjl+r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfE0JHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:07:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35316 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0JHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:07:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4R96u0w109353;
        Mon, 27 May 2019 04:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558948016;
        bh=6S54ESIYMmpxy+kompIXto4pV+JNxqetVk/JuZrY26k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cUTjl+r4BCYvMRqp88aG3GR29rQn0tlI6WBN0noSL9+vc7MKiZn4unA4HF1n+zvsa
         +rocwno3NetwGkFDLvyxeYEEFUPxgCxSlhZkEBPoCi1ahsaO7a9VCwYwhjUxEPpnAK
         po3guNyCI1SBx+wy7rXVhHLvU8eCtjc/YWZv8k5E=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4R96uEc018108
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 May 2019 04:06:56 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 27
 May 2019 04:06:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 27 May 2019 04:06:55 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4R96rV0066362;
        Mon, 27 May 2019 04:06:54 -0500
Subject: Re: [PATCH] drm/omapdrm: fix warning PTR_ERR_OR_ZERO can be used
To:     Matteo Croce <mcroce@redhat.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190525073026.GA7114@hari-Inspiron-1545>
 <CAGnkfhzauQGgGdvPtkNcdGkjvo1BsORxZ6f3SzGzQYuYCDetUg@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <9f72e575-82b6-0dc0-ec36-1e21d355c9f0@ti.com>
Date:   Mon, 27 May 2019 12:06:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGnkfhzauQGgGdvPtkNcdGkjvo1BsORxZ6f3SzGzQYuYCDetUg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/2019 17:56, Matteo Croce wrote:
> On Sat, May 25, 2019 at 9:30 AM Hariprasad Kelam
> <hariprasad.kelam@gmail.com> wrote:
>>
>> fix below warnings reported by coccicheck
>>
> 
> Hi,
> 
> a similar patch was nacked because it makes backports more difficult:
> 
> https://lore.kernel.org/lkml/3dec4093-824e-b13d-d712-2dedd445a7b7@ti.com/
> 
> Tomi, what's your thought?
> 

I don't particularly like the PTR_ERR_OR_ZERO, and changing old code to 
use it seem pointless.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
