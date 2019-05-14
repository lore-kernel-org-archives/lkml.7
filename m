Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9540C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30E42147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENNy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENNy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:54:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A901F3097033;
        Tue, 14 May 2019 13:54:58 +0000 (UTC)
Received: from amt.cnet (ovpn-112-10.gru2.redhat.com [10.97.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F0F8608A7;
        Tue, 14 May 2019 13:54:56 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id B8E7F105174;
        Tue, 14 May 2019 10:50:25 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x4EDoNXN004704;
        Tue, 14 May 2019 10:50:23 -0300
Date:   Tue, 14 May 2019 10:50:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     kvm-devel <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] sched: introduce configurable delay before entering idle
Message-ID: <20190514135022.GD4392@amt.cnet>
References: <20190507185647.GA29409@amt.cnet>
 <CANRm+Cx8zCDG6Oz1m9eukkmx_uVFYcQOdMwZrHwsQcbLm_kuPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Cx8zCDG6Oz1m9eukkmx_uVFYcQOdMwZrHwsQcbLm_kuPA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 14 May 2019 13:54:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 05:20:37PM +0800, Wanpeng Li wrote:
> On Wed, 8 May 2019 at 02:57, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> >
> > Certain workloads perform poorly on KVM compared to baremetal
> > due to baremetal's ability to perform mwait on NEED_RESCHED
> > bit of task flags (therefore skipping the IPI).
> 
> KVM supports expose mwait to the guest, if it can solve this?
> 
> Regards,
> Wanpeng Li

Unfortunately mwait in guest is not feasible (uncompatible with multiple
guests). Checking whether a paravirt solution is possible.

