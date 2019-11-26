Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401F8C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9D320862
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfKZKs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:48:59 -0500
Received: from foss.arm.com ([217.140.110.172]:32796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfKZKs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:48:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F88530E;
        Tue, 26 Nov 2019 02:48:58 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 766FF3F52E;
        Tue, 26 Nov 2019 02:48:57 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:48:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: avoid double free in error flow
Message-ID: <20191126104850.GA5784@bogus>
References: <20191125155409.9948-1-wenyang@linux.alibaba.com>
 <20191125161313.GA1157@bogus>
 <21f4f7d6-9085-382d-42d3-a63484aca8a2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21f4f7d6-9085-382d-42d3-a63484aca8a2@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 06:24:47PM +0800, Wen Yang wrote:
>
>
> On 2019/11/26 12:13 上午, Sudeep Holla wrote:
> > On Mon, Nov 25, 2019 at 11:54:09PM +0800, Wen Yang wrote:
> > > If device_register() fails, both put_device() and kfree()
> > > are called, ending with a double free of the scmi_dev.
> > >
> >
> > Correct.
> >
> > > Calling kfree() is needed only when a failure happens between the
> > > allocation of the scmi_dev and its registration, so move it to
> > > there and remove it from the error flow.
> > >
> >
> > kstrdup_const can fail and in that case device is not yet registered,
> > so we need to free. Since device_register() calls put_device() on failure
> > too, I would just drop it as it's unnecessary, not sure why I have added
> > it in the first place. Can you re-spin the patch dropping put_device
> > and renaming put_dev label to something like free_const.
> >

Please ignore the above completely. I have made some changes locally and
got completely confused when I looked at your patch and compared with
the modified context locally.

>
> Hi Sudeep,
> Thanks for your comments.
> Let's check the code like this:
>
> int device_register(struct device *dev)
> {
>         device_initialize(dev);   --> Initialize kobj-> kref to 1
>         return device_add(dev);
> }
>
> int device_add(struct device *dev)
> {
> ...
>         dev = get_device(dev);  --> kobj-> kref increases by 1
> ...
> done:
>         put_device(dev);  --> kobj-> kref decreases by 1 and is now 1
>         return error;
> ...
> }
>
> So we also need to call put_device (),
> and the original patch should be fine.
> Please kindly help to check again, thank you.
>

You are right, sorry for the confusion. I will apply your original patch.
Thanks again for the patch.

--
Regards,
Sudeep
