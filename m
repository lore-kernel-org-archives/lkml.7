Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CBAC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF22218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562183952;
	bh=qyhSe/m3iFJvhjLT7XfiQp9W/+VrvcZY//8DOqO8pmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rvYB4F37xt4vP2br7FjqItNK3YCj840vOIh3/b3GqL+M58S2UUrAPAu4OCHPvzY7H
	 DJ0ltdnYKNxVAuAcJKBra09jog82vvpCLI+4C9jHPyLJiuAY3Yd4WmtIB2tc6lHmpe
	 5kO6OyqagtT68ibPJ9ECH/NOIYPNOrZIClYl2cCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfGCT7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfGCT7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:59:10 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4626421882;
        Wed,  3 Jul 2019 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562183949;
        bh=qyhSe/m3iFJvhjLT7XfiQp9W/+VrvcZY//8DOqO8pmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0glXAHEjYCtRfQ5vgverCgt8lN8cjzwgJLzBScTnm4hRnf3ldUCMP9XpFA1splffi
         FUkETyP3XuHqUK65m2k+5kiWTWSssP+CnWNZof/ivMKz5ZY8Po2X7RIVmE7ls0wVs6
         09PoNq5qg00FHriHOQZGjufA54HkOAKIB7mNepRk=
Date:   Wed, 3 Jul 2019 15:59:08 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 4.19 26/72] usb: dwc3: gadget: use num_trbs when skipping
 TRBs on ->dequeue()
Message-ID: <20190703195908.GC2733@sasha-vm>
References: <20190702080124.564652899@linuxfoundation.org>
 <20190702080126.031346654@linuxfoundation.org>
 <20190703020312.GS11506@sasha-vm>
 <20190703072012.GA3033@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190703072012.GA3033@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 09:20:12AM +0200, Greg Kroah-Hartman wrote:
>On Tue, Jul 02, 2019 at 10:03:12PM -0400, Sasha Levin wrote:
>> On Tue, Jul 02, 2019 at 10:01:27AM +0200, Greg Kroah-Hartman wrote:
>> > commit c3acd59014148470dc58519870fbc779785b4bf7 upstream
>> >
>> > Now that we track how many TRBs a request uses, it's easier to skip
>> > over them in case of a call to usb_ep_dequeue(). Let's do so and
>> > simplify the code a bit.
>> >
>> > Cc: Fei Yang <fei.yang@intel.com>
>> > Cc: Sam Protsenko <semen.protsenko@linaro.org>
>> > Cc: Felipe Balbi <balbi@kernel.org>
>> > Cc: linux-usb@vger.kernel.org
>> > Cc: stable@vger.kernel.org # 4.19.y
>> > Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> > (cherry picked from commit c3acd59014148470dc58519870fbc779785b4bf7)
>> > Signed-off-by: John Stultz <john.stultz@linaro.org>
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> This one has an upstream fix: c7152763f02e05567da27462b2277a554e507c89
>> ("usb: dwc3: Reset num_trbs after skipping").
>
>You were the one who queued this series up :)

Indeed, and I'm actually quite happy about this.

Even though I goofed up and didn't notice the fix when it got queued up,
the automation we have in place to catch these cases worked and we were
able to get the fix in as well before release.

--
Thanks,
Sasha
