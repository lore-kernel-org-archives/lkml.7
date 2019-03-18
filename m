Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5175CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1FD2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfCRTSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfCRTSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:18:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1F7C307CDEA;
        Mon, 18 Mar 2019 19:18:46 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DE0919C67;
        Mon, 18 Mar 2019 19:18:45 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:18:43 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net
Subject: Re: [PATCH v2 0/8] klp-convert
Message-ID: <20190318191843.GA22702@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301141313.15057-1-jmoreira@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 18 Mar 2019 19:18:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:13:05AM -0300, Joao Moreira wrote:
> Livepatches may use symbols which are not contained in its own scope,
> and, because of that, may end up compiled with relocations that will
> only be resolved during module load. Yet, when the referenced symbols are
> not exported, solving this relocation requires information on the object
> that holds the symbol (either vmlinux or modules) and its position inside
> the object, as an object may contain multiple symbols with the same name.
> Providing such information must be done accordingly to what is specified
> in Documentation/livepatch/module-elf-format.txt.
> 
> Currently, there is no trivial way to embed the required information as
> requested in the final livepatch elf object. klp-convert solves this
> problem in two different forms: (i) by relying on a symbol map, which is
> built during kernel compilation, to automatically infers the relocation
> targeted symbol, and, when such inference is not possible (ii) by using
> annotations in the elf object to convert the relocation accordingly to
> the specification, enabling it to be handled by the livepatch loader.
> 
> Given the above, add support for symbol mapping in the form of
> Symbols.list file; add klp-convert tool; integrate klp-convert tool into
> kbuild; make livepatch modules discernible during kernel compilation
> pipeline; add data-structure and macros to enable users to annotate
> livepatch source code; make modpost stage compatible with livepatches;
> update livepatch-sample and update documentation.
> 
> The patch was tested under three use-cases:
> 
> use-case 1: There is a relocation in the lp that can be automatically
> resolved by klp-convert (tested by removing the annotations from
> samples/livepatch/livepatch-annotated-sample.c)
> 
> use-case 2: There is a relocation in the lp that cannot be automatically
> resolved, as the name of the respective symbol appears in multiple
> objects. The livepatch contains an annotation to enable a correct
> relocation - reproducible with this livepatch sample:
> www.livewire.com.br/suse/klp/livepatch-sample.1.c
> 
> use-case 3: There is a relocation in the lp that cannot be automatically
> resolved similarly as 2, but no annotation was provided in the livepatch,
> triggering an error during compilation - reproducible with this livepatch
> sample: www.livewire.com.br/suse/klp/livepatch-sample.2.c
> 
> In comparison with v1, this version of the patch-set:
> - was rebased to kernel 4.19
> - adds a Symbols.list versioning information
> - brings bug fixes and code improvements to klp-convert sources
> 
> This is a patch-set repost, given that a typo in a mail address prevented
> the original submission from being posted to lkml.
> 
> [ ... snip ... ]

Hi Joao,

Apologies for taking so long to get to this patchset, but I finally
spent last week reviewing and testing.  My goal was to write a klp
self-test based on the implementation and your sample module.  Along the
way I spotted a few minor bugs and other small suggestions.  Instead of
dumping a bunch of code or patch content in my replies, I posted my
rebase and modified branch here:

  https://github.com/joe-lawrence/linux/tree/klp-convert-v2-rebase-review

I added subject line [squash] tags to individual commits that should be
considered fixups for patches in this set.  Those commit logs also
contain [joe: description] tags and my sign-offs for that purpose as
well.

Hopefully this form of feedback will be easy to digest.  I'll reply to
the individual patchs here with high-level comments and a pointer to the
corresponding github patch.  Let me know if there are any questions.  If
it is easier to simply repost as a v3 with those changes, I can do that
as well -- whichever method is easier for you.

I'll also take comments on my work-in-progress self-test for
klp-convert:

  [new] livepatch/selftests: add klp-convert 
  https://github.com/torvalds/linux/commit/b0d858b9356d3c909096509a0f18e092b739b44f

At the moment, it consists of two livepatch modules (I'd prefer to
consolidate, but ran into an issue with klp-convert and multiple object
files) and verifies that livepatch can correctly resolve sympos of 0/1,
2 for unique/non-uniquely named strings and functions.

-- Joe
