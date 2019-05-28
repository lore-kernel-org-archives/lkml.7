Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CE4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42F921721
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m6MP/xrw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hvwoMvcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfE1QRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:17:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1QQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:16:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 387BF6188E; Tue, 28 May 2019 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559060219;
        bh=NZZxhr/Jde6iwR3plkTJWmJgNv290hmJqEH8yoF/dOE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=m6MP/xrw8LbKlYy3Am484x8NVoogtjAdQFQ+SzkWdvbl79o3tCdAqu7ogk7klXSZz
         pXmW1gxlX3iPEFqgdD27SqqldFkWvqOHTiDLCW3gu/1U3ZIobYyrMLjSUZLR9f5PYz
         eehn9QsUmbMDxqS2cJyYV7o8j9xS2Z3+XnMoct+c=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 582FC61B6A;
        Tue, 28 May 2019 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559060212;
        bh=NZZxhr/Jde6iwR3plkTJWmJgNv290hmJqEH8yoF/dOE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=hvwoMvcFHdinPmCvtky2U3w5mqiaWtS3H3yzP01VpBZSHg5+52w1o8bVxGgUvjUpT
         eCQSnnm4+T4wXCp8co+a46KYttuBX5oKproWtJfqnbIAzPkbAIM+kmBVPEk5XyswvU
         b85ufxgfXFz5Wv3xExY6mZ3L43Yp3fJM+6TKoDag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 582FC61B6A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: Perf: Preserving the event across CPU hotunplug/plug and Creation
 of an event on offine CPU
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <b94d3165-9870-9aa3-f76c-38383b649398@codeaurora.org>
Message-ID: <4f276f87-b6d8-f868-b3e7-9951d1383070@codeaurora.org>
Date:   Tue, 28 May 2019 21:46:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b94d3165-9870-9aa3-f76c-38383b649398@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly Ping.


On 5/23/2019 6:39 PM, Mukesh Ojha wrote:
> Hi Peter/All,
>
> This is regarding the discussion happen in the past about 
> https://lkml.org/lkml/2018/2/15/1324
>
> Where the exact ask is to allow preserving and creation of events on a 
> offline CPU, so that when the CPU
> comes online it will start counting.
>
> I had a look at your patch too and resolve crash during while trying 
> to create an event on an offline cpu.
>
> In your patch,  you seem to disable event when cpu goes offline which 
> is exactly deleting the event
> from the pmu and add when it comes online, it seems to  work.
>
> But, For the purpose of allowing the creation of event while CPU is 
> offline is not able to count event while
> CPU coming online, for that i did some change, that did work.
>
> Also, I have query about the events which gets destroyed while CPU is 
> offline and we need to remove them
> once cpu comes online right ? As Raghavendra also queried the same in 
> the above thread.
>
> Don't we need  a list where we maintain the events which gets 
> destroyed while CPU is dead ?
> and clean it  up when CPU comes online ?
>
> Thanks.
> Mukesh
>
>
