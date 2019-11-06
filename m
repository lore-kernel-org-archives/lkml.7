Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF6C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFB6217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T8/62/ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfKFU4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:56:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49942 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfKFU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:56:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA6KtdZU073969;
        Wed, 6 Nov 2019 14:55:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573073739;
        bh=w+Tyy9QsPPN1sBDVfeliF6HcdaVsegn5tBhO2yOcUfA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=T8/62/eaTgvMfifJlSmFVr/I9zNJa3P1Kw3aOcCh8XKIlnYIUa3v5+4P8r0CHJchU
         vInP7lCxFryjt1ylRgrk3XPwzdZnpvm5o/2OLig/MU/5DuuNzT6Srg/tlkcrH72MgR
         0kj1aWa5V4vjkD3ZrjIYpalMQIaq0dCgR2d6iXGw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA6KtdjK035505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 14:55:39 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 14:55:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 14:55:38 -0600
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with SMTP id xA6KtcLI095631;
        Wed, 6 Nov 2019 14:55:38 -0600
Date:   Wed, 6 Nov 2019 14:58:39 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     Hans Verkuil <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 12/20] media: ti-vpe: cal: Add DRA76x support
Message-ID: <20191106205839.3zxqdttlqmrzghla@ti.com>
References: <20191104193140.31145-1-bparrot@ti.com>
 <20191104193140.31145-13-bparrot@ti.com>
 <20191106085709.GB6253@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191106085709.GB6253@valkosipuli.retiisi.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sakari Ailus <sakari.ailus@iki.fi> wrote on Wed [2019-Nov-06 10:57:09 +0200]:
> Hi Benoit,
> 
> On Mon, Nov 04, 2019 at 01:31:32PM -0600, Benoit Parrot wrote:
> 
> ...
> 
> > +static struct cal_data dra76x_cal_data = {
> 
> const?

Hmm, most likely.

> 
> > +	.csi2_phy_core = dra76x_cal_csi_phy,
> > +	.num_csi2_phy = ARRAY_SIZE(dra76x_cal_csi_phy),
> > +
> 
> This newline seems extra.
> 
> > +	.flags = 0,
> 
> And flags will be zero in any case, as one more struct members are assigned
> to.

Is this guaranteed or compiler version dependent?

> 
> > +};
> 
> -- 
> Regards,
> 
> Sakari Ailus
