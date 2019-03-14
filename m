Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B003C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F422184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfCNQPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfCNQPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:15:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ECB430EEF63;
        Thu, 14 Mar 2019 16:15:07 +0000 (UTC)
Received: from treble (ovpn-125-78.rdu2.redhat.com [10.10.125.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 086DD5C21F;
        Thu, 14 Mar 2019 16:15:05 +0000 (UTC)
Date:   Thu, 14 Mar 2019 11:15:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     moosotc@gmail.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool: Move objtool_file struct off the stack
Message-ID: <20190314161503.67ti3ikrw6uydcqd@treble>
References: <183fac0cca806ab54b0709ed0eb94aa2e86fdc24.1552577139.git.jpoimboe@redhat.com>
 <87mulxxyjq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mulxxyjq.fsf@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 14 Mar 2019 16:15:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 06:31:37PM +0300, moosotc@gmail.com wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> 
> > Objtool uses over 512k of stack, thanks to the hash table embedded in
> > the objtool_file struct.  This causes an unnecessarily large stack
> > allocation and breaks users with low stack limits.
> >
> > Move the struct off the stack.
> >
> > Fixes: 042ba73fe7eb ("objtool: Add several performance improvements")
> > Reported-by: Vassili Karpov <moosotc@gmail.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  tools/objtool/check.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 0414a0d52262..91c4799192e1 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2184,9 +2184,10 @@ static void cleanup(struct objtool_file *file)
> >  	elf_close(file->elf);
> >  }
> >  
> > +struct objtool_file file;
> > +
> 
> Maybe it also deserves a "static" storage duration (if nothing else this
> would prevent possible name clashes)?

Yeah, good point.

> 
> >  int check(const char *_objname, bool orc)
> >  {
> > -	struct objtool_file file;
> >  	int ret, warnings = 0;
> >  
> >  	objname = _objname;
> 
> -- 
> mailto:moosotc@gmail.com

-- 
Josh
