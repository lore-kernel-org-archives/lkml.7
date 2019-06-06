Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED97BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B687720868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559837001;
	bh=bqeYNfYKWFO0ZpgArUkrFcZ05IYNJaXWaMgEzUAmVMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nhR6hOlDdILDV+qctF2XU3BeOG9FNI9wxil66d+ER/JPW4KoFFxJ0e/KqkJ4WQuBF
	 Q9gkPbASAQfkcpCssT1w1Nf5iVohOiK+t6kXMXB8m9WnuIfuMROQVjOz3HMRqzHLBi
	 bo0KmWmnFCd4s9y2tobBDr2766tszDmz4WDbFChE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfFFQDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbfFFQDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:03:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA1420645;
        Thu,  6 Jun 2019 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559836999;
        bh=bqeYNfYKWFO0ZpgArUkrFcZ05IYNJaXWaMgEzUAmVMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2IWxsI3Fg+yw9+mWjz5P6qZkkKCdo5sz1Bos3VBrbZV5zPgWm1GDT4L8QZP8cSgK
         GLdQxH2xnBF4iCqJze+EE8VDBUqZP2qpe9oT+D4yTSwl6h0rejAvJEn8Ij8D0WKg0O
         F9j0UtgXFdtJArhWpRe57wr+CS9gpNaZGtkIGWVE=
Date:   Thu, 6 Jun 2019 18:03:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Vishnu DASA <vdasa@vmware.com>,
        Adit Ranadive <aditr@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] VMCI: Fixup atomic64_t abuse
Message-ID: <20190606160317.GA32400@kroah.com>
References: <20190606093428.GF3402@hirez.programming.kicks-ass.net>
 <BC2D213B-89E4-4C14-A093-AC61EAB56830@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2D213B-89E4-4C14-A093-AC61EAB56830@vmware.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 03:54:24PM +0000, Jorgen Hansen wrote:
> 
> 
> > On 6 Jun 2019, at 11:34, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > 
> > The VMCI driver is abusing atomic64_t and atomic_t, there is no actual
> > atomic RmW operations around.
> > 
> > Rewrite the code to use a regular u64 with READ_ONCE() and
> > WRITE_ONCE() and a cast to 'unsigned long'. This fully preserves
> > whatever broken there was (it's not endian-safe for starters, and also
> > looks to be missing ordering).
> 
> Thanks for the cleanup.
> 
> This code is only intended for use with the vmci device driver, and
> that is X86 only, so during the original upstreaming no effort was
> made to make this work correctly on anything else.
> 
> With that in mind, it should be fine to drop the unsigned long * type
> casts, since the introduction of the 32 bit operations were only done
> to avoid an issue with cmpxchg8b on 32-bit, and just doing straight
> writes avoids that too.
> 
> We’ll be updating the vmci device driver to work on other
> architectures soonish, so will be adding barriers to enforce ordering
> as well at that point. If you want to leave your patch as is, we can
> address the type casting then.

I've already applied it.

greg k-h
