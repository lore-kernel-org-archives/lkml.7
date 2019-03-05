Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E35C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DC20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551776496;
	bh=Jqu7d71snGoa2BV0+qw3peB2EK3U1LcVkWK7xz6qFrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mQX3Uzv1Wwqq1pqhTjnZxLGjls+v+t5WZ9vAgqJuOPXKOc3iuF/t5DSlFs5Uo/GHf
	 JkEShpcdk13VtN7gwGcpb50tC2iQteBAIhIJ24n0QuINRBwnF+Q9wxqpbIHpruknj6
	 SS2O989x/0sCdHGbYm+M1722nQgRkOPh5UN9YGg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfCEJBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfCEJBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:01:34 -0500
Received: from devnote (p218086-mobac01.tokyo.ocn.ne.jp [153.233.209.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495F3206DD;
        Tue,  5 Mar 2019 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551776492;
        bh=Jqu7d71snGoa2BV0+qw3peB2EK3U1LcVkWK7xz6qFrg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WPNG67sC1u4H34rE5jxXCpEKoTzMDZF3DZrN7hbCf9xOrGmqSJ4I5xLIk070M465w
         JdraszkD6bV75K7znH/TlVNKm3WNwEs2cCX8IUSeBtnK8KnwNqKPMpK8FWPU2hXohu
         jIEjozNCeantgPrY8TYJQfdvFqsavWN82m7SDo70=
Date:   Tue, 5 Mar 2019 18:01:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Subject: Re: [uaccess] 780464aed0:
 WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
Message-Id: <20190305180126.0f7201d8ec733fdc887135f1@kernel.org>
In-Reply-To: <20190305172241.2eef39c6ca74d09120bbbcad@kernel.org>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
        <20190304101434.8429ffffb17813c0e7930130@kernel.org>
        <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
        <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
        <CAHk-=wiQM84VsAiw92UWyQZTQxr+F032Gm5BiFBXk7tC+LQohQ@mail.gmail.com>
        <20190305113635.18f80ea3b1f4fca54b9d21e4@kernel.org>
        <20190305172241.2eef39c6ca74d09120bbbcad@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 17:22:41 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 5 Mar 2019 11:36:35 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 4 Mar 2019 10:59:22 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > I think the better way to do this is allowing strncpy_from_user()
> > if some conditions are match, like
> > 
> >  - strncpy_from_user() will be able to copy user memory with set_fs(USER_DS)
> >  - strncpy_from_user() can copy kernel memory with set_fs(KERNEL_DS)
> >  - strncpy_from_user() can access unsafe memory in IRQ context if
> >    pagefault is disabled.
> > 
> > This is almost done, except for CONFIG_DEBUG_ATOMIC_SLEEP=y on x86.
> > 
> > So, what about adding a condition to WARN_ON_IN_IRQ() like below
> > instead of introducing user_access_ok() ?

OK, here is the patch. Does it work for us?

====
x86/uaccess: Verify access_ok() context strictly

From: Masami Hiramatsu <mhiramat@kernel.org>

WARN_ON_IN_IRQ() assumes that the access_ok() and following
user memory access can sleep. But this assumption is not
always correct; when the pagefault is disabled, following
memory access will just returns -EFAULT and never sleep.

Add pagefault_disabled() check in WARN_ON_ONCE() so that
it can ignore the case we call it with disabling pagefault.
For this purpose, this modified pagefault_disabled() as
an inline function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/uaccess.h |    4 +++-
 include/linux/uaccess.h        |    5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 780f2b4..b98a552 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -70,7 +70,9 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 })
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-# define WARN_ON_IN_IRQ()	WARN_ON_ONCE(!in_task())
+static inline bool pagefault_disabled(void);
+# define WARN_ON_IN_IRQ()	\
+	WARN_ON_ONCE(!in_task() && !pagefault_disabled())
 #else
 # define WARN_ON_IN_IRQ()
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 37b226e..ef3032d 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -203,7 +203,10 @@ static inline void pagefault_enable(void)
 /*
  * Is the pagefault handler disabled? If so, user access methods will not sleep.
  */
-#define pagefault_disabled() (current->pagefault_disabled != 0)
+static inline bool pagefault_disabled(void)
+{
+	return current->pagefault_disabled != 0;
+}
 
 /*
  * The pagefault handler is in general disabled by pagefault_disable() or
