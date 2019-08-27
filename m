Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C3C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E6A20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfH0O6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbfH0O6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCAAE7BDB6;
        Tue, 27 Aug 2019 14:58:48 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE16F5D70D;
        Tue, 27 Aug 2019 14:58:41 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:58:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, ndesaulniers@google.com,
        miguel.ojeda.sandonis@gmail.com, luc.vanoostenryck@gmail.com,
        schwidefsky@de.ibm.com, gregkh@linuxfoundation.org, mst@redhat.com,
        gor@linux.ibm.com, andreyknvl@google.com,
        liuxiaozhou@bytedance.com, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7:
 call without frame pointer save/setup
Message-ID: <20190827145839.dsm6at6hp7rwwrjo@treble>
References: <cf0273fb-c272-72be-50f9-b25bb7c7f183@windriver.com>
 <20190826151808.upis57cckcpf2new@treble>
 <2c416fe7-f6be-440b-b476-9fede1ea123c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c416fe7-f6be-440b-b476-9fede1ea123c@windriver.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 27 Aug 2019 14:58:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:43:27AM +0800, He Zhe wrote:
> 
> 
> On 8/26/19 11:18 PM, Josh Poimboeuf wrote:
> > On Mon, Aug 26, 2019 at 10:42:53PM +0800, He Zhe wrote:
> >> Hi All,
> >>
> >> Since 3193c0836f20 ("bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()"),
> >> We have got the following warning,
> >> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7: call without frame pointer save/setup
> >>
> >> If reverting the above commit, we will get the following warning,
> >> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8b9: sibling call from callable instruction with modified stack frame
> >> if CONFIG_RETPOLINE=n, and no warning if CONFIG_RETPOLINE=y
> > Can you please share the following:
> >
> > - core.o file
> 
> Attached.
> 
> >
> > The following would also be helpful for me to try to recreate it:
> >
> > - config file
> > - compiler version
> > - kernel version
> 
> I pasted them in the other reply.

Thanks.  I was able to recreate.  I reduced it to:

void a(b);
__attribute__((optimize(""))) c(void) { a(); }

Apparently '__attribute__((optimize()))' is overwriting GCC cmdline
flags, including -fno-omit-frame-pointer.  I had assumed it would append
instead of replace.

I'm guessing this is a GCC "feature" instead of a bug.  I'll need to
follow up.

-- 
Josh
