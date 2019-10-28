Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86254CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AF821479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfJ1Wv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:51:57 -0400
Received: from foss.arm.com ([217.140.110.172]:46132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJ1Wv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:51:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C8621F1;
        Mon, 28 Oct 2019 15:51:56 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 324343F6C4;
        Mon, 28 Oct 2019 15:51:55 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/arm-smmu: fix "hang" when games exit
To:     Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org,
        freedreno <freedreno@lists.freedesktop.org>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
 <20191007204906.19571-1-robdclark@gmail.com>
 <20191028222042.GB8532@willie-the-truck>
 <CAJs_Fx7zRWsTPiAg0PFt+8nJPpHpzSkxW6XMMJwozVO6vyB78A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e3fc88d9-4934-0227-d9c7-b1cb37a8811e@arm.com>
Date:   Mon, 28 Oct 2019 22:51:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAJs_Fx7zRWsTPiAg0PFt+8nJPpHpzSkxW6XMMJwozVO6vyB78A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-28 10:38 pm, Rob Clark wrote:
> On Mon, Oct 28, 2019 at 3:20 PM Will Deacon <will@kernel.org> wrote:
>>
>> Hi Rob,
>>
>> On Mon, Oct 07, 2019 at 01:49:06PM -0700, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> When games, browser, or anything using a lot of GPU buffers exits, there
>>> can be many hundreds or thousands of buffers to unmap and free.  If the
>>> GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
>>> for each buffer, resulting 5-10 seconds worth of reprogramming the
>>> context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
>>> To the user it would appear that the system just locked up.
>>>
>>> A simple solution is to use pm_runtime_put_autosuspend() instead, so we
>>> don't immediately suspend the SMMU device.
>>
>> Please can you reword the subject to be a bit more useful? The commit
>> message is great, but the subject is a bit like "fix bug in code" to me.
> 
> yeah, not the best $subject, but I wasn't quite sure how to fit
> something better in a reasonable # of chars.. maybe something like:
> "iommu/arm-smmu: optimize unmap but avoiding toggling runpm state"?

FWIW, I'd be inclined to frame it as something like "avoid pathological 
RPM behaviour for unmaps".

Robin.
