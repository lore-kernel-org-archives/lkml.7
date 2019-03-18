Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59971C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330662133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCRSMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:12:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:34840 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfCRSMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:12:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 11:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="126470870"
Received: from tyagiami-mobl.ger.corp.intel.com (HELO [10.252.56.226]) ([10.252.56.226])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2019 11:12:25 -0700
Subject: Re: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, nd <nd@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Swati Sharma <swati2.sharma@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Vidya Srinivas <vidya.srinivas@intel.com>
References: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
 <dea64e97-1d6b-e728-1e1c-3880e2f0a2e8@linux.intel.com>
 <20190318154004.2llnsarwx77kyqbf@DESKTOP-E1NTVVP.localdomain>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
Date:   Mon, 18 Mar 2019 19:12:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190318154004.2llnsarwx77kyqbf@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 18-03-2019 om 16:40 schreef Brian Starkey:
> Hi,
>
> On Mon, Mar 18, 2019 at 11:17:55AM +0100, Maarten Lankhorst wrote:
>
> <snip>
>
>> Hey..
>>
>> There's a conflict with this patch and the merge of topic/hdr-formats, resulting in double definitions for Y210, Y410 and P010.
>>
>> Worse still is that one has set has_alpha to true for Y41x and other to false.
>>
>> ~Maarten
>>
> Oh that's sad :-( I think this fell through the cracks on our side
> when someone left our team. Also turns out I'm not subscribed to
> igt-dev.
>
> I see you commented the same on one of the previous patches, and that
> there was some discussion of this on the test patches too.
>
> I have been referring to Microsoft's page[1] as "the" source for these
> formats, which does indeed call out Y410 as having 2 bits of alpha.
> Our GPU expects alpha.

Ah. Yeah there has been discussion on whether there was supposed to be alpha or not, but the original discussion on HDR formats has been completely ignored by arm.

The patch had originally a few arm devs on cc and was sent to dri-devel with linux-media cc'd. Was sad to see it completely ignored so after having been sent twice I pushed it.

> Was there a specific reason for opting to change the test instead of
> the definition? Any way to get this changed now?
>
> It doesn't seem that sensible for the kernel to call something Y410
> which doesn't match an "existing" definition by the same name. If
> alpha needs to be ignored on scanout, the alpha blend mode property
> can be used (more archaeology - I see that was still giving CRC
> failures, but that might be a "known issue" for all YUV on your HW?)

Were a few bugs, but should be fixed now. :)

Well only that we didn't have hw supporting alpha, and didn't hear back from others so we went without alpha.

> -Brian
>
> [1] https://docs.microsoft.com/en-us/windows/desktop/medfound/10-bit-and-16-bit-yuv-video-formats#444-formats


