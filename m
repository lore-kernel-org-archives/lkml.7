Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EEFC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BA120665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbfIRU4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:56:21 -0400
Received: from verein.lst.de ([213.95.11.211]:36006 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbfIRU4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:56:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D21C668B05; Wed, 18 Sep 2019 22:56:16 +0200 (CEST)
Date:   Wed, 18 Sep 2019 22:56:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/mm: Remove set_pages_x() and set_pages_nx()
Message-ID: <20190918205616.GA23251@lst.de>
References: <20190918164121.30006-1-Larry.Finger@lwfinger.net> <20190918164518.GA19222@lst.de> <b4fa6ab6-ab30-fc05-0f9f-93c41e7e8c79@lwfinger.net> <CAHk-=wji2fMDpSwvR4U8FkKBx8=eZtg3CmWtH7hACzeHbBei8A@mail.gmail.com> <bd5684ee-afaf-a9ba-6c32-15d2aa94733c@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5684ee-afaf-a9ba-6c32-15d2aa94733c@lwfinger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 01:17:13PM -0500, Larry Finger wrote:
> The external module is vboxdrv, which is part of VirtualBox. The setting of 
> pages to be executable appears to have been added in kernel 2.4.20.
>
> I am now testing with the former calls to set_pages_x() and set_pages_nx() 
> disabled. Thus far, VMs seem to be running OK. I will contact Oracle to 
> discuss the matter with them and see if there is some special case that 
> requires this facility. If there is one, then they will need to discuss it 
> with you and Christoph.

Well, in this case the API is called /dev/kvm.  There is really
absolutely no reason for anyone badly reinventing the low-level
VT and SVM code when they can just use the kernel kvm support, which
already has at least half a dozen users.
