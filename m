Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B861520643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552326511;
	bh=cJqMmrl54HyULei8Ia4DY7Sui+gjLqh0hF+JvVcaioY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SyCkjcrL0d34JDSgJoOQI5r0PSKreDSFzHvWAS7qwYBltYkQD2CJeleNuRBu+VQz8
	 VGhYiqWZ9HYFy1PbL+1TtBEJ6NUKnxCBN7WaxdlyFkRENxcyBJSTy31IPz/mlPoBHs
	 tMZ/iiQ3iYyz1qBChTw70ZQpskJIXmB0oNJEs1W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCKRsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:48:30 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43678 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:48:29 -0400
Received: by mail-lf1-f46.google.com with SMTP id g7so3082343lfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQTnlpbYSlvlEggHKpOcgCUg+Hl6a6HGXGsz6xjzAWA=;
        b=H9WW6kpnCR3Swai6uKxOHSMrBKFShxbM49viAqT6juWuNfoDmTP3qwfqAWj3n6aqK+
         yS/DEveUpUvXkfc0PCZfdQhlEbxkgZSr0nZ7HdLlaymhlwY0oALHQpW6KmdUjHlOMfOC
         p2ZTqzNlU46sUxGzvBiyXPkXFX7Fb6BJ2iomk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQTnlpbYSlvlEggHKpOcgCUg+Hl6a6HGXGsz6xjzAWA=;
        b=JekW+OmDVfm5JvqajDGiJtJ+78iikhaydAeyTX3QpuC9kP9CCJ9DPXueuWvTTmZ9wm
         l5ipNod7uUeqreGVYqkHXKWQAjByg6cYYvE94YjyzpvDiVGaZKDCvBsq96lORkqNkL8/
         N81V7bmPXQeJqPg+vS7jULrem44MhZ5VqnBTYFRtQvAr5Nfvu13V6aL27ykVcSOZyHdY
         TPa2INPBcMVM491evZ+4oQ+j5IgN7WuCat65IjVHYC+hd6V68zxfblhN0d9udEV+R9oh
         e5qWglCwkjhYq1sccuD25enQ5+b3c+bmi/Icci7pqlXf2LgQkOAxRVXgBQmBkmIPbJBl
         Mzvw==
X-Gm-Message-State: APjAAAV/kJV9Vd7mEY61lOnfW7tqQejSLOlv5+H+u/cCQKWiVfiHx/Ym
        u+xQYZ6B62ElGljyDHD1DykK8Jwfp8M=
X-Google-Smtp-Source: APXvYqxRvqMsHewH7TCUkUw9KLL+gVpRSQRDZnKuwUxpZal0K/NNGxCqaIceZ/M32Vr1kTkRYeIQ/A==
X-Received: by 2002:ac2:52ae:: with SMTP id r14mr19323291lfm.66.1552326506538;
        Mon, 11 Mar 2019 10:48:26 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v20sm1038932ljv.83.2019.03.11.10.48.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:48:24 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v16so4877943ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:48:23 -0700 (PDT)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr17089773ljg.94.1552326503575;
 Mon, 11 Mar 2019 10:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000080952b0583d183f0@google.com> <1552317574.45180.94.camel@acm.org>
In-Reply-To: <1552317574.45180.94.camel@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 10:48:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_H+Wce_n8vW68ZzoSs3m=exP+kKZZZRCxAfi6dG2_Mg@mail.gmail.com>
Message-ID: <CAHk-=wh_H+Wce_n8vW68ZzoSs3m=exP+kKZZZRCxAfi6dG2_Mg@mail.gmail.com>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low!
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     syzbot <syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, dledford@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        johannes.berg@intel.com, leon@kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, linux-xfs@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, roland@purestorage.com,
        sean.hefty@intel.com, shamir.rabinovitch@oracle.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> I think this issue has been fixed by a commit that went upstream yesterday. Hence:
>
> #syz fix: workqueue, lockdep: Fix an alloc_workqueue() error path

Well, syzbot just reported a problem with that fix itself ("WARNING in
lockdep_unregister_key").

Looks like now the lockdep_unregister_key() cleanup might be called
even when the lockdep map was never initialized at all in that error
case. Hmm?

I _think_ you need to split that "err_free_wq" label into "just free
the wq" and "unregister lockdep and free wq".

But I didn't look any more closely, I might be misreading things.

                Linus
