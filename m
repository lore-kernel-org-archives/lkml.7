Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D041208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfFQSLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:11:22 -0400
Received: from namei.org ([65.99.196.166]:39700 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfFQSLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:11:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5HIB5hc026662;
        Mon, 17 Jun 2019 18:11:05 GMT
Date:   Mon, 17 Jun 2019 11:11:05 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Nayna Jain <nayna@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrity: Fix __integrity_init_keyring() section
 mismatch
In-Reply-To: <20190617074452.12901-1-geert@linux-m68k.org>
Message-ID: <alpine.LRH.2.21.1906171110550.25545@namei.org>
References: <20190617074452.12901-1-geert@linux-m68k.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Geert Uytterhoeven wrote:

> With gcc-4.6.3:
> 
>     WARNING: vmlinux.o(.text.unlikely+0x24c64): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys()
>     The function __integrity_init_keyring() references
>     the function __init set_platform_trusted_keys().
>     This is often because __integrity_init_keyring lacks a __init
>     annotation or the annotation of set_platform_trusted_keys is wrong.
> 
> Indeed, if the compiler decides not to inline __integrity_init_keyring(),
> a warning is issued.
> 
> Fix this by adding the missing __init annotation.
> 
> Fixes: 9dc92c45177ab70e ("integrity: Define a trusted platform keyring")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

