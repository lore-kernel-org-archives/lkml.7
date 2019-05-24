Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF5BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CC021851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391375AbfEXRm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfEXRm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EFF5308219F;
        Fri, 24 May 2019 17:42:28 +0000 (UTC)
Received: from treble (ovpn-121-106.rdu2.redhat.com [10.10.121.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 846315F7C5;
        Fri, 24 May 2019 17:42:26 +0000 (UTC)
Date:   Fri, 24 May 2019 12:42:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, will.deacon@arm.com, guillaume.gardet@arm.com,
        mark.rutland@arm.com, mingo@kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, x86@kernel.org
Subject: Re: [PATCH] x86/tools: deal with 64-bit relative relocations for
 per-CPU symbols
Message-ID: <20190524174224.pdj2hgyni675xaoi@treble>
References: <20190522174057.21770-1-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522174057.21770-1-ard.biesheuvel@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 24 May 2019 17:42:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 06:40:57PM +0100, Ard Biesheuvel wrote:
> In order to fix an issue in the place relative ksymtab code, we
> need to switch to 64-bit place relative references, which
> require special handling in the x86 'relocs' tool. The reason
> is that per-CPU symbols on x86_64 live in a separate link time
> section, whose load time address is not reflected in the ELF
> metadata, and so relative references emitted by the toolchain
> are guaranteed to be wrong.
> 
> So fix this by extending the handling of 32-bit relative references
> to per-CPU variables to support 64-bit relative references as
> well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
> This is a follow-up to [0] and a prerequisite to the change it
> implements: using 64-bit relative references on x86_64 requires
> this handling in the 'relocs' tool and in the decompressor.
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20190522150239.19314-1-ard.biesheuvel@arm.com
> 
> This patch plus [0] build and boot tested with x86_64_defconfig on QEMU/kvm + OVMF.

NACK based on

https://lkml.kernel.org/r/f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com

-- 
Josh
