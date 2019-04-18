Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B89C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1F52183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfDRF5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:57:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57142 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRF5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:57:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hH02t-000192-7R; Thu, 18 Apr 2019 05:57:15 +0000
Date:   Thu, 18 Apr 2019 06:57:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Ostrowski <mostrows@earthlink.net>,
        Dmitry Kozlov <xeb@mail.ru>,
        James Chapman <jchapman@katalix.com>,
        linux-ppp@vger.kernel.org, Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 02/26] compat_ioctl: move simple ppp command handling
 into driver
Message-ID: <20190418055715.GC2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-3-arnd@arndb.de>
 <20190417211303.GU2217@ZenIV.linux.org.uk>
 <CAK8P3a1tiRew6uqegUXsKbNQG7=sPVFMY3yXf0M7OjJdkxM=_g@mail.gmail.com>
 <20190417235300.GB2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417235300.GB2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:53:00AM +0100, Al Viro wrote:

> Why would you want to duplicate large chunks of anything?
> The above is not even compile-tested, but...  I can put
> together a patch if you wish.  Or am I missing something
> here?

Actually, there's another broken part - pppox.  And that one
is nastier - you've just lost everything outside of protocol
family ioctls on those sockets.  Try e.g.  SIOCGIFMTU in 32bit
process on those.

We really can't reuse native ->ioctl() there - proto family
->compat_ioctl() *must* return -ENOIOCTLCMD on everything it
doesn't handle.
