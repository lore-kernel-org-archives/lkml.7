Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83EECA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A835B21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390352AbfJWI3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:29:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48116 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390339AbfJWI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:29:22 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNC17-0005Up-55; Wed, 23 Oct 2019 10:29:17 +0200
Date:   Wed, 23 Oct 2019 10:29:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wanpeng Li <kernellwp@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, kvm <kvm@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] sched/nohz: Optimize get_nohz_timer_target()
In-Reply-To: <CANRm+CxUpwZ9KwOcQp=Ok64giyjjcJOGb2=zU6vayQzLqYvpXQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910231028250.2308@nanos.tec.linutronix.de>
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com> <20190628011012.GA19488@lerouge> <CANRm+CxUpwZ9KwOcQp=Ok64giyjjcJOGb2=zU6vayQzLqYvpXQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Wanpeng Li wrote:
> I didn't see your refactor to get_nohz_timer_target() which you
> mentioned in IRC after four months, I can observe cyclictest drop from
> 4~5us to 8us in kvm guest(we offload the lapic timer emulation to
> housekeeping cpu to avoid timer fire external interrupt on the pCPU
> which vCPU resident incur a vCPU vmexit) w/o this patch in the case of
> there is no busy housekeeping cpu. The score can be recovered after I
> give stress to create a busy housekeeping cpu.
> 
> Could you consider applying this patch for temporary since I'm not
> sure when the refactor can be ready.

Yeah. It's delayed (again).... Will pick that up.

Thanks,

	tglx
