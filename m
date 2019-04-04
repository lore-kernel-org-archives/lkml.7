Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F76A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfDDJXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:35374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387593AbfDDJO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88A78ACA8;
        Thu,  4 Apr 2019 09:14:53 +0000 (UTC)
Date:   Thu, 4 Apr 2019 11:14:51 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
In-Reply-To: <651eb328-b13a-9f31-d4da-9d2e965914e3@redhat.com>
Message-ID: <alpine.LSU.2.21.1904041113160.32428@pobox.suse.cz>
References: <20190301141313.15057-1-jmoreira@suse.de> <20190301141313.15057-3-jmoreira@suse.de> <20190318191926.GA23138@redhat.com> <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz> <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de> <ae018181-fd8a-03b2-69bf-e9302172bfeb@redhat.com>
 <699e78da-36ba-8217-c509-2e9b443bd380@suse.de> <1b6ee81b-5699-a1cc-9a85-02df0eeaed12@redhat.com> <20190328201703.GA8658@redhat.com> <20190401193529.GA26375@redhat.com> <alpine.LSU.2.21.1904031444020.18182@pobox.suse.cz>
 <651eb328-b13a-9f31-d4da-9d2e965914e3@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Joe Lawrence wrote:

> On 4/3/19 8:48 AM, Miroslav Benes wrote:
> > 
> >> and it looks like the combined KLP_MODULE_RELOC still contains the two
> >> unique symbol position values (2 and 3):
> >>
> >>    % objcopy -O binary --only-section=.klp.module_relocs.vmlinux lib/livepatch/test_klp_convert.klp.o >(hexdump -C)
> >>    00000000  00 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00  |................|
> >>    00000010  00 00 00 00 00 00 00 00  03 00 00 00              |............|
> >>    0000001c
> > 
> > Nice :/
> >   
> >> Maybe we can work around this by modifying the annotation macros and/or
> >> klp-convert, or live with this for now.
> > 
> > The question is (and I'll check later. I cannot wrap my head around it
> > now) if it at least works if there are two references of the same symbol
> > in two different .o. It would be same state_show in this case and not two
> > different ones. If it works then I think we can live with it for a while,
> > because after all duplicate symbols are quite rare in the kernel.
> 
> Possibly, but in testing that scenario I found another issue.  Check out what
> happens to the combined .klp.module_relocs.vmlinux section for:
> 
>   test_klp_convert_a.c
>   KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_a[] = {
>           KLP_SYMPOS(state_show, 2)
>           KLP_SYMPOS(joe, 10)
>           KLP_SYMPOS(joe2, 11)
>   };
> 
>   test_klp_convert_b.c
>   KLP_MODULE_RELOC(vmlinux) vmlinux_relocs_b[] = {
>           KLP_SYMPOS(state_show, 2)
>   };
> 
> The second file's klp_module_reloc are not aligned with the first,
> so I think there is additional padding to push the second set to a
> word boundary:
> 
>   % objcopy -O binary --only-section=.klp.module_relocs.vmlinux lib/livepatch/test_klp_convert.klp.o >(hexdump -C)
>   00000000  00 00 00 00 00 00 00 00  02 00 00 00 00 00 00 00
>             |-*sym----------------|  |--sympos-| |-*sym-----
> 
>   00000010  00 00 00 00 0a 00 00 00  00 00 00 00 00 00 00 00
>             ----------| |--sympos-|  |-*sym----------------|
> 
>   00000020  0b 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>             |-sympos--|              |-*sym----------------|
> 
>                         ^^^^^^^^^^^
>                         padding
>   00000030  02 00 00 00
>             |-sympos--|
>
> 
> in this case, klp-convert thought the last symbol's sympos was
> incorrectly 0 and not 2.

Ugh. It's getting better and better.
 
> If the packed attribute is merely a space optimization, can we
> simply pull that (or can we specify slightly looser alignment to
> account for the padding)?

I think so.

> I'll continue working on putting together v3 and add this new item
> to the TODO list.

Great job btw. Thanks.

Miroslav
