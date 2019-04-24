Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C6F2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfDXTXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDXTXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63B513001A9E;
        Wed, 24 Apr 2019 19:23:41 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D60FE1797A;
        Wed, 24 Apr 2019 19:23:36 +0000 (UTC)
Date:   Wed, 24 Apr 2019 14:23:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
Message-ID: <20190424192334.pdtbzpuz2dclsxsg@treble>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190417201316.GA690@redhat.com>
 <alpine.LSU.2.21.1904242013310.30239@pobox.suse.cz>
 <bcedf943-6c94-5d23-a637-4f29daf21eda@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcedf943-6c94-5d23-a637-4f29daf21eda@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Apr 2019 19:23:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:13:59PM -0300, Joao Moreira wrote:
> > > Future Work
> > > -----------
> > > 
> > > I don't see an easy way to support multiple homonym <object, name>
> > > symbols with unique <position> values in the current livepatch module
> > > Elf format.  The only solutions that come to mind right now include
> > > renaming homonym symbols somehow to retain the relocation->symbol
> > > relationship when separate object files are combined.  Perhaps an
> > > intermediate linker step could make annotated symbols unique in some way
> > > to achieve this.  /thinking out loud
> > 
> > I'd set this aside for now and we can return to it later. I think it could
> > be quite rare in practice.
> > 
> > I was thinking about renaming the symbol too. We can extend the symbol
> > naming convention we have now and deal with it in klp_resolve_symbols(),
> > but maybe Josh will come up with something clever and cleaner.
> 
> I think this could work well, but (sorry if I understood Joe's idea wrongly)
> not as a linker step. Instead of modifying the linker, I think we could
> create another tool and plug it into the kbuild pipeline prior to the
> livepatch module linking. This way, we would parse the .o elf files, check
> for homonyms and rename them based on a convention that is later understood
> by klp-convert, as suggested.
> 
> If I am not missing something, this would fix the case where we have
> homonyms pointing to the same or different positions, without additional
> user intervention other then adding the SYMPOS annotations.
> 
> If you consider this to be useful I can start experiencing.

I tend to agree with Miroslav that it's probably ok to ignore this issue
for now, as long as klp-convert can detect it and spit out an error.  I
assume the patch author could work around it with a kallsyms hack.  If
we encounter it much in the real world then we could figure out a
solution at that point.

-- 
Josh
