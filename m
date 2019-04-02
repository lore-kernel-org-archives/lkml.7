Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1300CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31A22084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sTFFjDS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfDBPgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:36:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60502 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbfDBPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:36:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32FaPXv022293;
        Tue, 2 Apr 2019 10:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554219385;
        bh=39svXkDNZtvIWcgszpZi7z6c0R7mgaQyzMTEPM2iz2I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sTFFjDS20QfcorAOEGrKAnrEiU3lAEe7KzWv5Grk1YWr4orMO811vrREm1aYFiU6a
         qlU+z9Q9H7yWO/4EO2JRvII8PCDdqyU/q359eqFwSFHrmuC0OeF6bjye2vU525gKQe
         FbKp1NK05T6vnvuEDkM9pTF9Iya7nBzICN+nDfu8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32FaP3q098302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 10:36:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 10:36:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 10:36:24 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32FaMK9114260;
        Tue, 2 Apr 2019 10:36:22 -0500
Subject: Re: [PATCHv5 0/6] omapdrm: DSI command mode panel support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3fed7238-776e-9ee7-9c54-b7c44a5e3a2e@ti.com>
Date:   Tue, 2 Apr 2019 18:36:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20181121160916.22017-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 21/11/2018 18:09, Sebastian Reichel wrote:
> Hi,
> 
> Here is another round of the DSI command mode panel patchset
> integrating the feedback from PATCHv4. The patches are based
> on 4.20-rc1 + fixes from Laurent and Tony. I dropped the patches
> for OMAP3 support (it needs a workaround for a hardware bug) and
> for automatic display rotation. They should get their own series,
> once this patchset has landed.

The big omapdrm bridge/panel series from Laurent has been merged to
drm-next. I think this series can now be rebased and merged.

However, all this needs to be changed to DRM bridge/panel model sooner
or later (sooner, please!), but perhaps it's best to first go with the
legacy way.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
