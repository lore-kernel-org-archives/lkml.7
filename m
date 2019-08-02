Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45323C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1617E217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404221AbfHBNak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfHBNYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDD0E307D90E;
        Fri,  2 Aug 2019 13:24:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id E9F0560BF4;
        Fri,  2 Aug 2019 13:24:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Aug 2019 15:24:22 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:24:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802132419.GD20111@redhat.com>
References: <20190731161223.2928-1-areber@redhat.com>
 <20190731174135.GA30225@redhat.com>
 <20190802072511.GD18263@dcbz.redhat.com>
 <20190802124738.GC20111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802124738.GC20111@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 13:24:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02, Oleg Nesterov wrote:
>
> On 08/02, Adrian Reber wrote:
> >
> > On Wed, Jul 31, 2019 at 07:41:36PM +0200, Oleg Nesterov wrote:
> > > But the main question is how it can really help if ns->level > 0, unlikely
> > > CRIU will ever need to clone the process with the same pid_nr == set_tid
> > > in the ns->parent chain.
> >
> > Not sure I understand what you mean. For CRIU only the PID in the PID
> > namespace is relevant.
>
> If it runs "inside" this namespace. But in this case alloc_pid() should
> use nr == set_tid only once in the main loop, when i == ns->level.

and I just noticed that your patch does exactly this, it clears set_tid
after the 1st usage when i == ns->level.

> > > So may be kernel_clone_args->set_tid should be pid_t __user *set_tid_array?
> > > Or I missed something ?
> >
> > Not sure why and how an array would be needed. Could you give me some
> > more details why you think this is needed.
>
> IIURC, criu can restore the process tree along with nested pid namespaces.
>
> how can this patch help in this case?
>
> But again, perhaps I missed something. I forgot everything about criu.

Yes... I guess in this case it can "safely" modify ns_last_pid in the child
namespaces it needs to create.

So Adrian, sorry for confusion, I think your patch is fine.

Oleg.

