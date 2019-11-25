Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EEFC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BB82068F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfKYQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:13:39 -0500
Received: from foss.arm.com ([217.140.110.172]:52336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbfKYQNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:13:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F5A31B;
        Mon, 25 Nov 2019 08:13:38 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1BD3F6C4;
        Mon, 25 Nov 2019 08:13:37 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:13:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: avoid double free in error flow
Message-ID: <20191125161313.GA1157@bogus>
References: <20191125155409.9948-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125155409.9948-1-wenyang@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:54:09PM +0800, Wen Yang wrote:
> If device_register() fails, both put_device() and kfree()
> are called, ending with a double free of the scmi_dev.
>

Correct.

> Calling kfree() is needed only when a failure happens between the
> allocation of the scmi_dev and its registration, so move it to
> there and remove it from the error flow.
>

kstrdup_const can fail and in that case device is not yet registered,
so we need to free. Since device_register() calls put_device() on failure
too, I would just drop it as it's unnecessary, not sure why I have added
it in the first place. Can you re-spin the patch dropping put_device
and renaming put_dev label to something like free_const.

--
Regards,
Sudeep

