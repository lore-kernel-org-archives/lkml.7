Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E22218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbfGYQlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:41:05 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:38324 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727957AbfGYQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:41:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C28EC100E86C1;
        Thu, 25 Jul 2019 16:41:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: egg25_7d66ef2072332
X-Filterd-Recvd-Size: 2173
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 16:41:01 +0000 (UTC)
Message-ID: <2331c1248aceff966403c0f3c5d527c95c930b5b.camel@perches.com>
Subject: Re: [PATCH v2] writeback: fix -Wstringop-truncation warnings
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@lca.pw>, David Laight <David.Laight@ACULAB.COM>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "tobin@kernel.org" <tobin@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "jack@suse.cz" <jack@suse.cz>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jul 2019 09:41:00 -0700
In-Reply-To: <1564069805.11067.20.camel@lca.pw>
References: <1564065511-13206-1-git-send-email-cai@lca.pw>
         <4017a4af4b0e4b96a6d7ed66afe18120@AcuMS.aculab.com>
         <1564069805.11067.20.camel@lca.pw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 11:50 -0400, Qian Cai wrote:

> > > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
[]
> > > @@ -66,8 +66,10 @@
> > >  	),
> > > 
> > >  	TP_fast_assign(
> > > -		strncpy(__entry->name,
> > > -			mapping ? dev_name(inode_to_bdi(mapping->host)-
> > > > dev) : "(unknown)", 32);
> > > 
> > > +		strscpy_pad(__entry->name,
> > > +			    mapping ?
> > > +			    dev_name(inode_to_bdi(mapping->host)->dev) :
> > > +			    "(unknown)", 32);
> > 
> > Shouldn't the 32 be 'sizeof (something)' ??
> 
> Maybe could do a sizeof(__entry->name) as it is defined as,
> 
> 	TP_STRUCT__entry (
> 		__array(char, name, 32)
> 		__field(unsigned long, ino)
> 		__field(pgoff_t, index)
> 
> But, that might be a follow-up patch and does not seem belong here.

stracpy_pad would work one day.


