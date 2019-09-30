Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6BFC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7835521855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BcvCOup+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfI3LiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:38:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33942 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3LiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:38:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8UBc3mf113627;
        Mon, 30 Sep 2019 06:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569843483;
        bh=rzzp9JtSMY8B/gEGQJjNHTW8qusfxRW7FdjakyT92pE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BcvCOup+UgVr+WykHRJsH0wDcPQDSNsDyQ7ASQov6hgFMlzZqUNShq9929E28NEmA
         yly+ZgqRG00SctEY1TyB3W/aeaN9TYd94PyJnK1W7qltbxHlKx/KcP0Sqo7380JOdH
         Kqrk8YGTIWXGg0YVd57Am8T7XS7xz7+7/Ar+nju0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8UBc2fc106969
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Sep 2019 06:38:03 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 30
 Sep 2019 06:38:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 30 Sep 2019 06:38:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8UBc20i105077;
        Mon, 30 Sep 2019 06:38:02 -0500
Date:   Mon, 30 Sep 2019 06:36:29 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Axel Lin <axel.lin@ingics.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: ti-abb: Fix timeout in
 ti_abb_wait_txdone/ti_abb_clear_all_txdone
Message-ID: <20190930113607.5l443q7qyg6eovnf@kahuna>
References: <20190929095848.21960-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190929095848.21960-1-axel.lin@ingics.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:58-20190929, Axel Lin wrote:
> ti_abb_wait_txdone() may return -ETIMEDOUT when ti_abb_check_txdone()
> returns true in the latest iteration of the while loop because the timeout
> value is abb->settling_time + 1. Similarly, ti_abb_clear_all_txdone() may
> return -ETIMEDOUT when ti_abb_check_txdone() returns false in the latest
> iteration of the while loop. Fix it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Nishanth Menon <nm@ti.com>

Mark, if you could pick it up, will be great.

-- 
Regards,
Nishanth Menon
