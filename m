Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837352133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfDBNVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:21:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfDBNVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:21:08 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBJLb-0007Vu-5r; Tue, 02 Apr 2019 15:21:03 +0200
Date:   Tue, 2 Apr 2019 15:21:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matteo Croce <mcroce@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/4] Introduce the aural error reporting framework
In-Reply-To: <CAGnkfhzkS-QDq0uTSF=XEutaZ3ig6NYg5rgcWwQNmH9QM0TMSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904021518170.1676@nanos.tec.linutronix.de>
References: <20190401102456.11162-1-mcroce@redhat.com> <20190401110329.GA12232@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1904021045310.1676@nanos.tec.linutronix.de> <CAGnkfhzkS-QDq0uTSF=XEutaZ3ig6NYg5rgcWwQNmH9QM0TMSg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matteo,

On Tue, 2 Apr 2019, Matteo Croce wrote:
> On Tue, Apr 2, 2019 at 11:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Aside of that, where is the android-app to customize and decode the
> > melodies?
> >
> > I surely want to have the music theme of 'Once Upon a Time in the West' on
> > kernel crashes.
> 
> I'm a little rusty with Android programming, so I'll share the script
> I use to convert notes to frequences.
> With some awk magic it can turn notes into a C array, I hope that you
> find it useful.

That's great. Just a few nitpicks on the patches themself. You want to
change msleep() to mdelay() in order to avoid "Scheduling while atomic"
noise and you want to have global serialization because interleaving "La
Paloma" from CPU1 and "Once Upon a Time in the West" from CPU2 sounds
really horrible.

Thanks,

	tglx
