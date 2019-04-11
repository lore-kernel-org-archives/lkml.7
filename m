Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03179C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72F22077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDKNT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:19:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3782206B7;
        Thu, 11 Apr 2019 13:19:57 +0000 (UTC)
Date:   Thu, 11 Apr 2019 09:19:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190411091955.67cdd9fd@gandalf.local.home>
In-Reply-To: <20190411082106.GB167446@google.com>
References: <20190410195708.162185-1-joel@joelfernandes.org>
        <20190410195708.162185-3-joel@joelfernandes.org>
        <20190410161112.540017d9@gandalf.local.home>
        <20190410202902.GA167446@google.com>
        <20190410204401.62f928ca@gandalf.local.home>
        <20190411082106.GB167446@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 04:21:06 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Patch 2/3 and 3/3 would not be nececessary if this works out. 1/3 may be a
> nice clean up but is not something urgent and we could do that in the future
> if needed.

Well, jump_labels is "special" because it requires sorting the RO data
and is done via module notify. The only other user that had to modify
RO data on module load is ftrace. It had to do the nop conversions in
the text area. It use to do it via module notify, but because of the
hardening of the kernel, doing it there was no longer possible because
everything was RO then. The solution was to call into ftrace directly
from the module code instead of a notifier. This was done before
sections were made RO.

One option is to do the same with jump_labels and just have a call to
the sorting before the notifiers and before the section gets turned
into RO. Or I would say just leave it as is. As I stated, jump_labels
are "special" and adding a loop of one section where I don't envision
any other sections needing to do the same thing for a long time to
come. I would save that patch for if there is another section that
comes along that needs to be modify at module notify.

-- Steve
