Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57735C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AD42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AOvHnDX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCLPZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:25:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OAThpFYHfFpJdEy8OwLPNDdww7fmMTYYWyenN4Id6uo=; b=AOvHnDX1lDeBOkejHAgtcES98
        maDyEJIbh2t0zujM6b1FKExleWlsQr9ryaTezc2F7EGc7u5iLKFyUKAZt9V0EjkBysvW1PlEps+O0
        qGt6i68gN15lovw3xoNxGU2FqsVKU0FpIcGbsogl0lu64m87a7E5ZMT1PIsXOOxBecMp8i5D4/kmB
        ZThuHfu/oIyz5uRfHh0N3RZRTcRwEjSPvrIEbfIbzRlDWkPmLveIeC9Z4QCSAi6IjN8kE+v9iOU52
        x7cXj+QX1JvdxblwYJwnWvHlo6Cdyr6VVLyBsXNYJaFL/+CWtkiBDA/ZyiaVMBOc+JwkWseRE7qzF
        LVUBGt8hA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3jHh-0004rb-E5; Tue, 12 Mar 2019 15:25:41 +0000
Date:   Tue, 12 Mar 2019 08:25:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-mm <linux-mm@kvack.org>, Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190312152541.GI19508@bombadil.infradead.org>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz>
 <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312080532.GE5721@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 09:05:32AM +0100, Michal Hocko wrote:
> On Mon 11-03-19 15:15:35, Suren Baghdasaryan wrote:
> > Yeah, killing speed is a well-known problem which we are considering
> > in LMKD. For example the recent LMKD change to assign process being
> > killed to a cpuset cgroup containing big cores cuts the kill time
> > considerably. This is not ideal and we are thinking about better ways
> > to expedite the cleanup process.
> 
> If you design is relies on the speed of killing then it is fundamentally
> flawed AFAICT. You cannot assume anything about how quickly a task dies.
> It might be blocked in an uninterruptible sleep or performin an
> operation which takes some time. Sure, oom_reaper might help here but
> still.

Many UNINTERRUPTIBLE sleeps can be converted to KILLABLE sleeps.  It just
needs someone to do the work.
