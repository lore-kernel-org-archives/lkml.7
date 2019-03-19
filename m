Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F72C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7D72085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCSQI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:08:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:18338 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfCSQI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:08:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 09:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="330023927"
Received: from tyagiami-mobl.ger.corp.intel.com (HELO [10.252.56.226]) ([10.252.56.226])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 09:08:52 -0700
Subject: Re: [PATCH v4 01/10] drm/fourcc: Add AFBC yuv fourccs for Mali
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
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
 <a67ec415-af2b-9ddd-9856-b5066ce2b791@linux.intel.com>
 <20190318232746.GA32276@arm.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <1059793f-9a8c-b81b-cb61-72a50426d50f@linux.intel.com>
Date:   Tue, 19 Mar 2019 17:08:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190318232746.GA32276@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Op 19-03-2019 om 00:27 schreef Ayan Halder:
> On Mon, Mar 18, 2019 at 07:12:24PM +0100, Maarten Lankhorst wrote:
>> Op 18-03-2019 om 16:40 schreef Brian Starkey:
>>> Hi,
>>>
>>> On Mon, Mar 18, 2019 at 11:17:55AM +0100, Maarten Lankhorst wrote:
>>>
>>> <snip>
>>>
>>>> Hey..
>>>>
>>>> There's a conflict with this patch and the merge of topic/hdr-formats, resulting in double definitions for Y210, Y410 and P010.
>>>>
>>>> Worse still is that one has set has_alpha to true for Y41x and other to false.
>>>>
>>>> ~Maarten
>>>>
>>> Oh that's sad :-( I think this fell through the cracks on our side
>>> when someone left our team. Also turns out I'm not subscribed to
>>> igt-dev.
>>>
>>> I see you commented the same on one of the previous patches, and that
>>> there was some discussion of this on the test patches too.
>>>
>>> I have been referring to Microsoft's page[1] as "the" source for these
>>> formats, which does indeed call out Y410 as having 2 bits of alpha.
>>> Our GPU expects alpha.
>> Ah. Yeah there has been discussion on whether there was supposed to be alpha or not, but the original discussion on HDR formats has been completely ignored by arm.
>>
>> The patch had originally a few arm devs on cc and was sent to dri-devel with linux-media cc'd. Was sad to see it completely ignored so after having been sent twice I pushed it.
> Apologies, I see that I was cc-ed in the mail 'drm: Add Y2xx and Y4xx
> (xx:10/12/16) format definitions and fourcc' sent by
> swati2.sharma@intel.com. It got lost in my pile of unread mails. :(
>
> About this patch, I had tagged you in irc channel
> (https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2019-03-11&show_html=true)
> for reviewing this seies. Did not hear back from you then ?

Looks like we both unfortunately not looked at each others series then, or at least I missed the HDR formats part.

>>> Was there a specific reason for opting to change the test instead of
>>> the definition? Any way to get this changed now?
>>>
>>> It doesn't seem that sensible for the kernel to call something Y410
>>> which doesn't match an "existing" definition by the same name. If
>>> alpha needs to be ignored on scanout, the alpha blend mode property
>>> can be used (more archaeology - I see that was still giving CRC
>>> failures, but that might be a "known issue" for all YUV on your HW?)
>> Were a few bugs, but should be fixed now. :)
>>
>> Well only that we didn't have hw supporting alpha, and didn't hear back from others so we went without alpha.
> In light of the suggestions made by brian.starkey@arm.com, I think
> changing the format from Y410 to X410 (in your case) might make sense
> as the alpha bits are absent.
> If this suggestion looks reasonable to you, I can volunteer myself to make
> this change in topic/hdr-formats.

I sent a patch to fix the conflicts. There's already XVYU2101010 in that series, which is
Y410 without alpha. I've extended it and used it to convert i915. It's unfortunate those
conflicts happen, but fortunately it didn't spread to drm-next or linux-next.

Link: https://patchwork.freedesktop.org/patch/292977/?series=58182&rev=1

Tested it, basic tests seems to work for i915.

~Maarten

