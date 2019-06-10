Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCD7C31E74
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FC920859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbfFJOeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31491 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389851AbfFJOeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:34:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5ABA590C87;
        Mon, 10 Jun 2019 14:34:23 +0000 (UTC)
Received: from flask (unknown [10.43.2.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5DBDA19C59;
        Mon, 10 Jun 2019 14:34:21 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Mon, 10 Jun 2019 16:34:20 +0200
Date:   Mon, 10 Jun 2019 16:34:20 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/3] KVM: Yield to IPI target if necessary
Message-ID: <20190610143420.GA6594@flask>
References: <1559178307-6835-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559178307-6835-1-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 10 Jun 2019 14:34:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-05-30 09:05+0800, Wanpeng Li:
> The idea is from Xen, when sending a call-function IPI-many to vCPUs, 
> yield if any of the IPI target vCPUs was preempted. 17% performance 
> increasement of ebizzy benchmark can be observed in an over-subscribe 
> environment. (w/ kvm-pv-tlb disabled, testing TLB flush call-function 
> IPI-many since call-function is not easy to be trigged by userspace 
> workload).

Have you checked if we could gain performance by having the yield as an
extension to our PV IPI call?

It would allow us to skip the VM entry/exit overhead on the caller.
(The benefit of that might be negligible and it also poses a
 complication when splitting the target mask into several PV IPI
 hypercalls.)

Thanks.
