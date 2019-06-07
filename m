Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C73FC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0203208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfFGJd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:33:57 -0400
Received: from foss.arm.com ([217.140.110.172]:36516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfFGJd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:33:56 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 05:33:56 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF56828;
        Fri,  7 Jun 2019 02:25:19 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53B153F96A;
        Fri,  7 Jun 2019 02:25:18 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] arm64: Do not enable IRQs for ct_user_exit
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com, liwei391@huawei.com
References: <1559813517-41540-1-git-send-email-julien.thierry@arm.com>
 <1559813517-41540-2-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <96a0eb12-bbf2-0854-a5e7-25246327e3ec@arm.com>
Date:   Fri, 7 Jun 2019 10:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559813517-41540-2-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 06/06/2019 10:31, Julien Thierry wrote:
> For el0_dbg and el0_error, DAIF bits get explicitly cleared before
> calling ct_user_exit.
> 
> When context tracking is disabled, DAIF gets set (almost) immediately
> after. When context tracking is enabled, among the first things done
> is disabling IRQs.
> 
> What is actually needed is:
> - PSR.D = 0 so the system can be debugged (should be already the case)
> - PSR.A = 0 so async error can be handled during context tracking
> 
> Do not clear PSR.I in those two locations.

(last time I looked at this I wrongly assumed ct_user_exit() should be run with interrupts
masked, but that isn't what you're saying).

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
