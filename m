Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A6C2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLf/KRas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfCDKAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:00:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37390 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCDKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:00:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id s22so2657776pfh.4;
        Mon, 04 Mar 2019 02:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LqBJvC3jKnzcjK7P9LIYsrh8zKUbPYSgARU78sfxG0=;
        b=NLf/KRasE9w3kpuz7AanPk5LUi1sUOk8BrFRDpdmIbK+Tlw7t2iYis+i2AhbuTAN8Z
         IJhkUugh1jCek0JJ3zsA9GaxntrjkvMNvjN1oEeyt/2RvhhvZmqYx8vOatiZGuEr5Of6
         t9YIM3dQQjO7eqBTrowVY6eztZvYfg9AvPZyIasqiWCYPlCJoQxFiSN1NksoeMk5ncW9
         GwJhiMKmMWLevSchJdLoBSgdC6YSR9mGkQJyZ4homBiTXjYL2OHBokKpsD6GveqLmXfe
         /uIBANNF6/dfyGawjZh+K9pQbT7oDXvbxEqJfLqS7Uhodzkv5rJ83p8LgIy1d+HiVcan
         MZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LqBJvC3jKnzcjK7P9LIYsrh8zKUbPYSgARU78sfxG0=;
        b=Vbv1KzKCQscbYq3HEnMECbUMGQvniw7G2WgdK7uIAhTkZikbWHmhQOTjtzoAqZrX48
         6ZYmPPn3wsQ+DiYOusCjbbJmzzPtbrbSDLmQVCWAXU/mNWBvngDi6gElCIqOs2YU9/2T
         vChbWRBP7Ldt+b0KGGoIE+WL8nOBaboginz/geaSi5oCuyLatlR7EsuXJMh9Uq+dgywu
         6UupSZfRSLP7AyTLMy4jydRL6dGPW2gxLXmRYvm//u/HcBGj26nhCyYM3DSbh3UYcRJB
         DkR7Vr9jAj4kadkxg/zMww7Wn567fRT9+LGRSFTGj8uX7sqVG80n2mwF6pNBJMyfVDFY
         zuMg==
X-Gm-Message-State: APjAAAVf75DCO7aaDAU0PLSZ3YUE0LioQtoRjp1+Kg9kaFxnr9yPeBLL
        62fD/rUfuDjL3iMZt6ScsJE=
X-Google-Smtp-Source: APXvYqwd9NeIU+MiQhQ68Za8a8+ftMRcl/20MZiherfu7OEtx2AjJzofExzbQz4TDRbiZJatMcQrJg==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr19599079pld.236.1551693649139;
        Mon, 04 Mar 2019 02:00:49 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id e26sm7680460pfd.124.2019.03.04.02.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 02:00:48 -0800 (PST)
Date:   Mon, 4 Mar 2019 19:00:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190304100044.GC21004@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304073856.GA552@jagdpanzerIV>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/04/19 16:38), Sergey Senozhatsky wrote:
> This, theoretically, creates a whole new world of possibilities for
> console drivers. Now they can do GFP_KERNEL allocations and stall
> printk_kthread during OOM; or they can explicitly reschedule from
> ->write() callback (via console_conditional_schedule()) because
> console_lock() sets console_may_schedule.

To demonstrate what kind of damage preemptible printk can do, some
of the reports I have in my inbox:

> ** 45 printk messages dropped ** [ 2637.275312] i2c-msm-v2 7af5000.i2c: NACK: slave not responding, ensure its powered: msgs(n:1 cur:0 tx) bc(rx:0 tx:2) mode:FIFO slv_addr:0x68 MSTR_STS:0x011363c8 OPER:0x00000090
> ** 59 printk messages dropped ** [ 2637.294937] i2c-msm-v2 7af5000.i2c: NACK: slave not responding, ensure its powered: msgs(n:1 cur:0 tx) bc(rx:0 tx:2) mode:FIFO slv_addr:0x68 MSTR_STS:0x011363c8 OPER:0x00000090
> ** 54 printk messages dropped ** ...

or

[..]
> ** 2499 printk messages dropped ** [   60.095515] CPU: 1 PID: 7148 Comm: syz-executor5 Tainted: G    B           4.4.104-ged884eb #2
> ** 5042 printk messages dropped ** [   60.107433]  [<ffffffff82564f65>] sg_finish_rem_req+0x255/0x2f0
> ** 3861 printk messages dropped ** [   60.116522] 	entry_SYSCALL_64_fastpath+0x16/0x76
> ** 3313 printk messages dropped ** [   60.124312] Object ffff8800b903e960: 00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> ** 5311 printk messages dropped ** [   60.136772] INFO: Freed in fasync_free_rcu+0x14/0x20 age=624 cpu=0 pid=3
> ** 4200 printk messages dropped ** [   60.146612] 	__slab_free+0x18c/0x2b0
> ** 2864 printk messages dropped ** [   60.153322] Object ffff8800b903e990: 00 50 8b 83 ff ff ff ff 01 46 00 00 07 00 00 00  .P.......F......
> ** 5323 printk messages dropped ** [   60.165806] Object ffff8800b903e980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> ** 5308 printk messages dropped ** [   60.178233] 	entry_SYSCALL_64_fastpath+0x16/0x76
> ** 3313 printk messages dropped ** [   60.186014] Object ffff8800b903e960: 00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> ** 5306 printk messages dropped ** [   60.198451] 	kmem_cache_alloc+0x155/0x290
[..]

One can lose tens, hundreds or even thousands of messages between
consecutive call_console_drivers(). These reports are back from the
days when printk used to be preemptible. I don't see that many dropped
messages starting from 4.15 (when we disabled preemption), at least not
in those syzbot reports which I have.

Some of those lost messages are probably going to be handled by ->atomic
path (depending on the loglevel), assuming that ->atomic console is
available. At the same time we might see a notable conversion of some
pr_foo-s to "a more safer emergency levels".

But in general, channels which depend on preemptible printk will become
totally useless in some cases.

	-ss
