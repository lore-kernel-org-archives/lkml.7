Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10ECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B3521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfCTT6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:58:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfCTT6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:58:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F1B3ADC4;
        Wed, 20 Mar 2019 19:58:07 +0000 (UTC)
Date:   Wed, 20 Mar 2019 20:58:06 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 8/8] documentation: Update on livepatch elf format
In-Reply-To: <20190318192127.GA23238@redhat.com>
Message-ID: <alpine.LSU.2.21.1903202054350.29796@pobox.suse.cz>
References: <20190301141313.15057-1-jmoreira@suse.de> <20190301141313.15057-9-jmoreira@suse.de> <20190318192127.GA23238@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +building system, the second is done by a tool called klp-convert, which can be
> > +found in "scripts/livepatch".
> > +
> > +When an unresolved relocation has as target a symbol whose name is also used by
> > +different symbols throughout the kernel, the relocation cannot be resolved
> > +automatically. In these cases, the livepatch developer must add annotations to
> > +the livepatch, making it possible for the system to identify which is the
> > +correct target amongst multiple homonymous symbols. Such annotations must be
> > +done through a data structure as follows:
> > +
> > +struct KLP_MODULE_RELOC(object) data_structure_name[] = {
> > +	KLP_SYMPOS(symbol, pos)
> > +};
> > +
> > +In the above example, object refers to the object file which contains the
> > +symbol, being vmlinux or a module; symbol refers to the symbol name that will
> > +be relocated and pos is its position in the object.
> > [ ... snip ... ]
> 
> Should we be explicit about how position is counted?  First = 1, second
> = 2, etc?  See the off-by-one bug I pointed out in the "livepatch: Add
> klp-convert tool" patch earlier.

We could, but I would add it to a general section somewhere and just add a 
reference here.

Documentation/livepatch/livepatch.txt says
"As an optional parameter, the symbol position in the kallsyms database 
can be used to disambiguate functions of the same name. This is not the 
absolute position in the database, but rather the order it has been found 
only for a particular object ( vmlinux or a kernel module )."

We can improve it.

Documentation/livepatch/module-elf-format.txt says
"[D] The position of the symbol in the object (as according to kallsyms)
    This is used to differentiate duplicate symbols within the same
    object. The symbol position is expressed numerically (0, 1, 2...).
    The symbol position of a unique symbol is 0."

It may even confuse someone.

So yes, I'd be for a change here and there.

Miroslav
