Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D6C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9B420838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="d636y+g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfHAMHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:07:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40546 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHAMHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:07:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so69875012qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L8sXm7xcpE01pWT1+FK9gK106nq8ernY7LG5QfcWBLM=;
        b=d636y+g5jgfJUvNhPTIGZxZDKyjoATAffWH81BTJS1WUYCviCX2KphcwKWu3UJbHCH
         Bca32WSj6wzC3XJeNRLsyRkS2aB3Rr34s4wqrL5uH2Cm02/DUmhwz7wzpzwJh8mwKBD6
         4QIf+Nbh+p8GagiqLRxHjxqi0iIJsBPTWjZigI4Y9eFqdFiFu24mQfWaqVVVkpPkUX8+
         mJKnvrkYID7808AWYwCuc1o8lEIkfSh9axdZIpfGW/2a1uboti0nmqHPUcPUs3+dD8go
         o/UEsIFGI0mQCMf7uMLVkS/MlJ0B6GqSM2Y86RU8B7OAx0ALkO+rWEo0sI8rT1U3UOQS
         e0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L8sXm7xcpE01pWT1+FK9gK106nq8ernY7LG5QfcWBLM=;
        b=PEKKT3xWhIPY4I4l6auKiddHupupCxh8f1Sn7WWIjxXpEG7PLyaYdAM8pdfAxrcdOk
         p6rQ/YkXPfUV+a2STvHsIY9/vvqr6y0Zu9ufajOmhPEqVWXtykTRo5WcX+MrIE0uC3wh
         eVN5AEfKLTFYvDfkViTqkMTcw0a+c84zNVeCC7qDLhFaZLKoalJzO+ZJR6lkRA1hxGUn
         jr0ZwZiJtIvpAprrkYvgoHJu6/rXQkB4W0cO+vXQVsCkgCR7QQy8TQh3qJYUiglOavCv
         0IWWlH35kwU7AOiVIR8tJgb+G0BWik1sLlPnDVj1HQsbkVhGXXc1pPG5SnPKNezl+sDu
         8vZQ==
X-Gm-Message-State: APjAAAVL6o+ETGjyOxIsIp2iFjQTvczp6BLAKyu5qJ/komTWIfwi74A5
        OtwttE3imoLLowROpzNVRSKS2Q==
X-Google-Smtp-Source: APXvYqyczlC981qA9pvtXHuVRF0isXbzlNG4ebJOhXdQq3CxmBtzxeJNbp7NlNyrnOn6nZhiv9GfjQ==
X-Received: by 2002:ac8:4697:: with SMTP id g23mr65965157qto.285.1564661233806;
        Thu, 01 Aug 2019 05:07:13 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h1sm33942126qkh.101.2019.08.01.05.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 05:07:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] arm64/mm: fix variable 'tag' set but not used
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190801120121.6cmtho3wd32nzfoz@willie-the-truck>
Date:   Thu, 1 Aug 2019 08:07:12 -0400
Cc:     Catalin Marinas <catalin.marinas@arm.com>, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E9F5456-3B82-4CB8-868B-1C7B4CBE4CBC@lca.pw>
References: <1564605498-17629-1-git-send-email-cai@lca.pw>
 <20190801120121.6cmtho3wd32nzfoz@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 1, 2019, at 8:01 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Wed, Jul 31, 2019 at 04:38:18PM -0400, Qian Cai wrote:
>> When CONFIG_KASAN_SW_TAGS=3Dn, set_tag() is compiled away. GCC throws =
a
>> warning,
>>=20
>> mm/kasan/common.c: In function '__kasan_kmalloc':
>> mm/kasan/common.c:464:5: warning: variable 'tag' set but not used
>> [-Wunused-but-set-variable]
>>  u8 tag =3D 0xff;
>>     ^~~
>>=20
>> Fix it by making __tag_set() a static inline function.
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> arch/arm64/include/asm/memory.h | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/include/asm/memory.h =
b/arch/arm64/include/asm/memory.h
>> index b7ba75809751..9645b1340afe 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -210,7 +210,11 @@ static inline unsigned long kaslr_offset(void)
>> #define __tag_reset(addr)	untagged_addr(addr)
>> #define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
>> #else
>> -#define __tag_set(addr, tag)	(addr)
>> +static inline const void *__tag_set(const void *addr, u8 tag)
>> +{
>> +	return addr;
>> +}
>=20
> Why doesn't this trigger a warning in page_to_virt(), which passes an
> unsigned long for the address parameter?

#define page_to_virt(page) =E2=80=A6 __tag_set(__addr, =
page_kasan_tag(page)); =E2=80=A6

static inline u8 page_kasan_tag(const struct page *page)
{=09
	return 0xff;
}

GCC will see that =E2=80=9Cpage=E2=80=9D is used.=
