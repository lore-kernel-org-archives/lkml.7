Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCBBC282E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D096217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfEXXpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:45:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42488 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfEXXpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:45:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hUJsj-0001OM-6M; Fri, 24 May 2019 23:45:49 +0000
Date:   Sat, 25 May 2019 00:45:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] close_range()
Message-ID: <20190524234549.GO17978@ZenIV.linux.org.uk>
References: <20190523182152.GA6875@avx2>
 <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
 <20190524183903.GB2658@avx2>
 <CAHk-=wjaCygWXyGP-D2=ER0x8UbwdvyifH2Jfnf1KHUwR3sedw@mail.gmail.com>
 <20190524212740.GA7165@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524212740.GA7165@avx2>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 12:27:40AM +0300, Alexey Dobriyan wrote:

> What about orthogonality of interfaces?
> 
> 	fdmap()
> 	bulk_close()
> 
> Now fdmap() can be reused for lsof/criu and it is only 2 system calls
> for close-everything usecase which is OK because readdir is 4(!) minimum:
> 
> 	open
> 	getdents
> 	getdents() = 0
> 	close
> 
> Writing all of this I understood how fdmap can be made more faster which
> neither getdents() nor even read() have the luxury of: it can return
> a flag if more data is available so that application would do next fdmap()
> only if truly necessary.

Tactless question: what has traumatised you so badly about string operations?
Because that seems to be the common denominator to a lot of things...
