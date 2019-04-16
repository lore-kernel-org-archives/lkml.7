Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0230C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762D922397
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfDPNzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:55:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:55:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE41130B8FA8;
        Tue, 16 Apr 2019 13:55:04 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52DCD5C220;
        Tue, 16 Apr 2019 13:55:01 +0000 (UTC)
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <452e0cc5-ea9b-1638-3557-17e12671e21e@redhat.com>
Date:   Tue, 16 Apr 2019 09:55:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410155058.9437-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Apr 2019 13:55:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 11:50 AM, Joe Lawrence wrote:
> Hi folks,
> 
> This is the third installment of the klp-convert tool for generating and
> processing livepatch symbols for livepatch module builds.  For those
> following along at home, archive links to previous versions:
> 
> RFC:
>    https://lore.kernel.org/lkml/cover.1477578530.git.jpoimboe@redhat.com/
> v2:
>    https://lore.kernel.org/lkml/f52d29f7-7d1b-ad3d-050b-a9fa8878faf2@redhat.com/
> 
> (Note that I don't see v2 archived at lore, but that is a link to the
> most recent subthread that lore did catch.)
> 
> 
> Livepatches may use symbols which are not contained in its own scope,
> and, because of that, may end up compiled with relocations that will
> only be resolved during module load. Yet, when the referenced symbols are
> not exported, solving this relocation requires information on the object
> that holds the symbol (either vmlinux or modules) and its position inside
> the object, as an object may contain multiple symbols with the same name.
> Providing such information must be done accordingly to what is specified
> in Documentation/livepatch/module-elf-format.txt.

Hi Miroslav,

I noticed that some binutils programs like gdb, objdump, etc. don't like 
the .ko kernel objects that we're generating from this patchset, 
specifically those with the additional '.klp.rela.<obj>..text' livepatch 
symbol relocation sections.

For reference, I opened a new bugzilla with more details here:
https://sourceware.org/bugzilla/show_bug.cgi?id=24456

And was about to ping the binutils mailing list about the assertion that 
is tripping in bfd/elf.c.  The thought occurred to me that you guys 
might already be carrying a patch to workaround this issue?

-- Joe
