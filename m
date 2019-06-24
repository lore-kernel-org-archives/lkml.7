Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C0C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E27E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PJvAq5c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfFXP2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:28:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44868 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFXP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:28:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190624152758euoutp02eb3aff13bf2855079fef50f52383601d~rLAD97jGs0124201242euoutp02U
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190624152758euoutp02eb3aff13bf2855079fef50f52383601d~rLAD97jGs0124201242euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561390078;
        bh=T6+kPVqLM5P3Wn9vishGMBbSKAuCBIcRIGEF2ERbMDY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PJvAq5c2DqswWC7mQ0ILExCyXK/uuCc4sNjG4FFdJOBv9Ssec+i6SZ0ryuLJPJsw1
         aUTz2sTnlPtlV4p6z7xpb/N+ItGCrt6CWA8/3PzTUbDakvlRP94VqTi4e61KeDql9V
         yUGcwAxMI44zF/0E3/r7n2+5LIRbVQqBv0VGmPSY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190624152757eucas1p150f35a7e5e83c5d6bdcf9e90160c9972~rLADUdpKF2418724187eucas1p1U;
        Mon, 24 Jun 2019 15:27:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B5.2D.04298.DFBE01D5; Mon, 24
        Jun 2019 16:27:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190624152757eucas1p14b3e9201cfa1e6c3c684f701c7e2a428~rLACi67LJ2603626036eucas1p1X;
        Mon, 24 Jun 2019 15:27:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190624152756eusmtrp22f3f3fc746ab79f0c401f5acf365e911~rLACUydH_2704627046eusmtrp2a;
        Mon, 24 Jun 2019 15:27:56 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-a1-5d10ebfda304
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 50.E9.04146.CFBE01D5; Mon, 24
        Jun 2019 16:27:56 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624152756eusmtip15f72ec26d0366bf4f81db5983560f798~rLAB11zfb1046310463eusmtip16;
        Mon, 24 Jun 2019 15:27:56 +0000 (GMT)
Subject: Re: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <37de5e40-38af-0bb5-88c0-dec1ad1c5d30@samsung.com>
Date:   Mon, 24 Jun 2019 17:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624111636.GB5737@pendragon.ideasonboard.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRz2vfe9u/eOy9cV95EmLmxMXcbsnZT8mL1jyPzBonHcK02XdlfH
        aSNWus6yOwxdjdbESXS703Hm105zckM/ZJEpaiW0piupJN29mf579jzP5/N5nu1DEdIGfiiV
        kpbBatKUqXKBmHQ+G3wVOfINJ0VXeBfQo04zQb/p7xHQjQNdBF3zvZGkB/Pu8Oh881Uh3XC/
        WEC3dj1GtPvMTnrQ/ZpHV+Yo4iczPU25QuZyRRZj+3yTzzz8WUIyRYZCPvPcVM9jWk57eMyI
        5THJPCk4RzI+++wEcaJ4pYpNTdGxGkXcHvGB2x9aUHrnnCOmOjPKRq9DjUhEAV4GbW15hBGJ
        KSm2IrhmKyP8ghT3IWgwhnCCD0G+94zw30Tt0CUBZ7qO4OeDaM7UjaC0r4P0C8F4AzgffOL7
        cQhWwWDxaaHfRGAvARcGmgLTArwQRhzvAliC4+Bj1RdkRBRF4vng6Fjnp6fjHdDnsiPOMg1q
        CtsD+0V4FRQ4fIH9BA6Hu93FBIdl8L79Cs9/C/APITiGL/G41OvA9u08n8PB8NVzZ7xNGIy6
        rox7jkOLNYfghg0IqmwughNi4Kmnju8PR4yFrryv4OjVUFPuJv004CBo6p7GZQiCs86LBEdL
        wHBKyrnnQsvLqvGFMiir7ReYkNwyoZllQhvLhDaW/3dLEFmOZGymVp3MapeksYejtEq1NjMt
        OWrfIbUdjb2a94+n9x7qr9/rRphC8imSkmqcJOUrdVq92o2AIuQhkjLlGCVRKfVHWc2h3ZrM
        VFbrRrMoUi6TZE1q3SnFycoM9iDLprOafyqPEoVmoxNvV6z2vIiZ//tReIQu8VblSVr1K3eL
        xmRev9/Xlp7gglJrUnFn4qa1W8PM23ZkxoaVipYXeTp0tQOGLzN6dcP1LnJL14rC+PbqjObY
        qfv0p445hjZHLravsc50HEXHpPryuc2K0aBdWeHrrRtt8xL0i3CEmtzuvdFsL9i2VBgrJ7UH
        lEsWERqt8i+MKHjKZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7p/XgvEGux/qGfxf9tEZosrX9+z
        WVz9/pLZ4uSbqywWP9u3MFl0TlzCbnF51xw2iwcv9zNaHOqLtvh56DyTxfoWfQduj/c3Wtk9
        5q2p9tjwaDWrx95vC1g8ZnfMZPU4MeESk8f97uNMHn9n7WfxONA7mcXj8ya5AK4oPZui/NKS
        VIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYx1d+4zFjxXqJhw
        cSJjA+N5qS5GTg4JAROJC79msHUxcnEICSxllLix5wQzREJcYvf8t1C2sMSfa11QRa8ZJd4c
        Ws8IkhAW8JLYtuchK4gtIpAisf/ORnaQImaBs8wSC66dYYXo2MIscehBI1gVm4CmxN/NN9lA
        bF4BO4l7W18ATeLgYBFQldj8zAUkLCoQITF7VwMLRImgxMmZT8BsTgF7id7Nn8HGMAuoS/yZ
        d4kZwpaX2P52DpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX
        5qXrJefnbmIExvK2Yz8372C8tDH4EKMAB6MSD++CIwKxQqyJZcWVuYcYJTiYlUR4lyYChXhT
        EiurUovy44tKc1KLDzGaAv02kVlKNDkfmGbySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeW
        pGanphakFsH0MXFwSjUwctz1nth7v67plFPoy3mTpv4+L5lgXM8vdfDzB4dF/QvqOwsf8fzq
        e7/psevjsOP6PNZOJzdmnFtv4fw/2Pe1/rTe2tBKtpk77vbuVrxWLtVwQ7u/amlL4LJmubt3
        1h+J4dwd4LxaQ6kvSanSKbUsuGDjge8cDwrY1X9d3aecdjLl5aF7L5ojlViKMxINtZiLihMB
        schapvsCAAA=
X-CMS-MailID: 20190624152757eucas1p14b3e9201cfa1e6c3c684f701c7e2a428
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190624111911epcas2p399d792d3e4663e489270c76c2bed2a25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190624111911epcas2p399d792d3e4663e489270c76c2bed2a25
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <085dc3be-20e5-b2fe-4c02-bf4a4d1473da@baylibre.com>
        <20190621090125.GX12905@phenom.ffwll.local>
        <20190623233017.GI6124@pendragon.ideasonboard.com>
        <58243243-fbd8-e67b-a050-baa9757be43e@baylibre.com>
        <CGME20190624111911epcas2p399d792d3e4663e489270c76c2bed2a25@epcas2p3.samsung.com>
        <20190624111636.GB5737@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2019 13:16, Laurent Pinchart wrote:
> Hi Neil,
>
> On Mon, Jun 24, 2019 at 10:19:34AM +0200, Neil Armstrong wrote:
>> Hi Daniel, Laurent, Andrzej,
>>
>> On 24/06/2019 01:30, Laurent Pinchart wrote:
>>> On Fri, Jun 21, 2019 at 11:01:25AM +0200, Daniel Vetter wrote:
>>>> On Thu, Jun 20, 2019 at 04:40:12PM +0200, Neil Armstrong wrote:
>>>>> Hi Andrzej,
>>>>>
>>>>> Gentle ping, could you review the dw-hdmi changes here ?
>>>> btw not sure you absolutely need review from Andrzej, we're currently a
>>>> bit undersupplied with bridge reviewers I think ... Better to ramp up
>>>> more.
>>> I try to review DRM bridge patches when possible, but dw-hdmi is a
>>> special case. I was told by the supplier of an SoC datasheet that
>>> contains the HDMI encoder IP core documentation that Synopsys required
>>> them to route all contributions made based on that documentation through
>>> Synopsys' internal legal review before publishing them. I thus decided
>>> to not contribute to the driver anymore, at least for areas that require
>>> access to documentation.
>> I'd like to propose myself as co-maintainer of the DRM bridge subsystem if
>> everybody agrees, following the excellent work Laurent and Andrzej did.
>> I have a very little knowledge of DSI, & other bridge drivers, but I'll do
>> my best.
>>
>> For the dw-hdmi driver, we have a big roadmap including :
>> - HDR (this patchset)
>> - HDCP 1/2
>> - YUV420, YUV422, YUV44, 10bit/12bit/16bit HDMI output
>> - Enhanced audio support and ELD notification to ASoC
>> ...
> You're more than welcome as a DRM bridge maintainer, especially given
> that you have just volunteered to implement bridge states and format
> negotiation, right ? ;-)


Two (even three) birds with one stone :)


>
>> Having a more active maintainer/reviewer team would be needed, at least for
>> the dw-hdmi bridge.
>>
>> I'll also propose Jonas Karlman <jonas@kwiboo.se> as reviewer since he is very
>> active for the multimedia support on RockChip, Allwinner and Amlogic SoCs.
>> I'll also propose Jernej Skrabec@siol.net <jernej.skrabec@siol.net>, if he wants,
>> as reviewer since he is very active on the Allwinner SoCs side.


Welcome on board, I will wait one/two days for possible comments, then I
will queue MAINTAINERS patch.


Regards

Andrzej



>>
>>>>> On 26/05/2019 23:18, Jonas Karlman wrote:
>>>>>> Add support for HDR metadata using the hdr_output_metadata connector property,
>>>>>> configure Dynamic Range and Mastering InfoFrame accordingly.
>>>>>>
>>>>>> A drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
>>>>>> can use to signal when Dynamic Range and Mastering infoframes is supported.
>>>>>> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
>>>>>> and only GXL support DRM InfoFrame.
>>>>>>
>>>>>> The first patch add functionality to configure DRM InfoFrame based on the
>>>>>> hdr_output_metadata connector property.
>>>>>>
>>>>>> The remaining patches sets the drm_infoframe flag on some SoCs supporting
>>>>>> Dynamic Range and Mastering InfoFrame.
>>>>>>
>>>>>> Note that this was based on top of drm-misc-next and Neil Armstrong's
>>>>>> "drm/meson: Add support for HDMI2.0 YUV420 4k60" series at [1]
>>>>>>
>>>>>> [1] https://patchwork.freedesktop.org/series/58725/#rev2
>>>>>>
>>>>>> Jonas Karlman (4):
>>>>>>   drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
>>>>>>   drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
>>>>>>   drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
>>>>>>   drm/sun4i: Enable DRM InfoFrame support on H6
>>>>>>
>>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 109 ++++++++++++++++++++
>>>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   |  37 +++++++
>>>>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c       |   5 +
>>>>>>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   2 +
>>>>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |   2 +
>>>>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |   1 +
>>>>>>  include/drm/bridge/dw_hdmi.h                |   1 +
>>>>>>  7 files changed, 157 insertions(+)


