Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A6FC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE851208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YKatqYp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbfFLU4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:56:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34908 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390632AbfFLU4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:56:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so10380792pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TZPBYSKEoaIkhIv00E3WuJ5aJFmWavGoQVJ9IN5iIvo=;
        b=YKatqYp5ZMD0rZsPMDq0to0PJDreG1XUyrx5SqWGPFgdgJtrZRf5AOIxLF1RFphdWH
         R8Uycb+uWLqjH30x5HeS9diZaO6zEKBi4ehrFWwTQQhEoyWIgNqsqXzSVDTswGRL/9KD
         uhKfahNauFol7O1XFQvxQp5RulEWOEW7iex6oysSu++JNYIgkrqn3WOcSrgDk5zaBXNp
         8B+4btiQ/WZSa7P4mcOyuxUL08dr8X75WN0f9Llk7Bg6kYQ1G/dW5uqsTcyfJCabZyCo
         CSzxOII00f5vEnofzolLz3aqRMf0Y2IeopHbP2PjiAMHgx7OfqBg8uf57PLTsF74jSYO
         KVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TZPBYSKEoaIkhIv00E3WuJ5aJFmWavGoQVJ9IN5iIvo=;
        b=L4XUKFN+II0jtwlRP8R2Mff+pxaa/vakuiIzlv0JZdaJMKQfh+hE9vHVGjKUNH2clO
         ODuUKmmQ2dK5/K4OuYtJThjYlpN2H0gnkNC4SZrhNuphCZ6ZukxA6lY1jgEMv7kRE7lY
         /QB8d0lgZz+0/ZfhwMeZUH/aupLSm6HTrsHJTisarCIs833MSNG+4XeSeIj/Khc/wy3g
         5mGnYX0CQg3JDZYs0wl5Ybb3X9MJg9ImSlQWdH0o95EpdaR+g4HZEaA3O+JKm4VqG9Mm
         ZeRDcWfgq7S3PLT9PvYvH4wI1Q0iSL8wOe311+dmiE2lAVOZDRqzBJDFKN3tIxiUKelw
         53sw==
X-Gm-Message-State: APjAAAWQtJvKpJgIc2FTGpmt3jKZ/1tVBFMT6MbwoCrwK9/lbp+ysXR3
        IzK6qzSwRKe4nhQPqORxErs00ppDFlyQ3w==
X-Google-Smtp-Source: APXvYqxo/ItMtB3OUs84fhqaf0UCPf/u6DxMcudVwkkrFpAqbneRAxpY8FuZIOMzxuIx2mCUlvJvAg==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr89000454pfk.239.1560372995458;
        Wed, 12 Jun 2019 13:56:35 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e92e:2d95:2c68:42e6? ([2601:646:c200:1ef2:e92e:2d95:2c68:42e6])
        by smtp.gmail.com with ESMTPSA id v18sm455164pfg.182.2019.06.12.13.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:56:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 00/10] Process-local memory allocations for hiding KVM secrets
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <3cd533c1-3f18-a84f-fbb2-264751ed3eeb@intel.com>
Date:   Wed, 12 Jun 2019 13:56:31 -0700
Cc:     Marius Hillenbrand <mhillenb@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, Alexander Graf <graf@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD3482AC-3FB0-41DE-9347-5BD7C3DE8B11@amacapital.net>
References: <20190612170834.14855-1-mhillenb@amazon.de> <eecc856f-7f3f-ed11-3457-ea832351e963@intel.com> <A542C98B-486C-4849-9DAC-2355F0F89A20@amacapital.net> <3cd533c1-3f18-a84f-fbb2-264751ed3eeb@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 12, 2019, at 1:41 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 6/12/19 1:27 PM, Andy Lutomirski wrote:
>>> We've discussed having per-cpu page tables where a given PGD is
>>> only in use from one CPU at a time.  I *think* this scheme still
>>> works in such a case, it just adds one more PGD entry that would
>>> have to context-switched.
>> Fair warning: Linus is on record as absolutely hating this idea. He
>> might change his mind, but it=E2=80=99s an uphill battle.
>=20
> Just to be clear, are you referring to the per-cpu PGDs, or to this
> patch set with a per-mm kernel area?

per-CPU PGDs=
