Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83082C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F853217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391807AbfHBNaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:30:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404019AbfHBNaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BF773086222;
        Fri,  2 Aug 2019 13:30:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E74C60BF7;
        Fri,  2 Aug 2019 13:30:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Aug 2019 15:30:12 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:30:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802133001.GE20111@redhat.com>
References: <20190731161223.2928-1-areber@redhat.com>
 <20190802131943.hkvcssv74j25xmmt@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802131943.hkvcssv74j25xmmt@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 02 Aug 2019 13:30:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02, Christian Brauner wrote:
>
> On Wed, Jul 31, 2019 at 06:12:22PM +0200, Adrian Reber wrote:
> > The main motivation to add CLONE_SET_TID to clone3() is CRIU.
> >
> > To restore a process with the same PID/TID CRIU currently uses
> > /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> > ns_last_pid and then (quickly) does a clone(). This works most of the
> > time, but it is racy. It is also slow as it requires multiple syscalls.
>
> Can you elaborate how this is racy, please. Afaict, CRIU will always
> usually restore in a new pid namespace that it controls, right?

Why? No. For example you can checkpoint (not sure this is correct word)
a single process in your namespace, then (try to restore) it. 

> What is
> the exact race?

something else in the same namespace can fork() right after criu writes
the pid-for-restore into ns_last_pid.

Oleg.

