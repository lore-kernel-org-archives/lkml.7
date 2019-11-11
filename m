Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27D8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9B2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNzzqjZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKKOP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:15:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47148 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbfKKOP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573481756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3WDQ1uC4gfTvXKgZQUE0k17gaSPZ7fT5q8w1d8GJzg=;
        b=GNzzqjZESPdVVRz/Uk4eNXaMYJDsNPWn6/+dcxaqTKqKCjSjA/ZU5v2ntUdHXWEWVqkMbU
        P5ydaAWirBmDprO1ln3Clf7TfCoR89v/K4HmUJzP3AOqrYgznfaOdhlyOlBgayTf8qxmQO
        QwduFb4Gnf1XVCYYfI2nKhP3vbgqlvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-9gJXOk2dNn6w9ytHuqfzag-1; Mon, 11 Nov 2019 09:15:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744D48C68D7;
        Mon, 11 Nov 2019 14:15:51 +0000 (UTC)
Received: from treble (ovpn-122-108.rdu2.redhat.com [10.10.122.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D554160852;
        Mon, 11 Nov 2019 14:15:44 +0000 (UTC)
Date:   Mon, 11 Nov 2019 08:15:42 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191111141542.dmr3l3gugcir3poh@treble>
References: <20191108212834.594904349@goodmis.org>
 <20191108225100.ea3bhsbdf6oerj6g@treble>
 <20191111084728.GO4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191111084728.GO4131@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 9gJXOk2dNn6w9ytHuqfzag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:47:28AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 08, 2019 at 04:51:00PM -0600, Josh Poimboeuf wrote:
>=20
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Subject: [PATCH] ftrace/x86: Tell objtool to ignore nondeterministic ft=
race stack layout
> >=20
> > Objtool complains about the new ftrace direct trampoline code:
> >=20
> >   arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_regs_caller()+0=
x190: stack state mismatch: cfa1=3D7+16 cfa2=3D7+24
> >=20
> > Typically, code has a deterministic stack layout, such that at a given
> > instruction address, the stack frame size is always the same.
> >=20
> > That's not the case for the new ftrace_regs_caller() code after it
> > adjusts the stack for the direct case.  Just plead ignorance and assume
> > it's always the non-direct path.  Note this creates a tiny window for
> > ORC to get confused.
>=20
> How is that not a problem for livepatch?

If this code were preempted at the point where the ORC data is wrong,
and then livepatch tried to unwind it, the reliable unwinder would error
out because it doesn't get all the way to the user-space pt_regs.  Then
it will just try again later.

I view this as a temporary fix; the code should be restructured to
follow normal rules.

--=20
Josh

