Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84626C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465432175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558686675;
	bh=cOpIXjCWAwSoPaaq155wr/SoQ9nOPr8nFPwrgTL3kkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a3an3ZlzVHXzoPsKNjs5sWZe11RDuRX2RDRshMTBUB6P53YJimqGMN4je4EZbqoUs
	 SkqUOwWE8EvhwLU8vfQYMsx/5Zbdog8CAMxmmQ3MsZK/wEdZouZLdqcSEGyHabNBdo
	 9mk7nJ4D5WqqZ59pwNcUj4Xow2CjNX6H9RDFRN2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbfEXIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389327AbfEXIbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:31:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7636D20675;
        Fri, 24 May 2019 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558686673;
        bh=cOpIXjCWAwSoPaaq155wr/SoQ9nOPr8nFPwrgTL3kkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TukiTooln7P5MuTvmAXSj+R7tHmKwqqLLTxU+Rp75HpARca8VWHmksbrvkfeqssUh
         go01oXNBoLlxHjD22dGdtmGXcrJW7OtoKuI1cWjx/e4pwH1kEYWIIrWmfMMXtFptto
         OIATy83Q4UCGI6UFpJ4Ap1M8LaKcy1mZmDKXe22Y=
Date:   Fri, 24 May 2019 10:31:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [BUG] USB: atm: Licensing conflict
Message-ID: <20190524083110.GA16254@kroah.com>
References: <alpine.DEB.2.21.1901181150090.1647@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901181150090.1647@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:53:18AM +0100, Thomas Gleixner wrote:
> The addition of SPDX identifiers to the USB subsystem introduced a license
> conflict. The driver is dual licensed under GPL v2 and BSD 2 clause
> according to the license texts in the file. But even the GPL v2 licensing
> of this driver is ambiguous:
> 
>  * This software is available to you under a choice of one of two
>  * licenses. You may choose to be licensed under the terms of the GNU
>  * General Public License (GPL) Version 2, available from the file
>  * COPYING in the main directory of this source tree, or the
> 
> This points to the kernel license which is GPL v2 only.
> 
>  * BSD license below:
>  *
>  * Redistribution and use in source and binary forms, with or without
>  * modification, are permitted provided that the following conditions
>  * are met:
>  * 1. Redistributions of source code must retain the above copyright
>  *    notice [unmodified], this list of conditions, and the following
>  *    disclaimer.
>  * 2. Redistributions in binary form must reproduce the above copyright
>  *    notice, this list of conditions and the following disclaimer in the
>  *    documentation and/or other materials provided with the distribution.
>  *
>  * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
>  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
>  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
>  * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
>  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
>  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
>  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
>  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
>  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
>  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>  * SUCH DAMAGE.
> 
> This is clearly a BSD 2 Clause license and not BSD 3 Clause
> 
>  * GPL license :
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License
>  * as published by the Free Software Foundation; either version 2
>  * of the License, or (at your option) any later version.
> 
> And here the license is GPL V2 or later.
> 
> Some detective work is due ...

Dug into this now, patches are sent to resolve this, thanks for letting
me know.

greg k-h
