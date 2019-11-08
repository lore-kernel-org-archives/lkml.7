Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CF5C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5714D21D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aipj1ePs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfKHINw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:13:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57874 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbfKHINv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573200830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9gPHJr4lKqA/qy4lU+Ot6ytQsbEtzegqOGni3evgQo=;
        b=Aipj1ePsaJiRpRRe7/I6nOAv7bKp19/eptFVd32sJENOLi0sAdNYT2Rr+RK0pDYYspP2vM
        5PWuqSE0bUU41y2BSqdIJPxrRply7HJ20zicwK5S80xbITFwo2Hfpwx2gWflKnQe23o4zG
        y8KNauG34c4W26YHJmVp5AKbllArpIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-vk3zzKaIP4mSdaOIoPy9DA-1; Fri, 08 Nov 2019 03:13:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32AD8017DE;
        Fri,  8 Nov 2019 08:13:45 +0000 (UTC)
Received: from ovpn-116-229.phx2.redhat.com (ovpn-116-229.phx2.redhat.com [10.3.116.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FEB960CCC;
        Fri,  8 Nov 2019 08:13:45 +0000 (UTC)
Message-ID: <b56f988176fca4f13c310b9dc866baf5408eeadd.camel@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Nov 2019 02:13:44 -0600
In-Reply-To: <20191105124351.GN4131@hirez.programming.kicks-ass.net>
References: <20191028150716.22890-1-frederic@kernel.org>
         <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
         <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
         <20191030133130.GY4097@hirez.programming.kicks-ass.net>
         <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
         <alpine.DEB.2.21.1911042315390.17054@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1911050042250.17054@nanos.tec.linutronix.de>
         <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
         <20191105124351.GN4131@hirez.programming.kicks-ass.net>
Organization: Red Hat
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vk3zzKaIP4mSdaOIoPy9DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 13:43 +0100, Peter Zijlstra wrote:
> On Tue, Nov 05, 2019 at 01:30:58AM -0600, Scott Wood wrote:
> > As for the warning in sched_tick_remote(), it seems like a test for tim=
e
> > since the last tick on this cpu (remote or otherwise) would be better
> > than
> > relying on curr->se.exec_start, in order to detect things like this.
>=20
> I don't think we have a timestamp that is shared between the remote and
> local tick.=20

Why wouldn't rq_clock_task() work on the local tick?  It's what
->task_tick() itself uses.

> Also, there is a reason this warning uses the task time
> accounting, there used to be (as in, I can't find it in a hurry) code
> that could not deal with >u32 (~4s) clock updates.

Detecting a 3 second interval between ticks for a given cpu should assert i=
n
a superset of the situations the current check asserts in -- it just avoids
the false negative of exec_runtime getting updated by something other than
the tick.

-Scott


