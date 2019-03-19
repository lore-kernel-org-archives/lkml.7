Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD55DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5DE20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCSRTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:19:36 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:54257 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727194AbfCSRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:19:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 94C3319B2A;
        Tue, 19 Mar 2019 17:19:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wave73_8d7d3ab736326
X-Filterd-Recvd-Size: 1729
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Mar 2019 17:19:32 +0000 (UTC)
Message-ID: <ca59b2ea703e60c2b74d7f0795dcf31dd2c8ba3c.camel@perches.com>
Subject: Re: [PATCH v2 19/19] locking/lockdep: Change if to else-if when
 checking bfs errors
From:   Joe Perches <joe@perches.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 10:19:31 -0700
In-Reply-To: <1553012967.152266.48.camel@acm.org>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-20-duyuyang@gmail.com>
         <1553012967.152266.48.camel@acm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 09:29 -0700, Bart Van Assche wrote:
> On Mon, 2019-03-18 at 16:57 +0800, Yuyang Du wrote:
> > -       if (ret < 0) {
> > +       if (unlikely(ret < 0)) {
> >                 print_bfs_bug(ret);
> >                 return 0;
> >         }
> > -       if (ret == 1)
> > +       else if (ret == 1)
> >                 return ret;
> 
> Have you verified this patch series with checkpatch? Checkpatch should have
> reported that you are changing code that conforms to the coding style into
> code that does not conform to the kernel coding style. Checkpatch should have
> reported the following:
> 
> "else is not generally useful after a break or return"

checkpatch just ain't that smart.
You're welcome to try to improve it.

