Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BDAC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EB2206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YUIjQlO8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MroH+pOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGZJGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:06:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:06:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51BEF602F5; Fri, 26 Jul 2019 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564131996;
        bh=GKjKfqyAh4cCg4+6N91NJvwSKC6Qu5ao+iivvHJtC6Q=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=YUIjQlO8ilnDXgutsoVkzHgSV88P8urhYlhxjYXvXUqtGB7O4ESWRRiSBhMnDJkJJ
         B+98kfPkxKkD05ADCUbC1oOYJsk2uIajYJ4uokuEoIhgWPZJF8AxjjeqZxvW3PW2E/
         fiH3OtJJudiy/uLWkDztJalvgeB7fZHzw/QEHaeg=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64918602B7;
        Fri, 26 Jul 2019 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564131995;
        bh=GKjKfqyAh4cCg4+6N91NJvwSKC6Qu5ao+iivvHJtC6Q=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=MroH+pOCY/ucecR5eM6PPFpOONutxzd6qqYXf7lmbB5aYutG3pQeyv1twAytxvNFx
         NoSUYw/PVmA27WuhB3cZp/LqyV0IcdyGgG4E2UAZtw9pZj4AL3jvcNAOaKD9ghUdI6
         Cim+qntonu7h4DY7EVr961g2IKfOSMOjpbcG3Xhw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64918602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH RESEND V4 0/1] perf: Add CPU hotplug support for events
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org
References: <1560848091-15694-1-git-send-email-mojha@codeaurora.org>
 <1560865617-7881-1-git-send-email-mojha@codeaurora.org>
 <8becbdff-6924-29d8-304a-8382e8fdb2d3@codeaurora.org>
Message-ID: <ce9626af-7f11-a556-1281-267b9f4422b4@codeaurora.org>
Date:   Fri, 26 Jul 2019 14:36:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8becbdff-6924-29d8-304a-8382e8fdb2d3@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Can you please review this ?

Thanks,
Mukesh

On 6/24/2019 2:31 PM, Mukesh Ojha wrote:
> Friendly ping.
>
> On 6/18/2019 7:16 PM, Mukesh Ojha wrote:
>> The embedded world, specifically Android mobile SoCs, rely on CPU
>> hotplugs to manage power and thermal constraints. These hotplugs
>> can happen at a very rapid pace. Adjacently, they also relies on
>> many perf event counters for its management. Therefore, there is
>> a need to preserve these events across hotplugs.
>>
>> In such a scenario, a perf client (kernel or user-space) can create
>> events even when the CPU is offline. If the CPU comes online during
>> the lifetime of the event, the registered event can start counting
>> spontaneously. As an extension to this, the events' count can also
>> be preserved across CPU hotplugs. This takes the burden off of the
>> clients to monitor the state of the CPU.
>>
>> The tests were conducted on arm64 device.
>> /* CPU-1 is offline: Event created when CPU1 is offline */
>>
>> / # cat /sys/devices/system/cpu/cpu1/online
>> 1
>> / # echo 0 > /sys/devices/system/cpu/cpu1/online
>>
>> Test used for testing
>> #!/bin/sh
>>
>> chmod +x *
>>
>> # Count the cycles events on cpu-1 for every 200 ms
>> ./perf stat -e cycles -I 200 -C 1 &
>>
>> # Make the CPU-1 offline and online continuously
>> while true; do
>>          sleep 2
>>          echo 0 > /sys/devices/system/cpu/cpu1/online
>>          sleep 2
>>          echo 1 > /sys/devices/system/cpu/cpu1/online
>> done
>>
>> Results:
>> / # ./test.sh
>> #           time             counts unit events
>>       0.200145885      <not counted>      cycles
>>       0.410115208      <not counted>      cycles
>>       0.619922551      <not counted>      cycles
>>       0.829904635      <not counted>      cycles
>>       1.039751614      <not counted>      cycles
>>       1.249547603      <not counted>      cycles
>>       1.459228280      <not counted>      cycles
>>       1.665606561      <not counted>      cycles
>>       1.874981926      <not counted>      cycles
>>       2.084297811      <not counted>      cycles
>>       2.293471249      <not counted>      cycles
>>       2.503231561      <not counted>      cycles
>>       2.712993332      <not counted>      cycles
>>       2.922744478      <not counted>      cycles
>>       3.132502186      <not counted>      cycles
>>       3.342255050      <not counted>      cycles
>>       3.552010102      <not counted>      cycles
>>       3.761760363      <not counted>      cycles
>>
>>      /* CPU-1 made online: Event started counting */
>>
>>       3.971459269            1925429      cycles
>>       4.181325206           19391145      cycles
>>       4.391074164             113894      cycles
>>       4.599130519            3150152      cycles
>>       4.805564737             487122      cycles
>>       5.015164581             247533      cycles
>>       5.224764529             103622      cycles
>> #           time             counts unit events
>>       5.434360831             238179      cycles
>>       5.645293799             238895      cycles
>>       5.854909320             367543      cycles
>>       6.064487966            2383428      cycles
>>
>>       /* CPU-1 made offline: counting stopped
>>
>>       6.274289476      <not counted>      cycles
>>       6.483493903      <not counted>      cycles
>>       6.693202705      <not counted>      cycles
>>       6.902956195      <not counted>      cycles
>>       7.112714268      <not counted>      cycles
>>       7.322465570      <not counted>      cycles
>>       7.532222340      <not counted>      cycles
>>       7.741975830      <not counted>      cycles
>>       7.951686246      <not counted>      cycles
>>
>>      /* CPU-1 made online: Event started counting
>>
>>       8.161469892           22040750      cycles
>>       8.371219528             114977      cycles
>>       8.580979111             259952      cycles
>>       8.790757132             444661      cycles
>>       9.000559215             248512      cycles
>>       9.210385256             246590      cycles
>>       9.420187704             243819      cycles
>>       9.630052287            7102438      cycles
>>       9.839848225             337454      cycles
>>      10.049645048             644072      cycles
>>      10.259476246            1855410      cycles
>>
>> Mukesh Ojha (1):
>>    perf: event preserve and create across cpu hotplug
>>
>>   include/linux/perf_event.h |   1 +
>>   kernel/events/core.c       | 122 
>> +++++++++++++++++++++++++++++----------------
>>   2 files changed, 79 insertions(+), 44 deletions(-)
>>
