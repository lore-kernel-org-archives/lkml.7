Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2560AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F305F21726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbfHVNJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:09:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53435 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388969AbfHVNJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGv5YRdz9sPl; Thu, 22 Aug 2019 23:09:11 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 415480dce2ef03bb8335deebd2f402f475443ce0
In-Reply-To: <80432f71194d7ee75b2f5043ecf1501cf1cca1f3.1566196646.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Doug Crawford <doug.crawford@intelight-its.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/603: fix handling of the DIRTY flag
Message-Id: <46DlGv5YRdz9sPl@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:11 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 06:40:25 UTC, Christophe Leroy wrote:
> If a page is already mapped RW without the DIRTY flag, the DIRTY
> flag is never set and a TLB store miss exception is taken forever.
> 
> This is easily reproduced with the following app:
> 
> void main(void)
> {
> 	volatile char *ptr = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 
> 	*ptr = *ptr;
> }
> 
> When DIRTY flag is not set, bail out of TLB miss handler and take
> a minor page fault which will set the DIRTY flag.
> 
> Fixes: f8b58c64eaef ("powerpc/603: let's handle PAGE_DIRTY directly")
> Cc: stable@vger.kernel.org
> Reported-by: Doug Crawford <doug.crawford@intelight-its.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/415480dce2ef03bb8335deebd2f402f475443ce0

cheers
