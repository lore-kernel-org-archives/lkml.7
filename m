Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDB3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9A820679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfG3HDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:03:33 -0400
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:35977 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728470AbfG3HDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:03:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 586E983777EE;
        Tue, 30 Jul 2019 07:03:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: anger88_1e83daf9ea507
X-Filterd-Recvd-Size: 2841
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jul 2019 07:03:29 +0000 (UTC)
Message-ID: <80fbaf63ddbe66cbbf3391256402295af1a3336f.camel@perches.com>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 30 Jul 2019 00:03:28 -0700
In-Reply-To: <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
References: <20190729151346.9280-1-hslester96@gmail.com>
         <201907292117.DA40CA7D@keescook>
         <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 14:39 +0800, Chuhong Yuan wrote:
> Kees Cook <keescook@chromium.org> 于2019年7月30日周二 下午12:26写道：
> > On Mon, Jul 29, 2019 at 11:13:46PM +0800, Chuhong Yuan wrote:
> > > strncmp(str, const, len) is error-prone.
> > > We had better use newly introduced
> > > str_has_prefix() instead of it.
> > 
> > Wait, stop. :) After Laura called my attention to your conversion series,
> > mpe pointed out that str_has_prefix() is almost redundant to strstarts()
> > (from 2009), and the latter has many more users. Let's fix strstarts()
> > match str_has_prefix()'s return behavior (all the existing callers are
> > doing boolean tests, so the change in return value won't matter), and
> > then we can continue with this replacement. (And add some documentation
> > to Documenation/process/deprecated.rst along with a checkpatch.pl test
> > maybe too?)
> > 
> 
> Thanks for your advice!
> Does that mean replacing strstarts()'s implementation with
> str_has_prefix()'s and then use strstarts() to substitute
> strncmp?
> 
> I am not very clear about how to add the test into checkpatch.pl.
> Should I write a check for this pattern or directly add strncmp into
> deprecated_apis?

After Nitin's patch gets applied: (which btw wasn't cc'd to lkml)

(sorry about the bad link, something about it hits some
 spam filter)

open wall . com/lists/kernel-hardening/2019/07/28/1

Add it to deprecated_string_apis

And we've had this sort of discussion before:

https://lore.kernel.org/patchwork/patch/1026598/

I believe I'm still in favor of global conversion of
strstarts to str_has_prefix.


