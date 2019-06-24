Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE21C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835CC2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QIxBzdD/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AAcZTumw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfFXJB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:01:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfFXJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:01:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C5F7608CE; Mon, 24 Jun 2019 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561366915;
        bh=TCxv8TQyBC46O+qBSiNWtgfVmJXuBSeMKHPfHa3q+WU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=QIxBzdD/ULclg/U2JvANvWDVBDbW+VYiP8BvVMOwp4dGijlIsKgDGT/RgHe2D8Qmk
         jDd/DR41Oj70LI1z/5+x96JbmreN0QGgZQ9X0VsQSKqF/4r0G/Y4jNTqihxIYnQgFP
         1s1j15xc/JTy41WGoJsx0RgGswEMrdy8CaMIiPgE=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4936608CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561366914;
        bh=TCxv8TQyBC46O+qBSiNWtgfVmJXuBSeMKHPfHa3q+WU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AAcZTumwXl2ZwiM2jz8Qy0MF8RItT30zRS7ahMfMfKurXIcZo2RvB5Hhn6dT62lNv
         d5bAxLQbQyg4LSTZ7+tf9fKgqKzwATGWW+gSIaCtv5B1DPIpOeKfo9Yy+LJk884Vpm
         4QquMPDVxBZYRtIMfjisfTkvfrPnEuLLW8QB/00k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4936608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH RESEND V4 0/1] perf: Add CPU hotplug support for events
To:     lkml <linux-kernel@vger.kernel.org>
References: <1560848091-15694-1-git-send-email-mojha@codeaurora.org>
 <1560865617-7881-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8becbdff-6924-29d8-304a-8382e8fdb2d3@codeaurora.org>
Date:   Mon, 24 Jun 2019 14:31:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1560865617-7881-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

On 6/18/2019 7:16 PM, Mukesh Ojha wrote:
> The embedded world, specifically Android mobile SoCs, rely on CPU
> hotplugs to manage power and thermal constraints. These hotplugs
> can happen at a very rapid pace. Adjacently, they also relies on
> many perf event counters for its management. Therefore, there is
> a need to preserve these events across hotplugs.
>
> In such a scenario, a perf client (kernel or user-space) can create
> events even when the CPU is offline. If the CPU comes online during
> the lifetime of the event, the registered event can start counting
> spontaneously. As an extension to this, the events' count can also
> be preserved across CPU hotplugs. This takes the burden off of the
> clients to monitor the state of the CPU.
>
> The tests were conducted on arm64 device.
> /* CPU-1 is offline: Event created when CPU1 is offline */
>
> / # cat /sys/devices/system/cpu/cpu1/online
> 1
> / # echo 0 > /sys/devices/system/cpu/cpu1/online
>
> Test used for testing
> #!/bin/sh
>
> chmod +x *
>
> # Count the cycles events on cpu-1 for every 200 ms
> ./perf stat -e cycles -I 200 -C 1 &
>
> # Make the CPU-1 offline and online continuously
> while true; do
>          sleep 2
>          echo 0 > /sys/devices/system/cpu/cpu1/online
>          sleep 2
>          echo 1 > /sys/devices/system/cpu/cpu1/online
> done
>
> Results:
> / # ./test.sh
> #           time             counts unit events
>       0.200145885      <not counted>      cycles
>       0.410115208      <not counted>      cycles
>       0.619922551      <not counted>      cycles
>       0.829904635      <not counted>      cycles
>       1.039751614      <not counted>      cycles
>       1.249547603      <not counted>      cycles
>       1.459228280      <not counted>      cycles
>       1.665606561      <not counted>      cycles
>       1.874981926      <not counted>      cycles
>       2.084297811      <not counted>      cycles
>       2.293471249      <not counted>      cycles
>       2.503231561      <not counted>      cycles
>       2.712993332      <not counted>      cycles
>       2.922744478      <not counted>      cycles
>       3.132502186      <not counted>      cycles
>       3.342255050      <not counted>      cycles
>       3.552010102      <not counted>      cycles
>       3.761760363      <not counted>      cycles
>
>      /* CPU-1 made online: Event started counting */
>
>       3.971459269            1925429      cycles
>       4.181325206           19391145      cycles
>       4.391074164             113894      cycles
>       4.599130519            3150152      cycles
>       4.805564737             487122      cycles
>       5.015164581             247533      cycles
>       5.224764529             103622      cycles
> #           time             counts unit events
>       5.434360831             238179      cycles
>       5.645293799             238895      cycles
>       5.854909320             367543      cycles
>       6.064487966            2383428      cycles
>
>       /* CPU-1 made offline: counting stopped
>
>       6.274289476      <not counted>      cycles
>       6.483493903      <not counted>      cycles
>       6.693202705      <not counted>      cycles
>       6.902956195      <not counted>      cycles
>       7.112714268      <not counted>      cycles
>       7.322465570      <not counted>      cycles
>       7.532222340      <not counted>      cycles
>       7.741975830      <not counted>      cycles
>       7.951686246      <not counted>      cycles
>
>      /* CPU-1 made online: Event started counting
>
>       8.161469892           22040750      cycles
>       8.371219528             114977      cycles
>       8.580979111             259952      cycles
>       8.790757132             444661      cycles
>       9.000559215             248512      cycles
>       9.210385256             246590      cycles
>       9.420187704             243819      cycles
>       9.630052287            7102438      cycles
>       9.839848225             337454      cycles
>      10.049645048             644072      cycles
>      10.259476246            1855410      cycles
>
> Mukesh Ojha (1):
>    perf: event preserve and create across cpu hotplug
>
>   include/linux/perf_event.h |   1 +
>   kernel/events/core.c       | 122 +++++++++++++++++++++++++++++----------------
>   2 files changed, 79 insertions(+), 44 deletions(-)
>
