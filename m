Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D114C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6AA2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YfMz2eXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLRLCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:02:42 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47357 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLRLCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:02:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47dBtQ3mHmz9sRv;
        Wed, 18 Dec 2019 22:02:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576666959;
        bh=FWlAjNM6cmTI+9Vit59LLCQZ6i+spyEjv7d/aZR81VA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YfMz2eXYxZdO8Wm8veuFf9IU7mF9LyzoX4KVXYDjvPFDtpb8Ogrf3H2FiPowFSIDR
         ad5k7V9s+DndepXK9fOd/Ln4IuytMJ/1GWUaXHRLf02gCeZlO8FWv2a9cvEZBj9jv/
         iGmTiTQ4e9KOdspMX1dzYDrdT7QNc5P0/GhXtYYQoY7h0Mu183rMtWvHx7Kb9zUUPZ
         tGVedghPFNXaDxiDgIhnDYQlqhqvPHgVp8B2EqTzct11UEe76IuwRhgrybe/Q2l9ST
         Qo+x79Fqyi/6Smi/zsqiCMAgrfhD3AZDBjzqCFFGBJMUuS3nsugek6U1Juu2rBru/6
         97/GJw+nsU7eQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Chen Zhou <chenzhou10@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        chenzhou10@huawei.com, Nicolai Stange <nicstange@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH] powerpc/setup_64: use DEFINE_DEBUGFS_ATTRIBUTE to define fops_rfi_flush
In-Reply-To: <20191218020842.186446-1-chenzhou10@huawei.com>
References: <20191218020842.186446-1-chenzhou10@huawei.com>
Date:   Wed, 18 Dec 2019 22:02:36 +1100
Message-ID: <8736dhoq0j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Zhou <chenzhou10@huawei.com> writes:
> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> debugfs files.
>
> Semantic patch information:
> Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> imposes some significant overhead as compared to
> DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

I know you didn't write this text, but these change logs are not great.
It doesn't really explain why you're doing it. And it is alarming that
you're converting *to* a function with "unsafe" in the name.

The commit that added the script:

  5103068eaca2 ("debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage")

Has a bit more explanation.

Maybe something like this:

  In order to protect against file removal races, debugfs files created via
  debugfs_create_file() are wrapped by a struct file_operations at their
  opening.
  
  If the original struct file_operations is known to be safe against removal
  races already, the proxy creation may be bypassed by creating the files
  using DEFINE_DEBUGFS_ATTRIBUTE() and debugfs_create_file_unsafe().


The part that's not explained is why this file is "known to be safe
against removal races already"?

It also seems this conversion will make the file no longer seekable,
because DEFINE_SIMPLE_ATTRIBUTE() uses generic_file_llseek() whereas
DEFINE_DEBUGFS_ATTRIBUTE() uses no_llseek.

That is probably fine, but should be mentioned.

cheers

> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/powerpc/kernel/setup_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 6104917..4b9fbb2 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -956,11 +956,11 @@ static int rfi_flush_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
>  
>  static __init int rfi_flush_debugfs_init(void)
>  {
> -	debugfs_create_file("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
> +	debugfs_create_file_unsafe("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
>  	return 0;
>  }
>  device_initcall(rfi_flush_debugfs_init);
> -- 
> 2.7.4
