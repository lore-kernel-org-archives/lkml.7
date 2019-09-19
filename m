Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985A5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1F7207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YYyD8I7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfISIG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:06:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33208 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfISIG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:06:57 -0400
Received: by mail-ot1-f66.google.com with SMTP id g25so2327988otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIQ+nUg1VdP9bbN5foNZlGVfInuxL+r2SKhzAZwecfY=;
        b=YYyD8I7iZQwU6EPYqOIs6pPlhZs8P6Xmfnk3WkQwBOLMQHbZYtPzN4CzwsjVMbLtXw
         xBXF9wahSO2Ct5eN5cDchW4GEF9kP7P5jIKiE822lMptLelGRXugc8djLAQ6BDihqyP3
         rgYF/7uedaefbRJF4axBK4RDxLDq73QW/SGrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIQ+nUg1VdP9bbN5foNZlGVfInuxL+r2SKhzAZwecfY=;
        b=koz4NlaYfL6iPPFUu3Gq7t8xdy5/Ela0KLmKay8PXmce2t/LtQyxnaeIb6TUy/tucx
         gz1WprS6/qNO8F0tLfMw3Q+hkVfXdPm9+bI3hcPxtduhaC1Sz9JCzCIedot9+Zmz9GzC
         a9drKwEQp2HeigHdhrG4D98HNx1xdYbATWz8a8OpONJFUUbOs98TB7RXn7ND5tjcMEPZ
         veDbC6+gTX6gcQM/+CLesekb1muQHgWhTagOfVxAnHuCsLsFe2fyXAMV2Djgxor03LOP
         jOpagA9MRf9xxyEJMLBDl6NK2QjE9E9wZGkxZmO6ZzMrdIdVIYuATl7rIXL5fiDQe6/N
         eqHg==
X-Gm-Message-State: APjAAAXUjAATbPFB46WLpEMkXRwt40dawwJoNk0Tvc8+y9viWwgiuMFv
        G3CmXN4qvuBxqTS6MhRHEYTe+3qbxlkaTub3QnvCJg==
X-Google-Smtp-Source: APXvYqyjc94TN0PXFSr23UDccKhWtl8ZEsxvv8Z2wuNSAuIgVaLFjlJ/6/0NbO+CohrV3a38rQsl7WWtd2WB3ptz3qQ=
X-Received: by 2002:a9d:404:: with SMTP id 4mr5965943otc.204.1568880415425;
 Thu, 19 Sep 2019 01:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz> <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home> <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de> <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home> <20190918023654.GB15380@jagdpanzerIV>
 <20190918051933.GA220683@jagdpanzerIV> <87h85anj85.fsf@linutronix.de>
In-Reply-To: <87h85anj85.fsf@linutronix.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 19 Sep 2019 10:06:44 +0200
Message-ID: <CAKMK7uH1Nz5+-oA06KmRzWvM+KcKZY4GnJOdQurFrXLc4k5h7Q@mail.gmail.com>
Subject: Re: printk meeting at LPC
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:42 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2019-09-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> For instance, tty/sysrq must be able to switch printk emergency
> >> on/off.
> >
> > How did we come up to that _sync() printk() emergency mode (when we
> > make sure that there is no active printing kthread)? We had a number
> > of cases (complaints) of lost kernel messages. There are scenarios in
> > which we cannot offload to async preemptible printing kthread, because
> > current control path is, for instance, going to reboot the kernel. In
> > sync printk() mode we have some sort (!) of guarantees that when we do
> >
> >               pr_emerg("Restarting system\n");
> >               kmsg_dump(KMSG_DUMP_RESTART);
> >               machine_restart(cmd);
> >
> > pr_emerg("Restarting system\n") is going to flush logbuf before the
> > system will machine_restart().
>
> Yes, this was why I asked Daniel how the bsod stuff will be
> implemented. We don't want a bsod just because we are
> restarting. Perhaps write_atomic() should also have a "reason" argument
> like kmsg_dump does. I will keep in touch with Daniel to make sure we
> are sync on this.

I thought that's why there'll be the oops_in_progress parameter for
write_atomic?

For the fbcon/graphics side I think we maybe need three levels:

- normal console writes with the kthread
- write_atomic, but non-destructive: Just directly write into the
framebuffer. Might need a serious locking rework in fbcon to make this
possible, plus won't work on drivers where the framebuffer is either
not statically pinned, or where you need to take additional work to
flush the updates out to the display.
- bsod, where we attempt an unfriendly takeover of the display with
trylocks and just overwrite what's there to display the oops. that one
is probably best suited for kmsg_dump.

Cheers, Daniel

> > It's going to be a bit harder when we have per-console kthread.
>
> Each console has its own iterator. This iterators will need to advance,
> regardless if the message was printed via write() or write_atomic().
>
> John Ogness



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
