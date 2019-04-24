Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80617C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45089218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfDXOjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:33 -0400
Received: from mail.netline.ch ([148.251.143.178]:33022 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbfDXOjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 3405E2AA104;
        Wed, 24 Apr 2019 16:39:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Z1QvlV2QawA9; Wed, 24 Apr 2019 16:39:26 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 809DE2AA100;
        Wed, 24 Apr 2019 16:39:26 +0200 (CEST)
Received: from [::1]
        by thor with esmtp (Exim 4.92)
        (envelope-from <michel@daenzer.net>)
        id 1hJJ3W-0002qp-1S; Wed, 24 Apr 2019 16:39:26 +0200
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Dave Airlie <airlied@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local>
 <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
 <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
 <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
 <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net>
Date:   Wed, 24 Apr 2019 16:39:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-24 2:01 p.m., Nicolas Dufresne wrote:
> Le mercredi 24 avril 2019 à 10:31 +0200, Michel Dänzer a écrit :
>> On 2019-04-19 10:38 a.m., Paul Kocialkowski wrote:
>>> On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
>>>> Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
>>
>>>> In the first, we'd need a mechanism where we can schedule a render at a
>>>> specific time or vblank. We can of course already implement this in
>>>> software, but with fences, the scheduling would need to be done in the
>>>> driver. Then if the fence is signalled earlier, the driver should hold
>>>> on until the delay is met. If the fence got signalled late, we also
>>>> need to think of a workflow. As we can't schedule more then one render
>>>> in DRM at one time, I don't really see yet how to make that work.
>>>
>>> Indeed, that's also one of the main issues I've spotted. Before using
>>> an implicit fence, we basically have to make sure the frame is due for
>>> display at the next vblank. Otherwise, we need to refrain from using
>>> the fence and schedule the flip later, which is kind of counter-
>>> productive.
>>
>> Fences are about signalling that the contents of a frame are "done" and
>> ready to be presented. They're not about specifying which frame is to be
>> presented when.
>>
>>
>>> I feel like specifying a target vblank would be a good unit for that,
>>
>> The mechanism described above works for that.
>>
>>> since it's our native granularity after all (while a timestamp is not).
>>
>> Note that variable refresh rate (Adaptive Sync / FreeSync / G-Sync)
>> changes things in this regard. It makes the vblank length variable, and
>> if you wait for multiple vblanks between flips, you get the maximum
>> vblank length corresponding to the minimum refresh rate / timing
>> granularity. Thus, it would be useful to allow userspace to specify a
>> timestamp corresponding to the earliest time when the flip is to
>> complete. The kernel could then try to hit that as closely as possible.
> 
> Rendering a video stream is more complex then what you describe here.
> Whenever there is a unexpected delay (late delivery of a frame as an
> example) you may endup in situation where one frame is ready after the
> targeted vblank. If there is another frame that targets the following
> vblank that gets ready on-time, the previous frame should be replaced
> by the most recent one.
> 
> With fences, what happens is that even if you received the next frame
> on time, naively replacing it is not possible, because we don't know
> when the fence for the next frame will be signalled. If you simply
> always replace the current frame, you may endup skipping a lot more
> vblank then what you expect, and that results in jumpy playback.

So you want to be able to replace a queued flip with another one then.
That doesn't necessarily require allowing more than one flip to be
queued ahead of time.

Note that this can also be done in userspace with explicit fencing (by
only selecting a frame and submitting it to the kernel after all
corresponding fences have signalled), at least to some degree, but the
kernel should be able to do it up to a later point in time and more
reliably, with less risk of missing a flip for a frame which becomes
ready just in time.


> Render queues with timestamp are used to smooth rendering and handle
> rendering collision so that the latency is kept low (like when you have
> a 100fps video over a 60Hz display). This is normally done in
> userspace, but with fences, you ask the kernel to render something in
> an unpredictable future, so we loose the ability to make the final
> decision.

That's just not what fences are intended to be used for with the current
KMS UAPI.


-- 
Earthling Michel Dänzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer
