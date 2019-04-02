Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC506C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1892084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh+RUIr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfDBOW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:22:57 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54491 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfDBOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:22:55 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so3867782ite.4;
        Tue, 02 Apr 2019 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTuuXgow23yAHO5FBRml6rBxyZpkve6TBfv3tPtT1X0=;
        b=jh+RUIr8uACojozI1ZwNh1fAPIjDUqxfdDpVgzvzoFMKgBWHdlnUpgseUMJbr3YpcR
         E2MwJLi1sap5ZMDsfdUvR48OUjuSO2ZCnpimRHUd9U6teribvwVkOJjrvVfu7WQqhDtZ
         WL5PPpMxVvlqoG7+s3fwc6CGopJzENn9ZAKQdf/UtNKFpGxZsmNN7YDEe/YE8FIeeVm/
         NH2XwETitiQ9PR9TvhaY9diDWmBxGHozhdJptHPB3pFjGBy/aWrX1u8fiGG31zP2Yrez
         n+hIL95FkWXQTRsqMz250NVOoCtyEMqnIvAgbEjDekWwCirhDz9j2Hr5cDFfM7Zj8KKG
         PAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTuuXgow23yAHO5FBRml6rBxyZpkve6TBfv3tPtT1X0=;
        b=LRXM6qFYgdKuxR5+V07YSDvYrPMuHd19esKd8NCTLe9lLrIsR6cxlk3wHNGnE6xCFl
         iqoFjxKUjl0QCJsyOEslDj5vjzWWWmz41/6WpOXJ78gzSHdMRg0LudYGCDFNfGy8vI7T
         SC2Opt3lGTem2pcW4CIKrMmvlwpIk0eAeC6iN7KP1iCbtSTAO5yNVQiDnkC6TNL9JLZH
         30ImqZ3j/QsZJDZIpUhSY+BHDd/xF4fU1vjVU6iHdqtPYAwBunpi8iyumWpZZZhm0k2H
         8+YmtzzVul4UIjtyHJ2MjAghuV/lDBG99TZOROeWtGOuqvQ/phNdqO10jHbeUF2vnwDE
         Okyw==
X-Gm-Message-State: APjAAAViKB8GASyncKZo5gBW0kaeenU/v3gQ8FpFnYBTfs/XnpnzXYfx
        b41HJvHqcamXj1Q+e73c5AhAj10NvS1L1P6wvvo=
X-Google-Smtp-Source: APXvYqz6PokoQGCuz6F+HLOuYffRjWrqJ8U5XU/0N541JLlGTSupuCe+KBAkEDQIu8LGBBqJZeqmLexFuz2UBR+BjZE=
X-Received: by 2002:a02:5f5b:: with SMTP id r88mr11258459jab.22.1554214974780;
 Tue, 02 Apr 2019 07:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <lsq.1554212307.17110877@decadent.org.uk> <lsq.1554212307.770456214@decadent.org.uk>
In-Reply-To: <lsq.1554212307.770456214@decadent.org.uk>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Tue, 2 Apr 2019 15:22:43 +0100
Message-ID: <CAJwJo6ahUWWSMWfM+qk109YfzJAB0HBMKcrVFqK2wzdBv_OtGQ@mail.gmail.com>
Subject: Re: [PATCH 3.16 23/99] tty/ldsem: Wake up readers after timed out down_write()
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Dmitry Safonov <dima@arista.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

JFI: I haven't checked your tree, but the same patches set contains fixes
that are more important to my mind (looking at 4.9 stable tree):
- "tty: Drop tty->count on tty_reopen() failure" commit fe3241679009
- "tty: Hold tty_ldisc_lock() during tty_reopen()" commit 83d817f41070
  with follow-up fixup "tty: Don't hold ldisc lock in tty_reopen() if
ldisc present"
  commit d3736d82e816

So, I don't know your policy about choosing backports, but I thought worth
to mention those patches as you might like to glance at them.
(maybe they are already in your tree)

Thanks,
Dmitry

On Tue, 2 Apr 2019 at 14:44, Ben Hutchings <ben@decadent.org.uk> wrote:
>
> 3.16.65-rc1 review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Dmitry Safonov <dima@arista.com>
>
> commit 231f8fd0cca078bd4396dd7e380db813ac5736e2 upstream.
>
> ldsem_down_read() will sleep if there is pending writer in the queue.
> If the writer times out, readers in the queue should be woken up,
> otherwise they may miss a chance to acquire the semaphore until the last
> active reader will do ldsem_up_read().
>
> There was a couple of reports where there was one active reader and
> other readers soft locked up:
>   Showing all locks held in the system:
>   2 locks held by khungtaskd/17:
>    #0:  (rcu_read_lock){......}, at: watchdog+0x124/0x6d1
>    #1:  (tasklist_lock){.+.+..}, at: debug_show_all_locks+0x72/0x2d3
>   2 locks held by askfirst/123:
>    #0:  (&tty->ldisc_sem){.+.+.+}, at: ldsem_down_read+0x46/0x58
>    #1:  (&ldata->atomic_read_lock){+.+...}, at: n_tty_read+0x115/0xbe4
>
> Prevent readers wait for active readers to release ldisc semaphore.
>
> Link: lkml.kernel.org/r/20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com
> Link: lkml.kernel.org/r/20180907045041.GF1110@shao2-debian
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/tty/tty_ldsem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> --- a/drivers/tty/tty_ldsem.c
> +++ b/drivers/tty/tty_ldsem.c
> @@ -306,6 +306,16 @@ down_write_failed(struct ld_semaphore *s
>         if (!locked)
>                 ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
>         list_del(&waiter.list);
> +
> +       /*
> +        * In case of timeout, wake up every reader who gave the right of way
> +        * to writer. Prevent separation readers into two groups:
> +        * one that helds semaphore and another that sleeps.
> +        * (in case of no contention with a writer)
> +        */
> +       if (!locked && list_empty(&sem->write_wait))
> +               __ldsem_wake_readers(sem);
> +
>         raw_spin_unlock_irq(&sem->wait_lock);
>
>         __set_task_state(tsk, TASK_RUNNING);
>
