Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F0C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E462084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfDMRin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:38:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfDMRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:38:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hFMbs-0005tc-DV; Sat, 13 Apr 2019 17:38:36 +0000
Date:   Sat, 13 Apr 2019 18:38:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kirill Smelkov <kirr@nexedi.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] vfs: pass ppos=NULL to .read()/.write() of
 FMODE_STREAM files
Message-ID: <20190413173836.GO2217@ZenIV.linux.org.uk>
References: <20190413165116.GB10314@deco.navytux.spb.ru>
 <20190413165449.11168-1-kirr@nexedi.com>
 <CAHk-=wg6Pn4M+7awA5WrHv2vVc5iLRL29ueG-NSwOCAyVT-OYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6Pn4M+7awA5WrHv2vVc5iLRL29ueG-NSwOCAyVT-OYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 10:27:00AM -0700, Linus Torvalds wrote:

> And I'd really like to have people (Al?) look at this and go "yeah,
> makes sense". I do think that moving to a model where we wither have a
> (properly locked) file position or no pos pointer at all is the right
> model (ie I'd really like to get rid of the mixed case), but there
> might be some practical problem that makes it impractical.
>
> Because the *real* problem with the mixed case is not "insane people
> who do bad things might get odd results". No, the real problem with
> the mixed case is that it could be a security issue (ie: one process
> intentionally changes the file position just as another process is
> going a 'read' and then avoids some limit test because the limit test
> was done using the old 'pos' value but the actual IO was done using
> the new one).
> 
> So I suspect that we will have to either
> 
>  - get rid of the mixed case entirely (and do only properly locked
> f_pos accesses or pass is a NULL f_pos)

Good luck.  Character devices
	get no exclusion
	often do use position
	are many
	might be buried behind several layers of indirection
	... and often left unmaintained for a decade or two

IOW, I don't see how you'd go about eliminating the mixed case...
