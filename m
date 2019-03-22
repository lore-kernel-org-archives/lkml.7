Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E81BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D816121874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfCVKdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:33:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfCVKdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:33:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C91388ABE;
        Fri, 22 Mar 2019 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73F706014E;
        Fri, 22 Mar 2019 10:33:33 +0000 (UTC)
Message-ID: <0eb092b7ca67942f52e36c672d20f130f1d54e1e.camel@redhat.com>
Subject: Re: [net-next PATCH v3 4/8] net: Change return type of sk_busy_loop
 from bool to void
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christoph Paasch <christoph.paasch@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Linux API <linux-api@vger.kernel.org>
Date:   Fri, 22 Mar 2019 11:33:32 +0100
In-Reply-To: <CALMXkpZ_eB+aRx3+aKM5Bs4RwDfzPNX+XneESo2-yuMPjHV5-Q@mail.gmail.com>
References: <20170324164902.15226.48358.stgit@localhost.localdomain>
         <20170324170812.15226.97497.stgit@localhost.localdomain>
         <CALMXkpb3MfLbNoBgLJc0rgMDbPg9yOevKOiq9N8pzVw-aeNb3g@mail.gmail.com>
         <e532fdb97e142eca2484e5abbeca4c30d11fbad6.camel@redhat.com>
         <CAKgT0Uc68jsuPHKbxxFpeMCQAo2M69DhzA_XGw7Kvou4H3eHPg@mail.gmail.com>
         <CALMXkpZ_eB+aRx3+aKM5Bs4RwDfzPNX+XneESo2-yuMPjHV5-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 22 Mar 2019 10:33:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-03-21 at 23:05 -0400, Christoph Paasch wrote:
> On Thu, Mar 21, 2019 at 12:43 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > On Thu, Mar 21, 2019 at 2:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > The following - completely untested - should avoid the unbounded loop,
> > > but it's not a complete fix, I *think* we should also change
> > > sk_busy_loop_end() in a similar way, but that is a little more complex
> > > due to the additional indirections.
> > 
> > As far as sk_busy_loop_end we could look at just forking sk_busy_loop
> > and writing a separate implementation for datagram sockets that uses a
> > different loop_end function. It shouldn't take much to change since
> > all we would need to do is pass a structure containing the sk and last
> > pointers instead of just passing the sk directly as the loop_end
> > argument.
> > 
> > > Could you please test it?
> > > 
> > > Any feedback welcome!
> > 
> > The change below looks good to me.
> 
> I just tried it out. Worked for me!
> 
> You can add my Tested-by if you do a formal patch-submission:
> 
> Tested-by: Christoph Paasch <cpaasch@apple.com>

Thanks for testing!

I'm trying to reproduce the issue locally, but I'm unable. I think that
the current UDP implementation is not affected, as we always ensure
sk_receive_queue is empty before busy polling. Unix sockets should not
be affected, too, as busy polling should not have any effect there
(sk_napi_id should be never >= MIN_NAPI_ID). Can you reproduce the
issue on an unpatched, recent, upstream kernel?

Can you please provide the syzkaller repro?

Thanks,

Paolo





