Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018BBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAAF2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mMoCqm6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfH1HF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:05:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33492 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfH1HF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:05:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190828070527euoutp02e0623986a43fe5cf850f7de06308ce22~-BE3L6fPw1645616456euoutp02f
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:05:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190828070527euoutp02e0623986a43fe5cf850f7de06308ce22~-BE3L6fPw1645616456euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566975927;
        bh=+4QUB6YY3idoooDaRl8HVCPEO87XwDwtGkwseO7KXcs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mMoCqm6LmkqsomnizrfLRbdCZJC3j4Jpp62WSVFWcxvcaWZvnusQpAmi4Lw8rTQfE
         CAdwC52DyVH/C346C6zgfrbFGQlitjgOOcOpmOXAbgRyYNeqwywAjihnOk7gAcdyhL
         LvyWHj4O2QOPeTWjTUWQxKKv1gsIKuLTF2zuuYuk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190828070526eucas1p12866871b88ee67f39c0608dc0787eb9e~-BE2kRYe41674316743eucas1p1q;
        Wed, 28 Aug 2019 07:05:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 08.F3.04309.6B7266D5; Wed, 28
        Aug 2019 08:05:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190828070526eucas1p1fccb58fbcc93f7200036fe5fb5ca704e~-BE114Juh1674516745eucas1p1g;
        Wed, 28 Aug 2019 07:05:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190828070525eusmtrp227e32f65b4011c51410f5f0ecd5cece0~-BE1npTIa0537705377eusmtrp2F;
        Wed, 28 Aug 2019 07:05:25 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-f8-5d6627b6d644
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 12.86.04166.5B7266D5; Wed, 28
        Aug 2019 08:05:25 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190828070524eusmtip19ce0d026fd8f0bef8d41b1dde5961759~-BE0xPIZn1305513055eusmtip1b;
        Wed, 28 Aug 2019 07:05:24 +0000 (GMT)
Subject: Re: [PATCH v2] drm/bridge: adv7511: Attach to DSI host at probe
 time
To:     John Stultz <john.stultz@linaro.org>,
        Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Sean Paul <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <7b7736ed-6cf1-d7ab-ae03-83b70b351261@samsung.com>
Date:   Wed, 28 Aug 2019 09:05:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVtzQSgVL0B0M2RNB_U-TvNs7+C=k6VUk0VJywdgJbNFQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTcRjH/e3utttwei5jDxWFq+iNrKTiIIuiiKMXSuiPKKSWXWq5aVur
        LDBBC1tpOkHxJr6UlUmo5Jy5ImIDlzYlK8O0MRsWudKoOXP0snbeIv/7PC/f3/N8H34kpvhE
        zCMztWdYnVadpRLLcGtXsG+1ddmJ1LWOp0vp4r5uEf068FVMD/wYw2jXz9V095cBnL5a1iCh
        X9mqxbTNUyeiO2paRbS95DDdGGxHtLu1F9FBWw2+Vc58HbwsYcz5/TjTybnDVFRFMM9KX4qY
        d28ei5mOqRGC8VxzipiGigEx87S4HGfM5V6C8T9YuD/6kCz5OJuVeZbVrdlyVJbR3VSJ5bxV
        nh9rTMxHkwojkpJArYepll7CiGSkgmpEUFvnFwnBJILmEjcmBH4EZpsZNyJyRlJhIYX8XQT1
        H1wR+TgCrrlYwjfNofYB1xXLj4inDsCExYL4HowKYXDLO4DxBTG1An63vRXzLKe2QI/9O8Ez
        Ti2Fil/mGZ5LHYTvIw5C6ImD7qpRnGcplQL1hSYJzxi1CDrGqzGBlTA0WjtjAagyEv4MfsME
        ozuguqkgwnPA57RIBF4AoU5ewPMl8DQWYoK4CEF7a2dEsAkczn6Cd4aFt26xrRHS22D66jAh
        XCUGBsfjhB1iwGStxIS0HIquRE6dAJ7e9siDSrj9IiAuRSpuljNulhtulhvu/9w6hDchJWvQ
        a9JZfZKWPZeoV2v0Bm16Ylq25gEK/7/nf5yTD5Ht1zE7okikipYXxbKpCkJ9Vp+rsSMgMVW8
        3LsknJIfV+deYHXZR3SGLFZvR/NJXKWUX4waOayg0tVn2FMsm8Pq/lVFpHRePtq0J0Qne678
        zts4far85ohXnqzR3bhc/nD5+Fjfjvie4VYi5CgY3nk6UJJ3L7g9t6SQ8lkfTZke3a4Y5Wpd
        XRcPVWY3F6YZDLI2WdIXl+9kapLaN/Fxg+p+ypDRHfiM+WtiV7XMleiWpHjfP9m117Q71Mtp
        +xOu35FtXizNjCJVuD5DvW4lptOr/wLa8C3uewMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7pb1dNiDb7P0rXoPXeSyeLK1/ds
        Fle/v2S2OPNb1+Lkm6ssFp0Tl7BbXN41h81i1/0FTBbb521gsjjUF22x4udWRou7G84yWvzc
        NY/Fgdfj/Y1Wdo/ZDRdZPHbOugtkdcxk9Tgx4RKTx51re9g8tn97wOpxv/s4k8eSaVfZPA70
        TmbxmD35EavH501yATxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYp
        qTmZZalF+nYJehknV01nLrgpXvFyhV4D4xehLkYODgkBE4lpWzi6GLk4hASWMkpM23GeqYuR
        EyguLrF7/ltmCFtY4s+1LjaIoteMEk/O/gNLCAv4Sny6vYsRxBYRCJF4fPo7C0gRs0Aji8TR
        9h52iI55TBKP7k9hB6liE9CU+Lv5JhuIzStgJ3Hq0CdWEJtFQFVi2p/ZYLaoQITE4R2zGCFq
        BCVOznzCAmJzCgRKLGyZBDaHWUBd4s+8S8wQtrzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUha
        ZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw5rcd+7l5B+OljcGHGAU4GJV4eDv4
        U2OFWBPLiitzDzFKcDArifA+UgEK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wHeWVxBua
        GppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamA01E+Mep+h4FUw0yr87rEQ
        x52OGfcTH4b9/LhxbcDup3eKV21T9D+1xWHbJqHlF1qbuJ68jrGLif5yr3h6nMP5RQ+LClO2
        GldOTNq94pJ0e82nzt9SjstvOCdnpXvk1bQHKBVkty76z5u3pDfxjnnFtnM3DpxaxJ+uoT7j
        zP2Uj6KHtpxbKnhHiaU4I9FQi7moOBEA18FlyQ8DAAA=
X-CMS-MailID: 20190828070526eucas1p1fccb58fbcc93f7200036fe5fb5ca704e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190827200326epcas3p4628e49747ff7e20b5451cb6e33235dc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190827200326epcas3p4628e49747ff7e20b5451cb6e33235dc6
References: <20190627151740.2277-1-matt.redfearn@thinci.com>
        <CALAqxLUsf4HJBcAcd+qzycFC3d8XbKk9HyQ7FfCrH8Ewc3mzvw@mail.gmail.com>
        <CGME20190827200326epcas3p4628e49747ff7e20b5451cb6e33235dc6@epcas3p4.samsung.com>
        <CALAqxLVtzQSgVL0B0M2RNB_U-TvNs7+C=k6VUk0VJywdgJbNFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.2019 22:03, John Stultz wrote:
> On Mon, Aug 19, 2019 at 3:27 PM John Stultz <john.stultz@linaro.org> wrote:
>> On Thu, Jun 27, 2019 at 8:18 AM Matt Redfearn <matt.redfearn@thinci.com> wrote:
>>> In contrast to all of the DSI panel drivers in drivers/gpu/drm/panel
>>> which attach to the DSI host via mipi_dsi_attach() at probe time, the
>>> ADV7533 bridge device does not. Instead it defers this to the point that
>>> the upstream device connects to its bridge via drm_bridge_attach().
>>> The generic Synopsys MIPI DSI host driver does not register it's own
>>> drm_bridge until the MIPI DSI has attached. But it does not call
>>> drm_bridge_attach() on the downstream device until the upstream device
>>> has attached. This leads to a chicken and the egg failure and the DRM
>>> pipeline does not complete.
>>> Since all other mipi_dsi_device drivers call mipi_dsi_attach() in
>>> probe(), make the adv7533 mipi_dsi_device do the same. This ensures that
>>> the Synopsys MIPI DSI host registers it's bridge such that it is
>>> available for the upstream device to connect to.
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
>>>
>>> ---
>> As a heads up, I just did some testing on drm-misc-next and this patch
>> seems to be breaking the HiKey board.  On bootup, I'm seeing:
>> [    4.209615] adv7511 2-0039: 2-0039 supply avdd not found, using
>> dummy regulator
>> [    4.217075] adv7511 2-0039: 2-0039 supply dvdd not found, using
>> dummy regulator
>> [    4.224453] adv7511 2-0039: 2-0039 supply pvdd not found, using
>> dummy regulator
>> [    4.231804] adv7511 2-0039: 2-0039 supply a2vdd not found, using
>> dummy regulator
>> [    4.239242] adv7511 2-0039: 2-0039 supply v3p3 not found, using
>> dummy regulator
>> [    4.246615] adv7511 2-0039: 2-0039 supply v1p2 not found, using
>> dummy regulator
>> [    4.272970] adv7511 2-0039: failed to find dsi host
>>
>> over and over.  The dummy regulator messages are normal, but usually
>> [    4.444315] kirin-drm f4100000.ade: bound f4107800.dsi (ops dsi_ops)
>>
>> Starts up right afterward.
> Hey Matt, Andrzej,
>   I just wanted to follow up on this as this patch is breaking a
> couple of boards. Any sense of what might be missing, or is this
> something we should revert?
>
> I'm happy to test any patch ideas you have.


I guess this is circular dependency issue:

- adv waits for dsi-host, then it creates drm_bridge,

- dsi-driver waits for drm_bridge, then it creates dsi host.


The patch introduces proper order:

- 1st we should register devices buses,

- then we should wait for drm components.


So the best solution would be to fix f4107800.dsi driver - it shouldn't
look for drm_bridge in probe, instead it should register dsi_host, and
in dsi host attach callback look for drm_bridge, then call component_add
(if all required resources are gathered), see
dw_mipi_dsi_rockchip_host_attach for example.


Regards

Andrzej



>
> thanks
> -john
>
>

