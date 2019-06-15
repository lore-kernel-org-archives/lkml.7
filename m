Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BC2C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4F421473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFODyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 23:54:14 -0400
Received: from namei.org ([65.99.196.166]:39348 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfFODyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 23:54:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5F3rkli004852;
        Sat, 15 Jun 2019 03:53:46 GMT
Date:   Fri, 14 Jun 2019 20:53:46 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     "Lubashev, Igor" <ilubashe@akamai.com>
cc:     Serge Hallyn <serge@hallyn.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/1] security: add SECURE_KEEP_FSUID to preserve
 fsuid/fsgid across execve
In-Reply-To: <720751180a9543cfa205cd527248df7c@ustx2ex-dag1mb5.msg.corp.akamai.com>
Message-ID: <alpine.LRH.2.21.1906142049480.3646@namei.org>
References: <1560473087-27754-1-git-send-email-ilubashe@akamai.com> <alpine.LRH.2.21.1906141445010.7150@namei.org> <720751180a9543cfa205cd527248df7c@ustx2ex-dag1mb5.msg.corp.akamai.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2019, Lubashev, Igor wrote:

> > On Friday, June 14, 2019, James Morris wrote:

> Unfortunately, perf is using uid==0 and euid==0 as a "capability bits".
>
> 
> In tools/perf/util/evsel.c:
> 	static bool perf_event_can_profile_kernel(void)
> 	{
> 		return geteuid() == 0 || perf_event_paranoid() == -1;
> 	}
> 
> In tools/perf/util/symbol.c:
> 	static bool symbol__read_kptr_restrict(void)
> 	{
> 	...
> 		value = ((geteuid() != 0) || (getuid() != 0)) ?
> 				(atoi(line) != 0) :
> 				(atoi(line) == 2);
> 	...
> 	}

These are bugs. They should be checking for CAP_SYS_ADMIN.


> 
> > Have you considered the example security configuration in
> > Documentation/admin-guide/perf-security.rst ?
> 
> Unfortunately, this configuration does not work, unless you reset 
> /proc/sys/kernel/perf_event_paranoid to a permissive level (see code 
> above). We have perf_event_paranoid set to 2. If it worked, we could had 
> implemented the same capability-based policy in the wrapper.

This is not necessary for a process which has CAP_SYS_ADMIN.


-- 
James Morris
<jmorris@namei.org>

