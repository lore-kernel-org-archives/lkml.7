Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCBFCA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647F020663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572426116;
	bh=MRJhIGTpcjvSR1b439Bv0bYXrlH47dNv1ro7P194GS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=VYoF5+4/nuQdB57nFQH/B5js7+R7P2xfci7pqsXbwALfOHnJCA3XYg5MjS/miUdxt
	 PqUUAa54h+lggTR9XVTQD2TIgZnrN3jn0tZO7cwXmPkfyDwacnPX/LpJTgafbWDx0C
	 hEP37mBIlXjl9o6pPrfJoYfLwcoCljQRsUwNmPDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJ3JBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:01:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:32433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfJ3JBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:01:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 02:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="193903444"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2019 02:01:49 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 6/9] usb: dwc3: Rework resets initialization to be more flexible
In-Reply-To: <CALAqxLX47uELsGbdociUKdC6KgDba-1SBVALmgjD3=jxh=fd8g@mail.gmail.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-7-john.stultz@linaro.org> <87h83rj4ha.fsf@gmail.com> <CALAqxLX47uELsGbdociUKdC6KgDba-1SBVALmgjD3=jxh=fd8g@mail.gmail.com>
Date:   Wed, 30 Oct 2019 11:01:49 +0200
Message-ID: <87k18mhaiq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

John Stultz <john.stultz@linaro.org> writes:

> On Tue, Oct 29, 2019 at 2:17 AM Felipe Balbi <balbi@kernel.org> wrote:
>> John Stultz <john.stultz@linaro.org> writes:
>> > The dwc3 core binding specifies one reset.
>> >
>> > However some variants of the hardware my not have more.
>>                                         ^^
>>                                         may
>>
>> According to synopsys databook, there's a single *input* reset signal on
>> this IP. What is this extra reset you have?
>>
>> Is this, perhaps, specific to your glue layer around the synopsys ip?
>
> Likely (again, I unfortunately don't have a ton of detail on the hardware).
>
>> Should, perhaps, your extra reset be managed by the glue layer?
>
> So yes the dwc3-of-simple does much of this already (it handles
> multiple resets, and variable clocks), but unfortunately we seem to
> need new bindings for each device added?  I think the suggestion from
> Rob was due to the sprawl of bindings for the glue code, and the extra
> complexity of the parent node.  So I believe Rob just thought it made
> sense to collapse this down into the core?
>
> I'm not really passionate about either approach, and am happy to
> rework (as long as there is eventual progress :).
> Just let me know what you'd prefer.

Well, I was under the impression we were supposed to describe the
HW. Synopsys IP has a single reset input :-p

-- 
balbi
