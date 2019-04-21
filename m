Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E320EC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB44D20821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555871040;
	bh=um4p6vtZMfMRY4QFSBDSwK24PwLXiP0L/zhfcrFij4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wm23+kzQwtNrVF8+i+qMS8pD5xUbKH7RSnjofgejTkDf7lWS52LE91Z976WNmncQ
	 I83lf5dJehVgBsNs6o9EQtlNo9sgNd3IKZaDdOjxRIRdnhgv/IbH0BPSURXzTuvX09
	 owfUrpjAMQK4j6qdEO9MkfhYIU3MzTEcVmTAE+yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfDUSX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:23:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45603 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfDUSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:23:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so13329509wra.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cwU8KWt6Vbw1JxjcY5Z7Yc90qCSt02W7DmZeK75H/FE=;
        b=U0dsgBcvTAMq1JHTNkoIqEQ0ENZOJcMWJm5WTY48CaWsJA5wKRcFggeLWf9avTLd0S
         qPwdom59TBqziYidnjoS+LtAISUfQvXIIx/AVgimr070qlF/SCUhgHKC1LRqeF+jLOre
         MyEHfIRfT1C+jmqLnoRJmCNuk8Fv+1gHNBYM3+Ob/tFu4xfZdvN0CmeZIKQMU5FZpcvm
         kUYNJCg2gGvA86XZRQClqEiXn5R0VdT48FbuT5bHmnwlgjsoa8RDL+ZdLOuBKJLyvlZC
         jC72FSSQmIHjpy5sE+FPlPEqkTgViTL7lihLX8u5Rgxe4HK9VchoSSGJxPKpguAH41Pe
         +mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cwU8KWt6Vbw1JxjcY5Z7Yc90qCSt02W7DmZeK75H/FE=;
        b=Jm/j0hbvrbLCZSnFsNxgjAfy4bxITOxpJ3VH8AX/BnR4yrR/HLXSYawhNTcWErWAwE
         s3lw2/gu3Om0m9WmYSppw63vGCmK05iQ5T9dLQLFq64z5sIB7ZUDjyL0UACOY4WwnoXG
         mPNfGBzEeRV/I/ueVPvDPXOR+uR5zLOrrh7Tw1G0Obidc4+DvcdBBxASkIc7Z4iK8MhK
         Y3EPXoRLnqQo9vlMkDK7gW330LhEzl00fE9gyXNXADxngroBJ7rS6DAovswVUb98dXSM
         17QTn/GQm3XP+Tn4f+fL8OKLjj9uQX+/ah8TaeFsCmig7vVJQ4IgFMXp3kTCQolUqHbY
         ch9Q==
X-Gm-Message-State: APjAAAV1vMRK9AWFdRbpEayr0EdcG+4ofBJtGVN1GdKyWxe80GDdOlPq
        flVh5NS7cVkENlnBE2MIJGo=
X-Google-Smtp-Source: APXvYqxfe4Bqb/uAFH3eH9ClXo4kHHiKF4KGgF3Vrecq12wTzhyyrZj2fJJhlIAnLnQlAEpEElwQpw==
X-Received: by 2002:adf:d850:: with SMTP id k16mr4246715wrl.35.1555871037019;
        Sun, 21 Apr 2019 11:23:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w11sm21194790wre.15.2019.04.21.11.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 11:23:56 -0700 (PDT)
Date:   Sun, 21 Apr 2019 20:23:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [GIT PULL] locking fixes
Message-ID: <20190421182354.GA35603@gmail.com>
References: <20190420073018.GA127076@gmail.com>
 <CAHk-=wgjQg4wTQjyo_m2ZgqUc8h3H81N-XAxR+kkwRR6+3MjvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjQg4wTQjyo_m2ZgqUc8h3H81N-XAxR+kkwRR6+3MjvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Apr 20, 2019 at 12:30 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > A lockdep warning fix and a script execution fix when atomics are
> > generated.
> 
> Hmm. I've pulled this, but looking at it, I think it's worth noting something...
> 
> > diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
> > index 27400b0cd732..000dc6437893 100644
> > --- a/scripts/atomic/gen-atomics.sh
> > +++ b/scripts/atomic/gen-atomics.sh
> > -       ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
> > +       /bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
> 
> /bin/sh ?
> 
> Yes, that's what the hash-bang line says in the scripts themselves,
> and thus what we used to do with the whole direct execution thing, so
> it's clearly not _wrong_, but every single time when we manually do
> the "run with shell" normally, we use $(CONFIG_SHELL)".
> 
> So I get the feeling that we should likely do that here too.
> 
> Of course, the gen-atomics script is (now) outside the normal build,
> so maybe people just go "this is special, doesn't go through the
> normal build process anyway, and thus might as well not follow the
> common rules".

Yeah, agreed that this is all a bit weird. The status quo right now is:

 - scripts/atomic/gen-atomics.sh is a completely standalone, external 
   script which isn't even tied into any Makefile mechanism to build the 
   kernel.

 - To generate the headers one has to explicitly call 
   scripts/atomic/gen-atomics.sh, and it's not even executable, so the 
   incantation is even more weird:

         $ . scripts/atomic/gen-atomics.sh

So I agree that the UI of all this should be improved, I suspect we 
should do the following improvements:

   - make gen-atomics.sh executable

   - add a "make headers_gen_atomics" target to the main Makefile

   - call gen-atomics.sh via the build system and thus have access to 
     $CONFIG_SHELL and such and don't have assumptions about the shell 
     environment.

Arguably /bin/sh tends to exist during the build, everywhere. What 
usually results in the use of CONFIG_SHELL isn't /bin/sh per se but 
specific shell variant assumptions such as /bin/bash and the resulting 
occasional Bashism in the scripts - there are systems with non-bash 
shells by default and so.

Thanks,

	Ingo
