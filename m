Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767DDC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B5621841
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 14:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437958AbfIWOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:33:29 -0400
Received: from foss.arm.com ([217.140.110.172]:43344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437427AbfIWOd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:33:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 438731000;
        Mon, 23 Sep 2019 07:33:28 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F293F59C;
        Mon, 23 Sep 2019 07:33:26 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8183: Add node for the Mali GPU
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Dominik Behr <dbehr@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nick Fan <nick.fan@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190905081546.42716-1-drinkcat@chromium.org>
 <CAL_JsqJCO2G90TTT9Mpy4kjVKQyXWw4aXEEnbRp_SE8X=EGc5g@mail.gmail.com>
 <CANMq1KCTPdFhJG1SLf-i+-557Yx-1WLzWCHu3tT_5Q2BF+JgdQ@mail.gmail.com>
 <20190913181729.GB3115@kevin>
 <CANMq1KD++==d0Mb6T2gKU1T7c_MaedswOYdxqEqEKKUL1bxgiw@mail.gmail.com>
 <20190919123243.GA3457@kevin>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3dfa9e3c-9a78-90d1-68c9-7b64a3d734e4@arm.com>
Date:   Mon, 23 Sep 2019 15:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919123243.GA3457@kevin>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 13:32, Alyssa Rosenzweig wrote:
>>> By the time MT8183 shows up in more concrete devices, it will, certainly
>>> in kernel-space and likely in userspace as well. At present, the DDK can
>>> be modified to run on top of the in-tree Mali drivers, i.e. "Bifrost on
>>> mainline linux-next (+ page table/compatible patches), with blob
>>> userspace".

Actually most(?) Bifrost GPUs support the "legacy" 'LPAE-ish' page table
format. So the only kernel change *required* is adding the compatible
string (and any SoC-specific quirks).

The support for "blob-on-Panfrost" is currently an experimental internal
investigation. So I can't make any promises about it ever being released
publicly.

>>> While the open userspace isn't ready here quite yet, I would definitely
>>> encourage upstream kernel for ChromeOS, since then there's no need to
>>> maintain the out-of-tree GPU driver.
>>
>> That's an interesting idea, I had no idea, thanks for the info!
>>
>> Would that work with midgard as well? We have released hardware with
>> RK3288/3399, so it might be nice to experiment with these first.
> 
> Yes, the above would work with Midgard as well with no changes needed.
> Ping Steven about thtat (CC'd).

Indeed since it's the same kernel driver the same compatibility layer
can be used to run Midgard DDK blob on Panfrost. Although given the
progress that has already occurred with the Mesa Panfrost user space you
might be able to simply switch to a completely open stack (available now).

Again I'm afraid I'm not in a position to give any guarantees that my
prototype blob-on-Panfrost work will actually be released or timescales
of when. However since the current focus internally is on newer GPUs I'm
less confident that there will be interest for Midgard DDK on Panfrost.

Steve

>>> More immediately, per Rob's review, it's important that the bindings
>>> accepted upstream work with the in-tree Bifrost driver. Conceptually,
>>> once Mesa supports Bifrost, if I install Debian on a MT8183 board,
>>> everything should just work. I shouldn't need MT-specific changes / need
>>> to change names for the DT. Regardless of which kernel driver you end up
>>> using, minimally sharing the DT is good for everyone :-)
>>
>> Yes. I'll try to dig further with MTK, but this may take some time.
> 
> Thank you!
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

