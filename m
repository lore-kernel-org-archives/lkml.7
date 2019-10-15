Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE608C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE25221835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571100048;
	bh=Lrmoll/pF3oUfimztWipSNNRZNM5JU3Kg9wAkgeg81U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nFw9AKB3knyeqkfQOmtpEtkQox4raRMxGeJCXi5WoDhimDl0PtDZNNyngwk6KUmJL
	 B6mKlm0/D8RQKwYhZX0G/hOjmVVp7V7NhcWgQ0/4sM2whqYVckzizQEjyMJM9KHj5W
	 eBxJLNUFFfBEjK/b3hVI/oFyfN/aWCJjJZmnL5J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJOAkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfJOAkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:40:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5718020663;
        Tue, 15 Oct 2019 00:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571100046;
        bh=Lrmoll/pF3oUfimztWipSNNRZNM5JU3Kg9wAkgeg81U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQaNKe3LDR4djt9gdNK+YnNIG9wxxr7x92+xjobfCJ2roqQP9L4pUA0BBTLtkfXNS
         akiHuwg4zzzveZJGx8qolBBQfv3Bs70iqAcktG1dHzrOX7+++VDUpZ/gOvYTL25eOX
         kJuLebsM857ZU2dtCqNPz+Fa6cCJnCsC5ZI1OUHg=
Date:   Tue, 15 Oct 2019 01:40:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: inform about bootloader-provided randomness
Message-ID: <20191015004041.oijbe245is5rhev2@willie-the-truck>
References: <20191005113632.GA74715@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005113632.GA74715@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 01:36:32PM +0200, Dominik Brodowski wrote:
> Inform how many bits of randomness were provided by the bootloader,
> and whether we trust that input.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Will Deacon <will@kernel.org>
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index de434feb873a..673375e05c0d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2515,6 +2515,10 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
>   */
>  void add_bootloader_randomness(const void *buf, unsigned int size)
>  {
> +	pr_notice("random: adding %u bits of %sbootloader-provided randomness",
> +		size * 8,
> +		IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER) ? "trusted " : "");
> +
>  	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
>  		add_hwgenerator_randomness(buf, size, size * 8);
>  	else

Looks fine to me:

Acked-by: Will Deacon <will@kernel.org>

Will
