Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B4FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F61206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WHiw2YsQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PScdcvIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCDROy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:14:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfCDROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:14:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2DDBA609D4; Mon,  4 Mar 2019 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551719692;
        bh=0kR7MaD+bxKy5kF3KHAjyUhtlHj7+bUZhnAmbPl/OLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHiw2YsQsKy+Vj9qm1710L6Hp6mQ87/1Vd7reF+XrnrCXMSjWykWz/FlO5XGbF605
         rQ5mzy23RZhdvCxetTMv8OWNy+1wWmReYD7ZWxdN4CDvbiRH2EsO79TONexiPOCEwC
         LtXUsajKq6G9c/G3YAV+fDDnPktUE0O/d+XFPLLg=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5949601FE;
        Mon,  4 Mar 2019 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551719691;
        bh=0kR7MaD+bxKy5kF3KHAjyUhtlHj7+bUZhnAmbPl/OLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PScdcvIUJom4u0PDH3uJEXGjuZQjg+sovlHGPRmhg27cRCThILAgMlYlgFXs/UQsQ
         KUox9TbDGV/S3/a0qP/SG2EvSm8PXZ6+mTU9E07m1kNav/GOvQLmjbqPW56MOMzWim
         1DaV16zwcqdD6pGFg95BcRbgLPa5p4sCf52nnSuM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5949601FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 4 Mar 2019 10:14:50 -0700
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
Message-ID: <20190304171450.GB10971@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
 <20190221121827.32427-3-rplsssn@codeaurora.org>
 <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
 <20190227222913.GA10971@codeaurora.org>
 <155146312862.16805.13188707704058408931@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155146312862.16805.13188707704058408931@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01 2019 at 10:58 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-02-27 14:29:13)
>> Hi Stephen,
>>
>> On Tue, Feb 26 2019 at 17:49 -0700, Stephen Boyd wrote:
>> >Quoting Raju P.L.S.S.S.N (2019-02-21 04:18:26)
>> >> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> >> index d6b834eeeb37..9cc303e88a06 100644
>> >> --- a/drivers/soc/qcom/rpmh-rsc.c
>> >> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> >> @@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>> >>         return ret;
>> >>  }
>> >>
>> >> +/**
>> >> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
>> >> + *
>> >> + *  @drv: The controller
>> >> + *
>> >> + *  Returns true if the TCSes are engaged in handling requests.
>
>By the way, this says AMCs are busy and then TCSes are engaged. Which
>one is it?
>
>> >> + */
>> >> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
>> >> +{
>> >
>> >This API seems inherently racy. How do we know that nothing else is
>> >going to be inserted into the TCS after this function returns true? Do
>> >you have a user of this API? It would be good to know how it is used
>> >instead of adding some code that never gets called.
>> >
>> This API is called from the last CPU that is powering down in an
>> interrupt locked context (say during suspend). If we are waiting on a
>> request, we would bail out of the suspend process. There can be no issue
>> requested during the last step in suspend. The PM driver itself does not
>> make any TCS request. Currently, this API is used by the downstream code
>> in its last man activities. The usage by platform coordinated mode is
>> still under discussion.
>>
>
>Ok, can you explain why it's even a problem for the TCSes to be active
>during suspend? I would hope that for suspend/resume, if this is
>actually a problem, the RPMh driver itself can block suspend with a
>driver suspend callback that checks for idleness.
The RSC can transmit TCS executed from Linux and when all the CPUs have
powered down, could execute a firmware in the RSC to deliver the sleep
state requests. The firmware cannot run when there are active requests
being processed. To ensure that case, we bail out of sleep or suspend,
when the last CPU is powering down, if there are active requests.

>But I suspect that in
>the system wide suspend/resume case, any callers that could make TCS
>requests are child devices of the RPMh controller and therefore they
>would already be suspended if they didn't have anything pending they're
>waiting for a response on or they would be blocking suspend themselves
>if they're waiting for the response. So why are we even checking the
>TCSes in system suspend path at all? Assume that callers know what
>they're doing and will block suspend if they care?
>
In suspend, they probably would do what you mention above. All CPUs
might conincidentally be idle at the same idle, when a request is being
processed.

>Following that same logic, is this more of an API that is planned for
>use by CPU idle? Where the case is much more of a runtime PM design.
>Even then, I don't get it. A device that's runtime active and making
>RPMh requests might need to block some forms of CPU idle states because
>a request hasn't been processed yet that may change the decision for
>certain deep idle states?
>
A process waiting on a RPMH request, may let the CPU go to sleep and
therefore this is a possibility.

--Lina

