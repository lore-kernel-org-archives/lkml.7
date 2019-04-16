Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D04217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfDPNhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfDPNhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:37:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E69783082206;
        Tue, 16 Apr 2019 13:37:38 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74BB95C22C;
        Tue, 16 Apr 2019 13:37:37 +0000 (UTC)
Subject: Re: [PATCH v3 0/9] klp-convert livepatch build tooling
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190416052422.GA7482@350D>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <57510765-be85-4f91-493b-f7213a7580f3@redhat.com>
Date:   Tue, 16 Apr 2019 09:37:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416052422.GA7482@350D>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 16 Apr 2019 13:37:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 1:24 AM, Balbir Singh wrote:
> 
> Could we get some details with examples or a sample, sorry I might be dense
> and missing simple information. The problem being solved is not clear to
> me from the changelog.
> 

Hi Balbir,

I see that Miroslav has already pointed to documentation, samples and 
self-tests for the patchset, but here is a summary in my own words:

kpatch-build constructs livepatch kernel modules by comparing a 
reference build with a patched build, combing through ELF object 
sections and extracting new and changed sections that include patched code.

An alternative approach is "source-based", in which a livepatch kernel 
module is built (mostly entirely) using the kernel's build 
infrastructure.  Sources for a livepatch are gathered ahead of time and 
then built like an ordinary kernel module.

In either approach, there lies the problem of symbol visibility: how can 
a livepatch resolve symbols that a kernel module ordinarily can't.  For 
example, file local or simply unexported symbols in across the kernel 
and other modules.  Enter the concept of "livepatch symbols" described 
in module-elf-format.txt.

kpatch-build already creates such "livepatch symbols" (see its 
create_klp_relasecs_and_syms()) and the livepatching core kernel code 
already knows how resolve such symbols at klp_object patch time (see 
klp_write_object_relocations()).

The klp-convert tool and this supporting patchset would empower 
source-based-constructed livepatch modules to do the same.

-- Joe
