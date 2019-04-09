Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D488020833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OpDzbeTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDIQUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:20:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45010 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9imv8zmeNakxRzEk5Gp6PO+5BWFNMWRb4XZCaz5T864=; b=OpDzbeTN0eTNcSzbJSfUzlzlH
        tffFRcXesd1LRtPlJWom6JqRr/wMvNWW27ajHc7TH3/5f8h+jx/QuyQA77PDDlKr+2KL+8hiJ2rg5
        yZmTPkU049xb6YBx3DwodswZbKFh1eknhPUFwWLfqQHIY3EY0DX0tsLUpixilERgcNTRd0m/CtuGn
        6EK8uTXe8nYW8xqcg8yYxDxg67JvRg2bPup/omtvMSI5JmhqpTqgEU9ImbohXUqtDAt2qln4K2HNA
        9pVmRch2REayQlUp5S0PYccHDet9XY7Az9OaUlO7ErOclGzPm5XzbYyf5FgWhCzB+GDZ/AKuiXXxq
        vM0xza87w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDtU6-0001Cb-DG; Tue, 09 Apr 2019 16:20:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F27A0201F29A3; Tue,  9 Apr 2019 18:20:28 +0200 (CEST)
Date:   Tue, 9 Apr 2019 18:20:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC 2/6] objtool: arm64: Add required implementation for
 supporting the aarch64 architecture in objtool.
Message-ID: <20190409162028.GT11158@hirez.programming.kicks-ass.net>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-3-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409135243.12424-3-raphael.gault@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:52:39PM +0100, Raphael Gault wrote:

> The decoding of the instruction is split into classes and subclasses as described into
> the Instruction Encoding in the ArmV8.5 Architecture Reference Manual.

>  tools/objtool/arch/arm64/decode.c             | 2843 +++++++++++++++++

Oh man, I hope you generated much of that from the ARM64 Instruction Set
Architecture XML files [*]. Otherwise that's been a lot of typing.

Anyway, since you now have that, would it make sense to use this same
decoder in your kernel tree? I found at least one partial decoder in
arch/arm64/kernel/probes/decode-insn.c, but I suspect you have more.

(Note kprobes is how x86 initially grew its instruction decoder IIRC)


* https://developer.arm.com/architectures/cpu-architecture/a-profile/exploration-tools
