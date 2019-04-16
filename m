Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC89C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3104920663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfDPTJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:09:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfDPTJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:09:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34599AF9A;
        Tue, 16 Apr 2019 19:09:16 +0000 (UTC)
Date:   Tue, 16 Apr 2019 21:09:15 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
In-Reply-To: <452e0cc5-ea9b-1638-3557-17e12671e21e@redhat.com>
Message-ID: <alpine.LSU.2.21.1904162107110.9731@pobox.suse.cz>
References: <20190410155058.9437-1-joe.lawrence@redhat.com> <452e0cc5-ea9b-1638-3557-17e12671e21e@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, Joe Lawrence wrote:

> On 4/10/19 11:50 AM, Joe Lawrence wrote:
> > Hi folks,
> > 
> > This is the third installment of the klp-convert tool for generating and
> > processing livepatch symbols for livepatch module builds.  For those
> > following along at home, archive links to previous versions:
> > 
> > RFC:
> >    https://lore.kernel.org/lkml/cover.1477578530.git.jpoimboe@redhat.com/
> > v2:
> >    https://lore.kernel.org/lkml/f52d29f7-7d1b-ad3d-050b-a9fa8878faf2@redhat.com/
> > 
> > (Note that I don't see v2 archived at lore, but that is a link to the
> > most recent subthread that lore did catch.)
> > 
> > 
> > Livepatches may use symbols which are not contained in its own scope,
> > and, because of that, may end up compiled with relocations that will
> > only be resolved during module load. Yet, when the referenced symbols are
> > not exported, solving this relocation requires information on the object
> > that holds the symbol (either vmlinux or modules) and its position inside
> > the object, as an object may contain multiple symbols with the same name.
> > Providing such information must be done accordingly to what is specified
> > in Documentation/livepatch/module-elf-format.txt.
> 
> Hi Miroslav,
> 
> I noticed that some binutils programs like gdb, objdump, etc. don't like the
> .ko kernel objects that we're generating from this patchset, specifically
> those with the additional '.klp.rela.<obj>..text' livepatch symbol relocation
> sections.
> 
> For reference, I opened a new bugzilla with more details here:
> https://sourceware.org/bugzilla/show_bug.cgi?id=24456

Another great catch.
 
> And was about to ping the binutils mailing list about the assertion that is
> tripping in bfd/elf.c.  The thought occurred to me that you guys might already
> be carrying a patch to workaround this issue?

No, unfortunately we don't. At least I don't know about anything and a 
quick test on openSUSE Leap 15.0 confirms it (objdump -D gives "bad 
value").

Thanks
Miroslav
