Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E33EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A22D20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCGQqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25399 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGQqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:46:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6714D3082AED;
        Thu,  7 Mar 2019 16:46:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2074D5C28C;
        Thu,  7 Mar 2019 16:46:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  7 Mar 2019 17:46:52 +0100 (CET)
Date:   Thu, 7 Mar 2019 17:46:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] signal: fix building with clang
Message-ID: <20190307164647.GC25101@redhat.com>
References: <20190307091218.2343836-1-arnd@arndb.de>
 <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 07 Mar 2019 16:46:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07, Arnd Bergmann wrote:
>
> We could use % everywhere,

Yes.

But again, why not simply use the "for (;;)" loops? Why we can't kill the
supid switch(_NSIG_WORDS) tricks altogether?

Oleg.

--- x/include/linux/signal.h
+++ x/include/linux/signal.h
@@ -121,26 +121,9 @@
 #define _SIG_SET_BINOP(name, op)					\
 static inline void name(sigset_t *r, const sigset_t *a, const sigset_t *b) \
 {									\
-	unsigned long a0, a1, a2, a3, b0, b1, b2, b3;			\
-									\
-	switch (_NSIG_WORDS) {						\
-	case 4:								\
-		a3 = a->sig[3]; a2 = a->sig[2];				\
-		b3 = b->sig[3]; b2 = b->sig[2];				\
-		r->sig[3] = op(a3, b3);					\
-		r->sig[2] = op(a2, b2);					\
-		/* fall through */					\
-	case 2:								\
-		a1 = a->sig[1]; b1 = b->sig[1];				\
-		r->sig[1] = op(a1, b1);					\
-		/* fall through */					\
-	case 1:								\
-		a0 = a->sig[0]; b0 = b->sig[0];				\
-		r->sig[0] = op(a0, b0);					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
+	int i;								\
+	for (i = 0; i < ARRAY_SIZE(r->sig); ++i)			\
+		r->sig[i] = op(a->sig[i], b->sig[i]);			\
 }
 
 #define _sig_or(x,y)	((x) | (y))

