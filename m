Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CCFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643AD20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfCEUPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:15:13 -0500
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:43965 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbfCEUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:15:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4FE6818224BAE;
        Tue,  5 Mar 2019 20:15:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fog92_84595543a7c23
X-Filterd-Recvd-Size: 2575
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Mar 2019 20:15:09 +0000 (UTC)
Message-ID: <c0ecfffb979efbe38dd02d843c175d40342e40ed.camel@perches.com>
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Louis Taylor <louis@kragniz.eu>,
        Jonathan Corbet <corbet@lwn.net>, pmladek@suse.com,
        geert+renesas@glider.be, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Date:   Tue, 05 Mar 2019 12:15:08 -0800
In-Reply-To: <20190305200725.GG13380@bombadil.infradead.org>
References: <20190303123647.22020-1-louis@kragniz.eu>
         <20190303201016.GO9224@smile.fi.intel.com>
         <CAKwvOdm4uCWCtSMVQDVTSKavpT0dCo+ayuwvoXtewmk+ksn5sA@mail.gmail.com>
         <e244390e3d245c94d6d2fb036943e63111ada86d.camel@perches.com>
         <20190305200725.GG13380@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 12:07 -0800, Matthew Wilcox wrote:
> On Tue, Mar 05, 2019 at 11:59:30AM -0800, Joe Perches wrote:
> > Many of the -Wformat warnings are bogus too.
> > 
> > There's nothing wrong with using %x for a unsigned int
> > of less than long size. (u8/u16)
> 
> I believe you to be incorrect.
> 
> 6.5.2.2 Function calls
> 
> 7 If the expression that denotes the called function has a type that does
>   include a prototype, the arguments are implicitly converted, as if by
>   assignment, to the types of the corresponding parameters, taking the
>   type of each parameter to be the unqualified version of its declared
>   type. The ellipsis notation in a function prototype declarator causes
>   argument type conversion to stop after the last declared parameter. The
>   default argument promotions are performed on trailing arguments.

Look at default argument promotions for varargs functions.
(integer promotions)

> I could define a calling convention for my CPU which says to pack u8s
> and u16s as tightly as possible in registers (or on the stack), rather
> than the prevailing calling convention of having each argument take up
> at least one register-sized slot.

Doesn't matter for varargs.  See above.

cheers, Joe

