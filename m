Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FD3C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C9B21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PDyWp4Dp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Auk8BWFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437380AbfJYHzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:55:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfJYHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:55:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 66C8E60ECE; Fri, 25 Oct 2019 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571990100;
        bh=U54r6LX0ssw+g8qjLKGHh1Yhi6Sj5o6iNs4ZAFLlmsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PDyWp4DptCJ+c2ap2wzUz4fI0KeRZqy5pI23Xk5JUlPJrP1QjMto/IkhLFCBYatQe
         w9j1qNCE8sTG1O267wV5k2aanJoSlQU6HvzIQmHDNe9rQ+lH/frXDVib9Vu+vmO2Lj
         1ouHOhcYxMX8lur/8QIqJ/XkYdMk5DsdOufE5n3g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6AE8A60B19;
        Fri, 25 Oct 2019 07:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571990099;
        bh=U54r6LX0ssw+g8qjLKGHh1Yhi6Sj5o6iNs4ZAFLlmsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Auk8BWFrXU39kNQrasYkgigZIAjmQlNoLTm9OhiHh7ON9HRrMXwVZ1zo2+kF7gOH7
         vmyStNYQg1UbT+vi7H36qwXpW0br4wfITh06/G/y9JqQU8CcKvhLcp0cSQ+TPcZRnr
         AJc8dDV5IDC7u9vk4EFjf92fgq9TpZOBwHpCyQSo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Oct 2019 13:24:59 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv2 0/3] Add LLCC support for SC7180 SoC
In-Reply-To: <CAL_Jsq+5p7gQzDfGipNFr1ry-Pc3pDJpcXnAqdX9eo0HLETATQ@mail.gmail.com>
References: <cover.1571484439.git.saiprakash.ranjan@codeaurora.org>
 <20191021033220.GG4500@tuxbook-pro>
 <CAL_JsqLzRRQe8UZCxgXArVNhNry7PgMCthAR2aZNcm6CCEpvDA@mail.gmail.com>
 <2fbab8bc38be37fba976d34b2f89e720@codeaurora.org>
 <CAL_Jsq+5p7gQzDfGipNFr1ry-Pc3pDJpcXnAqdX9eo0HLETATQ@mail.gmail.com>
Message-ID: <81f57dc623fe8705cea52b5cb2612b32@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-25 04:03, Rob Herring wrote:
> On Thu, Oct 24, 2019 at 6:00 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Hi Rob,
>> 
>> On 2019-10-24 01:19, Rob Herring wrote:
>> > On Sun, Oct 20, 2019 at 10:32 PM Bjorn Andersson
>> > <bjorn.andersson@linaro.org> wrote:
>> >>
>> >> On Sat 19 Oct 04:37 PDT 2019, Sai Prakash Ranjan wrote:
>> >>
>> >> > LLCC behaviour is controlled by the configuration data set
>> >> > in the llcc-qcom driver, add the same for SC7180 SoC.
>> >> > Also convert the existing bindings to json-schema and add
>> >> > the compatible for SC7180 SoC.
>> >> >
>> >>
>> >> Thanks for the patches and thanks for the review Stephen. Series
>> >> applied
>> >
>> > And they break dt_binding_check. Please fix.
>> >
>> 
>> I did check this and think that the error log from dt_binding_check is
>> not valid because it says cache-level is a required property [1], but
>> there is no such property in LLCC bindings.
> 
> Then you should point out the issue and not just submit stuff ignoring
> it. It has to be resolved one way or another.
> 

I did not ignore it. When I ran the dt-binding check locally, it did not
error out and just passed on [1] and it was my bad that I did not check
the entire build logs to see if llcc dt binding check had some warning 
or
not. But this is the usual case where most of us don't look at the 
entire
build logs to check if there is a warning or not. We notice if there is 
an
immediate exit/fail in case of some warning/error. So it would be good 
if
we fail the dt-binding check build if there is some warning/error or 
atleast
provide some option to strict build to fail on warning, maybe there is 
already
a flag to do this?

After submitting the patch, I noticed this build failure on
patchwork.ozlabs.org and was waiting for your reply.

[1] https://paste.ubuntu.com/p/jNK8yfVkMG/

> If you refer to the DT spec[1], cache-level is required. The schema is
> just enforcing that now. It's keying off the node name of
> 'cache-controller'.
> 

This is not L2 or L3 cache, this is a system cache (last level cache) 
shared by
clients other than just CPU. So I don't know how do we specify 
cache-level for
this, let me know if you have some pointers.

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
