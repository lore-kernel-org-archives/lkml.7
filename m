Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93867C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2CB23A1B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="ihI5KqDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE2OYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:24:43 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:21814 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE2OYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:24:42 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 10:24:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559139880;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=hEg459JKNjMZU93JrKXvFePGJVmrCgpuxqZhr0jzbp8=;
        b=ihI5KqDB4pVEUqLq3JLZG6AIUhzUOWAqdVUiSi8AG9ych9hn2FqHEyY+yMngRmc1mL
        xoczZSwZ2agM/mnvJxGakSnSNYREKR6dacmVEmd5Uv1dD/feXoGH0zfApnti1ghOHFdu
        izs6Nou3TShL09IoySp8/vscBH7A7wn0Tyu2NhCoSspbs0fM9ewFsCf6vAu/9k6s50su
        FJxKXYOtmS/CQZOlNbumRntdGke9qmwTVd4zeYjjm8INn6LIwFphQSeJkYtMXKDQMGwc
        NoVQmyzigbDqaOWVATuQBKhVcdHjQetsBCUWQ0KfSPPyVEzLC8RmTP5rogZNiTa80pDQ
        A0iA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbLvSf34ur"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id R0373fv4TEIIvuo
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 29 May 2019 16:18:18 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     David Gstir <david@sigma-star.at>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: Can an ahash driver be used through shash API?
Date:   Wed, 29 May 2019 16:18:18 +0200
Message-ID: <4256916.YlTHG9RRyR@tauon.chronox.de>
In-Reply-To: <729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at>
References: <729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. Mai 2019, 16:04:47 CEST schrieb David Gstir:

Hi David,

> Hi!
> 
> I've done some testing with hardware acceleration of hash functions
> and noticed that, when using the synchronous message digest API (shash),
> some drivers are not usable. In my case the CAAM driver for SHA256.
> Using the asynchronous interface (ahash), everything works as expected.
> Looking at the driver source, the CAAM driver only implements the ahash
> interface.
> 
> I'm wondering if there a way to use an ahash driver through the shash
> interface?

Short: no.
> 
> I've seen that it does actually work the other way around, since
> crypto_init_shash_ops_async() in crypto/shash.c takes care of translating
> calls from ahash to shash and that's how the *-generic drivers are usable
> through the ahash API.

The crypto_alloc_shash will only identify cipher implementations that were 
registered with the CRYPTO_ALG_TYPE_SHASH flag. That flag is set when a cipher 
is registered using crypto_register_shash.

Thus, ciphers registered with crypto_register_ahash will not bear this flag 
and thus will not be found by the allocation function.

Ciao
Stephan


