Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E928207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574878784;
	bh=3z/LI0ZW+lWzsFFtnbhGfCPlI9pGPLBMxsnuKFuuTxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jIrAuFM0LIKHvKGBaFGgzLkVjg9Ucrp77n+ArU4EODNOmfVwiy8K7/bYXpz3ULKl8
	 nO6FPqeLvmdWmXMzNiqVDoAILYt1DX0q7gqZ1vVCVQONxaSp+S9HgJwYe+qd/jP4FR
	 6i42jPKo5MV2UjW3LeIOEWoBXJEkzA7LsjXPv/vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK0STn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfK0STn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:19:43 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DEA72070B;
        Wed, 27 Nov 2019 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574878782;
        bh=3z/LI0ZW+lWzsFFtnbhGfCPlI9pGPLBMxsnuKFuuTxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCI00rr6Y6zcqdb8oSw3hpBOnEFRedT3VgxdgpCBrRq0CHnPg+iFvzaoFjMMou/tm
         lLPWW4i7EsV+xNfeARsrDmT3BPHdCbbuKt0StnvdNbWj4KfPY5Lrlcirz5leqh+QAk
         DLwSqC8CR65E43Xx9abjOEfXf/edj6DU1MR/MyR0=
Date:   Wed, 27 Nov 2019 10:19:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3] crypto: arm64/sha: fix function types
Message-ID: <20191127181940.GB49214@sol.localdomain>
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191119201353.2589-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119201353.2589-1-samitolvanen@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:13:53PM -0800, Sami Tolvanen wrote:
> +static void __sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> +				int blocks)
> +{
> +	return sha1_ce_transform(container_of(sst, struct sha1_ce_state, sst),
> +				 src, blocks);
> +}
> +

'return' isn't needed in functions that return void.

Likewise everywhere else in this patch.

Otherwise this patch looks fine.

- Eric
