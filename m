Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FFCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0D1206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbfIVWcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:32:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34961 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfIVWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:32:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iC9bB-00016O-4Z; Sun, 22 Sep 2019 15:40:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iC9bA-0006lK-5E; Sun, 22 Sep 2019 15:40:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
        <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
        <20190917153830.GE1872@dhcp22.suse.cz>
        <87ftku96md.fsf@x220.int.ebiederm.org>
        <20190918071541.GB12770@dhcp22.suse.cz>
        <87h8585bej.fsf@x220.int.ebiederm.org>
        <20190922065801.GB18814@dhcp22.suse.cz>
        <f1b89360-a70c-0a30-6a7b-9bafe74701ed@gmx.de>
Date:   Sun, 22 Sep 2019 16:40:26 -0500
In-Reply-To: <f1b89360-a70c-0a30-6a7b-9bafe74701ed@gmx.de> (Heinrich
        Schuchardt's message of "Sun, 22 Sep 2019 17:31:16 +0200")
Message-ID: <875zlk2enp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iC9bA-0006lK-5E;;;mid=<875zlk2enp.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+dpU+wrMcpwUJyGndmWILCcP3mbhZWntQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: threads-max observe limits
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

> Did this patch when applied to the customer's kernel solve any problem?
>
> WebSphere MQ is a messaging application. If it hits the current limits
> of threads-max, there is a bug in the software or in the way that it has
> been set up at the customer. Instead of messing around with the kernel
> the application should be fixed.

While it is true that almost every workload will be buggy if it exceeds
1/8 of memory with just the kernel data structures for threads.  It is
not necessary true of every application.  I can easily imagine cases
up around 1/2 of memory where things could work reasonably.

Further we can exhaust all of memory much more simply in a default
configuration by malloc'ing more memory that in physically present
and zeroing it all.

Henrich, you were the one messed with the kernel by breaking a
reasonable kernel tunable.  AKA you caused a regression.  That violates
the no regression rule.

As much as possible we fix regressions so software that used to work
continues to work.  Removing footguns is not a reason to introduce a
regression.

I do agree that Michal's customer's problem sounds like it is something
else but if the kernel did not have a regression we could focus on the
real problem instead of being side tracked by the regression.

> With this patch you allow administrators to set values that will crash
> their system. And they will not even have a way to find out the limits
> which he should adhere to. So expect a lot of systems to be downed
> this way.

Nope.  The system administrator just setting a higher value whon't crash
their system.  Only using that many resources would crash the system.

Nor is a sysctl like this for discovering the physical limits of a
machine.  Which the current value is vastly inappropriate for.  As
the physical limits of many machines are much higher than 1/8 of memory.

Eric
