Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F99C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A51020684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PsZPmC7S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HE3dg8WC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCFWTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:19:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfCFWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:19:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 094BE60398; Wed,  6 Mar 2019 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551910752;
        bh=FjAPG91adVQ/deU/7tj7eq/dvC+j0eL4tQu8/mOkG9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsZPmC7SkvqKGN8DWkc2/4mKd4V1928nvSiq4KxELqal+2boh9urQ17CHh1WXQfhu
         XJeg42sIv3VVWd8dAN9KTzKJqEzGva9iXgByHTIHFjVTucl16Z6CEHdgPk+5ngFfcT
         g5P48+QVg5UcoJCa5Hb2aiJp4D/FxOB2tDcHK7pg=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0592B60398;
        Wed,  6 Mar 2019 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551910751;
        bh=FjAPG91adVQ/deU/7tj7eq/dvC+j0eL4tQu8/mOkG9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HE3dg8WC/30IvqPuYQlPKYb13Us3Hfi6/0HMY3+WRWfrpAfXuvek2URnrdmmBdyOS
         Ao0mUAVCtO5f0iFlTERmiu3eOhWz3J+/xKfsZ96iZvPGkmEEF0qtouK/j/FltVouSn
         OqSvQgvoYNMk/1dfjPYLYatPwJ1U4G4PAIo50AQg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0592B60398
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 6 Mar 2019 15:19:10 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the
 controller is idle
Message-ID: <20190306221910.GC10971@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
 <20190221121827.32427-3-rplsssn@codeaurora.org>
 <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
 <20190227222913.GA10971@codeaurora.org>
 <155146312862.16805.13188707704058408931@swboyd.mtv.corp.google.com>
 <20190304171450.GB10971@codeaurora.org>
 <155191036168.20095.16985811185745151630@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155191036168.20095.16985811185745151630@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06 2019 at 15:12 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-03-04 09:14:50)
>> On Fri, Mar 01 2019 at 10:58 -0700, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2019-02-27 14:29:13)
>> >> Hi Stephen,
>> >>
>> >> On Tue, Feb 26 2019 at 17:49 -0700, Stephen Boyd wrote:
>> >
>> >Ok, can you explain why it's even a problem for the TCSes to be active
>> >during suspend? I would hope that for suspend/resume, if this is
>> >actually a problem, the RPMh driver itself can block suspend with a
>> >driver suspend callback that checks for idleness.
>> The RSC can transmit TCS executed from Linux and when all the CPUs have
>> powered down, could execute a firmware in the RSC to deliver the sleep
>> state requests. The firmware cannot run when there are active requests
>> being processed. To ensure that case, we bail out of sleep or suspend,
>> when the last CPU is powering down, if there are active requests.
>
>Ok, do we actually bail out or just pick a shallower idle state that
>wouldn't trigger the firmware to run something that may conflict with
>the active requests (i.e. some light CPU sleep mode)? The commit text
>seems to imply we block certain idle states.
>
We bail out of idle and let cpuidle determine the state again. We don't
go into a shallower state.
>>
>> >But I suspect that in
>> >the system wide suspend/resume case, any callers that could make TCS
>> >requests are child devices of the RPMh controller and therefore they
>> >would already be suspended if they didn't have anything pending they're
>> >waiting for a response on or they would be blocking suspend themselves
>> >if they're waiting for the response. So why are we even checking the
>> >TCSes in system suspend path at all? Assume that callers know what
>> >they're doing and will block suspend if they care?
>> >
>> In suspend, they probably would do what you mention above. All CPUs
>> might conincidentally be idle at the same idle, when a request is being
>> processed.
>>
>> >Following that same logic, is this more of an API that is planned for
>> >use by CPU idle? Where the case is much more of a runtime PM design.
>> >Even then, I don't get it. A device that's runtime active and making
>> >RPMh requests might need to block some forms of CPU idle states because
>> >a request hasn't been processed yet that may change the decision for
>> >certain deep idle states?
>> >
>> A process waiting on a RPMH request, may let the CPU go to sleep and
>> therefore this is a possibility.
>>
>
>Ok thanks for the info. Can these details be included in the commit text
>so we don't lose sight of the bigger picture? And can this patch series
>be combined with a larger cpuidle/suspend patch series so we don't have
>to review this in isolation? I don't understand the need to add more
>APIs that aren't used yet.
>
Agreed.

--Lina

