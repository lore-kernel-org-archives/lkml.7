Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9B7C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DE12173C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFOC62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:58:28 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:34681 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbfFOC62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 22:58:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C0F2540EE;
        Sat, 15 Jun 2019 02:58:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waves33_4975be92db727
X-Filterd-Recvd-Size: 2217
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 15 Jun 2019 02:58:24 +0000 (UTC)
Message-ID: <75c8f066c3aa2e20db2e1554a4d28c20b2952724.camel@perches.com>
Subject: Re: [PATCH 1/3] lib/vsprintf: add snprintf_noterm
From:   Joe Perches <joe@perches.com>
To:     "Yan, Zheng" <ukernel@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, agruenba@redhat.com
Date:   Fri, 14 Jun 2019 19:58:23 -0700
In-Reply-To: <CAAM7YAnZ=NtsOuR0Pm82fWCSUdFLkJ7NLNk+fNK9+T4viW=_1Q@mail.gmail.com>
References: <20190614134625.6870-1-jlayton@kernel.org>
         <20190614134625.6870-2-jlayton@kernel.org>
         <CAAM7YAnZ=NtsOuR0Pm82fWCSUdFLkJ7NLNk+fNK9+T4viW=_1Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-15 at 10:41 +0800, Yan, Zheng wrote:
> On Fri, Jun 14, 2019 at 9:48 PM Jeff Layton <jlayton@kernel.org> wrote:
> > The getxattr interface returns a length after filling out the value
> > buffer, and the convention with xattrs is to not NULL terminate string
> > data.
> > 
> > CephFS implements some virtual xattrs by using snprintf to fill the
> > buffer, but that always NULL terminates the string. If userland sends
> > down a buffer that is just the right length to hold the text without
> > termination then we end up truncating the value.
> > 
> > Factor the formatting piece of vsnprintf into a separate helper
> > function, and have vsnprintf call that and then do the NULL termination
> > afterward. Then add a snprintf_noterm function that calls the new helper
> > to populate the string but skips the termination.

Is this function really necessary enough to add
the additional stack use to the generic case?

Why not add have this function call vsnprintf
and then terminate the string separately?


