Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4356C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D5A218C5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MKDsXU/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfGEPBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:01:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54477 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGEPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:01:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190705150144euoutp013579e077506ce0c0eabaa2f5c654662b~uivTFx1DO2710727107euoutp01O
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2019 15:01:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190705150144euoutp013579e077506ce0c0eabaa2f5c654662b~uivTFx1DO2710727107euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562338904;
        bh=shCOV+1PW8MbuK0OPbmczyJ7lxB2cQP1KmnKQubcN00=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MKDsXU/hCabMQSRKHXLkJlp/Od7aX9J928zBzBE5ehSk/g/zE8+8IPy/vswI2oaul
         CP2qvy3/6w4NyU75icB8uAGsWL1q5L7ukB2xiWUL3E2tQvr0aX3RWs4vc5hyBV06nW
         mnvBVrKjvM0KB0vJ/LRCVIlGgqzwfivrPelKubV4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190705150144eucas1p2cf96d8cccefac002a50e7ea2a16a425f~uivSp2eIy3230632306eucas1p2N;
        Fri,  5 Jul 2019 15:01:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0E.B5.04325.7566F1D5; Fri,  5
        Jul 2019 16:01:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190705150143eucas1p1712278f45fd864d491c4664fd9c4c83f~uivRmB6gh2189821898eucas1p1v;
        Fri,  5 Jul 2019 15:01:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190705150142eusmtrp1a1b81a3b8b924afb6e61ce5386fc8d3d~uivRYDE5m0410604106eusmtrp1V;
        Fri,  5 Jul 2019 15:01:42 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-6c-5d1f66573ac5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.56.04146.6566F1D5; Fri,  5
        Jul 2019 16:01:42 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190705150142eusmtip12670f8d45368a6269b75bb44b718964b~uivRH4dij1502715027eusmtip1g;
        Fri,  5 Jul 2019 15:01:42 +0000 (GMT)
Subject: Re: [PATCH 09/11] video: fbdev: sm501fb: convert platform driver to
 use dev_groups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <bf91b478-7b70-1464-fd43-65ae251fa79a@samsung.com>
Date:   Fri, 5 Jul 2019 17:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190704084617.3602-10-gregkh@linuxfoundation.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87rhafKxBkcbLSyufH3PZtG8eD2b
        xYm+D6wWl3fNYXNg8dg/dw27x/3u40wenzfJBTBHcdmkpOZklqUW6dslcGW8/n2JteAtS8W0
        XY1sDYzdLF2MnBwSAiYS3Qs2sHYxcnEICaxglDgzfTcjhPOFUWLfrAssEM5nRolt33oZYVp6
        952ASixnlNj5dAFUy1tGiSPLethBqoQFYiW2Xm9jBbFFBIwl+s/OAopzcDALJEjsXmQGEmYT
        sJKY2L4KbCivgJ3E/Lt/mUBsFgEVifn9K8BaRQUiJO4f28AKUSMocXLmE7C7OQUcJNrP7wTr
        ZRYQl7j1ZD4ThC0vsf3tHGaQeyQEutkl/txawwKyV0LAReLABm2IB4QlXh3fwg5hy0icntzD
        AlG/jlHib8cLqObtjBLLJ/9jg6iyljh8/CIrxAOaEut36UOEHSXWTm1hgpjPJ3HjrSDEDXwS
        k7ZNZ4YI80p0tAlBVKtJbFi2gQ1mbdfOlcwTGJVmIflsFpJvZiH5ZhbC3gWMLKsYxVNLi3PT
        U4uN81LL9YoTc4tL89L1kvNzNzECE8rpf8e/7mDc9yfpEKMAB6MSD+8JJ/lYIdbEsuLK3EOM
        EhzMSiK8iUFAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxS
        DYwZR1NlK3u/W3YXsqdfzN5UdlDZt9LhTbl7xrRrfuKWS45cbNvN+6ul9aSt/qzTnNMWH/vd
        ZekjxCFus65jefF934m+3wLa43LmJcbdYrEr7S8XmXSJ5+eH/Hv9S7J+FqZfus25U/1XS1fY
        9sV9EqnZEzcm3/kfU+zd3rQqrGVHhGIdV8fG1UosxRmJhlrMRcWJABJejU8kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7phafKxBjfm61pc+fqezaJ58Xo2
        ixN9H1gtLu+aw+bA4rF/7hp2j/vdx5k8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4/fsSa8FbloppuxrZGhi7WboYOTkkBEwkeved
        ALK5OIQEljJKvJ1/EsjhAErISBxfXwZRIyzx51oXG4gtJPCaUWLZEQsQW1ggVmLr9TZWEFtE
        wFii/+wsdhCbWSBBYsXbdlaImScYJU6s2MEEkmATsJKY2L6KEcTmFbCTmH/3L1icRUBFYn7/
        CrBBogIREmfer2CBqBGUODnzCZjNKeAg0X5+JyPEAnWJP/MuMUPY4hK3nsxngrDlJba/ncM8
        gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzACNp27OfmHYyX
        NgYfYhTgYFTi4T3hJB8rxJpYVlyZe4hRgoNZSYQ3MQgoxJuSWFmVWpQfX1Sak1p8iNEU6LmJ
        zFKiyfnA6M4riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAYf/7J
        BWseG8/efbbzPS4Fnk7sYvw7S3XRwg7P/ccLThu/1wlYXbJ28dNTl2TjTzgcb4j0XSC4KjPi
        6SzRz7yBot3VzuYybyOTRRwk4hkLjG+ItTOu8+Pedqc893msxccPUf2VKnezls5+eozPY5r/
        812Rsz8cPLb2pZGNxi3dPv5zJzsM5tkqsRRnJBpqMRcVJwIAdCydALYCAAA=
X-CMS-MailID: 20190705150143eucas1p1712278f45fd864d491c4664fd9c4c83f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190704084710epcas1p2416255911d43174fc5bbfc9353431648
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190704084710epcas1p2416255911d43174fc5bbfc9353431648
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
        <CGME20190704084710epcas1p2416255911d43174fc5bbfc9353431648@epcas1p2.samsung.com>
        <20190704084617.3602-10-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/19 10:46 AM, Greg Kroah-Hartman wrote:
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a bunch of sysfs files.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
