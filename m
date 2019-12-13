Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A91C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49C722527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BEkQwPG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLMJFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:05:39 -0500
Received: from m228-5.mailgun.net ([159.135.228.5]:35544 "EHLO
        m228-5.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLMJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:05:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576227938; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=oiZ6N7do6DpLWyW7ai3fK8w8lB8Z4mhLsKqRpsecyYA=; b=BEkQwPG/ipLYEf8Nq8qBlXXEjU9qWltzngcaNgDuX4RMhPFPsQtSpv/jNCx/28YdHAq3pWjU
 4OVAL/CYC0EXMYhRl/WbG+QhwZttfZHw7picH2ajdlt2cyNXyqPLdBW5hKTTh7ZVUbsThEt9
 a7nWM0JulI5Yu/UicSsOw4GiBnw=
X-Mailgun-Sending-Ip: 159.135.228.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df35462.7f8b5ffcff48-smtp-out-n01;
 Fri, 13 Dec 2019 09:05:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34568C447A6; Fri, 13 Dec 2019 09:05:36 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D24FC43383;
        Fri, 13 Dec 2019 09:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Dec 2019 14:35:35 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH 2/2] drivers: edac: Add EDAC support for Kryo CPU caches
Message-ID: <af73f8f15cfeb40746819e87b5a78b60@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thanks for the review comments.

On 2019-12-12 01:02, Evan Green wrote:
> 
> No name?
> 

Will add them in next spin.

> 
> A comment is warranted to indicate that err_type is indexed by the
> enum, as this would be easy to mess up in later changes.
> 

Will use array index as suggested by Stephen.

>> +static const char *get_error_msg(u64 errxstatus)
>> +{
>> +       const struct error_record *rec;
>> +       u32 errxstatus_serr;
>> +
>> +       errxstatus_serr = FIELD_GET(KRYO_ERRXSTATUS_SERR, errxstatus);
>> +
>> +       for (rec = serror_record; rec->error_code; rec++) {
> 
> It looks like you expect the table to be zero terminated, but it's
> not. Add the missing zero entry.
> 

Will add it.

>> +
>> +static inline void kryo_clear_error(u64 errxstatus)
>> +{
>> +       write_sysreg_s(errxstatus, SYS_ERXSTATUS_EL1);
>> +       isb();
> 
> Is the isb() necessary? If so, why not a dsb as well?
> 

We usually use isb() with cache and system control registers.
I do not see anything about isb or dsb mentioned in the TRM
for error record registers so it's probably OK to remove this.
James can help us here.

>> +
>> +static void kryo_check_l1_l2_ecc(void *info)
>> +{
>> +       struct edac_device_ctl_info *edev_ctl = info;
>> +       u64 errxstatus;
>> +       u64 errxmisc;
>> +       int cpu;
>> +
>> +       cpu = smp_processor_id();
>> +       /* We know record 0 is L1 and L2 */
>> +       write_sysreg_s(0, SYS_ERRSELR_EL1);
>> +       isb();
> 
> Another isb I'm not sure about. Is this meant to provide a barrier
> between ERRSELR and ERXSTATUS? Wouldn't that be dsb, not isb?
> 

Same as above.

I will repost with your comments addressed once I get more feedbacks 
from EDAC maintainers.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
