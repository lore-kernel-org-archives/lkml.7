Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D42ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71882190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aXDs1GdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfJKXgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:36:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46084 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJKXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:36:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so10420604qkd.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 16:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aRw8hJuPAozTmVQlfAga1PNrnmiO6p/5H/4R+qW5ALA=;
        b=aXDs1GdPzcKKKOormFuS//NALpRaYnAjkxNTHPHLD7VaOZIKk/W9CyrGLEK/DMwtQe
         4CSKWUm5/ZnCR4p20bpX5RPlWNUqqt+7aYwRcQBHzWhAnytQ7wvawwGBx/77oItQmAn7
         jaifqJs4zff2zMJyOMSzLNiZ4Zd33e9LPY2QcodFP03XCmAvFTSOU8uDowX12QM4AYbq
         cEyMJGhkg2MRKnHLcdNUbWTgUNn3q32BS3NNRuJbzpksO+RIhhgR534TjGKaiNEZGx9T
         77iGve+xvPeZhmyoFJ+sPOTFHZ9QT8PVq/Gg/Z99FqBB6OQN77ZUT7SPPSREAaY9o0yp
         I8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aRw8hJuPAozTmVQlfAga1PNrnmiO6p/5H/4R+qW5ALA=;
        b=CdnUmERdULery6pCDfIvLbAKNFj2/pUB6MZFGkejPXR9zP6SvzKVy53uOhn82RGA6i
         ju23+D2q8xCYY/oP7jLliYfx5qMRZtO898dI/cUzwsKMeS2VhfH5Tqnn/PXqjq7pfXPx
         lRjZzfAzpUf44kIRIgXrbHt+CrkmdLhu5MfJq5tA+dSnBvuGniLaoS2K+dQUREJf3ccm
         DGdFvHcSsDaR6AIX1h84+zuCMRBARiIYDX9+ohaNiD/Czi2ZCT1LjEmwkAypoBa9M+Q6
         2yJYsdLPtKomE1si3yBMJtkopsMV0/xuvEqLK+tP1Wo3Q71rOqCXdINOSZqGi+kL/H4v
         1wug==
X-Gm-Message-State: APjAAAXj4+kE6P7MDOf5JiU5R2lQQqQZMD+/kWK/bLubgRsADYla5TO0
        E/SrbtQOrnG6lm3J1Q+qNGjENg==
X-Google-Smtp-Source: APXvYqzSc2HFdsBlaqRV99E/dFMnMal4Vn5+RT/NZBdiuRn+HdHjluTCmENwQM2s/hsIK4S0YHx/UA==
X-Received: by 2002:a37:412:: with SMTP id 18mr13073500qke.203.1570836959114;
        Fri, 11 Oct 2019 16:35:59 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q64sm5404232qkb.32.2019.10.11.16.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 16:35:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages creation
Date:   Fri, 11 Oct 2019 19:35:57 -0400
Message-Id: <36C2B5DF-7F21-42C6-BA77-6D86EDCB6BB3@lca.pw>
References: <20191011223955.1435-1-gpiccoli@canonical.com>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com,
        kernel@gpiccoli.net
In-Reply-To: <20191011223955.1435-1-gpiccoli@canonical.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2019, at 6:40 PM, Guilherme G. Piccoli <gpiccoli@canonical.com>=
 wrote:
>=20
> Kdump kernels won't benefit from hugepages - in fact it's quite opposite,
> it may be the case hugepages on kdump kernel can lead to OOM if kernel
> gets unable to allocate demanded pages due to the fact the preallocated
> hugepages are consuming a lot of memory.
>=20
> This patch proposes a new kernel parameter to prevent the creation of
> HugeTLB hugepages - we currently don't have a way to do that. We can
> even have kdump scripts removing the kernel command-line options to
> set hugepages, but it's not straightforward to prevent sysctl/sysfs
> configuration, given it happens in later boot or anytime when the
> system is running.

Typically, kdump kernel has its own initramfs, and don=E2=80=99t even need t=
o mount a rootfs, so I can=E2=80=99t see how sysfs/sysctl is relevant here.=
