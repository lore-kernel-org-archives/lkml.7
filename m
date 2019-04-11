Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1608C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24732083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OBiPuxAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDKPda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:33:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKPd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KCh9rGSq/KL+6mqDbYpIlhQVTAEOXp0DwEg9orG5vFk=; b=OBiPuxAUqmi4MzzMOAbfGUg3p
        OsRROYl/3oMT+lqMELNrjtTdjmaVU12ZIvPy1FUKd7IaQdx3001ZjQfUwxsPDbpEpQ4t3K1anfRwb
        mfeQVW5DYiApCBa1+F1q0ISj2o5jsPKF9RB5Qygpqo9r2RefUae3Vg7XKslgaIrXSDE4oF9unbEwM
        61iSdWXRcAqbiynMfNqpz99f+OKBTkQruOitwbYhW77q3qFUfMCl1G4UNlsI5GFmcKgYQhr7UKH+Q
        0CUUcg3x87CVAUNx3f6AE58umR0TooNMRd/ErVEm+IV/gev4UEn3czJF2NE7Kv61qYZrM1Bkcmzqj
        niIdh0kKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEbhR-0004hT-HN; Thu, 11 Apr 2019 15:33:13 +0000
Date:   Thu, 11 Apr 2019 08:33:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        ebiederm@xmission.com, shakeelb@google.com, christian@brauner.io,
        minchan@kernel.org, timmurray@google.com, dancol@google.com,
        joel@joelfernandes.org, jannh@google.com, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
Message-ID: <20190411153313.GE22763@bombadil.infradead.org>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411014353.113252-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411014353.113252-3-surenb@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> pidfd_send_signal() syscall to allow expedited memory reclaim of the
> victim process. The usage of this flag is currently limited to SIGKILL
> signal and only to privileged users.

What is the downside of doing expedited memory reclaim?  ie why not do it
every time a process is going to die?

