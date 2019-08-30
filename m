Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46686C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209C92186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 04:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfH3E4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 00:56:50 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:53171 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbfH3E4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:56:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3FC70909B;
        Fri, 30 Aug 2019 04:56:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake28_deb57dfa01b
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 04:56:45 +0000 (UTC)
Message-ID: <b9b83ce738fc0abde04ad82d0fa6786a1370fbab.camel@perches.com>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
From:   Joe Perches <joe@perches.com>
To:     shuah <shuah@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        sboyd@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu, 29 Aug 2019 21:56:44 -0700
In-Reply-To: <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
References: <20190828093143.163302-1-brendanhiggins@google.com>
         <20190828094929.GA14038@jagdpanzerIV>
         <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
         <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 21:44 -0700, Joe Perches wrote:
> On Thu, 2019-08-29 at 11:01 -0600, shuah wrote:
[]
> > WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ... then 
> > dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
> > #105: FILE: include/kunit/test.h:343:
> > +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
> > 
> > 
> > Is there supposed to be pr_level() - I can find dev_level()

btw: the checkpatch message is meant to be interpreted as

Prefer [subsystem eg: netdev]_<level>([subsystem]dev, ...) then dev_<level>(dev, ...) then pr_<level>(...), to printk(KERN_<LEVEL> ...)

btw2:

dev_level is actually not a function, but a convenience macro argument
which indirects to an actual specific logging function.

So no, there is not supposed to be a pr_level.


