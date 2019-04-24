Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D530AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D4821900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfDXTbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfDXTbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:31:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3B9430BC75B;
        Wed, 24 Apr 2019 19:31:23 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A083B1A267;
        Wed, 24 Apr 2019 19:31:22 +0000 (UTC)
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
To:     Joao Moreira <jmoreira@suse.de>, Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190417201316.GA690@redhat.com>
 <alpine.LSU.2.21.1904242013310.30239@pobox.suse.cz>
 <bcedf943-6c94-5d23-a637-4f29daf21eda@suse.de>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <97990f04-9c4c-17ad-901c-5285901d5a7f@redhat.com>
Date:   Wed, 24 Apr 2019 15:31:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bcedf943-6c94-5d23-a637-4f29daf21eda@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 24 Apr 2019 19:31:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 3:13 PM, Joao Moreira wrote:
>>> Future Work
>>> -----------
>>>
>>> I don't see an easy way to support multiple homonym <object, name>
>>> symbols with unique <position> values in the current livepatch module
>>> Elf format.  The only solutions that come to mind right now include
>>> renaming homonym symbols somehow to retain the relocation->symbol
>>> relationship when separate object files are combined.  Perhaps an
>>> intermediate linker step could make annotated symbols unique in some way
>>> to achieve this.  /thinking out loud
>> I'd set this aside for now and we can return to it later. I think it could
>> be quite rare in practice.

I agree, especially since we can detect this corner case and abort the 
translation.

>> I was thinking about renaming the symbol too. We can extend the symbol
>> naming convention we have now and deal with it in klp_resolve_symbols(),
>> but maybe Josh will come up with something clever and cleaner.
> I think this could work well, but (sorry if I understood Joe's idea
> wrongly) not as a linker step. Instead of modifying the linker, I think
> we could create another tool and plug it into the kbuild pipeline prior
> to the livepatch module linking. This way, we would parse the .o elf
> files, check for homonyms and rename them based on a convention that is
> later understood by klp-convert, as suggested.

My knowledge of the build tools is limited, so there was a bunch of 
hand-waving you couldn't see when I wrote that paragraph :) But yes, 
that is basically the idea: plugging into the kbuild pipeline to give 
these some kinda of .o-unique prefix that klp-convert would interpret 
and strip accordingly.

> If I am not missing something, this would fix the case where we have
> homonyms pointing to the same or different positions, without additional
> user intervention other then adding the SYMPOS annotations.
> 
> If you consider this to be useful I can start experiencing.
> 

It's not the highest priority, but even a prototype of how to insert a 
script into the pipeline to achieve this would be massively time saving 
for myself.  If renaming looks easy, we could try to work into the 
initial klp-convert patchset... if not, save it for a follow up enhancement.

Thanks,

-- Joe
