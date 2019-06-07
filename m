Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF058C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32A0208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iuPpEETG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfFGGV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:21:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56142 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfFGGVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:21:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607062121euoutp02c854a91513631ea03478e451be4e370c~l1k8tl2GH0055800558euoutp02g
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:21:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607062121euoutp02c854a91513631ea03478e451be4e370c~l1k8tl2GH0055800558euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559888481;
        bh=4HQUvtnVFKSCot9Y4wFuv+WoVDO7QgUm/yf8qlXrVgI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iuPpEETG9YjUwYr35q4Tc/a8Sjpq1zQD3avSWE8FyH2DpsO+wzyieTczjacZIlk16
         3R1a663Bdd4gRKr3jOaHcnEntOfRlss3CTC2vvTUK2ttvw1H7s/H+teUoFo9cVMQD6
         DNI8/G+4yTXe4jWmNcwX/aW+JyAAXZw9JCjeCuhM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607062120eucas1p1451fd2f62646aa8420421d4800a2ade0~l1k8BNVUD1447614476eucas1p1K;
        Fri,  7 Jun 2019 06:21:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 07.BD.04377.0620AFC5; Fri,  7
        Jun 2019 07:21:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607062119eucas1p1296cbd76216303b7ec1b712d59abbc1e~l1k66NLFs3127331273eucas1p1a;
        Fri,  7 Jun 2019 06:21:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607062119eusmtrp284823900f41674c04cca049d26ae409b~l1k6pR5og2248522485eusmtrp2R;
        Fri,  7 Jun 2019 06:21:19 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-38-5cfa02604296
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.4B.04146.F520AFC5; Fri,  7
        Jun 2019 07:21:19 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607062118eusmtip15d25a35d1130ec20b1ba6a2387f29f1b~l1k59O-jb0566205662eusmtip1a;
        Fri,  7 Jun 2019 06:21:18 +0000 (GMT)
Subject: Re: [PATCH v4 13/15] drm/bridge: tc358767: Simplify
 tc_aux_wait_busy()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <fab61a07-6842-f986-25e9-a4cc2e5c8978@samsung.com>
Date:   Fri, 7 Jun 2019 08:21:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607044550.13361-14-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUhUURj23GXmOjV2HI35UUkapBVXCm5laSA0L0Wagpigo17UXJmrk8tD
        LmWmQWmZNSb2kGiFaeOSDqG44LhgKSm4j4FhZlKmYlpqXa+Sbx/fcv7vg8OQig7ajomOT+K0
        8ZpYlURGNXSufnAOJdaC3VY37Nns3LNsVlsGzf4abKfY1ncmgh1c/i5hp0pHCPZOwXMp+9H4
        VMJOTHZRbHXZqMRbpp4q2iTUTfoJqbok9wmtNuebCPW9dTe1afgtoV40HFC/L+ojLjNBMs8I
        LjZax2ldz4XKoqoWfRJf45RvP2boDFQvz0OWDOATcHd9nchDMkaBKxEszD9AgqDASwjmqpJE
        YRHB5NKkZCdRvbxIi0IFgkZDBi0m5hG8MQQI2Ab7wueVrq2ALb4MP7OaJEKAxL0E3DaOkYIg
        wUdhvXZkyyTH56Bn9JNUwBR2grnxVkLA+3EgmDtraNFjDd1Ppqk8xDCW2AsKGsMFmsSOkF1f
        QopYCaPTZVtzAE9Kobx4iBJb+0D7gJkQsQ18NdVJRewAm01l2/wNMFfeJMVwLoL6miZSFM5A
        u2mAFg6T/0pXG11F+jwstDwiBRqwFQzPW4sdrKCwoXiblkNujkJ0HwRzX/32g0oo71+W3Ecq
        /a5h+l1r9LvW6P/ffYaol0jJJfNxkRzvEc9dd+E1cXxyfKRLeEKcAf37W70bpqVGZPwT1oYw
        g1R75d4Wq8EKWqPjU+PaEDCkylau6/8VrJBHaFLTOG1CiDY5luPbkD1DqZTydIupqwocqUni
        YjgukdPuqARjaZeBctzMwT4ufY5H/HytkoKa10i7rJVXlwoPlwaleftIle6HLsyOt/h3bQw7
        dUVVPPCPcTDMWiQ+tDC2Zj/uaLbJP2Xr3LPA63jprcxrfjOeziV1ypCLp/3HPDJXU2uP5ylP
        Gx0DL3x5oXPRBvxuAG2lc7j70MmWtX0pN7uveKWHVe9RUXyUxv0YqeU1fwFaVQPlVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7rxTL9iDO69FLBo7rC1aDrUwGrx
        48phFouDe44zWVz5+p7N4sHcm0wWnROXsFtc3jWHzeLuvRMsFuvn32Jz4PJ4MPU/k8fOWXfZ
        PWZ3zGT1uN99nMmj/6+Bx/Eb25k8Pm+S8zg39SxTAEeUnk1RfmlJqkJGfnGJrVK0oYWRnqGl
        hZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbazy4F6wQq3nx4ztrAuJW3i5GTQ0LARGL9
        18+sXYxcHEICSxklLt7qYINIiEvsnv+WGcIWlvhzrYsNoug1o8SD/nesIAlhgUCJp99PgDWI
        CPhJdM07wARSxCxwlkni9+6dUB3HGCW69n0B62AT0JT4u/kmWAevgJ3EqVsP2UFsFgEVidd3
        DjKB2KICERJn3q9ggagRlDg58wmQzcHBKWAvMXFHMkiYWUBd4s+8S8wQtrxE89bZULa4xK0n
        85kmMArNQtI9C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iREYrduO/dy8
        g/HSxuBDjAIcjEo8vA4MP2OEWBPLiitzDzFKcDArifCWXfgRI8SbklhZlVqUH19UmpNafIjR
        FOi3icxSosn5wESSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB
        UfPmMt/cP8liOzW+bXq48saP7xkM+/5JN84XDV1/+z3/6l7Zk4eDn73mn65vH/fW9eHpXU+n
        n35cVdDg+uD5Iq/TyxwXMLaIWvB9Y91q+evarv7km/2f64rvrZa7yHnzsPDKD94vWbcUuIZu
        /L5l7vn9jRluKZFvr8VUtDKqbusVKXa705eon6fEUpyRaKjFXFScCADbaYPf7AIAAA==
X-CMS-MailID: 20190607062119eucas1p1296cbd76216303b7ec1b712d59abbc1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607044648epcas1p1362e8ce905aa3eb81c46f95b527e408e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607044648epcas1p1362e8ce905aa3eb81c46f95b527e408e
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
        <CGME20190607044648epcas1p1362e8ce905aa3eb81c46f95b527e408e@epcas1p1.samsung.com>
        <20190607044550.13361-14-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 06:45, Andrey Smirnov wrote:
> We never pass anything but 100 as timeout_ms to tc_aux_wait_busy(), so
> we may as well hardcode that value and simplify function's signature.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index c994c72eb330..e747f10021e3 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -294,10 +294,9 @@ static inline int tc_poll_timeout(struct tc_data *tc, unsigned int addr,
>  					sleep_us, timeout_us);
>  }
>  
> -static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
> +static int tc_aux_wait_busy(struct tc_data *tc)
>  {
> -	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0,
> -			       1000, 1000 * timeout_ms);
> +	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0, 1000, 100000);
>  }
>  
>  static int tc_aux_write_data(struct tc_data *tc, const void *data,
> @@ -350,7 +349,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	u32 auxstatus;
>  	int ret;
>  
> -	ret = tc_aux_wait_busy(tc, 100);
> +	ret = tc_aux_wait_busy(tc);
>  	if (ret)
>  		return ret;
>  
> @@ -377,7 +376,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	if (ret)
>  		return ret;
>  
> -	ret = tc_aux_wait_busy(tc, 100);
> +	ret = tc_aux_wait_busy(tc);
>  	if (ret)
>  		return ret;
>  


