Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9077C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806B0206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCAXnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:43:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34839 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:43:52 -0500
Received: from p5492e5b8.dip0.t-ipconnect.de ([84.146.229.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gzroi-0007wi-0G; Sat, 02 Mar 2019 00:43:48 +0100
Date:   Sat, 2 Mar 2019 00:43:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dongli Zhang <dongli.zhang@oracle.com>
cc:     xen-devel@lists.xenproject.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, jgross@suse.com, joe.jin@oracle.com,
        Herbert Van Den Bergh <herbert.van.den.bergh@oracle.com>,
        sboyd@kernel.org, john.stultz@linaro.org
Subject: Re: [BUG linux-4.9.x] xen hotplug cpu leads to 100% steal usage
In-Reply-To: <841bb9a9-1cba-483f-a353-1209684f7c74@default>
Message-ID: <alpine.DEB.2.21.1903020030320.1638@nanos.tec.linutronix.de>
References: <841bb9a9-1cba-483f-a353-1209684f7c74@default>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019, Dongli Zhang wrote:
> 
> The root cause is that the return type of jiffies_to_usecs() is 'unsigned int',
> but not 'unsigned long'. As a result, the leading 32 bits are discarded.

Errm. No. The root cause is that jiffies_to_usecs() is used for that in the
first place. The function has been that way forever and all usage sites
(except a broken dev_debug print in infiniband) feed delta values. Yes, it
could have documentation....

> jiffies_to_usecs() is indirectly triggered by cputime_to_nsecs() at line 264.
> If guest is already up for long time, the initial steal time for new vcpu might
> be large and the leading 32 bits of jiffies_to_usecs() would be discarded.

> So far, I have two solutions:
> 
> 1. Change the return type from 'unsigned int' to 'unsigned long' as in above
> link and I am afraid it would bring side effect. The return type in latest
> mainline kernel is still 'unsigned int'.

Changing it to unsigned long would just solve the issue for 64bit.

Thanks,

	tglx

