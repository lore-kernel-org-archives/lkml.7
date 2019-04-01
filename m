Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC8F20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wyoqnv04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDAOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:41:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51903 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDAOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:41:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401144123euoutp019991fa7671d0293bace6a8e2b50cf71b~RYLaFEeO-0567205672euoutp01N
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 14:41:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401144123euoutp019991fa7671d0293bace6a8e2b50cf71b~RYLaFEeO-0567205672euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554129683;
        bh=ugjuCOoce7TWYki1vlIOuRE7/1u8tFASRRWlpnasNS4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wyoqnv04IH6HD5rvXmvszTIfwQYUWlWaSzQ3jmY65F/D8s/f+X0LzmU9154sfugEd
         KkdB9uXYK05a8w0cHAGdepInFaBRNmHUVr0NHF7N5cSEmcvs8fmiGn8FAiTiyWIBbS
         kDXKKIoGwgI+3X90uG2jGra98Qxymx2uJbMpVo7M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401144122eucas1p2634fcb64d6351bdcdeb841da6a321f35~RYLZe-x8u2561325613eucas1p2W;
        Mon,  1 Apr 2019 14:41:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FC.06.04377.21322AC5; Mon,  1
        Apr 2019 15:41:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190401144122eucas1p126a58324ef493f5f47defc117c3559d6~RYLYw8kh40848208482eucas1p1e;
        Mon,  1 Apr 2019 14:41:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190401144121eusmtrp1365ecc77f997f891277a5b2d89228d3c~RYLYiow2v1015510155eusmtrp12;
        Mon,  1 Apr 2019 14:41:21 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-26-5ca2231254bf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 03.C1.04140.11322AC5; Mon,  1
        Apr 2019 15:41:21 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401144121eusmtip1d1816f07280b4d230c4cbaeff015bcca~RYLYN1StF1774117741eusmtip1B;
        Mon,  1 Apr 2019 14:41:21 +0000 (GMT)
Subject: Re: [PATCH] video: hgafb: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        linux-nvidia@lists.surfsouth.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f239940f-d67c-ee8d-7d53-1df5543c9710@samsung.com>
Date:   Mon, 1 Apr 2019 16:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190314073027.22337-1-kjlu@umn.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7pCyotiDK6/k7W48vU9m8Xx2XfZ
        LE7MO8tucaLvA6vF5V1z2Cz2bLrGZLF4+U9GB3aPO98PsHvc7z7O5PHu8EZ2j6sLm9g9Pm+S
        C2CN4rJJSc3JLEst0rdL4MqYd3crW8Fe5opbh28xNzC+Zepi5OSQEDCReHzuMWMXIxeHkMAK
        RolLW5vZIZwvjBKnZv2Dcj4zSqxYdpQdpuXh25NQieWMEhffrGCFcN4ySvyf+wysSljAUeL2
        +XesILaIgKzEx5sP2UCKmAUOMUpcfd4AVsQmYCUxsX0VI4jNK2AnsWxmLzOIzSKgIvFs0wkg
        m4NDVCBCov+MOkSJoMTJmU9YQGxOASOJr9PfgJUzCxhIHFk0hxXClpfY/nYOM8guCYFl7BLr
        nq9mhDjbReLu4t9QtrDEq+NboN6RkTg9uYcFomEdo8TfjhdQ3dsZJZZP/scGUWUtcfj4RVYI
        21Fi9ZTr7CDXSQjwSdx4KwixmU9i0rbpzBBhXomONiGIajWJDcs2sMHs6tq5khnC9pC4MuE+
        0wRGxVlIfpuF5J9ZSP5ZwMi8ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDlnP53/MsO
        xl1/kg4xCnAwKvHwcogvihFiTSwrrswFhjkHs5II75n+BTFCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGOXY9674POkM93QOP4FrBcxL1aR+lt00Fi2s
        1f9hMeOm6fury6/xxTzc/Om3z8PUsqxJXY01UT0f3EVWGJ1oFbRvXB/onVSgethYkVE5qP1+
        8wrDfykTNS13vtHYKvz+yG21SN6bskrzNv9TYfG/mrU+bK3m3Bfzb27I36uySPb0ycLEw83N
        DEosxRmJhlrMRcWJABp5aO01AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qCyotiDJoW6ltc+fqezeL47Lts
        FifmnWW3ONH3gdXi8q45bBZ7Nl1jsli8/CejA7vHne8H2D3udx9n8nh3eCO7x9WFTewenzfJ
        BbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXM
        u7uVrWAvc8Wtw7eYGxjfMnUxcnJICJhIPHx7kr2LkYtDSGApo0TTg6VADgdQQkbi+PoyiBph
        iT/Xutggal4zSvx7f40VJCEs4Chx+/w7MFtEQFbi482HUEWtjBIX9m9jAnGYBQ4xSrz/fYwN
        pIpNwEpiYvsqRhCbV8BOYtnMXmYQm0VAReLZphNgtqhAhMSthx0sEDWCEidnPgGzOQWMJL5O
        fwNWwyygJ7Hj+i9WCFteYvvbOcwTGAVnIWmZhaRsFpKyBYzMqxhFUkuLc9Nzi430ihNzi0vz
        0vWS83M3MQLjaNuxn1t2MHa9Cz7EKMDBqMTDGyG0KEaINbGsuDIX6BEOZiUR3jP9C2KEeFMS
        K6tSi/Lji0pzUosPMZoCPTGRWUo0OR8Y43kl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tS
        s1NTC1KLYPqYODilGhgdOFbIr9h5aclhq9eXuBOTFNtOzP319snOf16ereciRA1LbrOXOPdc
        4bmpr1nEXFP62GzfgS3znkoWzXi1mq857GWrzcOQKD8VpTPWFm6cHWUWqcdUjs76+/P5WRNR
        U7uqOGfPtSvk737SvrS0Y71U4darvY+S91k0M+ZWZ1Z82b1Jvdt9XZwSS3FGoqEWc1FxIgAU
        ui7luQIAAA==
X-CMS-MailID: 20190401144122eucas1p126a58324ef493f5f47defc117c3559d6
X-Msg-Generator: CA
X-RootMTR: 20190314073039epcas3p29225f2fcf1102266ce8265811f7f244e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190314073039epcas3p29225f2fcf1102266ce8265811f7f244e
References: <CGME20190314073039epcas3p29225f2fcf1102266ce8265811f7f244e@epcas3p2.samsung.com>
        <20190314073027.22337-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/14/2019 08:30 AM, Kangjie Lu wrote:
> When ioremap fails, hga_vram should not be dereferenced. The fix
> check the failure to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Patch queued for v5.2 with minor change in the patch summary
("video: hgafb: fix potential NULL pointer dereference"), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
