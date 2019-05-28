Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E182EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A052070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qAj37Eg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfE1K6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:58:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36814 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1K6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:58:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4SAvsI3030112;
        Tue, 28 May 2019 05:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559041074;
        bh=5nPt/cxqBGAOTV5zZu0P7LbT0gravsharvQbZ8UG4tU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qAj37Eg+W8vGlkzxCtgXm0Igin9JVmdRgnbhbTWE9iYDCeehWTggWVDmdsrwJgnY1
         Vsk3dVEy178kDDTOnrMptzb9ewZwUB8as0lDqhmCjOdMysuc55wuYpdCDlDpwsA1u1
         Is55Lry01g4GNyKoAKgjjX7wQmT8lXooXoADYvA4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4SAvs2E057534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 05:57:54 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 05:57:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 05:57:53 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4SAvq0P065502;
        Tue, 28 May 2019 05:57:52 -0500
Subject: Re: [PATCH next 06/25] drm/omap: Use dev_get_drvdata()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-7-wangkefeng.wang@huawei.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <9010b5b2-8a7c-5cf8-2a1d-2fbeb9f5b55b@ti.com>
Date:   Tue, 28 May 2019 13:57:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423075020.173734-7-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2019 10:50, Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   .../gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Thanks! I have picked this up.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
