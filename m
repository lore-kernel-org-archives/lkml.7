Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB4C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B669223403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfH2Okk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfH2Oke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5CF3102504A;
        Thu, 29 Aug 2019 14:40:33 +0000 (UTC)
Received: from amt.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4731D5C1D6;
        Thu, 29 Aug 2019 14:40:33 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id B6F20105140;
        Thu, 29 Aug 2019 11:40:18 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x7TEeEe7014394;
        Thu, 29 Aug 2019 11:40:14 -0300
Date:   Thu, 29 Aug 2019 11:40:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v1] cpuidle-haltpoll: vcpu hotplug support
Message-ID: <20190829144011.GA14365@amt.cnet>
References: <20190828185650.16923-1-joao.m.martins@oracle.com>
 <20190829115634.GA4949@amt.cnet>
 <8c459d91-bc47-2ff4-7d3b-243ed4e466cb@oracle.com>
 <311c2ffe-f840-9990-c1a7-5561cc5a0f54@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311c2ffe-f840-9990-c1a7-5561cc5a0f54@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 29 Aug 2019 14:40:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 03:24:31PM +0100, Joao Martins wrote:
> On 8/29/19 2:50 PM, Joao Martins wrote:
> > On 8/29/19 12:56 PM, Marcelo Tosatti wrote:
> >> Hi Joao,
> >>
> >> On Wed, Aug 28, 2019 at 07:56:50PM +0100, Joao Martins wrote:
> >>> +static void haltpoll_uninit(void)
> >>> +{
> >>> +	unsigned int cpu;
> >>> +
> >>> +	cpus_read_lock();
> >>> +
> >>> +	for_each_online_cpu(cpu) {
> >>> +		struct cpuidle_device *dev =
> >>> +			per_cpu_ptr(haltpoll_cpuidle_devices, cpu);
> >>> +
> >>> +		if (!dev->registered)
> >>> +			continue;
> >>> +
> >>> +		arch_haltpoll_disable(cpu);
> >>> +		cpuidle_unregister_device(dev);
> >>> +	}
> >>
> >> 1)
> >>
> >>> +
> >>> +	cpuidle_unregister(&haltpoll_driver);
> >>
> >> cpuidle_unregister_driver.
> > 
> > Will fix -- this was an oversight.
> > 
> >>
> >>> +	free_percpu(haltpoll_cpuidle_devices);
> >>> +	haltpoll_cpuidle_devices = NULL;
> >>> +
> >>> +	cpus_read_unlock();
> >>
> >> Any reason you can't cpus_read_unlock() at 1) ?
> >>
> > No, let me adjust that too.
> > 
> >> Looks good otherwise.
> >>
> 
> BTW, should I take this as a Acked-by, Reviewed-by, or neither? :)
> 
> 	Joao

I'll ACK -v2 once you send it.

