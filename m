Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE2DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417FA2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U5KgQpFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfCNHrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:47:43 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:13470 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfCNHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:47:42 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190314074739epoutp038867c2299507851b95e43de26d841e87~Lw7ByzaiQ0953309533epoutp03r
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:47:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190314074739epoutp038867c2299507851b95e43de26d841e87~Lw7ByzaiQ0953309533epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552549659;
        bh=xNnYwL6CfNzGQuXbhKlugEnLnTYr0q/qVj+CwffWNp4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=U5KgQpFlK9V8Sz1ZUxdjFZNrS8rbej+tuX0rN7VYudNwTM9mhIPoZhZ0uxmo7M8ed
         oTUZvEIjA5vifFIpM35A6Q9+nZim/gUeRzblYBzAHB+1+Ws0rY5KvJNd8SSCwI4zia
         TCa8PFvQPMn3BQ1KSlzEKyc1sNIUvZ43EzmKWRqY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190314074735epcas1p4137a9e5523723e9f0918a435c781f21d~Lw6_xohwg2414324143epcas1p4A;
        Thu, 14 Mar 2019 07:47:35 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-15-5c8a07163aa0
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.4F.04143.6170A8C5; Thu, 14 Mar 2019 16:47:34 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [RESEND PATCH] PM / devfreq: Fix static checker warning in
 try_then_request_governor
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel@collabora.com" <kernel@collabora.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190313122253.24355-1-enric.balletbo@collabora.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190314074734epcms1p8c7c23ea44032c17581fd1bf252bea5fa@epcms1p8>
Date:   Thu, 14 Mar 2019 16:47:34 +0900
X-CMS-MailID: 20190314074734epcms1p8c7c23ea44032c17581fd1bf252bea5fa
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG/Xa2naM1OS7LD7utQwkaczuu6TE1ujPIQqhQQloHPW3ibuxs
        lUW17D5aKAkTW9kNBSc4ZupIabakiFK6oWgXpBolmTW0IEht29mo/348vO/zvs/7fRgiPiNM
        x6oMFsZsoHWEMInf/TBTJl2C2svlI7+k1MjMZwH1dc7Jp9rfBADVOXRJQA3WTqLUq3suITXt
        GAAbUZXv3R2gCgXH+KrLd9uAatq7ooS/r7pQy9CVjFnCGCqMlVUGTRGxY7d6i1qZKyelZD6V
        R0gMtJ4pIrYWl0i3V+nCGxCSQ7TOGpZKaJYlZBsKzUarhZFojayliGBMlTpTvimbpfWs1aDJ
        rjDq15NyeY4yXHigWjtwNYiYhtEjl6ffAhtwC+0gEYP4Ojg/PcazgyRMjPsAHH3Yi9oBhonw
        FDjrWxSpWYRXQPfEC16ExTgBbaP3EU6XwQvj3SDCQlwKuzzv+BFOxY/CHx8no4zgEwCemirl
        Zolg4/kgn+OlsKe1K9qbiG+GrvrfCKcvhqPub2icvz9qBhynwrPvB2M1KXD8dy+I+zQ2zMc8
        j8Fh5200kgXiZwB0uBtiRTL47NqTaGARvhPaGxqjYfj4GtjvORsz3QpfjvfxuKVXwp5vLiRy
        BwTPhB33ZJycDKd+XhLEs/iuf+JxnAEDvXdiOy+DT503Y5Yq2GKP3/YigK8bnyN1YGXTv/M2
        /Tet6d+0GwBpA0sYE6vXMCxpUvz/ol4Q/YFZeT7gGSoOABwDxEKRDblYLhbQh9gafQBADCFS
        RXuzw5Kokq45ypiNarNVx7ABoAyHrkfSF1cYw//ZYFGTyhyFQkGtI3OVJEmkiTo2bikX4xra
        wlQzjIkxx/t4WGK6DdD99J5g8xTqkTpP3GwtOOdyHCxGvX9SglfEZRk+SaffmNY9vrx3+GTo
        T0JIumZTx+rQ4we1M3a/fCRhgSJ50+mcvIPz0sKJL2vL2uePFwnTNJOncm+hLbxMb2efY/jD
        7OF9oQFixq96NbtqrMCdnwT3a7v2KHaVzunrtmX5FQSf1dJkFmJm6b9d1l48lwMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190313122310epcas5p1cc4a6a8570c90ce76743b90a7e5c96c1
References: <20190313122253.24355-1-enric.balletbo@collabora.com>
        <CGME20190313122310epcas5p1cc4a6a8570c90ce76743b90a7e5c96c1@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>The patch 23c7b54ca1cd: "PM / devfreq: Fix devfreq_add_device() when
>drivers are built as modules." leads to the following static checker
>warning:
>
>    drivers/devfreq/devfreq.c:1043 governor_store()
>    warn: 'governor' can also be NULL
>
>The reason is that the try_then_request_governor() function returns both
>error pointers and NULL. It should just return error pointers, so fix
>this by returning a ERR_PTR to the error intead of returning NULL.
>
>Fixes: 23c7b54ca1cd ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>---
>Hi,
>
>This is a resend of [1] as seems that got lost at some point and I just
>noticed that was never merged.
>
>Thanks,
> Enric

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Thanks!


CHeers,
MyungJoo
