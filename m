Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959DBC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7795F2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLCNlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:41:35 -0500
Received: from ms.lwn.net ([45.79.88.28]:52276 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfLCNlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:41:35 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 91DBC60B;
        Tue,  3 Dec 2019 13:41:33 +0000 (UTC)
Date:   Tue, 3 Dec 2019 06:41:32 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Amol Grover <frextrite@gmail.com>
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
Message-ID: <20191203064132.38d75348@lwn.net>
In-Reply-To: <20191203063941.6981-1-frextrite@gmail.com>
References: <20191203063941.6981-1-frextrite@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Dec 2019 12:09:43 +0530
Amol Grover <frextrite@gmail.com> wrote:

> - Add more information about listRCU patterns taking examples
> from audit subsystem in the linux kernel.
> 
> - The initially written audit examples are kept, even though they are
> slightly different in the kernel.
> 
> - Modify inline text for better passage quality.
> 
> - Fix typo in code-blocks and improve code comments.
> 
> - Add text formatting (italics, bold and code) for better emphasis.

Thanks for improving the documentation!  I'll leave the RCU stuff to the
experts, but I do have one request...

[...]

> +When a process exits, ``release_task()`` calls ``list_del_rcu(&p->tasks)`` under
> +``tasklist_lock`` writer lock protection, to remove the task from the list of
> +all tasks. The ``tasklist_lock`` prevents concurrent list additions/removals
> +from corrupting the list. Readers using ``for_each_process()`` are not protected
> +with the ``tasklist_lock``. To prevent readers from noticing changes in the list
> +pointers, the ``task_struct`` object is freed only after one or more grace
> +periods elapse (with the help of ``call_rcu()``). This deferring of destruction
> +ensures that any readers traversing the list will see valid ``p->tasks.next``
> +pointers and deletion/freeing can happen in parallel with traversal of the list.
> +This pattern is also called an **existence lock**, since RCU pins the object in
> +memory until all existing readers finish.

Please don't put function names as literal text.  If you just say
call_rcu(), it will be formatted correctly and cross-linked to the
appropriate kerneldoc entry.  Saying ``call_rcu()`` defeats that and
clutters the plain-text reading experience.

Thanks,

jon
