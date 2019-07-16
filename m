Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8AC76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 02:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE2C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 02:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563243241;
	bh=1WXPaLAxJOus0JflLOCmf91JljCoNLWlAUD7TSVunLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jumeuseRSFETB8L5tdxQPTjV/e9oUVCy0C31cew3mHvMWwjFfY2WG1PAbIpcg0xlS
	 20yZcZFtlisCT4zDgxLt4LAmFF0ZZtBF9/Fzp6gBPP1eKLAm+FTF2VWcqiOjp2wcSA
	 vh3nLCdVqrb4SHdXyC6juyXVUPgZi/xY9qv4pL7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfGPCOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 22:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733303AbfGPCOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 22:14:00 -0400
Received: from localhost (unknown [88.128.80.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B527C20880;
        Tue, 16 Jul 2019 02:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563243239;
        bh=1WXPaLAxJOus0JflLOCmf91JljCoNLWlAUD7TSVunLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otpIewzTS2BCt4D6NLKOkDkFrN+yl1xFmNapQfs4OCftxcE6ZgRSBnNEJBuUzAaNG
         DcJDE7j2jP0Sea0ksNgunMOHibyOErzZLgL5H2ifQOEASbJxod0S4w5YvIYppWMHiZ
         tRUfvtTj4oi8FKKc9OM2Bt1Opfve1sbf7Y/nVcTo=
Date:   Tue, 16 Jul 2019 04:12:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>, kaleshsingh@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH v3] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190716021201.GB8310@kroah.com>
References: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
 <20190715201116.221078-1-trong@android.com>
 <20190715203651.GA7513@kroah.com>
 <CANA+-vC+_Gp4RwdLH_XYDAepRONB66PdekvaCxNT3ZVGx73G6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANA+-vC+_Gp4RwdLH_XYDAepRONB66PdekvaCxNT3ZVGx73G6A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 02:48:13PM -0700, Tri Vo wrote:
> > And I am guessing that you actually tested this all out, and it works
> > for you?
> 
> Yes, I played around with wakelocks to make sure that wakeup source
> stats are added/updated/removed as expected.

Great!

> > Have you changed Android userspace to use the new api with no
> > problems?
> 
> Kalesh helped me test this patch (added him in Tested-by: field in
> latest patch version). We haven't tested beyond booting and manual
> inspection on android devices. Android userspace changes should be
> fairly trivial though.

Ok, I know some people wanted to do some premature optimization with the
original discussion about this, glad to see it's not needed...

thanks,

greg k-h
