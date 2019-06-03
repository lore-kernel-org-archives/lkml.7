Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B37DC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC0127C3C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6ER9IEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfFCGwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:52:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37665 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfFCGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:51:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id 20so7715255pgr.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FNUoc3EO/BJ3F1Vcs9cRrfhxm+rGxZRQNrf7L+HUo8w=;
        b=H6ER9IEGx++OKxx8gxUH0k86zFrw5mTqHdkg1vDOWjFbaNN6Os0QQCCZ8RrISec+sM
         nRz4xsthgpb8Q/54x4oa0bMXEQuU94ZclFheWE3gp7S5Pqx5RwXu+EemYgzjHuys9uIl
         EPLIdtLDZuTcdAO+aLQOo1rFBX9ojbRRY1iJgpBzrBHyD5OjkGD33SnpGtzfqcHbulPR
         49SNghhrtfYj8O6GAAgmoKoe2cTZuzDcRLPVk2ldIf7DjiZ6URgXMYiBuJ0Ug2E+JKWj
         tsw8AXsZUFNF7xRp8XI+m78xFoRey3ePJCs+V5KViyYCfZ4Mz+/fFWu+OzJKlEAW31y6
         /tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNUoc3EO/BJ3F1Vcs9cRrfhxm+rGxZRQNrf7L+HUo8w=;
        b=QBPWtOE15GEnztIy6Zo76yuORaGLe8wPs3m/v07upj82Cfg19Wq2/yavsTk8pot6r2
         VUTDLBSwVZmRBdy8Kqy4/HbwMtEWjNkaKj0Z4c92msgGASC85vvEsDnE0JWqwRsU0pBs
         vvSiTEIj7hmCUYyw6iFr9p6921J/qzprsogcKZ7I3kvGnyWrr2EgTjTx58rmUVN7hm2D
         KzGykVjdPavOmID2c7BOBOgh9RKqporNQ0BbqLuCzjUxJ+tOHPO++sOl/ujRY7yZTA57
         3TmbSvpXdsxq5n5EwUJVl8nVdVqBIgmZoeX/L0cgERQOZ8EsBTcKKtt7A+2L18EimGJ1
         q5/Q==
X-Gm-Message-State: APjAAAVOC7QhRMZ9+49pw4OYLegj8DcC5D+HhseSYXV78kGbUMiCl+lq
        FdfAR5v80aR1CI2hlQk2+U4=
X-Google-Smtp-Source: APXvYqxeX2GmESpc0G9DhSTChfg5BjfqOy4jkdIaNOWkzWhYsyu0Wp/pVgO7w0MIvU03OKkSinPIvg==
X-Received: by 2002:a17:90a:1706:: with SMTP id z6mr7410125pjd.108.1559544717952;
        Sun, 02 Jun 2019 23:51:57 -0700 (PDT)
Received: from localhost ([110.70.56.170])
        by smtp.gmail.com with ESMTPSA id 124sm15095264pfe.124.2019.06.02.23.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 23:51:56 -0700 (PDT)
Date:   Mon, 3 Jun 2019 15:51:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190603065153.GA13072@jagdpanzerIV>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV>
 <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/28/19 15:42), Petr Mladek wrote:
> On Tue 2019-05-28 13:46:19, Sergey Senozhatsky wrote:
> > On (05/28/19 13:15), Sergey Senozhatsky wrote:
> > > On (05/28/19 01:24), Dmitry Safonov wrote:
> > > [..]
> > > > While handling sysrq the console_loglevel is bumped to default to print
> > > > sysrq headers. It's done to print sysrq messages with WARNING level for
> > > > consumers of /proc/kmsg, though it sucks by the following reasons:
> > > > - changing console_loglevel may produce tons of messages (especially on
> > > >   bloated with debug/info prints systems)
> > > > - it doesn't guarantee that the message will be printed as printk may
> > > >   deffer the actual console output from buffer (see the comment near
> > > >   printk() in kernel/printk/printk.c)
> > > > 
> > > > Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
> > > > Make sysrq print the headers unsuppressed instead of changing
> > > > console_loglevel.
> 
> I like this idea. console_loglevel is temporary manipulated only
> when some messages should or should never appear on the console.
> Storing this information in the message flags would help
> to solve all the related races.

I don't really like the whole system-wide console_loglevel manipulation
thing, expect for console_verbose(), which seems the be the only legit
case. Maybe we better do something about it. I like the idea of
KERN_UNSUPPRESSED, especially if it will let us to completely remove
those console_loglevel manipulations.
E.g.

	console_loglevel = NEW;
	foo()
	 bar()
	  dump_stack();
	  ....
        console_loglevel = OLD;

    I understand the intent, but printk() is deferred (not always but still),
    so this code is not really expected to do the same thing all the time.
    Especially when it comes to NMI, etc.

If KERN_UNSUPPRESSED is going to be yet-another-way-to-print-important-messages
then I'm slightly less excited.

	-ss
