Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13079C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E7421670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmjFVvyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbfIQHvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:51:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34423 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfIQHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:51:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so1160888plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GdV6ui5LZLnW8fFVJkCHLEeDEzLY87U+BmVYVOmxHi0=;
        b=cmjFVvyBZ27L7F1N/sqThnFHwxhbjLSWiOYMhYapK6G2l9k5eV4rZ+zoeuZHC+79Qz
         5k9SeOOedWTrI8+chd90HXxGc87hfPShd+dSpVybZI1g+YtmzWgHVsyWqe7SrkvH3voj
         n/E9uyVAbMC0F36kyyb65AODfAviRMuUPLiIvfFshs851gDhwt4S6hhzDG11zTQ+AkmJ
         GIL8dI4Fgo12YuAc/gd1SI2AfbA+tOid2YIod27QIYhfdm8tUYWnNwFgeLEbAyUHw3Sm
         Y8+vKC2jn/rGSxRNovq0huizTGnKTZGRLmT8ckQtdpXkp0ZJzZPz0M7aqWf4N2oc7/41
         AEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GdV6ui5LZLnW8fFVJkCHLEeDEzLY87U+BmVYVOmxHi0=;
        b=pKYpeKdvHcX9+oZEu2PENXkbXoNkqYNaFkO+qwXYDJeAzKuzSZHeyIhf88Vf/Q6C/t
         +QvaDW/YGYB32zT+HBode/jKrH9a3C1+JcI8jL8S0+kBOEoEee68f6M66i+qFY+h7zAk
         znN+cbSMIKXmSv/V9iVmos3GtA/1CnzKXe+Aoi6pH39NuMlxFcErn/AZ53RK846KCXwF
         hDI+AwZwtfr206yXam2g30jOAjyZYDvPpz1s9S3rakMHQq2WeAwMzFWqGBlfq7nH7CXv
         OeRuDKmUzqNafcSv+OtBoK2W9UhuylEwBMNoTTLONjk5qGP12ZDkmnMrqXAzZm5XdBln
         6K4g==
X-Gm-Message-State: APjAAAUAZgRRVvds77hILvGgE8gQzdtDZoigPyqbYn6vJXCMDBg6TYxs
        fXdZOB01FFPHWPtY4Zpo18A=
X-Google-Smtp-Source: APXvYqzLvYAN+gNKUQ3BY1oZRmJEV64y8Q783k4xFSVrqm1ok4xmashJ8v9gp1obIubEabAsJY+ihQ==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr2293862plm.149.1568706694385;
        Tue, 17 Sep 2019 00:51:34 -0700 (PDT)
Received: from localhost ([110.70.27.73])
        by smtp.gmail.com with ESMTPSA id k5sm1521940pfi.142.2019.09.17.00.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:51:33 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:51:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Ogness <john.ogness@linutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk meeting at LPC
Message-ID: <20190917075130.GA860@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <cfc7b1fa-e629-19a6-154b-0dd4f5604aa7@I-love.SAKURA.ne.jp>
 <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/16/19 12:46), Petr Mladek wrote:
> Hmm, it seems that journalctl is able to filer device specific
> information, for example, I get:
> 
> $> journalctl _KERNEL_DEVICE=+usb:2-1
> -- Logs begin at Tue 2019-08-13 09:00:03 CEST, end at Mon 2019-09-16 12:32:58 CEST. --
> Aug 13 09:00:04 linux-qszd kernel: usb 2-1: new high-speed USB device number 2 using ehci-pci
> 
> One question is if anyone is using this filtering. Simple grep is
> enough. Another question is whether it really needs to get passed
> this way.

Hmm. If I recall correctly...

There was some sort of discussion (and a patch, I believe) a long time
ago. If I'm not mistaken, guys at facebook somehow add "machine ID"
(e.g. CONFIG_DEFAULT_HOSTNAME?) to kernel messages (via dicts). This
has one interesting use case: net consoles print extended headers.

So they have monitoring systems, which capture and track net consoles
output from many servers, and should one of them warn/oom/etc. they
immediately know which one of the machines is "under the weather"
(ext_text directly points at the right server).

Well, once again, if I recall this correctly.

	-ss
