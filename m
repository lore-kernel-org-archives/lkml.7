Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63DC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF1B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l4aW6nnP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XtLSKjLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfFRNkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:40:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfFRNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:40:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A48F60A00; Tue, 18 Jun 2019 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560865231;
        bh=3S920kb9n9ahqKRzh5GewJNZfwKu57RH7nMn5VmTegs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l4aW6nnPwElZx+0tcypQKi7XbSu6KOxNtbIfky2jofdFgmEUfQqXjEwvRwQR24N7J
         +FEhGWq3Q+zdbl68+wCqqK8k5nNx3LJnItZEW2JDY6MmXoljFxjsq/A8ZJBuipwLlL
         XjLxPCa66cilnVCEN43ACwh0BSd2qbDkpY8KBZr8=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64D4060A00;
        Tue, 18 Jun 2019 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560865227;
        bh=3S920kb9n9ahqKRzh5GewJNZfwKu57RH7nMn5VmTegs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XtLSKjLWrLutIGH8KwFxjxolWP6E5fuG4T9J870AB6WdXIVg5pfxa4gyAyTQ7WTWp
         ahuSaYp9ihiEQVDisIqsmz0CUG6ePwoq2ECYZ/+o99JdQLHEuFKc1AI8/d/mLGOEDX
         hz8H/kQZWGOxB9+59FW14lzmDNMvtUPvvRDKcZ0I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64D4060A00
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH V4] perf: event preserve and create across cpu hotplug
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <1560337045-13298-1-git-send-email-mojha@codeaurora.org>
 <1560848091-15694-1-git-send-email-mojha@codeaurora.org>
 <20190618122329.GE3419@hirez.programming.kicks-ass.net>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <cc01dc2b-8992-cd95-e181-3400fc1ce82f@codeaurora.org>
Date:   Tue, 18 Jun 2019 19:10:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618122329.GE3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/18/2019 5:53 PM, Peter Zijlstra wrote:
> On Tue, Jun 18, 2019 at 02:24:51PM +0530, Mukesh Ojha wrote:
>> Perf framework doesn't allow preserving CPU events across
>> CPU hotplugs. The events are scheduled out as and when the
>> CPU walks offline. Moreover, the framework also doesn't
>> allow the clients to create events on an offline CPU. As
>> a result, the clients have to keep on monitoring the CPU
>> state until it comes back online.
>>
>> Therefore,
> That's not a therefore. There's a distinct lack of rationale here. Why
> do you want this?

Thanks Peter for coming back on this.

Missed to send the coverletter,
https://lkml.org/lkml/2019/5/31/438
Will resend this with coverletter.

Btw,  This patch

is based on suggestion given by you on this
https://lkml.org/lkml/2018/2/16/763


Thanks.
Mukesh


Thanks.
Mukesh

