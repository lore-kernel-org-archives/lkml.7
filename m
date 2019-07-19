Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78880C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163F421849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q8iJ6hKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGSJuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:50:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56594 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSJuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:50:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190719095038euoutp02a1f877a3b2b5ceeb519bea72e208721a~yxhq07kGi0577805778euoutp02h
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:50:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190719095038euoutp02a1f877a3b2b5ceeb519bea72e208721a~yxhq07kGi0577805778euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563529838;
        bh=UtMj5ktXO8NN/dLxR8ryNqQMtDNRVoeJwep6Dew2dWA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q8iJ6hKr0Io0uG+8c6wkQzvXqbhw79jbMJssSnAM1w0zLDe0qbKjIBRTA+WaQQJop
         yq6s+/RqgI9uPi9Pp/yRqTo2izVAJYiG+5NgtxlgtfZ6TlNsdE+PWSvFEj59DC7vq/
         sFRGZibV+k3vzeGjYVZ6loiqYi4wW36eXDMW9FDI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719095037eucas1p208b65fbc9f78728baf36f6993e00f3e9~yxhpxbFVa2668326683eucas1p2W;
        Fri, 19 Jul 2019 09:50:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.15.04298.D62913D5; Fri, 19
        Jul 2019 10:50:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719095036eucas1p2e495ffb551be40283756491b19461024~yxhpDoWtF2668326683eucas1p2V;
        Fri, 19 Jul 2019 09:50:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719095036eusmtrp2a01400284e656b7bf73222ca42c52791~yxho1hPlC2835628356eusmtrp2S;
        Fri, 19 Jul 2019 09:50:36 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-b3-5d31926df8da
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.DB.04146.C62913D5; Fri, 19
        Jul 2019 10:50:36 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719095036eusmtip103d641f757d278d6ac4685280b0de87b~yxhoZ8lU62903329033eusmtip1N;
        Fri, 19 Jul 2019 09:50:36 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: fix RC_CORE dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <0a78f32d-009c-fe89-8211-cf5d893d0014@samsung.com>
Date:   Fri, 19 Jul 2019 11:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2rJ1WqWZ8VtOZZ5YwFrg5bpVve_kS4utL0MjeBUzrLew@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7q5kwxjDQ48ErDoPXeSyeLvpGPs
        Fv+3TWS2OLzoBaPFla/v2Sw6Jy5ht7i8aw6bxYt7b5ks7k4+wujA6fH71yRGj73fFrB47Jx1
        l91jdsdMVo8pnRIe2789YPW4332cyeP4rlvsHp83yQVwRnHZpKTmZJalFunbJXBlvDrcylow
        lafi5/vXLA2Mezm7GDk5JARMJM7u/cPUxcjFISSwglFi16wDjBDOF0aJrVtXQWU+M0rc+HWB
        GablwqwrLBCJ5YwSj/7PgnLeArUcn84KUiUsYC6xa/YjMFtEQFFi6otnzCBFzALvmCTeTOpi
        AkmwCWhK/N18kw3E5hWwk/h7ay47iM0ioCrxsu8D2DpRgTCJnws6oWoEJU7OfMICYnMKBErM
        3LUJrIZZQF5i+9s5ULa4xK0n88HulhC4xy7R/q+REeJuF4lnrYvZIWxhiVfHt0DZMhL/d85n
        grDrJe6vaGGGaO4AemfDTqinrSUOH78I9A4H0AZNifW79CHCjhJn765hAQlLCPBJ3HgrCHED
        n8SkbdOZIcK8Eh1tQhDVihL3z26FGigusfTCV7YJjEqzkHw2C8k3s5B8Mwth7wJGllWM4qml
        xbnpqcWGeanlesWJucWleel6yfm5mxiBCez0v+OfdjB+vZR0iFGAg1GJhzcg1yBWiDWxrLgy
        9xCjBAezkgjv7Zf6sUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFk
        mTg4pRoYBT8ItP6e3JnLzJ/awT/rdONy8YcFL8WFBDxXNl8/mnWmObJONHzVyT8b/Tkmib/1
        s7sXr3fLzO3Ehub0J2ofD+9V64gNb51k6/g13bbZ+fJy6btGvsZv+Nx728+Z2Jb7VWcJPXnL
        tM5S+E9ysnrYw+V/og44RC/zuy+/5MfzwOllpYJB9bOUWIozEg21mIuKEwEgcxsiXAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7o5kwxjDRpuSFv0njvJZPF30jF2
        i//bJjJbHF70gtHiytf3bBadE5ewW1zeNYfN4sW9t0wWdycfYXTg9Pj9axKjx95vC1g8ds66
        y+4xu2Mmq8eUTgmP7d8esHrc7z7O5HF81y12j8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyXh1uZS2YylPx8/1rlgbGvZxdjJwcEgIm
        EhdmXWHpYuTiEBJYyijR3tDGBpEQl9g9/y0zhC0s8edaFxtE0WtGib7fHewgCWEBc4ldsx+x
        gtgiAooSU188YwYpYhZ4xyRxcu90ZoiOFiaJ5187GEGq2AQ0Jf5uvgm2glfATuLvrblgk1gE
        VCVe9n0AauDgEBUIkzh6Ig+iRFDi5MwnLCA2p0CgxMxdm8AuYhZQl/gz7xKULS+x/e0cKFtc
        4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM2G3H
        fm7ewXhpY/AhRgEORiUe3oBcg1gh1sSy4srcQ4wSHMxKIry3X+rHCvGmJFZWpRblxxeV5qQW
        H2I0BfptIrOUaHI+MJnklcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+Lg
        lGpgnPiEO1ByNqvowqe/i6azmdxaXue+NuCEX7pNQc2pm50Zoi07Hlx6v0uy4KjmsycbIy/E
        mLKudb9wblrIiWXZtTxh+q/XTudX3XVTnk/q72xpI492xw1fvwSLPjB7Kds1N7P31dkzV0IF
        H87Rcrtx7fiyoFyZD+v3XYm8sEG6x7+h8LXzWgfOq0osxRmJhlrMRcWJAMoHOFHuAgAA
X-CMS-MailID: 20190719095036eucas1p2e495ffb551be40283756491b19461024
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022
References: <CGME20190718134253epcas3p32a5afece52c47aaac0cd5795ff4cf022@epcas3p3.samsung.com>
        <20190718134240.2265724-1-arnd@arndb.de>
        <763005f0-fc66-51bc-fcfe-3ae4942a9c07@samsung.com>
        <CAK8P3a2rJ1WqWZ8VtOZZ5YwFrg5bpVve_kS4utL0MjeBUzrLew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2019 10:33, Arnd Bergmann wrote:
> On Fri, Jul 19, 2019 at 9:01 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 18.07.2019 15:42, Arnd Bergmann wrote:
>>> Using 'imply' causes a new problem, as it allows the case of
>>> CONFIG_INPUT=m with RC_CORE=y, which fails to link:
>>
>> I have reviewed dependencies and I wonder how such configuration is
>> possible at all.
>>
>> RC_CORE depends on INPUT (at least on today's next branch) so if INPUT=m
>> then RC_CORE should be either n either m, am I right?
> Right.
>
>> Arnd, are there unknown to me changes in RC/INPUT dependencies?
> I think this is 'imply' behaving oddly when we have conflicting requirements:
>
> - INPUT=m forces RC_CORE to be =m or =n
> - DRM_SIL_SII8620=y asks RC_CORE to be =y unless it cannot be enabled
>
> Kconfig decided to make this RC_CORE=y, which caused the link
> failure. Making it RC_CORE=m however would not work either because
> then we'd get a link failure from the sii8620 driver to rc_core.
>
> so a pure 'imply' cannot work here, and we need a dependency, one of:
>
> a)
>    depends on INPUT || !INPUT
>    select RC_CORE if INPUT
>
> b) depends on RC_CORE || !RC_CORE
>
> b) is what othe drivers use, e.g. SMS_SDIO_DRV


OK, thanks for explanation, really weird.

I though about imply as "weak dependency", but it is "weak select" with
drawbacks of select.

Anyway I am surprised that Kconfig did not complain about contradictory
requirements on RC_CORE symbol.


Regards

Andrzej


>
>        Arnd
>

