Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9536CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC7D21835
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VsTB+FtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfJ2Ln3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:29 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42860 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbfJ2Ln3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:29 -0400
Received: by mail-lj1-f172.google.com with SMTP id a21so14877353ljh.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M83Iy4PUSKtgLbhNDvSjjiCu9pY50pItVp7oVDhWeQg=;
        b=VsTB+FtJJL6fTlT2oLENyReJFw1K/M/Z3nMaE20bpM79KdW4rlM/PRdZv3dK4rbfFr
         0xgf5gIE/l2eJjOMF9hcIL1Mw2xWmC1RbMXZxdUKHCPJa3QPgNI6srbHoIc2nMvBfWNg
         fZluwfI2ueosXeisHRvFAmJ0Q9jLOU7/tpgmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M83Iy4PUSKtgLbhNDvSjjiCu9pY50pItVp7oVDhWeQg=;
        b=MJSpXePbsaiBiy+Gsgg5CT8hvtrefaNyAJCMgi7PkMITrEcCh+ufHUeg7Yo/OFD/fn
         z5vH1wlEZVC2W7SmHxwgaAqmJm7vWI3glc73EoV/EgFCoxwoN1AxpkODmvblCGukyeCr
         EzTxOFUz82XR2youQSD3uuFswBDtHVgdGgxnkEl9LO8yWoHTPzk/PGv35o7MnPNTLdyG
         xhJMpd7DXfwgU1+mBlWmuuWqF2qPAj8384NvEth2wkXGQ5zcslN9+9Z2ZAwn43WJO3Un
         CnTfBxqgbE0yFbD02vLv/5tUF08oN86LD8Ejl0Gq9PROrcioNg1MRbwhtEhNjrl7LtDV
         SFQA==
X-Gm-Message-State: APjAAAVnHkb9fpYJdXHVrgtcijbAyRRhTrgxehvVL/aPHDiVeKTz61Ke
        xyR1jecU98we2oBatjDJQoXdh9Sec8YJrsH1
X-Google-Smtp-Source: APXvYqw/feTkhqnQPFwlp5/Kij2FfUPZKSK7MCZqil4/t2hQoFpgZOgiWTjrKOSDG04g2B2B9EIGfQ==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr2362730ljk.62.1572349406342;
        Tue, 29 Oct 2019 04:43:26 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u11sm3315927ljo.17.2019.10.29.04.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 04:43:25 -0700 (PDT)
Subject: Re: detecting misuse of of_get_property
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.co>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191029104917.GI1944@kadam>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e255d01b-ecd7-8386-e99e-b3226dac27c4@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 12:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029104917.GI1944@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 11.50, Dan Carpenter wrote:
> This should probably work?

I haven't tested it, but yes, something like that. Can you also do the
case of struct property::value, i.e. handling

  struct property *p = ...;
  u32 *v = p->value;

Thanks,
Rasmus
