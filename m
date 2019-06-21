Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0587C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5917215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="asyD1YYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFULH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:07:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39765 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFULH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:07:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190621110726euoutp01870260d53c536dcfe9ed8489b90691bb~qMguVIVb32736927369euoutp01Y
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:07:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190621110726euoutp01870260d53c536dcfe9ed8489b90691bb~qMguVIVb32736927369euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561115246;
        bh=KTzkzIChllLy2c5xxfE082TNL9X2BY16GTTqGf8LcYA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=asyD1YYg7j/dCVF/YWu7GuZwXoIq2uN2F5/+9t0zXN+l3bsPeOtWZ4YQ2ALFhU+92
         Tq+tGfqGHDV+PmMTcbMqC4L+YiyXxBqbBTSD4smliMpdBZxnNpk7oZCNuEBljB2yvz
         0vzS1NSsGQaD6rGQ7NTxmT3qVaTQ1resEaXlgCHc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190621110725eucas1p1bd6c17d084452e54d39f0dec1f2d433b~qMgtcIkEk2803728037eucas1p1V;
        Fri, 21 Jun 2019 11:07:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9B.BA.04325.C6ABC0D5; Fri, 21
        Jun 2019 12:07:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190621110724eucas1p280d182bc57d444db561561fd62384c60~qMgsrncMm2562925629eucas1p2-;
        Fri, 21 Jun 2019 11:07:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190621110724eusmtrp16eac737eaf298c20c1f15bf833ee4b88~qMgsdd-6t0192801928eusmtrp1G;
        Fri, 21 Jun 2019 11:07:24 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-e3-5d0cba6c5a01
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6F.54.04140.C6ABC0D5; Fri, 21
        Jun 2019 12:07:24 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190621110723eusmtip2ac731f6d596f6b4c9be2014c7c05dcf7~qMgr-xOfO3226132261eusmtip23;
        Fri, 21 Jun 2019 11:07:23 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: imxfb: fix sparse warnings about using
 incorrect types
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kbuild test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <af111901-1fdb-a2d5-dcf7-aa2fd14c2ac5@samsung.com>
Date:   Fri, 21 Jun 2019 13:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8520d744-cebc-c76a-e51a-ff6a471af57d@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3b27u85NrlPxsKRiZZSUGvrjoqUG/VgZ6K8KRWzmZYrza1ct
        7UeGOT/xa0q5pITM6SCdc86PxEJlmopgqYihpkk4Q83MsA8l3VXy33POeZ7znAcOiUlG+FIy
        PimNUScpVDJCiFusv0bPq7pEUb6LLwPo8c01gp6fCKMNVZ04bfo8yacHS77x6cLfjRj9oauG
        oJdzFgh6u92E00tmd/pjuRaFOMo7dTMC+YtuG09uMhQQ8rmiAZ68te6BvGW1gycv3faVb5iO
        hZMRwouxjCo+g1H7BN0WxlmHtIKUHOKe3qYXZKMCfiFyIIHyh5I/67tYSEqoBgRjm18wrviB
        oHxkRsAVGwharA8FBxJzm57gBnoEraO5+8UKgrrcFftiFyoSNJX9dgVBBUB5ngHtYVcqBCqn
        yuxrMWqLB0WWJvtATAVB6dx3O8YpT9gqbsL2sBt1C+asRj7HcYZ31Yv4HnaggqFmtsfOxyh3
        mF58zuPwcchpe2oPAZRNAIPr9Yi7+woUV+Tsx3aB5QHzfh4PGNYW45ygCcF2/tK+uh2BXrtD
        cKxA6BsY21WTuxZnobnLh2tfBtPXOt5eGygnmFpx5o5wggrLY4xriyFfI+HYp8FYbyQObAs7
        G7EyJNMdiqY7FEd3KI7uv28twg3InUlnE5UM65fE3PVmFYlsepLS+05yognt/tjwzsBmB+r5
        G9OLKBLJROK3OscoCV+RwWYm9iIgMZmrWKQSRUnEsYrMLEadHK1OVzFsLzpK4jJ38f0jnyIl
        lFKRxiQwTAqjPpjySAdpNpoe94v3X4jZXH6TWuoj0zC10jWP8PGq7VQlOhFx85zEs75mMDq4
        sbT7tTbTeG2uiTcKSxihadwqaFWFBvaLOiew5Jm1LP/3CUM+FU8sfebQS0cUV70mG16FpDUT
        s/nsksqSld918lToz6BHAtv8Knv9xrOwDKtbdYXfcN4ZqQxn4xQXvDA1q/gHYkQCX18DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7o5u3hiDWZ+ZrO48vU9m8XDq/4W
        q6buZLHY9Pgaq8WJvg+sFl2/VjJbXN41h83iVfMjNou/2zexWLzYIm5xe+JkRgduj52z7rJ7
        LN7zkslj06pONo/73ceZPDYvqffY+G4Hk0f/XwOPz5vkAjii9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKOnZrMXtDMVrH85XL2BsZO1i5GTg4J
        AROJLVuXs3UxcnEICSxllLh66C1jFyMHUEJG4vj6MogaYYk/17qgal4zSvyY3MsEkhAWiJZo
        m3KEHcRmE7CSmNi+ihHEFhFwkJhyYwI7SAOzwA8miaVz/oFtExIolljY9RXM5hWwk+i//wms
        gUVAVeJHzzpmEFtUIELizPsVLBA1ghInZz4BszkF7CXm3NsHVs8soC7xZ94lZghbXOLWk/lM
        ELa8RPPW2cwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM
        2W3Hfm7Zwdj1LvgQowAHoxIP74FZ3LFCrIllxZW5hxglOJiVRHh5cnhihXhTEiurUovy44tK
        c1KLDzGaAj03kVlKNDkfmE7ySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0
        MXFwSjUwFj5/duvtAdbuIP72w2xnlF89VapydP1S97Hrw6pfu1LSWso0rO4/Uvi7yTp08kTv
        p9M6+O786Ln5++LffUr3f0clnP7c7XcvO7m36tWdzSoi3asdtsQ7928/933WulVK/HEB7+WY
        7m081lGTfsfhA/MP/m2XT21a6/Ol5smLmh5PP7HQOUaPZiqxFGckGmoxFxUnAgBIybWq7wIA
        AA==
X-CMS-MailID: 20190621110724eucas1p280d182bc57d444db561561fd62384c60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190621110724eucas1p280d182bc57d444db561561fd62384c60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190621110724eucas1p280d182bc57d444db561561fd62384c60
References: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
        <8520d744-cebc-c76a-e51a-ff6a471af57d@samsung.com>
        <CGME20190621110724eucas1p280d182bc57d444db561561fd62384c60@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/19 1:53 PM, Bartlomiej Zolnierkiewicz wrote:
> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
> 
> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>   pointer") for details. ]
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
