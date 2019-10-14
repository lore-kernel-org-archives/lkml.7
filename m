Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA2ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0131C21848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbfJNQ5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:57:49 -0400
Received: from foss.arm.com ([217.140.110.172]:49048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJNQ5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:57:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09EFC28;
        Mon, 14 Oct 2019 09:57:48 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D09D3F718;
        Mon, 14 Oct 2019 09:57:47 -0700 (PDT)
Subject: Re: [PATCH] arm64: cpufeature: Don't expose ZFR0 to userspace when
 SVE is not enabled
To:     Will Deacon <will@kernel.org>, Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, Dave.Martin@arm.com
References: <20191014102113.16546-1-julien.grall@arm.com>
 <20191014164313.hu2dnf5rokntzhhp@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <223c22d0-cfe3-4aed-6a8f-b80e44cb6548@arm.com>
Date:   Mon, 14 Oct 2019 17:57:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014164313.hu2dnf5rokntzhhp@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/2019 17:43, Will Deacon wrote:
> On Mon, Oct 14, 2019 at 11:21:13AM +0100, Julien Grall wrote:
>> The kernel may not support SVE if CONFIG_ARM64_SVE is not set and
>> will hide the feature from the from userspace.
> 
> I don't understand this sentence.
> 
>> Unfortunately, the fields of ID_AA64ZFR0_EL1 are still exposed and could
>> lead to undefined behavior in userspace.
> 
> Undefined in what way? Generally, we can't stop exposing things that
> we've exposed previously in case somebody has started relying on them, so
> this needs better justification.

We still expose them with this patch, but zero them out, if the SVE is not
supported. When SVE is enabled, we expose them as usual.

Cheers
Suzuki
