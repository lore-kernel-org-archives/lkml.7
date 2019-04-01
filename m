Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5507FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D90206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l9IZ1wEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDAMHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:07:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45634 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:07:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401120719euoutp01364588f9e88d48cb766f9c504f45ad2b~RWE5IlDBj1497414974euoutp010
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 12:07:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401120719euoutp01364588f9e88d48cb766f9c504f45ad2b~RWE5IlDBj1497414974euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554120439;
        bh=NbQwYxhD1GJUI+86oE424O4Ya7Qekvp1w/74+ElfbcM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l9IZ1wEXbQl8+LoMUmE98ZqPpJlhzsY7ZrmULwZdi52XRzKC0W/OspOhQSel6JAaH
         ZVDmKKbYPKrzr0syUumkvfnCNe8HpCOYpeNNp5ciIYSXnwRQWZn+SPlrd7LO4QszPo
         Rx0NLkJUjZHF16tRhcmRt62se/RiEKr5gCPiQwGI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401120719eucas1p27dd8a531d2e9b345bc111a6e75f41a67~RWE40ckrx2147621476eucas1p2W;
        Mon,  1 Apr 2019 12:07:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A6.C1.04298.7FEF1AC5; Mon,  1
        Apr 2019 13:07:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401120718eucas1p29f9e74edf63ab6b52df497d0c6981f5d~RWE4MJHk22147621476eucas1p2V;
        Mon,  1 Apr 2019 12:07:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190401120718eusmtrp19cddcb4b31080dc7f9a8bb1c449bb8f9~RWE39_PIi1453914539eusmtrp15;
        Mon,  1 Apr 2019 12:07:18 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-83-5ca1fef76687
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 53.4A.04140.6FEF1AC5; Mon,  1
        Apr 2019 13:07:18 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401120718eusmtip1807e41e08249bfd233a00714228138de~RWE3q-vks2203722037eusmtip1Y;
        Mon,  1 Apr 2019 12:07:18 +0000 (GMT)
Subject: Re: [PATCH 06/12] omapfb: add missing of_node_put after
 of_device_is_available
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f06e8d3a-a98d-239b-d5e1-e5fad2bc4bb9@samsung.com>
Date:   Mon, 1 Apr 2019 14:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-7-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7rf/y2MMTjfzGpx5et7NotlD04z
        Wmy9JW1xou8Dq8XlXXPYLGYv6WdxYPPYuyXL4373cSaPz5vkApijuGxSUnMyy1KL9O0SuDJW
        dZ1hL9jLVnFt00rGBsavLF2MnBwSAiYSlzv/AdlcHEICKxglZh55ywrhfGGU+PXwBDOE85lR
        4tLyScwwLeee3YRKLGeU2Dj1JlT/W0aJaTubmECqhAUiJV5PeMcIYosIqEu0btjFCFLELDCf
        UWLPyj+sIAk2ASuJie2rwIp4Bewkdp2cDTSJg4NFQEXi71RXEFNUIEKi/4w6RIWgxMmZT8Du
        5hRwlTg7owNsFbOAgcSRRXNYIWx5ie1v54AdJyHQzS5xc9EKNoirXSQa12yB+kBY4tXxLewQ
        tozE6ck9LBAN6xgl/na8gOreziixfPI/qG5ricPHL7JC2I4Scz+uZgW5TkKAT+LGW0GIzXwS
        k7ZNZ4YI80p0tAlBVKtJbFi2gQ1mV9fOlVA3eEic3/SOaQKj4iwkv81C8s8sJP8sYGRexSie
        Wlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhOTv87/mkH49dLSYcYBTgYlXh4FRgWxgixJpYV
        V+YeYpTgYFYS4T3TvyBGiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQi
        mCwTB6dUA+O0W5MtuWZsWrwvJ/qQ8hJ9w6wNnp07v9fNPWjAyfl+MnNvQ1F6d/3soo0Ncod/
        P5pocDzvmDXHWgcp/Xki/w9qKLLwadvJ7Dous1Sj4ozRT0aVpcuSGV9HNenVXwrIMv928qpk
        anHib5Pwu2ZXGu5eztxvcMpTTJMvZo1R3nPt3nOmllvnMCmxFGckGmoxFxUnAgD+OAshIwMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7rf/i2MMfg8W9ziytf3bBbLHpxm
        tNh6S9riRN8HVovLu+awWcxe0s/iwOaxd0uWx/3u40wenzfJBTBH6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWs6jrDXrCXreLappWMDYxfWboY
        OTkkBEwkzj27ydzFyMUhJLCUUeLYg39sXYwcQAkZiePryyBqhCX+XOtig6h5zShxe00vWLOw
        QKTE6wnvGEFsEQF1idYNuxghii4zSkyZ+ALMYRaYzyjx7d9HsCo2ASuJie2rwGxeATuJXSdn
        s4BsYxFQkfg71RUkLCoQIXHrYQcLRImgxMmZT8BsTgFXibMzOphAbGYBPYkd13+xQtjyEtvf
        zmGewCg4C0nLLCRls5CULWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYI9uO/dyyg7Hr
        XfAhRgEORiUe3gqmhTFCrIllxZW5hxglOJiVRHjP9C+IEeJNSaysSi3Kjy8qzUktPsRoCvTD
        RGYp0eR8YPzmlcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgPNMq
        NUU/WTZRMu3Eh8ppSesOzrdsidq/8vmCqvjYqc9/pbXUvlf9XNpx71dxyx8NnUCBlCKX644P
        Lx/5L1wqPHfzKl570WtKfdse9yqssI/VDTx37oLoZ7kVXYGGpRJOq04vyW1pXBJ752iOVbIr
        0wOBHDZbzaf8eTNrC7e9jXj/7MZdE729SizFGYmGWsxFxYkAQZtIt6cCAAA=
X-CMS-MailID: 20190401120718eucas1p29f9e74edf63ab6b52df497d0c6981f5d
X-Msg-Generator: CA
X-RootMTR: 20190223135900epcas2p27cce442a6e691905bd290e89d4c17dbb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190223135900epcas2p27cce442a6e691905bd290e89d4c17dbb
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
        <CGME20190223135900epcas2p27cce442a6e691905bd290e89d4c17dbb@epcas2p2.samsung.com>
        <1550928043-14889-7-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/23/2019 02:20 PM, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
> 
> e = f(...);
> ... when != of_node_put(e)
>     when != x = e
>     when != e = x
>     when any
> if (<+...of_device_is_available(e)...+>) {
>   ... when != of_node_put(e)
> (
>   return e;
> |
> + of_node_put(e);
>   return ...;
> )
> }
> // </smpl>
> 
> Fixes: f76ee892a99e6 ("omapfb: copy omapdss & displays for omapfb")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
