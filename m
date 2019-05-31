Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6649C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793A626341
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEaNfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaNfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:35:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F6B92EED06;
        Fri, 31 May 2019 13:35:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77E9D17AB4;
        Fri, 31 May 2019 13:35:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 31 May 2019 15:35:38 +0200 (CEST)
Date:   Fri, 31 May 2019 15:35:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190531133535.GB31323@redhat.com>
References: <20190529113157.227380-1-jannh@google.com>
 <20190530123452.GF22536@redhat.com>
 <CAG48ez0ivQ+gfwKMife-3ZwBuqAuc1BhDGW3dtYTHMq0sByuNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0ivQ+gfwKMife-3ZwBuqAuc1BhDGW3dtYTHMq0sByuNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 31 May 2019 13:35:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31, Jann Horn wrote:
>
> So I guess I should make a v2 that still adds the smp_rmb() in
> __ptrace_may_access(), but gets rid of the smp_wmb() in
> commit_creds()? (With a comment above the rcu_assign_pointer() that
> explains the ordering?)

I am fine either way, whatever you like more.

If you prefer v1 (this patch), feel free to add

Acked-by: Oleg Nesterov <oleg@redhat.com>


