Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A22CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5AF2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g+NibsXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfDREqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:46:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:49289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfDREqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555562803;
        bh=8tS7bpBhtkoI0dYCLrd7uGVEa9ncF8t48Ghfbe80uvc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g+NibsXtovx0V/aHZoxy3xD6UDuB/AoGF79F8m4j7tCKM1rKYV1xycnNdG25IRkQB
         KFL7zr5ueKIG2N0Ummf8HC67cHs21eTSxqAA1N/s2iA5MccgLDdFkyFmN25ywTDwzX
         LXmbyZBD/ZSQmmT0IzJe26mf3bnJvFf2qJlowbjI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from notebook.internal ([84.160.214.37]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lp7d2-1gedz50P92-00eq5G; Thu, 18
 Apr 2019 06:46:43 +0200
From:   Mathias =?ISO-8859-1?Q?Fr=F6hlich?= <Mathias.Froehlich@gmx.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.0 072/246] drm/amd/display: Fix reference counting for struct dc_sink.
Date:   Thu, 18 Apr 2019 06:46:41 +0200
Message-ID: <12751920.KfR1oLxoXd@notebook.internal>
In-Reply-To: <20190415105029.GC9397@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org> <4990954.l4Ku8jBaGM@notebook.internal> <20190415105029.GC9397@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:H3MnPmqDNjS7Qi0VN27dO/M2SkFHnxNghFEkAI8cU+DhrCJuF8J
 FXJfQluSyMKGY/Q6k/XL0KnCi0dKTPGiqOnDTv/hg6Lkx+0Fo07Rs4fvZK1UeDqTLF6j7r1
 c+INcTsin3vFITayb0QHiPXPC3eU0E2s1Q25AZdU1+32o/nyF5fiX/vk2huT9f6RGW1UsJf
 ugVVZwNpWZ2MgBPK4cCGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EOf6wQRe6Do=:qbP/DOHIW2gXpVgwemY5nb
 SgZ4c2LfC6zN+AH7VlHoph5WH2AmiWJZ7WT6FBtmPtNumplCt6T8u28Gu6sx3i5BEm7asL/Ia
 Yqs4Eyhu3PqDlq5EVtLe0w0FxsvrQfImb9EsvXTwYuXAEOvSUrLojQSamNmnvcWCBQ7YGFYs4
 L6tl0U45SnYOKdjQ04GNwCCm3Jdp8GPsE+0r/7hq0rqFcNDIhD/K5nPOlVOAd6Wnakjyz80IT
 LTQunnHjMPqoOEZoZ2pnioJqU3xAwoy1R8oq0RrSh/W6dyBG4AYWsK0yJd3vtdUhnaHFdwTfX
 YEb8SSQ6318OFESEzW2D5RRpKgMcZNj3MZLxAEIPdoqYNN6kwbnDF9qfTPu0rPy0lTa9lMtgD
 iMrabKei/GrUWsvYguJl6Kv4sGtZ+4IZjyqmzSC0M/0oC0iB9i45lM46aaLst/Gq0Mg51iObj
 71HyaN7GJcADp62qwP2H9GAOVJPTwhRlPuVnsjJVsI7BRa73llVOTvg2it5XHxs/K74kdhAI9
 +XQ6n9e7SAKiVrue+Ip70Mh/amKHW/VJWBYKzU5XjhYrvzWpGDAIgUf2KOTqrOQf0HBQxm6m5
 YLj18WKa5aW9Uh8n0x/8UIvVcFlvEzsT/tJ28Egm18uQMFRJJGMxu6HeAPyrC3BFz2o0Tqf7S
 3HBk5tOPyZ7KQ0BFQb5TuTLSRoSiawjCofcCKKSb4soW1xyUVwP0e47sQjbGUtEEOa0oArgof
 AOzDjYhehuxl6FBb4mnw8w2XYRLLlZXIdnAKZewvI/nn9IeZzMyRXOHvUVQLIALMBY5Djinwl
 ACwE/YGfdoQfMZyYa9pjGQ29mfQXHy0gkKHb7FBFQFvbEh/nvQyAvEn49VAz55oIOIXptDP2a
 vvtVzPSaXyf7FgLdryyw/6vN++O49LExqLm0jgTydo72y78/gLmy3kCweqtdpzzyL22dI1MXF
 cHRjNJBgRfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Monday, 15 April 2019 12:50:29 CEST Greg Kroah-Hartman wrote:
> On Fri, Apr 05, 2019 at 07:12:47AM +0200, Mathias Fr=F6hlich wrote:
> > Greg,
> >=20
> > as I mentioned in the commit message, I saw more fixes to that area in =
Alex
> > Deuchers queue when I fed that to Alex. There is one fix that I can thi=
nk of
> > that interacts with my fixes. Means, we may get unwanted side effects o=
f my
> > patch without the fix mentioned below. With that below patch also selec=
ted,
> > I think we should be ok for stable.
> > Alex, AMD people, your opinion?
> >=20
> > The one that I can spot not already in linux-5.0.y is:
> >=20
> > commit 3f01f098a4e2ef30ef628497c43a3d568e720376
> > Author: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> > Date:   Thu Jan 24 11:46:49 2019 -0500
> >=20
> >     drm/amd/display: Clear dc_sink after it gets released
> >    =20
> >     [Why]
> >     The dc_sink was released but the pointer on the aconnector was
> >     not cleared.
> >    =20
> >     [How]
> >     Clear it.
>=20
> This patch does not apply to the 5.0.y tree, so I can not queue it up :(

Sounds plausible.
And thanks for trying!

I had now the chance to test the 5.0.7 kernel tree as is including just
my patch on the box in question. I can say that it works as expected with 5=
=2E0.7
and since I did also not hear complaints on the lists I hope we are good as=
 is!

Many thanks!

best

Mathias


