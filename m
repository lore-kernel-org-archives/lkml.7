Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07569C17440
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4E6214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVKyPo8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfKHWvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:51:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41728 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726095AbfKHWvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573253474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d464DpcuE6mdspnzUiHTqmDKb3ctMZKVUfOjByI5RRw=;
        b=UVKyPo8zunMkv7A2fwhJ//BNRLoNYWfoe1xTgJrj4M7jQf9nKlApjOOBPVKnNnIrQc029f
        uaNAcHKwUJMfOQfiDTnsVIkhxmOYDDBsdO2GAslcvHHg/PrOyfHOVYZFqRqnv0AA0vHfZH
        1GTIo+E3XRYcvRFO5vp4BM9jGX1tlF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-nzSRBjVrMreFWSL-Q56U7A-1; Fri, 08 Nov 2019 17:51:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 796A7107ACC4;
        Fri,  8 Nov 2019 22:51:08 +0000 (UTC)
Received: from treble (ovpn-123-141.rdu2.redhat.com [10.10.123.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C051B5D9E2;
        Fri,  8 Nov 2019 22:51:02 +0000 (UTC)
Date:   Fri, 8 Nov 2019 16:51:00 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 00/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191108225100.ea3bhsbdf6oerj6g@treble>
References: <20191108212834.594904349@goodmis.org>
MIME-Version: 1.0
In-Reply-To: <20191108212834.594904349@goodmis.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nzSRBjVrMreFWSL-Q56U7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 04:28:34PM -0500, Steven Rostedt wrote:
>=20
> Alexei mentioned that he would like a way to access the ftrace fentry
> code to jump directly to a custom eBPF trampoline instead of using
> ftrace regs caller, as he said it would be faster.
>=20
> I proposed a new register_ftrace_direct() function that would allow
> this to happen and still work with the ftrace infrastructure. I posted
> a proof of concept patch here:
>=20
>  https://lore.kernel.org/r/20191023122307.756b4978@gandalf.local.home
>=20
> This patch series is a more complete version, and the start of the
> actual implementation. I haven't run it through my full test suite but
> it passes my smoke tests and some other custom tests I built.
>=20
> I also realized that I need to make the sample modules depend on X86_64
> as it has inlined assembly in it that requires that dependency.
>=20
> This is based on 5.4-rc6 plus the permanent patches that prevent
> a ftrace_ops from being disabled by /proc/sys/kernel/ftrace_enabled
>=20
> Below is the tree that contains this code.
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/direct

Here's the fix for the objtool warning:

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] ftrace/x86: Tell objtool to ignore nondeterministic ftrace=
 stack layout

Objtool complains about the new ftrace direct trampoline code:

  arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_regs_caller()+0x190=
: stack state mismatch: cfa1=3D7+16 cfa2=3D7+24

Typically, code has a deterministic stack layout, such that at a given
instruction address, the stack frame size is always the same.

That's not the case for the new ftrace_regs_caller() code after it
adjusts the stack for the direct case.  Just plead ignorance and assume
it's always the non-direct path.  Note this creates a tiny window for
ORC to get confused.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/unwind_hints.h |  8 ++++++++
 arch/x86/kernel/ftrace_64.S         | 12 +++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unw=
ind_hints.h
index 0bcdb1279361..f5e2eb12cb71 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -86,6 +86,14 @@
 =09UNWIND_HINT sp_offset=3D\sp_offset
 .endm
=20
+.macro UNWIND_HINT_SAVE
+=09UNWIND_HINT type=3DUNWIND_HINT_TYPE_SAVE
+.endm
+
+.macro UNWIND_HINT_RESTORE
+=09UNWIND_HINT type=3DUNWIND_HINT_TYPE_RESTORE
+.endm
+
 #else /* !__ASSEMBLY__ */
=20
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)=09=09\
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 5d946ab40b52..1c79624a36b2 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -175,6 +175,8 @@ ENTRY(ftrace_regs_caller)
 =09/* Save the current flags before any operations that can change them */
 =09pushfq
=20
+=09UNWIND_HINT_SAVE
+
 =09/* added 8 bytes to save flags */
 =09save_mcount_regs 8
 =09/* save_mcount_regs fills in first two parameters */
@@ -249,8 +251,16 @@ GLOBAL(ftrace_regs_call)
 1:=09restore_mcount_regs
=20
=20
+2:
+=09/*
+=09 * The stack layout is nondetermistic here, depending on which path was
+=09 * taken.  This confuses objtool and ORC, rightfully so.  For now,
+=09 * pretend the stack always looks like the non-direct case.
+=09 */
+=09UNWIND_HINT_RESTORE
+
 =09/* Restore flags */
-2:=09popfq
+=09popfq
=20
 =09/*
 =09 * As this jmp to ftrace_epilogue can be a short jump
--=20
2.20.1

