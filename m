Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7373BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524B6206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKLS0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfKLS0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:26:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE343206B6;
        Tue, 12 Nov 2019 18:26:38 +0000 (UTC)
Date:   Tue, 12 Nov 2019 13:26:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and
 more)
Message-ID: <20191112132637.7d80fa57@gandalf.local.home>
In-Reply-To: <20191111131252.921588318@infradead.org>
References: <20191111131252.921588318@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 14:12:52 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Ftrace is one of the last W^X violators (after this only KLP is left). These
> patches move it over to the generic text_poke() interface and thereby get rid
> of this oddity.
> 
> The first 14 patches are the same as in the -v4 posting. The last 3 patches are
> new.
> 
> Will, patch 13, arm/ftrace, is unchanged. This is because this way it preserves
> behaviour, but if you can provide me a tested-by for the simpler variant I can
> drop that in.
> 
> Patch 15 reworks ftrace's event_create_dir(), which ran module code before the
> module was finished loading (before we even applied jump_labels and all that).
> 
> Patch 16 and 17 address minor review feedback.
> 
> Ingo, Alexei wants patch #1 for some BPF stuff, can he get that in a topic branch?

Hi Peter,

I ran this through my entire test suite and it actually passed :-)

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org> (for the
series, at least the x86 and generic part).

I'm still reviewing this series, I had some questions about patch 5 that
I sent out already.

-- Steve
