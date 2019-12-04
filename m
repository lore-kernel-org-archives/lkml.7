Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D99C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51F20637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amGepPz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLDIYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:24:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46029 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:24:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so3242786pfg.12;
        Wed, 04 Dec 2019 00:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8xvQ4KrBz1M6n1c0YpMC9j+X8HvnhtQ5BjOcRHIdsx4=;
        b=amGepPz7ql+vTupsCnD6IPDipjGdbEdlKhY9cDj1Ekdy9V/2p6pYvzaA+jruVaXcuZ
         rO1xKldA6IhBJmcwJ/vnXGFEIYBKAHziPGeGrBZvW9m1px5SyLsyUbx3D3ydcil6qGB/
         K1NZiwbGggzcQ5EoFuozvvigL+u60IS+K2+0sJw7PUREwd0Vq9rbx8I+x1RrSOT9ychp
         CeBXvLiBfT64rb0Ixq0cMg6+y7mOOd+UDClM+uVwM7FESrFiH1aysjLxbYJqiwg+TKX4
         dl7VDEbU7KJNXdlpyx4/lY4iLWHNBLsFgMZ8ZdIyej9mA+hM03g7ymt93X70bI7zNJjo
         3+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xvQ4KrBz1M6n1c0YpMC9j+X8HvnhtQ5BjOcRHIdsx4=;
        b=nvAJnrpEqFG05x4iwxcpcCIfrz9OS+bozDiZ1E97UXPINxwpPFLDUaPz7S7Pzi1Q81
         QxG9/stbglf1NEw00drpqVRy6pyzeR4h9uYPq4ycYXWtxMiV96jAS8dkdeZvhYA8wWND
         P+cpBG0Hjk/fy5KNp/t8r6iZA7GncqW2WTT45nd7cT1DG/Yq0vFAGpEmYWYg3+sDRFCX
         tY+w9pWSKhWid9l2VTifFh6KGvqXMTTVjyxpstxcVeGz6eM1gPkcGCa7aG0zCjoo+Gl/
         06LW1BPsRtoXJpnBYTsNu3g3r9OI0kNt8EZtx5GVGM1Np6nHWwPiH87QMEv0mloN6NDe
         Jq7Q==
X-Gm-Message-State: APjAAAXB5H6D5Li7COyiA3vGn+sJ6LbfjcwrK7Ysm7bQB5JqEDXMkUq6
        42VoOOJhNvGomZ+fIm0pduzHYRXacJY=
X-Google-Smtp-Source: APXvYqylPnT6dgCmD55Q7hCAukiHfv8BLJTgQms5dq+Bh33cuTtxDo9AxShUdojQylsoPDn2w9Zvbw==
X-Received: by 2002:aa7:80d2:: with SMTP id a18mr2318629pfn.29.1575447860727;
        Wed, 04 Dec 2019 00:24:20 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.253.155])
        by smtp.gmail.com with ESMTPSA id o19sm5926518pjr.2.2019.12.04.00.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 00:24:20 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:54:12 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191204082412.GA6959@workstation-kernel-dev>
References: <20191203063941.6981-1-frextrite@gmail.com>
 <20191203064132.38d75348@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203064132.38d75348@lwn.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 06:41:32AM -0700, Jonathan Corbet wrote:
> On Tue,  3 Dec 2019 12:09:43 +0530
> Amol Grover <frextrite@gmail.com> wrote:
> 
> > - Add more information about listRCU patterns taking examples
> > from audit subsystem in the linux kernel.
> > 
> > - The initially written audit examples are kept, even though they are
> > slightly different in the kernel.
> > 
> > - Modify inline text for better passage quality.
> > 
> > - Fix typo in code-blocks and improve code comments.
> > 
> > - Add text formatting (italics, bold and code) for better emphasis.
> 
> Thanks for improving the documentation!  I'll leave the RCU stuff to the
> experts, but I do have one request...
> 
> [...]
> 
> > +When a process exits, ``release_task()`` calls ``list_del_rcu(&p->tasks)`` under
> > +``tasklist_lock`` writer lock protection, to remove the task from the list of
> > +all tasks. The ``tasklist_lock`` prevents concurrent list additions/removals
> > +from corrupting the list. Readers using ``for_each_process()`` are not protected
> > +with the ``tasklist_lock``. To prevent readers from noticing changes in the list
> > +pointers, the ``task_struct`` object is freed only after one or more grace
> > +periods elapse (with the help of ``call_rcu()``). This deferring of destruction
> > +ensures that any readers traversing the list will see valid ``p->tasks.next``
> > +pointers and deletion/freeing can happen in parallel with traversal of the list.
> > +This pattern is also called an **existence lock**, since RCU pins the object in
> > +memory until all existing readers finish.
> 
> Please don't put function names as literal text.  If you just say
> call_rcu(), it will be formatted correctly and cross-linked to the
> appropriate kerneldoc entry.  Saying ``call_rcu()`` defeats that and
> clutters the plain-text reading experience.
> 

Hi Jon,

The cross-reference of the functions should be done automatically by sphinx
while generating HTML, right? But when compiled none of the functions were
cross-referenced hence "``" was added around the methods (and other symbols)
to distinguish them from normal text.

Thanks
Amol

> Thanks,
> 
> jon
