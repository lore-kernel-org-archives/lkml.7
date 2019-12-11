Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F82C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A01D206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gO/JxjeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfLKUho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:37:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726242AbfLKUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576096662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vDUOH0NL2++sNq8ly9oZ+vSwQKreWmMi7WXNmKRknE=;
        b=gO/JxjeHYpoyEnAbhNmsd/ztYVfT8wP6MP48oMUQR2CIT4h6puOdnUjSIaqJbFGM+kulXa
        EydpJcoW/yo5sSog5gPMBZXQPGsyMV+79MAEWYgJDakEQcAmWZOT4b/kHmPQqxYRvg5PKR
        veCYIJcpb0hD/sZsfo3OxUDc5IjAfXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-6yr6dRIEPVy6laS1jeqZIA-1; Wed, 11 Dec 2019 15:37:38 -0500
X-MC-Unique: 6yr6dRIEPVy6laS1jeqZIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DD9C18AAFC9;
        Wed, 11 Dec 2019 20:37:37 +0000 (UTC)
Received: from ovpn-116-192.phx2.redhat.com (ovpn-116-192.phx2.redhat.com [10.3.116.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB32D5C219;
        Wed, 11 Dec 2019 20:37:36 +0000 (UTC)
Message-ID: <e525584892b7f3a707ddfe32870e6128f888cefd.camel@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <b56f988176fca4f13c310b9dc866baf5408eeadd.camel@redhat.com>
References: <20191028150716.22890-1-frederic@kernel.org>
         <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
         <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
         <20191030133130.GY4097@hirez.programming.kicks-ass.net>
         <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
         <alpine.DEB.2.21.1911042315390.17054@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1911050042250.17054@nanos.tec.linutronix.de>
         <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
         <20191105124351.GN4131@hirez.programming.kicks-ass.net>
         <b56f988176fca4f13c310b9dc866baf5408eeadd.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 11 Dec 2019 14:37:05 -0600
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 02:13 -0600, Scott Wood wrote:
> On Tue, 2019-11-05 at 13:43 +0100, Peter Zijlstra wrote:
> > On Tue, Nov 05, 2019 at 01:30:58AM -0600, Scott Wood wrote:
> > > As for the warning in sched_tick_remote(), it seems like a test for
> > > time
> > > since the last tick on this cpu (remote or otherwise) would be better
> > > than
> > > relying on curr->se.exec_start, in order to detect things like this.
> > 
> > I don't think we have a timestamp that is shared between the remote and
> > local tick. 
> 
> Why wouldn't rq_clock_task() work on the local tick?  It's what
> ->task_tick() itself uses.
> 
> > Also, there is a reason this warning uses the task time
> > accounting, there used to be (as in, I can't find it in a hurry) code
> > that could not deal with >u32 (~4s) clock updates.
> 
> Detecting a 3 second interval between ticks for a given cpu should
> assert in a superset of the situations the current check asserts in --
> it just avoids the false negative of exec_runtime getting updated by
> something other than the tick.

The main difficulty with such a check is that when we're not on a full
nohz cpu, there's no remote tick, and so we can legitimately go more than
3 seconds between ticks when idle.

-Scott

