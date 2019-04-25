Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86754C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552172084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfDYLW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:22:59 -0400
Received: from mx.ungleich.ch ([185.203.112.16]:40238 "EHLO smtp.ungleich.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDYLW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:22:59 -0400
Received: from nico.schottelius.org (localhost [IPv6:::1])
        by smtp.ungleich.ch (Postfix) with ESMTP id 0FC651FF02;
        Thu, 25 Apr 2019 13:22:57 +0200 (CEST)
Received: by nico.schottelius.org (Postfix, from userid 1000)
        id F2EBC1A0100C; Thu, 25 Apr 2019 13:22:56 +0200 (CEST)
References: <87pnpaqvk9.fsf@line.ungleich.ch> <20190425103033.GA20813@angband.pl>
User-agent: mu4e 1.0; emacs 26.1
From:   Nico Schottelius <nico-kernel-20190425@schottelius.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: How to turn off IPv4 without disabling IPv6
In-reply-to: <20190425103033.GA20813@angband.pl>
Date:   Thu, 25 Apr 2019 13:22:56 +0200
Message-ID: <87mukeqqgf.fsf@line.ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Adam,

thanks for the fast response.


Adam Borowski <kilobyte@angband.pl> writes:

> On Thu, Apr 25, 2019 at 11:32:38AM +0200, Nico Schottelius wrote:
>> running some IPv6 only
>> networks. The systems in the IPv6 only networks do not need any IPv4
>> support anymore and thus for switches/routers we turned the support off.
>
>> Today we tried to turn off IPv4 in the Linux kernel at compile time.
>> But it seems that as soon as we turn off CONFIG_INET, CONFIG_IPV6 is
>> automatically turned off as well.
>
> Even if you don't want global nor even link-scope IPv4, way too many
> programs assume that at least 127.0.0.1 (ie, lo) is working.  They can't be
> reconfigured to use ::1 without patching and rebuilding.

I think we have to distinguish here between 2 kinds of programs:

- stuff that listen()s
- stuff that connect()s

Afaics, the latter does not need any lo connectivity, neither v4 nor
v6. It will use whatever IP address the kernel chooses for outgoing
connections.

For the former, I agree that there might be software that actually
fails without having 127.0.0.1. However, if they bind to 0.0.0.0, the
software will actually not work in IPv6 only network anyway.

The big problem here is:

if I cannot turn off IPv4, I cannot test what needs to be fixed.

> [...]
> That's an extra moving part where there was none before.  Complexity is bad.
> Having the IPv4 stack built just for the lo interface simplifies
> things.

I tend to disagree with this statement: turning off IPv4 first off all
reduces complexity. You can even fully get rid of ARP. Yes, there will
be the need for some changes / updates, but all of this can only be
spotted once IPv4 is turned off.

Best,

Nico

--
Your Swiss, Open Source and IPv6 Virtual Machine. Now on www.datacenterlight.ch.
