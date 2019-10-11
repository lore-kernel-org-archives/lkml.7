Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C48ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AE0214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VKq0sCcl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eXa6dZiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfJKNkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:40:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfJKNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:40:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2FBD6087B; Fri, 11 Oct 2019 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570801214;
        bh=woLGvO2KYpg2LI7wSKbSPuYqu+XlHMDuEXAS7R5cZOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VKq0sCclKNivwnNSoPPjcMpAVnrxUj4hBlG/L0azIufkvsk5DtKK81UjfwA7wCJow
         btgYgwBTr6mAFB3AVSiDgweZ8Ie7AaMZ95b+zWmH2d5v5bLzl7SkilRllSeOnknqQs
         w5lfPP3qKW6Fm4NPgYWYvNJbH+7Xc+zrMt1coNDU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B5EB160265;
        Fri, 11 Oct 2019 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570801213;
        bh=woLGvO2KYpg2LI7wSKbSPuYqu+XlHMDuEXAS7R5cZOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eXa6dZiI4q1VAhio2kWuZBGU1fCbx8+AHMQtQJ9Br1yNLHJF6zk1weYdOIRYZyeeJ
         dWKjwDS2U8FZt+T06BwB+V496sxzXc0wxItPawySpmI1hvxAPWbtEzYMZ4nKenzNnd
         qj0OkdKjd172OZmH1j11jkel4U/S2MCEvWJGg76g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Oct 2019 19:10:13 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, rnayak@codeaurora.org,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        andrew.murray@arm.com, will@kernel.org, Dave.Martin@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm-owner@vger.kernel.org, marc.w.gonzalez@free.fr
Subject: Re: Relax CPU features sanity checking on heterogeneous architectures
In-Reply-To: <20191011143442.515659f4@why>
References: <b3606e76af42f7ecf65b1bfc2a5ed30a@codeaurora.org>
 <20191011105010.GA29364@lakrids.cambridge.arm.com>
 <7910f428bd96834c15fb56262f3c10f8@codeaurora.org>
 <20191011143442.515659f4@why>
Message-ID: <ac7599b30461d6a814e4f36d68bba6c2@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-11 19:04, Marc Zyngier wrote:
> On Fri, 11 Oct 2019 18:47:39 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> Hi Mark,
>> 
>> Thanks a lot for the detailed explanations, I did have a look at all 
>> the variations before posting this.
>> 
>> On 2019-10-11 16:20, Mark Rutland wrote:
>> > Hi,
>> >
>> > On Fri, Oct 11, 2019 at 11:19:00AM +0530, Sai Prakash Ranjan wrote:
>> >> On latest QCOM SoCs like SM8150 and SC7180 with big.LITTLE arch, below
>> >> warnings are observed during bootup of big cpu cores.
>> >
>> > For reference, which CPUs are in those SoCs?
>> >
>> 
>> SM8150 is based on Cortex-A55(little cores) and Cortex-A76(big cores). 
>> I'm afraid I cannot give details about SC7180 yet.
>> 
>> >> SM8150:
>> >> >> [    0.271177] CPU features: SANITY CHECK: Unexpected variation in
>> >> SYS_ID_AA64PFR0_EL1. Boot CPU: 0x00000011112222, CPU4: >> 0x00000011111112
>> >
>> > The differing fields are EL3, EL2, and EL1: the boot CPU supports
>> > AArch64 and AArch32 at those exception levels, while the secondary only
>> > supports AArch64.
>> >
>> > Do we handle this variation in KVM?
>> 
>> We do not support KVM.
> 
> Mainline does. You don't get to pick and choose what is supported or
> not.
> 

Ok thats good.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
