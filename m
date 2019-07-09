Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20779C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB3A208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562703437;
	bh=/7w2s/MYH1JhMDmaUyVtvh5HJdLLcWL4dUX+RYNl888=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vszvVbv4dXE6ET4auA51P47f+XDQi19MCIYzViY3FSPVmyHItogHoxkU2leH3a1pD
	 nlO/b4Ry4z/9LowQcy5AQ9dxn/h1d4M2+4gj+/PO/mhiQq6kRGjLAVBDG20ct2CbTR
	 XyFIWV5lb0mIh49mcyqcfxjvlcNfk6SMLoevOT5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfGIURP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbfGIURP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:17:15 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4359D2073D;
        Tue,  9 Jul 2019 20:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562703434;
        bh=/7w2s/MYH1JhMDmaUyVtvh5HJdLLcWL4dUX+RYNl888=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1zb64ASlEC203NksJleQ987t2K4CdmHfcYyXBkEyww967+p0KR51WgOm+k9HzaOG+
         x4YY9k1okgvBw7KK5T1OVVaTqsSKpRiLci2oPhPlGabLQi8X+X5zID6h7C+3pEbnjQ
         g2lxW3/kGHVIEB/1pyXk/h13qFa/XaI734p5yDiU=
Date:   Tue, 9 Jul 2019 13:17:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: next-20190705 - problems generating certs/x509_certificate_list
Message-ID: <20190709201712.GI641@sol.localdomain>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        keyrings@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <27671.1562384658@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27671.1562384658@turing-police>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:44:18PM -0400, Valdis Klētnieks wrote:
> This worked fine in next-20190618, but in next-20190701 I'm seeing dmesg
> entries at boot:
> 
> dmesg | grep -i x.509
> [    8.345699] Loading compiled-in X.509 certificates
> [    8.366137] Problem loading in-kernel X.509 certificate (-13)
> [    8.507348] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    8.526556] cfg80211: Problem loading in-kernel X.509 certificate (-13)
> 
> I start debugging, and discover that certs/x509_certificate_list is a zero-length file.
> I rm it, and 'make V=1 certs/system_certificates.o', which tells me:
> 
> (....)
> make -f ./scripts/Makefile.headersinst obj=include/uapi
> make -f ./scripts/Makefile.headersinst obj=arch/x86/include/uapi
> make -f ./scripts/Makefile.build obj=certs certs/system_certificates.o
> ---- smoking gun alert
>   scripts/extract-cert "" certs/x509_certificate_list
> ----
>   gcc -Wp,-MD,certs/.system_certificates.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/9/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -D__KERNEL__ -D__ASSEMBLY__ -fno-PIE -m64 -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wa,-gdwarf-2 -DCC_USING_FENTRY -I.   -c -o certs/system_certificates.o certs/system_certificates.S
> 
> I go look at extract-cert.c, and sure enough, if the first parameter is a null string
> it just goes and creates an empty file.
> 
> The Makefile says:
> 
> quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
>       cmd_extract_certs  = scripts/extract-cert $(2) $@
> 
> and damned if I know why $(2) is "". Diffed the config files from -0618 and -0705,
> not seeing anything relevant difference.
> 
> Any ideas?
> 

I'm seeing on mainline now:

[   10.915386] Problem loading in-kernel X.509 certificate (-13)

- Eric
