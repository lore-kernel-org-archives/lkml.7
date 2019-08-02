Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBB2206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbfHBKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:54:01 -0400
Received: from foss.arm.com ([217.140.110.172]:49682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHBKyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:54:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49BF344;
        Fri,  2 Aug 2019 03:54:00 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44BBD3F71F;
        Fri,  2 Aug 2019 03:53:59 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:53:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tushar.2nov@gmail.com, morten_bp@live.dk, nd@arm.com,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Message-ID: <20190802105357.GF23424@e107155-lin>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:49:58AM -0500, Jassi Brar wrote:
> On Sun, Jul 21, 2019 at 4:58 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >

[...]

> > If the mhuv2 instance implements, say, 3 channel windows between
> > sender (linux) and receiver (firmware), and Linux runs two protocols
> > each requiring 1 and 2-word sized messages respectively. The hardware
> > supports that by assigning windows [0] and [1,2] to each protocol.
> > However, I don't think the driver can support that. Or does it?
> >
> Thinking about it, IMO, the mbox-cell should carry a 128 (4x32) bit
> mask specifying the set of windows (corresponding to the bits set in
> the mask) associated with the channel.
> And the controller driver should see any channel as associated with
> variable number of windows 'N', where N is [0,124]
>
> mhu_client1: proto1@2e000000 {
>        .....
>        mboxes = <&mbox 0x0 0x0 0x0 0x1>
> }
>
> mhu_client2: proto2@2f000000 {
>        .....
>        mboxes = <&mbox 0x0 0x0 0x0 0x6>
> }
>

This still doesn't address the overhead I mentioned in my arm_mhu_v1
series.

As per you suggestion, we will have one channel with all possible
bit mask value to specify the window. Let's imagine that 2 protocols
share the same channel, then the requests are serialised.
E.g. if bits 0 and 1 are allocated for say protocol#1 and bits 2 and 3
for protocol#2.

Further protocol#1 has higher latency requirements like sched-governor
DVFS and there are 3-4 pending requests on protocol#2, then the incoming
requests for protocol#1 is blocked.

This is definitely overhead and I have seen lots of issue around this
and hence I was requesting that we need to create individual channels
for each of these. Having abstraction on top to multiplex or arbitrate
won't help.

--
Regards,
Sudeep
