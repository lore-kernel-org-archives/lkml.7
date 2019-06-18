Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C7C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F73A20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfFRASy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 20:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfFRASx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:18:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9602B20861;
        Tue, 18 Jun 2019 00:18:51 +0000 (UTC)
Date:   Mon, 17 Jun 2019 20:18:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Matt Mullins <mmullins@fb.com>, Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH] bpf: hide do_bpf_send_signal when unused
Message-ID: <20190617201850.010a4cf6@gandalf.local.home>
In-Reply-To: <CAADnVQKCeHrq+bf4DceH7+ihpq+q-V+bFOiF-TpYjekH7dPA0w@mail.gmail.com>
References: <20190617125724.1616165-1-arnd@arndb.de>
        <CAADnVQ+LzuNHFyLae0vUAudZpOFQ4cA02OC0zu3ypis+gqnjew@mail.gmail.com>
        <20190617190920.71c21a6c@gandalf.local.home>
        <75e9ff40e1002ad9c82716dfd77966a3721022b6.camel@fb.com>
        <CAADnVQKCeHrq+bf4DceH7+ihpq+q-V+bFOiF-TpYjekH7dPA0w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 16:27:33 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jun 17, 2019 at 4:13 PM Matt Mullins <mmullins@fb.com> wrote:
> > >
> > > The bug (really just a warning) reported is exactly here.  
> >
> > I don't think bpf_send_signal is tied to modules at all;
> > send_signal_irq_work_init and the corresponding initcall should be
> > moved outside that #ifdef.  
> 
> right. I guess send_signal_irq_work_init was accidentally placed
> after bpf_event_init and happened to be within that ifdef.
> Should definitely be outside.

So Arnd did find a bug. Just the wrong solution ;-)

-- Steve
