Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A62C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27D220854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfCACI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:08:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46956 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfCACI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:08:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C3B114CCB49A;
        Thu, 28 Feb 2019 18:08:27 -0800 (PST)
Date:   Thu, 28 Feb 2019 18:08:24 -0800 (PST)
Message-Id: <20190228.180824.2041984657827980829.davem@davemloft.net>
To:     fruggeri@arista.com
Cc:     dsahern@gmail.com, yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru,
        maxim@arista.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: check net in ip6_call_ra_chain
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CA+HUmGhBBJ+bTdAQK0bAReW0-fFWRzrx73Og_9Qa9ftDhrUWRw@mail.gmail.com>
References: <20190228.130213.1481374802407995712.davem@davemloft.net>
        <171e33d9-ee82-6a62-693e-5d585e4eca28@gmail.com>
        <CA+HUmGhBBJ+bTdAQK0bAReW0-fFWRzrx73Og_9Qa9ftDhrUWRw@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 18:08:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Ruggeri <fruggeri@arista.com>
Date: Thu, 28 Feb 2019 16:09:17 -0800

> On Thu, Feb 28, 2019 at 3:31 PM David Ahern <dsahern@gmail.com> wrote:
>>
>> On 2/28/19 2:02 PM, David Miller wrote:
>> > From: fruggeri@arista.com (Francesco Ruggeri)
>> > Date: Thu, 28 Feb 2019 11:01:46 -0800
>> >
>> >> ip6_call_ra_chain is called when IPv6 packet with Router Alert option
>> >> is forwarded.
>> >> It needs to check if the net of the socket is the same as the net of the
>> >> input device, otherwise the packet gets delivered to every IPv6 socket
>> >> listening for Router Alerts, no matter which network namespace it is in.
>> >>
>> >> Suggested-by: Maxim Martynov <maxim@arista.com>
>> >> Signed-off-by: Maxim Martynov <maxim@arista.com>
>> >> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
>> >
>> > Right now someone using such a tool does get all RAs in the system.
>> >
>> > Your change not only breaks them, but also gives them no method by
>> > which to keep obtaining the same behavior.
>> >
>> > I don't know what to do or suggest in this situation, but right now
>> > I'm putting this patch on hold.
>> >
>>
>> need an equivalent to NETLINK_LISTEN_ALL_NSID
> 
> If that would be acceptable, we can look into it.

It is.
