Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E657521874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a0RnkQvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCVK3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:29:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60280 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:29:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MAT7B4013509;
        Fri, 22 Mar 2019 05:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553250547;
        bh=0O1zkDSF0obwwtT/py6J6dtl46lTqaWeKMz+a7C4wtw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a0RnkQvgZx58JZhU1Go8ypJ4vatoR1dXdhWaMLGCeFNXwNfgEqFVf6gJ5NWkayzII
         3s1KZH3Eg6N2a37FaxhJzjxGUsL/JQioCh4Kf+krzNbcHC8DzjBJvQN8lPCcEnzG/4
         zFW2HLfv/au45IQTWqJ/mIxh/LYSdeUsW0fQ+iV0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MAT6NS058320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 05:29:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 05:29:06 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 05:29:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MAT3gu006787;
        Fri, 22 Mar 2019 05:29:03 -0500
Subject: Re: [PATCH v2 05/15] drm/bridge: tc358767: Drop custom
 tc_write()/tc_read() accessors
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
 <20190322032901.12045-6-andrew.smirnov@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <19eddb76-38f7-e7cb-9a9f-5b435e67c63e@ti.com>
Date:   Fri, 22 Mar 2019 12:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322032901.12045-6-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 05:28, Andrey Smirnov wrote:
> A very unfortunate aspect of tc_write()/tc_read() macro helpers is
> that they capture quite a bit of context around them and thus require
> the caller to have magic variables 'ret' and 'tc' as well as label
> 'err'. That makes a number of code paths rather counterintuitive and
> somewhat clunky, for example tc_stream_clock_calc() ends up being like
> this:
> 
> 	int ret;
> 
> 	tc_write(DP0_VIDMNGEN1, 32768);
> 
> 	return 0;
> err:
> 	return ret;
> 
> which is rather surprising when you read the code for the first
> time. Since those helpers arguably aren't really saving that much code
> and there's no way of fixing them without making them too verbose to
> be worth it change the driver code to not use them at all.

I fully agree with this patch and thought about the same thing during my
work.

However, the timing of this patch is not too good, as this one will
totally conflict with any other patch for tc358767, and my series is
still evolving.

We need to figure out how to combine this series and mine, but I think
either this patch should be dropped for now, and reapplied after the
other patches have stabilized, or I think preferably, this one could be
rebased on top of 5.1-rc1, and used as a base for all other tc358767 work.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
