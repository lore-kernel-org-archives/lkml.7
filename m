Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC232089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfIJJ2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIJJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:28:07 -0400
Received: from oasis.local.home (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34EC620872;
        Tue, 10 Sep 2019 09:28:06 +0000 (UTC)
Date:   Tue, 10 Sep 2019 05:28:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: simplify ftrace hash lookup code
Message-ID: <20190910052804.57308909@oasis.local.home>
In-Reply-To: <20190910003321.d3q65j756z3vzhiw@mail.google.com>
References: <20190909003159.10574-1-changbin.du@gmail.com>
        <20190909105424.6769b552@oasis.local.home>
        <20190910003321.d3q65j756z3vzhiw@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 08:33:23 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> > 
> > bool ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip, bool empty_result)
> > {
> > 	if (ftrace_hash_empty(hash))
> > 		return empty_result;
> > 
> > 	return __ftrace_lookup_ip(hash, ip);
> > }
> >  
> We must add another similar function since ftrace_lookup_ip() returns a pointer.
> 
> bool ftrace_contains_ip(struct ftrace_hash *hash, unsigned long ip,
> 			bool empty_result)
> {
> 	if (ftrace_hash_empty(hash))
> 		return empty_result;
> 
> 	return !!__ftrace_lookup_ip(hash, ip);
> }
> 
> But after this, it's a little overkill I think. It is not much simpler than before.
> Do you still want this then?
> 
>

Or...

static struct ftrace_func_entry empty_func_entry;
#define EMPTY_FUNC_ENTRY = &empty_func_entry;

[..]
 * @empty_result: return NULL if false or EMPTY_FUNC_ENTRY on true
[..]
 * @empty_result should be false, unless this is used for testing if the ip
 * exists in the hash, and an empty hash should be considered true.
 * This is useful when the empty hash is considered to contain all addresses.
[..]
struct ftrace_func_entry *
ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip, bool empty_result)
{
	if (ftrace_hash_empty(hash))
		return empty_result ? EMPTY_FUNC_ENTRY : NULL;

	return __ftrace_lookup_ip(hash, ip);
}

But looking at this more, I'm going back to not touching the code in
this location, because __ftrace_lookup_ip() is static, where as
ftrace_lookup_ip() is not, and this is in a very fast path, and I
rather keep it open coded.

Lets just drop the first hunk of your patch. The second hunk is fine.


-- Steve
