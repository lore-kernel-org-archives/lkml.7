Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C333C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37934206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfDJDhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:37:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfDJDhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:37:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3143EF74B5;
        Wed, 10 Apr 2019 03:37:35 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F22E71001DC7;
        Wed, 10 Apr 2019 03:37:33 +0000 (UTC)
Date:   Tue, 9 Apr 2019 22:37:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/6] objtool: Add support for Arm64
Message-ID: <20190410033732.ibtpnd36655afpfj@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <CAKv+Gu_qGN8SG7ajkF7zAoAJd=qskC1oonmjzsqzZyGb9rYGLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_qGN8SG7ajkF7zAoAJd=qskC1oonmjzsqzZyGb9rYGLA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 10 Apr 2019 03:37:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:43:18AM -0700, Ard Biesheuvel wrote:
> On Tue, 9 Apr 2019 at 06:53, Raphael Gault <raphael.gault@arm.com> wrote:
> >
> > Hi,
> >
> > As of now, objtool only supports the x86_64 architecture but the
> > groundwork has already been done in order to add support for other
> > architecture without too much effort.
> >
> > This series of patches adds support for the arm64 architecture
> > based on the Armv8.5 Architecture Reference Manual.
> >
> 
> I think it makes sense to clarify *why* we want this on arm64. Also,
> we should identify things that objtool does today that maybe we don't
> want on arm64, rather than buy into all of it by default.

Agreed, the "why" should at least be in the cover letter.  From my
perspective, the "why" includes:

- Live patching - objtool stack validation is the foundation for a
  reliable unwinder

- ORC unwinder - benefits include presumed improved overall performance
  from disabling frame pointers, and the ability to unwind across
  interrupts and exceptions

- PeterZ's new uaccess validation?

-- 
Josh
