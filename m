Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C07C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB73C208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VifnmWCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCDJm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:42:26 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48638 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:42:25 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190304094224euoutp02cbc775d831670846b9cc0c026ecf251c~IuCXXL_jZ0429704297euoutp02C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 09:42:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190304094224euoutp02cbc775d831670846b9cc0c026ecf251c~IuCXXL_jZ0429704297euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551692544;
        bh=3/o9Onbf4Pjb/+y4x4YautGoWFsU4CPKxVSL5OfB2Gw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VifnmWCtEjXOU23/Q3m4EvEAgkUqV6lG0YoRjowe86fGDn5RaWFLtUy9xXWVVSDMo
         +NsS5CoZ5OJNUg6f/chFk+gvUxoNxOb7kt7kZ1TcQsT5SUl3SjzBP/SLAk+VplyVOL
         lpDziGuE5sDm4BF0Ffqj/mgzHq1bRQ+JIWcrBhaM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190304094223eucas1p1b954a512e880aa29c0ef8d97b18794cc~IuCWpZRoo1950319503eucas1p1h;
        Mon,  4 Mar 2019 09:42:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.E8.04441.FF2FC7C5; Mon,  4
        Mar 2019 09:42:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190304094222eucas1p117ddcb0f2ef906c896504eaa0dc225a7~IuCVndmxm1950519505eucas1p1q;
        Mon,  4 Mar 2019 09:42:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190304094222eusmtrp13a1caf478b0ad0f284bb6a6d1c3c4dc9~IuCVUulZv2559225592eusmtrp1y;
        Mon,  4 Mar 2019 09:42:22 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-96-5c7cf2ffcf37
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.35.04284.DF2FC7C5; Mon,  4
        Mar 2019 09:42:21 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190304094221eusmtip2ac3a3e639b1b6008105d201303ced4be~IuCU6MJct0543705437eusmtip2Z;
        Mon,  4 Mar 2019 09:42:21 +0000 (GMT)
Subject: Re: [PATCH 2/9] drm/bridge: tc358767: Simplify
 tc_stream_clock_calc()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <bad3c902-8ead-dbe4-fa77-e365dd29e6f2@samsung.com>
Date:   Mon, 4 Mar 2019 10:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226193609.9862-3-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7r/P9XEGPxYy2HR3GFr0dTxltXi
        4J7jTBZXvr5ns3gw9yaTRefEJewWl3fNYXNg97jc18vksXPWXXaP2R0zWT3udx9n8uj/a+Dx
        eZNcAFsUl01Kak5mWWqRvl0CV0bDv1tMBU/5Kras62duYPzL3cXIySEhYCJxYdViJhBbSGAF
        o8S5j9ldjFxA9hdGieMftjBDOJ8ZJTqPNTHBdLy4MZ0VIrGcUWLWn0XsEM5bRomdvyeyglQJ
        CwRI9J2YBtYhAmR/atrJBmIzC5xklOhvcQex2QQ0Jf5uvgkW5xWwk7jW8R+sl0VARWLt9jXM
        ILaoQITE4d53jBA1ghInZz5hAbE5BWwldv76zwIxU16ieetsZghbXOLWk/lMIAdJCGxil7j4
        4zorxNkuEv9bNrFD2MISr45vgbJlJE5P7mGBsOslmmZeYYZo7mCUOLF4ORtEwlri8PGLQIM4
        gDZoSqzfpQ8RdpR41v+WHSQsIcAnceOtIMQNfBKTtk1nhgjzSnS0CUFUK0rcP7uVGcIWl1h6
        4SvbBEalWUg+m4Xkm1lIvpmFsHcBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwER0
        +t/xTzsYv15KOsQowMGoxMNroFITI8SaWFZcmXuIUYKDWUmEl+kDUIg3JbGyKrUoP76oNCe1
        +BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVAOjwNcPLseYZ7Uab1n05pjwZxPxTX5b
        LZzXhCmn+t1gFr8wkZf/w6Td8gu3fTvbob1utYX69hSJ4qVhe2JbXm7i2GihnrzdI2/V5imr
        Os9sWbl2xYfCtJw/xhW6f+xrdG/fv5T2krOgadu/civPKTdOVMszethYbqy5HRku5fOA/dNE
        3SC+6SlXlFiKMxINtZiLihMBWdYKukADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7p/P9XEGPw/a2PR3GFr0dTxltXi
        4J7jTBZXvr5ns3gw9yaTRefEJewWl3fNYXNg97jc18vksXPWXXaP2R0zWT3udx9n8uj/a+Dx
        eZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        XkbDv1tMBU/5Kras62duYPzL3cXIySEhYCLx4sZ01i5GLg4hgaWMEle2HmeHSIhL7J7/lhnC
        Fpb4c62LDaLoNaPE/QdvWUESwgJ+Erc+fAErEgGyu+YdYAIpYhY4zSix/9BWqLGHGSXOru4F
        62AT0JT4u/kmG4jNK2Anca3jP1icRUBFYu32NWCTRAUiJD4+3ccEUSMocXLmExYQm1PAVmLn
        r/9gNrOAusSfeZeYIWx5ieats6FscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3
        PbfYUK84Mbe4NC9dLzk/dxMjMP62Hfu5eQfjpY3BhxgFOBiVeHgNVGpihFgTy4orcw8xSnAw
        K4nwMn0ACvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MDXklcQbmhqaW1gamhubG5tZKInz
        njeojBISSE8sSc1OTS1ILYLpY+LglGpg1Dwos5O/3aZ6skbgeknXtWcvJ3+NaTxmtKP1stvB
        pkVFN0KkXdfJ3a5ytVrVlfL02uR9m54FrH6wwvnn/vPt+dlRmfGMUkJeefU1bAFnF4eeN87O
        /xwxv9b8eH/Kqwtrqt+8DX4aLjU/zudJZ6nnIdsDWy1an/lvLKo8H3zqjv3JdDdLw0gXJZbi
        jERDLeai4kQALmVrwNUCAAA=
X-CMS-MailID: 20190304094222eucas1p117ddcb0f2ef906c896504eaa0dc225a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190226193632epcas4p139e0002746989958fef4913a0af9fc0d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190226193632epcas4p139e0002746989958fef4913a0af9fc0d
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
        <CGME20190226193632epcas4p139e0002746989958fef4913a0af9fc0d@epcas4p1.samsung.com>
        <20190226193609.9862-3-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.2019 20:36, Andrey Smirnov wrote:
> Drop the use of tc_write() as well as "magicly" used "ret" and "err:"
> and replace it with a simple call to regmap_write(). No functional
> change intended.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index b0f8264a1285..86ebd49194b7 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -504,7 +504,6 @@ static int tc_pxl_pll_dis(struct tc_data *tc)
>  
>  static int tc_stream_clock_calc(struct tc_data *tc)
>  {
> -	int ret;
>  	/*
>  	 * If the Stream clock and Link Symbol clock are
>  	 * asynchronous with each other, the value of M changes over
> @@ -520,11 +519,7 @@ static int tc_stream_clock_calc(struct tc_data *tc)
>  	 * M/N = f_STRMCLK / f_LSCLK
>  	 *
>  	 */
> -	tc_write(DP0_VIDMNGEN1, 32768);
> -
> -	return 0;
> -err:
> -	return ret;
> +	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);


The patch looks semantically correct, but you are dropping here custom
accessor (tc_write) in favor of regmap API.

I think the best would be consistent across the whole driver: either use
only  accessors, either drop them entirely and use regmap API.

And it would be good to have comment of the original authors about this
change.


Regards

Andrzej


>  }
>  
>  static int tc_aux_link_setup(struct tc_data *tc)


