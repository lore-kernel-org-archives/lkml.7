Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35919C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A8D2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2Y8e8ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfGISl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:41:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40684 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfGISl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:41:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so9710406pfp.7;
        Tue, 09 Jul 2019 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7mRDpdwyWxZq2wO8TvWNgc04/fYMS0yJ2sBb7G4LNi4=;
        b=q2Y8e8aeAwgbcMcfwE8lzxh5vYEBYtKuSrskwyf8ott5tKbXO8HzaI3zMJ+GoU/MtW
         zXUnydZ2t7ogPzS+kZdLwQFqChgcMy6bW9hrddliGFNaL0CR661bTdQXfLpmillmiO1l
         K3WL5SvULiTP2wgjQsSRqtHPdh9xYfs8w0WNiyxi+2bkwKkuKuKMsewf3m8809rb0Kly
         NobJrGm8WBEe78o4qqKGFABtsJLbCJdAtZNMREV1YcUVcfCsu+xH4Wvqb6+deE1Uk5iT
         itfkl3dPWhbDfK3F7f9itlIgN2ZdUQWT7sxvxJPaBp7J3k5p/wGs8CUlC4CD9KlXPzxJ
         4/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7mRDpdwyWxZq2wO8TvWNgc04/fYMS0yJ2sBb7G4LNi4=;
        b=c6sRmf5zbSkRu6TxyysxiI/zZv9PIFprIsK7Q59nEVh/jCDpPCXzPZBgGIxqflFlih
         UTeij+NP+EzUbrwoqZawRELlJxmTijAq8mDqWJ6yCpgTFXzFOw4eN9ndV//E7vPVf0jI
         uR2ONtwtl+7WqSTzSSS+VIH6mZOcVTQ2GSiAYl93LtNLaKl5Q/oK1GGQ2HvMtNp7+Mws
         DaMqXyH9ZJJsg7+OJ9hnF64k74s6g5KozYxShnmvbeNLKBz6yGdO8Ys5B4r4PPiDt0ln
         ApUI2iTLz5dcXrFYyWAirhyFumUGERHqpSnKzvGo19ZM1+SIPS4TPYmz5RzjQMXO084z
         E8jA==
X-Gm-Message-State: APjAAAUHuMzx7Msr8FIcQUA/Rs72d+0/Nosiu3IqW1LQ/O3Kke4Plzgv
        gSqB6LiIRwetbF+HXmZaUiU=
X-Google-Smtp-Source: APXvYqyqSMrhkZKCqvTQLUjjZzxs7co0e3noKW6Z//N+rmxM2L+kls2HB9tEI0g6wdNl3b/895Eqtw==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr1590700pjs.55.1562697716130;
        Tue, 09 Jul 2019 11:41:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7sm26166762pfp.131.2019.07.09.11.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:41:55 -0700 (PDT)
Date:   Tue, 9 Jul 2019 11:41:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.1 00/96] 5.1.17-stable review
Message-ID: <20190709184154.GD2656@roeck-us.net>
References: <20190708150526.234572443@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:12:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.17 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 10 Jul 2019 03:03:52 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 364 pass: 364 fail: 0

Guenter
