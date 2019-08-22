Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8372339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfHVUAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731648AbfHVUAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:00:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB92E3175283;
        Thu, 22 Aug 2019 20:00:30 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D43B419C5B;
        Thu, 22 Aug 2019 20:00:29 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:00:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 03/18] objtool: Move registers and control flow to
 arch-dependent code
Message-ID: <20190822200027.e4oidncgyj5oq7to@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-4-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-4-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 22 Aug 2019 20:00:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:48PM +0100, Raphael Gault wrote:
> The control flow information and register macro definitions were based on
> the x86_64 architecture but should be abstract so that each architecture
> can define the correct values for the registers, especially the registers
> related to the stack frame (Frame Pointer, Stack Pointer and possibly
> Return Address).
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  tools/objtool/arch/x86/include/arch_special.h | 36 +++++++++++++++++++
>  tools/objtool/{ => arch/x86/include}/cfi.h    |  0
>  tools/objtool/check.h                         |  1 +
>  tools/objtool/special.c                       | 19 +---------
>  4 files changed, 38 insertions(+), 18 deletions(-)
>  create mode 100644 tools/objtool/arch/x86/include/arch_special.h
>  rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)
> 
> diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
> new file mode 100644
> index 000000000000..424ce47013e3
> --- /dev/null
> +++ b/tools/objtool/arch/x86/include/arch_special.h

The arch in the filename is redundant.  It would be a bit nicer if it
were named "special.h" but I guess that would conflict with the non-arch
special.h, unless we put non-arch headers and arch headers in separate
namespaces somehow.  Maybe it's ok for now unless anybody has a better
idea.

> @@ -0,0 +1,36 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

Instead of the above can you use the SPDX identifier?

/* SPDX-License-Identifier: GPL-2.0-or-later */

And the same comment for the other headers in the patch set.

-- 
Josh
