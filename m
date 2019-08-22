Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79743C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FC521848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfHVUKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731991AbfHVUKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0138B106BB20;
        Thu, 22 Aug 2019 20:10:21 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C96BC5C221;
        Thu, 22 Aug 2019 20:10:19 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:10:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 12/18] arm64: assembler: Add macro to annotate asm
 function having non standard stack-frame.
Message-ID: <20190822201017.3w77h374qs5uyxso@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-13-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-13-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 20:10:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:57PM +0100, Raphael Gault wrote:
> Some functions don't have standard stack-frames but are intended
> this way. In order for objtool to ignore those particular cases
> we add a macro that enables us to annotate the cases we chose
> to mark as particular.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  include/linux/frame.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/frame.h b/include/linux/frame.h
> index 02d3ca2d9598..1e35e58ab259 100644
> --- a/include/linux/frame.h
> +++ b/include/linux/frame.h
> @@ -11,14 +11,31 @@
>   *
>   * For more information, see tools/objtool/Documentation/stack-validation.txt.
>   */
> +#ifndef __ASSEMBLY__
>  #define STACK_FRAME_NON_STANDARD(func) \
>  	static void __used __section(.discard.func_stack_frame_non_standard) \
>  		*__func_stack_frame_non_standard_##func = func
> +#else
> +	/*
> +	 * This macro is the arm64 assembler equivalent of the
> +	 * macro STACK_FRAME_NON_STANDARD define at
> +	 * ~/include/linux/frame.h
> +	 */

This comment is a bit confusing as it's referring to its own header
file.  And it's not arm64-specific.  I don't think we really need a
comment here anyway.

> +	.macro	asm_stack_frame_non_standard	func
> +	.pushsection ".discard.func_stack_frame_non_standard"
> +	.quad	\func
> +	.popsection
> +	.endm

Can you call it STACK_FRAME_NON_STANDARD for consistency with the
non-asm version?

-- 
Josh
