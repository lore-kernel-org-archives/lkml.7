Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF739C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD99C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NFUEa1xO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iopALxqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfEWNJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:09:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:09:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 53F4C6087A; Thu, 23 May 2019 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558616976;
        bh=wfXAsv/D6tc2pz76WMJTOlgUtKHJzRfaFaV69eXWLao=;
        h=From:Subject:To:Cc:Date:From;
        b=NFUEa1xOwYbpvtJfzWND+VGOOYp1tN57Zc4ZHjSuQAy1iJOnLx3GKtTGc0oUEClk4
         A3aAJRZ4N4fw4VciptE5e8rGw8m8xwPZkNekzOVvhUrMuraqexA8QXK0VFeyq2O531
         8aEOkVKbN6KBlEWaOeUjQrogrCcZpkWse6XjfCTo=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4467260388;
        Thu, 23 May 2019 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558616975;
        bh=wfXAsv/D6tc2pz76WMJTOlgUtKHJzRfaFaV69eXWLao=;
        h=From:Subject:To:Cc:Date:From;
        b=iopALxqe4UjLh7YxbAj5A2jLZNrr7riwpgd9nw81qmTPOULMuNSxSMwNC+u2Imrcq
         0EYcBwFoIfM8MKZgXBdE/GwKCVscxOfrdajjSnxiM8isL4qyIjsWxT38t7T/XwDX/b
         FIjOIWB03H2wCu9QRO4L3htvfNO5A8b5+bT4EaGU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4467260388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
Subject: Perf: Preserving the event across CPU hotunplug/plug and Creation of
 an event on offine CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <b94d3165-9870-9aa3-f76c-38383b649398@codeaurora.org>
Date:   Thu, 23 May 2019 18:39:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter/All,

This is regarding the discussion happen in the past about 
https://lkml.org/lkml/2018/2/15/1324

Where the exact ask is to allow preserving and creation of events on a 
offline CPU, so that when the CPU
comes online it will start counting.

I had a look at your patch too and resolve crash during while trying to 
create an event on an offline cpu.

In your patch,  you seem to disable event when cpu goes offline which is 
exactly deleting the event
from the pmu and add when it comes online, it seems to  work.

But, For the purpose of allowing the creation of event while CPU is 
offline is not able to count event while
CPU coming online, for that i did some change, that did work.

Also, I have query about the events which gets destroyed while CPU is 
offline and we need to remove them
once cpu comes online right ? As Raghavendra also queried the same in 
the above thread.

Don't we need  a list where we maintain the events which gets destroyed 
while CPU is dead ?
and clean it  up when CPU comes online ?

Thanks.
Mukesh


