Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9763CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C56F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554188403;
	bh=vziQEd/kNbp3AqJtWeKXSaJBESYXRGW+D7V26gouVcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xn4WZf/XihKGS1bqn2IcKyMEzUkSZs36SRryM4SNTaBOlEqEt/0TX920FfnMZcerm
	 mH//lr4beEUwOtgnVPUPqEEEdR7uuExp1YmmsdEMfP8YChecFH38qG7v9Pkwz0OGaN
	 RMzyWDAH9TPm4mtWHwu2h4DqsJBkqyYXY84j6EkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfDBHAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfDBHAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:00:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75970206BA;
        Tue,  2 Apr 2019 07:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554188401;
        bh=vziQEd/kNbp3AqJtWeKXSaJBESYXRGW+D7V26gouVcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alf0mcn6T8mJ79zdzmSkS3E29mdh9lS11z0C8YbOJcKeWrVvxgwTkDwzniFN3PCmV
         oTTLBmUtLJpy9lQJCD1JggFUfZ+bF05tJBBOcXjaJKNUVFEnm14YWY1VDxdhXjE5sW
         k3OTtv+iZLqXcchv8onVJHKP7xed7r9CyVQoH+1E=
Date:   Tue, 2 Apr 2019 08:59:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshul Garg <aksgarg1989@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Davidson <md@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4.4 034/131] lib/int_sqrt: optimize small argument
Message-ID: <20190402065958.GA21380@kroah.com>
References: <20190401170051.645954551@linuxfoundation.org>
 <20190401170055.035782875@linuxfoundation.org>
 <d153fa8079c3e49e1ad35a54c400298ba51184e3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d153fa8079c3e49e1ad35a54c400298ba51184e3.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 10:42:52AM -0700, Joe Perches wrote:
> On Mon, 2019-04-01 at 19:01 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> If this is to be ported just for an optimization
> (which I think is dubious as it's not a bug fix),

Yes, it was requested to be backported because of that.

> why not port the __fls optimization too?
> 
> __fls has a bigger effect on performance.

What commit are you referring to?

thanks,

greg k-h
