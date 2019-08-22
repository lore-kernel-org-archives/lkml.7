Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E43C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BFA2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfHVT50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfHVT50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:57:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE167A2BDB4;
        Thu, 22 Aug 2019 19:57:25 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD5C060925;
        Thu, 22 Aug 2019 19:57:24 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:57:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 01/18] objtool: Add abstraction for computation of
 symbols offsets
Message-ID: <20190822195722.gx36v32x2zfythwy@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-2-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-2-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Thu, 22 Aug 2019 19:57:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:46PM +0100, Raphael Gault wrote:
> @@ -672,14 +672,19 @@ static int add_call_destinations(struct objtool_file *file)
>  			}
>  
>  		} else if (rela->sym->type == STT_SECTION) {
> +			/*
> +			 * the original x86_64 code adds 4 to the rela->addend
> +			 * which is not needed on arm64 architecture.
> +			 */
> +			dest_off = arch_dest_rela_offset(rela->addend);

I agree with Julien that this comment isn't needed.  The "arch_" prefix
already implies there are arch-specific differences.

Also, this patch should replace all the other "addend + 4" usages:

$ git grep "addend + 4" tools/objtool
tools/objtool/arch/x86/decode.c:        return addend + 4;
tools/objtool/check.c:                  dest_off = rela->addend + 4;
tools/objtool/check.c:                  dest_off = rela->sym->sym.st_value + rela->addend + 4;

-- 
Josh
