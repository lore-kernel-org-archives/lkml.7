Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2D6C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C7224677
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLGVbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 16:31:23 -0500
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:44104
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLGVbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 16:31:22 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1idhfc-000cer-O3
        for linux-kernel@vger.kernel.org; Sat, 07 Dec 2019 22:31:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Akemi Yagi <toracat@elrepo.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
Date:   Sat, 7 Dec 2019 13:31:13 -0800
Message-ID: <qsh5n2$3pu9$1@blaine.gmane.org>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
 <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
 <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
 <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
In-Reply-To: <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Content-Language: en-US
Cc:     linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/19 10:59 AM, Linus Torvalds wrote:
> Hmm. I think I just saw this same bug with a plain kernel compile.
> 
> My "make -j32" suddenly came to a crawl, and seems to be entirely
> single-threaded.
> 
> And that's almost certainly because the way 'make' handles load
> distribution is with a network of pipes that has a token passed to the
> sub-makes.
> 
> So there's most definitely something wrong with the new pipe rework.
> Well, I can't _guarantee_ the pipes are the cause of this, but it does
> smell like it.
> 
>                Linus
> 

We encountered what seems to be the same problem when building a kernel
under RHEL 8.

As it turned out, this was due to a bug in make (make-4.2.1-9.el8) and
a patch is available. Details are found in this Red Hat bugzilla report:

https://bugzilla.redhat.com/show_bug.cgi?id=1774790

Akemi

