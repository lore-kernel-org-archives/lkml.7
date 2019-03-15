Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBB2C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E30521871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XlCmr86N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfCOStH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:49:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40513 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfCOStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:49:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id f11so11236101qti.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDVu9oumcNkqVWq1A9ByqO3eErH+1lF+kli+4UwjDSo=;
        b=XlCmr86Nfgg3xBxju2EZKTlTIuahwPKKbKnb6AAlhmp/tbiXOHmzB9Z4TTY65xaPhY
         h4du8n5E8MqaLaMPiBzkN0MAjbdzjR75E/AcT2yQNsgUl/sytZ2UHw3nW5f5SaJzdt7G
         qzWXFPPAMKCh8WrfHRT1c/0etmimiPLKZ6KAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDVu9oumcNkqVWq1A9ByqO3eErH+1lF+kli+4UwjDSo=;
        b=aLXP+3uZxna3cexEKi40FKjnH/yQVi8A/TNd26OfoevAUEwt1TmPwT001ar0dz8p0Y
         AFcAkd0cjzzClVpYVZlJy/ApZyCCrcCIZeDHBURtIoA3RjUnFtxkhWXR+wGzY281gODy
         rND9EAGHclBUh2JBfaNdeZeTHAORyGyKyfVUv2uzxWA4794Mn5jsKGTDMBHF2eNi+6y9
         8UUtSg3ZpDoVuRwubjoyXQzkEUERr9puIUxHzb8dTEgOzmihFiWwq9KHXVVtqj4UEZ0D
         S7TVuT/7fwyVOrHPFEbu4HP5M1iD/BHtlKkBN23Wj1/VZyuqaOwDQD6V0ceqm/KT5eOA
         JhlA==
X-Gm-Message-State: APjAAAXdQSFUCUDlOKL7DP7EumhWDR6ivP8z1vcg5oc2LvYILPFsmzVe
        qYJRCHdtkbFgIf/EYhpk05dZEQ==
X-Google-Smtp-Source: APXvYqw8pCjTHPS+C/nJz1ilQ/4K2gffZ1/50M17YBUUilptOjlnj0xzZ/lMuV0kS8T6iuWCBA4H8g==
X-Received: by 2002:ac8:3042:: with SMTP id g2mr4025863qte.1.1552675745275;
        Fri, 15 Mar 2019 11:49:05 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id m88sm1384596qte.68.2019.03.15.11.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 11:49:04 -0700 (PDT)
Date:   Fri, 15 Mar 2019 14:49:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190315184903.GB248160@google.com>
References: <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain>
 <20190314231641.5a37932b@oasis.local.home>
 <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
 <20190315180306.sq3z645p3hygrmt2@brauner.io>
 <20190315181324.GA248160@google.com>
 <20190315182426.sujcqbzhzw4llmsa@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315182426.sujcqbzhzw4llmsa@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 07:24:28PM +0100, Christian Brauner wrote:
[..]
> > why do we want to add a new syscall (pidfd_wait) though? Why not just use
> > standard poll/epoll interface on the proc fd like Daniel was suggesting.
> > AFAIK, once the proc file is opened, the struct pid is essentially pinned
> > even though the proc number may be reused. Then the caller can just poll.
> > We can add a waitqueue to struct pid, and wake up any waiters on process
> > death (A quick look shows task_struct can be mapped to its struct pid) and
> > also possibly optimize it using Steve's TIF flag idea. No new syscall is
> > needed then, let me know if I missed something?
> 
> Huh, I thought that Daniel was against the poll/epoll solution?

Hmm, going through earlier threads, I believe so now. Here was Daniel's
reasoning about avoiding a notification about process death through proc
directory fd: http://lkml.iu.edu/hypermail/linux/kernel/1811.0/00232.html

May be a dedicated syscall for this would be cleaner after all.

> I have no clear opinion on what is better at the moment since I have
> been mostly concerned with getting pidfd_send_signal() into shape and
> was reluctant to put more ideas/work into this if it gets shutdown.
> Once we have pidfd_send_signal() the wait discussion makes sense.

Ok. It looks like that is almost in though (fingers crossed :)).

thanks,

 - Joel

