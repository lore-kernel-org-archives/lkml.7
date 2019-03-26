Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44000C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1723E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCZJ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:26:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfCZJ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:26:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E49C52D7EB;
        Tue, 26 Mar 2019 09:26:10 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2BF82636E;
        Tue, 26 Mar 2019 09:26:08 +0000 (UTC)
Date:   Tue, 26 Mar 2019 10:26:07 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] timekeeping: Force upper bound for setting CLOCK_REALTIME
Message-ID: <20190326092607.GE14186@localhost>
References: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 26 Mar 2019 09:26:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 11:36:19AM +0100, Thomas Gleixner wrote:
> It is reasonable to force an upper bound for the various methods of setting
> CLOCK_REALTIME. Year 2262 is the absolute upper bound. Assume a maximum
> uptime of 30 years which is plenty enough even for esoteric embedded
> systems. That results in an upper bound of year 2232 for setting the time.

The patch looks good to me.

I like this approach better than using a larger value closer to the
overflow (e.g. one week) and stepping the clock back automatically
when the clock reaches that time, but I suspect it might possibly
break more tests (or any unusual applications messing with time) as a
much larger interval is now EINVAL.

Thanks,

-- 
Miroslav Lichvar
