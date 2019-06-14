Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39095C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D0321537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfFNLxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:53:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:57180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727611AbfFNLxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:53:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E70AABD7;
        Fri, 14 Jun 2019 11:53:50 +0000 (UTC)
Subject: Re: [RFC PATCH 07/16] x86/xen: make vcpu_info part of xenhost_t
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-8-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <9f1323f4-06ae-93a5-c9b0-3b84ee549fa6@suse.com>
Date:   Fri, 14 Jun 2019 13:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-8-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Abstract out xen_vcpu_id probing via (*probe_vcpu_id)(). Once that is
> availab,e the vcpu_info registration happens via the VCPUOP hypercall.
> 
> Note that for the nested case, there are two vcpu_ids, and two vcpu_info
> areas, one each for the default xenhost and the remote xenhost.
> The vcpu_info is used via pv_irq_ops, and evtchn signaling.
> 
> The other VCPUOP hypercalls are used for management (and scheduling)
> which is expected to be done purely in the default hypervisor.
> However, scheduling of L1-guest does imply L0-Xen-vcpu_info switching,
> which might mean that the remote hypervisor needs some visibility
> into related events/hypercalls in the default hypervisor.

Another candidate for dropping due to layering violation, I guess.


Juergen
