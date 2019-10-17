Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E5AFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6F721835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408727AbfJQQiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:38:15 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:45423 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729529AbfJQQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:38:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 326BC181D341E;
        Thu, 17 Oct 2019 16:38:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: club44_2a4e4b9966947
X-Filterd-Recvd-Size: 3120
Received: from XPS-9350.home (unknown [47.151.135.62])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Oct 2019 16:38:10 +0000 (UTC)
Message-ID: <c2a4d95bee896df95d277fe84295e91014835030.camel@perches.com>
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
From:   Joe Perches <joe@perches.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Whitcroft <apw@canonical.com>,
        "DavidS. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        AlexeiStarovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        ArnaldoCarvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Date:   Thu, 17 Oct 2019 09:38:09 -0700
In-Reply-To: <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
         <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
         <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
         <20191017130550.nwswlnwdroyjwwun@pathway.suse.cz>
         <21f6322c-1c2b-f857-2e6e-e1c6aa45dd2d@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-17 at 21:29 +0800, Kefeng Wang wrote:
> On 2019/10/17 21:05, Petr Mladek wrote:
> > On Tue 2019-10-08 14:39:32, Kefeng Wang wrote:
> > > On 2019/10/2 16:55, Petr Mladek wrote:
> > > > On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
> > > > > There are pr_warning and pr_warng to show WARNING level message,
> > > > > most of the code using pr_warn, number based on next-20190919,
> > > > > 
> > > > > pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)
> > > > 
> > > > The ratio is 10:1 in favor of pr_warn(). It would make sense
> > > > to remove the pr_warning().
> > > > 
> > > > Would you accept pull request with these 32 simple patches
> > > > for rc2, please?
> > > > 
> > > > Alternative is to run a simple sed. But it is not trivial
> > > > to fix indentation of the related lines.
> > > 
> > > Kindly ping, should I respin patches with comments fixed?
> > > Is the patchset acceptable, hope to be clear that what to do next :)
> > 
> > I am going to check how many conflicts appeared in linux-next.
> > 
> > If there are only few then I'll take it via printk.git. This way
> > we get proper indentation and other changes.
[]
> For tools parts(api/bpf/perf, patch [29-31]), it renames pr_warning
> to pr_warn, and make manually changes in some place, simply 'sed'
> maybe not enough.

Perhaps tools/ should not be changed.

Last time I did this, I did not convert tools/ as there are
possible external dependencies and code like pr_warning_wrapper
exists and that adds some complexity to the change.

https://lore.kernel.org/patchwork/cover/761816/


