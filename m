Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6EEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D763920883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b7HAl2F4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE1KIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:08:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42262 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfE1KIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:08:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id i2so17179844otr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EX6OLV5ZAUtrIspgTC/dD9s7hQyjTDGZmjCu936OSL8=;
        b=b7HAl2F4pyNTMb75RB18eK82rHnNb7sgimOIYVdxdoBd3KMFC5Gjs9sBasws5mbWSr
         6MvIZ2l2IHj+B6MG2f2G9kG8nd2YTmTKodF/+81DHkSIq1siG+Rr4BEGz+78XEcDvogX
         faTEFwe/nSAFn9Dqy3uSjz+u0TI+Eatyzr+VHJNiT/clF9B7WrAW0rMRYEWj/4JMg6KQ
         JzUaH6ij8XJQ6dygU5bRCXts80yn8/Lqudl+AjGwYmc4F8fM+lMFJEatCRBMytSC7xHo
         WbHYBOCkAjSuq8yim7t//gtzYwulMNqxo/+3ecE5puMtJx9CwNP6PJTnbljhla7FTmOQ
         9xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EX6OLV5ZAUtrIspgTC/dD9s7hQyjTDGZmjCu936OSL8=;
        b=PIDlaQ1X8yMflJXdepqi1/IRiEs9ROdSomgaHkQhcWCnXK2EuaILXnVspS5r4jHvNK
         /vFFxYlDj3xbGZvCbwZayLRLXWWQigXE+A9Pw2mG5K65rIVfxBnc+nFQjst3nytd3CCk
         aqyT+Zzs6K6mHj1aMQgrMT3fLWTRSMd8VCD4/hGzrtXb0lcLzjb28ksPj0TO2himjfoq
         SpACvZch9pRgIkgj600+GLG14Fh7jDYKRCNdZ1mZhgqlgaSXQRuOz6ySJgII0epVjVSP
         Zft0xhcuYk3Fjag/yV6MpZmvhwIt2W/YWV/dvDdhHTHswLrz8BprBcO5Ulv+ialyFI6P
         NQmQ==
X-Gm-Message-State: APjAAAVpoag/HPGOYHmtCbbOHK1kWty/d/XR3sqAcfzXtQ9sYx2iin8I
        ORvTU8Hn88m8NouowU0LqkHwaw==
X-Google-Smtp-Source: APXvYqy+CVLW4qcGF5HZbujWnRF7l0dKamIr0LRxh4BCVKOiOumpEkoC7xrroBljDS1vYgtKHhWhrw==
X-Received: by 2002:a9d:5a14:: with SMTP id v20mr4657355oth.356.1559038092169;
        Tue, 28 May 2019 03:08:12 -0700 (PDT)
Received: from brauner.io ([172.56.7.242])
        by smtp.gmail.com with ESMTPSA id q21sm4633894ota.24.2019.05.28.03.08.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 03:08:11 -0700 (PDT)
Date:   Tue, 28 May 2019 12:08:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/2] fork: add clone6
Message-ID: <20190528100802.sdfqtwrowrmulpml@brauner.io>
References: <20190526102612.6970-1-christian@brauner.io>
 <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
 <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:27:08PM -0700, Linus Torvalds wrote:
> On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > Hm, still pondering whether having one unsigned int argument passed
> > through registers that captures all the flags from the old clone() would
> > be a good idea.
> 
> That sounds like a reasonable thing to do.
> 
> Maybe we could continue to call the old flags CLONE_XYZ and continue
> to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
> flags for a new 64-bit flag field that comes in through memory in the
> new clone_args thing?

Hm. I think I'll try a first version without an additional register
flags argument. And here's why: I'm not sure it buys us a lot especially
if we're giving up on making this convenient for seccomp anyway.
And with that out of the way (at least for the moment) I would really
like to make this interface consistent. But we can revisit this when I
have the code.

Christian
