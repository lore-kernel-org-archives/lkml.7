Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFC6C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045F20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="d/b9IEHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfHAMJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:09:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37518 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfHAMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:09:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so69920006qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4ZQ6TiKkp7FeZK0ooFcm/uroirFmJLs2m0Bg+zbC2WU=;
        b=d/b9IEHcXeYgcPKyu5UOkSrhbTP7nrZ9KXUmPqRUp1iIn8CmH1lqJYX/r5AGx/0zFV
         Od39MpqwOefCYos+oJY3aXdBU2283zsDVAEbJoNb5ZXYhoT4zdXGFehqbQx5P1UHeUwr
         NdSg/uIOrcAqKfp4Lb4xxsBWwkPe1EKmJRi/h5N+LcD/CXhQJNev+z0vsBg5PD8kthcA
         OS9GZ8NfDwDQp92qU4nJoB64gImJjr48hkawnZi60Zd38Yr0I2LhUDO8NwQSdrWDeLJo
         Jnq7F6leWN/VM5IcbxcC4sqmkTxFZE/qq/IXY4jAIFWHdOpiHSuNYlPSpKHi1j5fHtW/
         mc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4ZQ6TiKkp7FeZK0ooFcm/uroirFmJLs2m0Bg+zbC2WU=;
        b=rMYXsCINB1WqHHZ0xPoqFuUnl//MlGbgsT0QUwlXNRLiUubKuou5bkwzzTv8DUhFRh
         Ff+6h4EsGeARXuDJlFpGESPwD+UaXIxxHxZ20BJ+mM+n2/DlwtrG40TMOlqvn8t9/xz3
         o/D/Csr4Y5HD6WeZCdD7A0slRwqw2hQGbCesNEhSB4+dAvwGzoXhRTSgJVud0rjc5Ras
         9g5DTCZXbk60VHOUeqw3BnNj5JayBi4bWHTBfoTyBMiHi9X+1nMYp5vqYn1ZLzplvC0q
         UB9T4HOvk2sC2qdCmAeCUmSYkiS9Q3xBnvYimewfiKgd/hKyGaqzsmuRpKpU7EO5WJqb
         eYtA==
X-Gm-Message-State: APjAAAXP4PU1iNX6xbZypPu3JPHhPsRaHQ+3Dnc7cYb9nCrA8SYL8bVW
        CSlhniKUaMu6bHnQ1W6sDgN87iXvVV6PSw==
X-Google-Smtp-Source: APXvYqx/PTh7ds9WIw967/F8IV3FNPmp/Cllds5C7Wl5yNxFCD9qgsWHSEcpCPOgx/NdTTaexBlSRg==
X-Received: by 2002:aed:23ef:: with SMTP id k44mr86879052qtc.202.1564661386475;
        Thu, 01 Aug 2019 05:09:46 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v84sm31265914qkb.0.2019.08.01.05.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 05:09:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] arm64/mm: fix variable 'tag' set but not used
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <5E9F5456-3B82-4CB8-868B-1C7B4CBE4CBC@lca.pw>
Date:   Thu, 1 Aug 2019 08:09:44 -0400
Cc:     Catalin Marinas <catalin.marinas@arm.com>, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <16BFDECA-7774-49D0-A68C-86711E10DDC5@lca.pw>
References: <1564605498-17629-1-git-send-email-cai@lca.pw>
 <20190801120121.6cmtho3wd32nzfoz@willie-the-truck>
 <5E9F5456-3B82-4CB8-868B-1C7B4CBE4CBC@lca.pw>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 1, 2019, at 8:07 AM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Aug 1, 2019, at 8:01 AM, Will Deacon <will@kernel.org> wrote:
>>=20
>> On Wed, Jul 31, 2019 at 04:38:18PM -0400, Qian Cai wrote:
>>> When CONFIG_KASAN_SW_TAGS=3Dn, set_tag() is compiled away. GCC =
throws a
>>> warning,
>>>=20
>>> mm/kasan/common.c: In function '__kasan_kmalloc':
>>> mm/kasan/common.c:464:5: warning: variable 'tag' set but not used
>>> [-Wunused-but-set-variable]
>>> u8 tag =3D 0xff;
>>>    ^~~
>>>=20
>>> Fix it by making __tag_set() a static inline function.
>>>=20
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>> ---
>>> arch/arm64/include/asm/memory.h | 6 +++++-
>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/arm64/include/asm/memory.h =
b/arch/arm64/include/asm/memory.h
>>> index b7ba75809751..9645b1340afe 100644
>>> --- a/arch/arm64/include/asm/memory.h
>>> +++ b/arch/arm64/include/asm/memory.h
>>> @@ -210,7 +210,11 @@ static inline unsigned long kaslr_offset(void)
>>> #define __tag_reset(addr)	untagged_addr(addr)
>>> #define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
>>> #else
>>> -#define __tag_set(addr, tag)	(addr)
>>> +static inline const void *__tag_set(const void *addr, u8 tag)
>>> +{
>>> +	return addr;
>>> +}
>>=20
>> Why doesn't this trigger a warning in page_to_virt(), which passes an
>> unsigned long for the address parameter?
>=20
> #define page_to_virt(page) =E2=80=A6 __tag_set(__addr, =
page_kasan_tag(page)); =E2=80=A6
>=20
> static inline u8 page_kasan_tag(const struct page *page)
> {=09
> 	return 0xff;
> }
>=20
> GCC will see that =E2=80=9Cpage=E2=80=9D is used.

If you are talking about =E2=80=9Caddr=E2=80=9D,

#define __tag_set(addr, tag)	(addr)

It is actually used.

