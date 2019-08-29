Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C8C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEDF2339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfH2KHA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:07:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfH2KHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:07:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90B1DABD0;
        Thu, 29 Aug 2019 10:06:58 +0000 (UTC)
Date:   Thu, 29 Aug 2019 12:06:57 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Allison Randal <allison@lohutok.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/4] fs: always build llseek.
Message-ID: <20190829120657.400ee915@naga>
In-Reply-To: <20190829062200.GA3047@infradead.org>
References: <cover.1566936688.git.msuchanek@suse.de>
        <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
        <20190828151552.GA16855@infradead.org>
        <20190828181540.21fa33a4@naga>
        <20190829062200.GA3047@infradead.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 23:22:00 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Aug 28, 2019 at 06:15:40PM +0200, Michal Suchánek wrote:
> > On Wed, 28 Aug 2019 08:15:52 -0700
> > Christoph Hellwig <hch@infradead.org> wrote:
> >   
> > > On Tue, Aug 27, 2019 at 10:21:06PM +0200, Michal Suchanek wrote:  
> > > > 64bit !COMPAT does not build because the llseek syscall is in the tables.    
> > > 
> > > Well, this will bloat thinkgs like 64-bit RISC-V for no good reason.
> > > Please introduce a WANT_LSEEK like symbol that ppc64 can select instead.  
> > 
> > It also builds when llseek is marked as 32bit only in syscall.tbl
> > 
> > It seems it was handled specially in some way before syscall.tbl was
> > added, though (removed in ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5)  
> 
> Independ of if you need it on a purely 64-bit build on powerpc (which
> I'll let the experts figure out) it is not needed on a purely 64-bit
> build on other platforms.  So please make sure it is still built
> conditional, just possibly with an opt-in for powerpc.

AFAICT it is needed for all 64bit platforms with unified syscall.tbl.

I modified the syscall.tbl for powerpc to not need the syscall with
64bit only build but other platforms are still broken. There are a few
platforms that use multiple tables and on those the 64bit one indeed
does not contain llseek.

Thanks

Michal
