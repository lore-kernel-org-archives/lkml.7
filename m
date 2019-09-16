Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C9FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985D20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfIPPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:06:50 -0400
Received: from baldur.buserror.net ([165.227.176.147]:34794 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfIPPGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:06:50 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1i9sYG-0008L7-6q; Mon, 16 Sep 2019 10:04:28 -0500
Message-ID: <71490f3b94b851106eb48c8909239f401d0018d1.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        galak@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Sep 2019 10:04:27 -0500
In-Reply-To: <7f8f9747ef1ab2e1261cf83b03c1da321d47f7b7.1568616151.git.christophe.leroy@c-s.fr>
References: <966e6d6a226f9786098d296239a6c65064e73a41.1568616151.git.christophe.leroy@c-s.fr>
         <7f8f9747ef1ab2e1261cf83b03c1da321d47f7b7.1568616151.git.christophe.leroy@c-s.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2 2/2] powerpc/83xx: map IMMR with a BAT.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 06:42 +0000, Christophe Leroy wrote:
> @@ -145,6 +147,15 @@ void __init mpc83xx_setup_arch(void)
>  	if (ppc_md.progress)
>  		ppc_md.progress("mpc83xx_setup_arch()", 0);
>  
> +	if (!__map_without_bats) {
> +		phys_addr_t immrbase = get_immrbase();
> +		int immrsize = IS_ALIGNED(immrbase, SZ_2M) ? SZ_2M : SZ_1M;
> +		unsigned long va = __fix_to_virt(FIX_IMMR_BASE);

Why __fix_to_virt() and not fix_to_virt()?

-Scott


