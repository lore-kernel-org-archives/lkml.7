Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A135C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C7822CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfHVLM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:12:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfHVLM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF8098D5BA6;
        Thu, 22 Aug 2019 11:12:55 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE9B16E710;
        Thu, 22 Aug 2019 11:12:54 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, binutils@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: Re: ELF NT_GNU_PROPERTY_TYPE_0 Questions
References: <20190822110049.GE27757@arm.com>
Date:   Thu, 22 Aug 2019 13:12:53 +0200
In-Reply-To: <20190822110049.GE27757@arm.com> (Dave Martin's message of "Thu,
        22 Aug 2019 12:00:50 +0100")
Message-ID: <87k1b5xxl6.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 22 Aug 2019 11:12:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Martin:

> Hi there,
>
> Can you clarify a couple of points about the SysV ABI Linux
> Extensions [1] for me?
>
> 1) Can there be more than one NT_GNU_PROPERTY_TYPE_0 note in a valid
> ELF file?  I think the answer should be "no".

Yes, if it has been produced by a link editors which does not about
property notes.  The ELF file still needs to be treated as valid, but
the note should be ignored.

> 2) Is is permissible for an ELF ET_EXEC or ET_DYN file that contains
> an NT_GNU_PROPERTY_TYPE_0 property not to have a PT_GNU_PROPERTY phdrs
> entry mapping it?  Except for historical usage by RedHat (which
> apparently can be worked round in userspace) it seems reasonable for
> the answer to be "no", at least for Linux.

Using an older link editor on a CET-enabled distribution will produce
such binaries, too.  The ELF file still needs to be treated as valid,
but the property date should be ignored.

> 3) Is it permissible for the PT_GNU_PROPERTY phdr (if present) to
> map anything other than precisely one NT_GNU_PROPERTY_TYPE_0
> note?  I think the answer should be "no".

Correct.  Additional processing logic in the link editor is needed.

> 4) Is an NT_GNU_PROPERTY_TYPE_0 note allowed to contain two or more
> properties with the same pr_type?  I think the answer should be "no".

H.J. needs to answer that.

> 5) What's the rationale for sorting the properties by pr_type?  I can
> see this would make it easier for the linker to merge
> NT_GNU_PROPERTY_TYPE_0 notes from different files, but I'm wondering
> whether the kernel really needs to enforce the ordering when loading
> an ELF.  The kernel doesn't need to merge property lists together.

Likewise.

> 6) Do you have a view on the best way to define the Elf_Prop type in
> headers?  bfd elf-bfd.h seems to have elf_property, but this doesn't
> follow the style of the public ELF headers.

We should put it into <elf.h> in glibc.  We don't want to rely on UAPI
headers there because this version of <elf.h> is used in many places.

Thanks,
Florian
