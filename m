Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD90C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583FD21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfH3PYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:24:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3PYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:24:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80A4C3CA19;
        Fri, 30 Aug 2019 15:24:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9CBC519C6A;
        Fri, 30 Aug 2019 15:24:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 30 Aug 2019 17:24:23 +0200 (CEST)
Date:   Fri, 30 Aug 2019 17:24:19 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov@parallels.com>,
        Kirill Tkhai <ktkhai@parallels.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
Message-ID: <20190830152419.GB2634@redhat.com>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830140805.GD13294@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 30 Aug 2019 15:24:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30, Russell King - ARM Linux admin wrote:
>
> which means that when probe_kernel_address() returns -EFAULT, the
> destination is left uninitialised.  In the case of
> task_rcu_dereference(), this means that "siginfo" can be used without
> having been initialised,

Yes, but this is fine, please see the long comment below (case 2).

If probe_kernel_address() fails, "sighand" is not initialized. but this
doesn't differ from the case when we inspect the random value if this
task_struct was freed, then reallocated as another thing, then freed and
reallocated as task_struct again.

Oleg.

