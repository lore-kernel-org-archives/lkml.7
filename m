Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D40C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A00621850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rlZLpqWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfDEKRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:17:40 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64933 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfDEKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:17:39 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x35AHRus030643;
        Fri, 5 Apr 2019 19:17:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x35AHRus030643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554459448;
        bh=KzCUIXCIRpJ6mQ94WJb4kq/tCoGKLTGlGupi3uFPm+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rlZLpqWa++pwtVWQImJ0ObMWm8EpcfcdQzylxynbwJY5O11pLBJ+SsISiM+GOcXvM
         Jghb1vezms2GllJmARoNtfo7G45cwrJSPPkZJekR9XHrX+TUvdEYzEFysT1bHs0fJx
         XVu3/2P5VYMScLiwra6a2cNq1oZmu5iOrOi4sF1K5MBZbr692VIootpFxUqM7lzpC9
         LzBJsun5hqSjpG6WRQCeYLkTBEGdOPZMl170Xu/Fz5yflFcrh/qWzfKlIw087JFAPh
         QJBtOcUgMgPVBOlJ59qri9VXxxH88VoNnN8m+4Hhbeb/6skqW+jyIkfWdpPqPdsvhb
         Br7THV1fXFVIA==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id w140so1321403vkd.3;
        Fri, 05 Apr 2019 03:17:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUrHAG30Y96cgIRezFNcbRTVXLLVWOuodrhStfAOc1Cnot7LsSQ
        T9KaiCQsJAQuDXvXB1rEcBVN5JtFT2TmggyId/U=
X-Google-Smtp-Source: APXvYqxfbwp9QuNskIva/2KZFfaktyYA3Xp6oZ5MU/HEHyszXsIv5yAzawwUYgvnAPt3pnUKO+sSJixSli8oRRrWxrc=
X-Received: by 2002:a1f:b3c6:: with SMTP id c189mr4533015vkf.33.1554459446944;
 Fri, 05 Apr 2019 03:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
 <20190402070858.49597-1-ndesaulniers@google.com>
In-Reply-To: <20190402070858.49597-1-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 5 Apr 2019 19:16:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQGUe0h2ti6_u5=y9KUrNStESdd=D=8K3NOiE08tt022w@mail.gmail.com>
Message-ID: <CAK7LNAQGUe0h2ti6_u5=y9KUrNStESdd=D=8K3NOiE08tt022w@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: lld: tell clang to use lld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002794cc0585c5cb81"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002794cc0585c5cb81
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 2, 2019 at 4:09 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> This is needed because clang doesn't select which linker to use based on
> $LD but rather -fuse-ld={bfd,gold,lld,<absolute path to linker>}.  This
> is problematic especially for cc-ldoption, which checks for linker flag
> support via invoking the compiler, rather than the linker.
>
> Select the linker via absolute path from $PATH via `which`. This allows
> you to build with:
>
> $ make LD=ld.lld
> $ make LD=ld.lld-8
> $ make LD=/path/to/ld.lld
>
> Add -Qunused-arguments to KBUILD_CPPFLAGS when using LLD, as otherwise
> Clang likes to complain about -fuse-lld= being unused when compiling but
> not linking (-c) such as when cc-option is used.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/342
> Link: https://github.com/ClangBuiltLinux/linux/issues/366
> Link: https://github.com/ClangBuiltLinux/linux/issues/357
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V2->V3:
> * Use absolute path based on `which $LD` as per Masahiro.

This is not what I suggested.  I wanted to say:
"You cannot do this for GCC, so do not do it at all".

I want to propose alternative solution.
Please check the attached patches.

To apply 0002, you need the following as a prerequisite:

https://lore.kernel.org/patchwork/patch/1057685/



--
Best Regards
Masahiro Yamada

--0000000000002794cc0585c5cb81
Content-Type: application/x-patch; 
	name="0001-ARM-vdso-use-LD-instead-of-CC-to-link-VDSO.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-vdso-use-LD-instead-of-CC-to-link-VDSO.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ju3wsehm0>
X-Attachment-Id: f_ju3wsehm0

RnJvbSA3ZmNiNzgwNjk5MWQ5YjY0NDE3Mzg3OWMzYzFmY2JiZGVkNTMyNDM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5tYXNhaGlyb0Bzb2Np
b25leHQuY29tPgpEYXRlOiBGcmksIDUgQXByIDIwMTkgMTc6NDY6MTQgKzA5MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gQVJNOiB2ZHNvOiB1c2UgJChMRCkgaW5zdGVhZCBvZiAkKENDKSB0byBsaW5r
IFZEU08KCldlIHVzZSAkKExEKSB0byBsaW5rIHZtbGludXgsIG1vZHVsZXMsIGRlY29tcHJlc3Nv
cnMsIGV0Yy4KClZEU08gaXMgdGhlIG9ubHkgZXhjZXB0aW9uYWwgY2FzZSB3aGVyZSAkKENDKSBp
cyB1c2VkIGFzIHRoZSBmcm9udGVuZApvZiBsaW5raW5nLCBidXQgSSBkbyBub3Qga25vdyB3aHku
IFZEU08gdXNlcyBhIHNwZWNpYWwgbGlua2VyIHNjcmlwdCwKYW5kIGRvZXMgbm90IGxpbmsgc3Rh
bmRhcmQgbGlicmFyaWVzIGF0IGFsbC4KCkkgY2hhbmdlZCB0aGUgTWFrZWZpbGUgdG8gdXNlICQo
TEQpIHJhaHRlciB0aGFuICQoQ0MpLiBJIGNvbmZpcm1lZAp0aGUgc2FtZSB2ZHNvLnNvLnJhdyB3
YXMgc3RpbGwgcHJvZHVjZWQuCgpVc2VycyB3aWxsIGJlIGFibGUgdG8gdXNlIHRoZWlyIGZhdm9y
aXRlIGxpbmtlciAoZS5nLiBsbGQgaW5zdGVhZCBvZgpvZiBiZmQpIGJ5IHBhc3NpbmcgTEQ9IGZy
b20gdGhlIGNvbW1hbmQgbGluZS4KCk15IHBsYW4gaXMgdG8gcmV3cml0ZSBhbGwgVkRTTyBNYWtl
ZmlsZXMgdG8gdXNlICQoTEQpLCB0aGVuIGRlbGV0ZQpjYy1sZG9wdGlvbi4KClNpZ25lZC1vZmYt
Ynk6IE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+Ci0tLQog
YXJjaC9hcm0vdmRzby9NYWtlZmlsZSB8IDIxICsrKysrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vdmRzby9NYWtlZmlsZSBiL2FyY2gvYXJtL3Zkc28vTWFrZWZpbGUKaW5kZXggZjRl
ZmZmOWQzYWZiLi5mYWRmNTU0ZDkzOTEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3Zkc28vTWFrZWZp
bGUKKysrIGIvYXJjaC9hcm0vdmRzby9NYWtlZmlsZQpAQCAtMTAsMTIgKzEwLDEyIEBAIG9iai12
ZHNvIDo9ICQoYWRkcHJlZml4ICQob2JqKS8sICQob2JqLXZkc28pKQogY2NmbGFncy15IDo9IC1m
UElDIC1mbm8tY29tbW9uIC1mbm8tYnVpbHRpbiAtZm5vLXN0YWNrLXByb3RlY3RvcgogY2NmbGFn
cy15ICs9IC1ERElTQUJMRV9CUkFOQ0hfUFJPRklMSU5HCiAKLVZEU09fTERGTEFHUyA6PSAtV2ws
LUJzeW1ib2xpYyAtV2wsLS1uby11bmRlZmluZWQgLVdsLC1zb25hbWU9bGludXgtdmRzby5zby4x
Ci1WRFNPX0xERkxBR1MgKz0gLVdsLC16LG1heC1wYWdlLXNpemU9NDA5NiAtV2wsLXosY29tbW9u
LXBhZ2Utc2l6ZT00MDk2Ci1WRFNPX0xERkxBR1MgKz0gLW5vc3RkbGliIC1zaGFyZWQKLVZEU09f
TERGTEFHUyArPSAkKGNhbGwgY2MtbGRvcHRpb24sIC1XbCQoY29tbWEpLS1oYXNoLXN0eWxlPXN5
c3YpCi1WRFNPX0xERkxBR1MgKz0gJChjYWxsIGNjLWxkb3B0aW9uLCAtV2wkKGNvbW1hKS0tYnVp
bGQtaWQpCi1WRFNPX0xERkxBR1MgKz0gJChjYWxsIGNjLWxkb3B0aW9uLCAtZnVzZS1sZD1iZmQp
CitsZGZsYWdzLXkgPSAtQnN5bWJvbGljIC0tbm8tdW5kZWZpbmVkIC1zb25hbWU9bGludXgtdmRz
by5zby4xIFwKKwkgICAgLXogbWF4LXBhZ2Utc2l6ZT00MDk2IC16IGNvbW1vbi1wYWdlLXNpemU9
NDA5NiBcCisJICAgIC1ub3N0ZGxpYiAtc2hhcmVkIFwKKwkgICAgJChjYWxsIGxkLW9wdGlvbiwg
LS1oYXNoLXN0eWxlPXN5c3YpIFwKKwkgICAgJChjYWxsIGxkLW9wdGlvbiwgLS1idWlsZC1pZCkg
XAorCSAgICAtVAogCiBvYmotJChDT05GSUdfVkRTTykgKz0gdmRzby5vCiBleHRyYS0kKENPTkZJ
R19WRFNPKSArPSB2ZHNvLmxkcwpAQCAtMzcsOCArMzcsOCBAQCBLQ09WX0lOU1RSVU1FTlQgOj0g
bgogJChvYmopL3Zkc28ubyA6ICQob2JqKS92ZHNvLnNvCiAKICMgTGluayBydWxlIGZvciB0aGUg
LnNvIGZpbGUKLSQob2JqKS92ZHNvLnNvLnJhdzogJChzcmMpL3Zkc28ubGRzICQob2JqLXZkc28p
IEZPUkNFCi0JJChjYWxsIGlmX2NoYW5nZWQsdmRzb2xkKQorJChvYmopL3Zkc28uc28ucmF3OiAk
KG9iaikvdmRzby5sZHMgJChvYmotdmRzbykgRk9SQ0UKKwkkKGNhbGwgaWZfY2hhbmdlZCxsZCkK
IAogJChvYmopL3Zkc28uc28uZGJnOiAkKG9iaikvdmRzby5zby5yYXcgJChvYmopL3Zkc29tdW5n
ZSBGT1JDRQogCSQoY2FsbCBpZl9jaGFuZ2VkLHZkc29tdW5nZSkKQEAgLTQ4LDExICs0OCw2IEBA
ICQob2JqKS8lLnNvOiBPQkpDT1BZRkxBR1MgOj0gLVMKICQob2JqKS8lLnNvOiAkKG9iaikvJS5z
by5kYmcgRk9SQ0UKIAkkKGNhbGwgaWZfY2hhbmdlZCxvYmpjb3B5KQogCi0jIEFjdHVhbCBidWls
ZCBjb21tYW5kcwotcXVpZXRfY21kX3Zkc29sZCA9IFZEU08gICAgJEAKLSAgICAgIGNtZF92ZHNv
bGQgPSAkKENDKSAkKGNfZmxhZ3MpICQoVkRTT19MREZMQUdTKSBcCi0gICAgICAgICAgICAgICAg
ICAgLVdsLC1UICQoZmlsdGVyICUubGRzLCReKSAkKGZpbHRlciAlLm8sJF4pIC1vICRACi0KIHF1
aWV0X2NtZF92ZHNvbXVuZ2UgPSBNVU5HRSAgICRACiAgICAgICBjbWRfdmRzb211bmdlID0gJChv
Ymp0cmVlKS8kKG9iaikvdmRzb211bmdlICQ8ICRACiAKLS0gCjIuMTcuMQoK
--0000000000002794cc0585c5cb81
Content-Type: application/x-patch; 
	name="0002-arm64-vdso-use-LD-instead-of-CC-to-link-VDSO.patch"
Content-Disposition: attachment; 
	filename="0002-arm64-vdso-use-LD-instead-of-CC-to-link-VDSO.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ju3wsjwn1>
X-Attachment-Id: f_ju3wsjwn1

RnJvbSBkYjkzYWJhNTA4NmViYzA1NThjMTkzMTAxZDU2YzJlNWE1ODc4ZGRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5tYXNhaGlyb0Bzb2Np
b25leHQuY29tPgpEYXRlOiBUaHUsIDQgQXByIDIwMTkgMjM6NDA6MTggKzA5MDAKU3ViamVjdDog
W1BBVENIIDIvMl0gYXJtNjQ6IHZkc286IHVzZSAkKExEKSBpbnN0ZWFkIG9mICQoQ0MpIHRvIGxp
bmsgVkRTTwoKV2UgdXNlICQoTEQpIHRvIGxpbmsgdm1saW51eCwgbW9kdWxlcywgZGVjb21wcmVz
c29ycywgZXRjLgoKVkRTTyBpcyB0aGUgb25seSBleGNlcHRpb25hbCBjYXNlIHdoZXJlICQoQ0Mp
IGlzIHVzZWQgYXMgdGhlIGZyb250ZW5kCm9mIGxpbmtpbmcsIGJ1dCBJIGRvIG5vdCBrbm93IHdo
eS4gVkRTTyB1c2VzIGEgc3BlY2lhbCBsaW5rZXIgc2NyaXB0LAphbmQgZG9lcyBub3QgbGluayBz
dGFuZGFyZCBsaWJyYXJpZXMgYXQgYWxsLgoKSSBjaGFuZ2VkIHRoZSBNYWtlZmlsZSB0byB1c2Ug
JChMRCkgcmFodGVyIHRoYW4gJChDQykuIEkgdGVzdGVkLCBhbmQKVkRTTyBzdGlsbCB3b3JrZWQu
CgpVc2VycyB3aWxsIGJlIGFibGUgdG8gdXNlIHRoZWlyIGZhdm9yaXRlIGxpbmtlciAoZS5nLiBs
bGQgaW5zdGVhZCBvZgpvZiBiZmQpIGJ5IHBhc3NpbmcgTEQ9IGZyb20gdGhlIGNvbW1hbmQgbGlu
ZS4KCk15IHBsYW4gaXMgdG8gcmV3cml0ZSBhbGwgVkRTTyBNYWtlZmlsZXMgdG8gdXNlICQoTEQp
LCB0aGVuIGRlbGV0ZQpjYy1sZG9wdGlvbi4KClNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFk
YSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+Ci0tLQogYXJjaC9hcm02NC9rZXJuZWwv
dmRzby9NYWtlZmlsZSB8IDEzICsrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVs
L3Zkc28vTWFrZWZpbGUgYi9hcmNoL2FybTY0L2tlcm5lbC92ZHNvL01ha2VmaWxlCmluZGV4IGEw
YWY2YmY2YzExYi4uNzQ0YjlkYmFiYTAzIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2tlcm5lbC92
ZHNvL01ha2VmaWxlCisrKyBiL2FyY2gvYXJtNjQva2VybmVsL3Zkc28vTWFrZWZpbGUKQEAgLTEy
LDE3ICsxMiwxMiBAQCBvYmotdmRzbyA6PSBnZXR0aW1lb2ZkYXkubyBub3RlLm8gc2lncmV0dXJu
Lm8KIHRhcmdldHMgOj0gJChvYmotdmRzbykgdmRzby5zbyB2ZHNvLnNvLmRiZwogb2JqLXZkc28g
Oj0gJChhZGRwcmVmaXggJChvYmopLywgJChvYmotdmRzbykpCiAKLWNjZmxhZ3MteSA6PSAtc2hh
cmVkIC1mbm8tY29tbW9uIC1mbm8tYnVpbHRpbgotY2NmbGFncy15ICs9IC1ub3N0ZGxpYiAtV2ws
LXNvbmFtZT1saW51eC12ZHNvLnNvLjEgXAotCQkkKGNhbGwgY2MtbGRvcHRpb24sIC1XbCQoY29t
bWEpLS1oYXNoLXN0eWxlPXN5c3YpCitsZGZsYWdzLXkgOj0gLXNoYXJlZCAtbm9zdGRsaWIgLXNv
bmFtZT1saW51eC12ZHNvLnNvLjEgXAorCQkkKGNhbGwgbGQtb3B0aW9uLCAtLWhhc2gtc3R5bGU9
c3lzdikgLW4gLVQKIAogIyBEaXNhYmxlIGdjb3YgcHJvZmlsaW5nIGZvciBWRFNPIGNvZGUKIEdD
T1ZfUFJPRklMRSA6PSBuCiAKLSMgV29ya2Fyb3VuZCBmb3IgYmFyZS1tZXRhbCAoRUxGKSB0b29s
Y2hhaW5zIHRoYXQgbmVnbGVjdCB0byBwYXNzIC1zaGFyZWQKLSMgZG93biB0byBjb2xsZWN0Miwg
cmVzdWx0aW5nIGluIHNpbGVudCBjb3JydXB0aW9uIG9mIHRoZSB2RFNPIGltYWdlLgotY2NmbGFn
cy15ICs9IC1XbCwtc2hhcmVkCi0KIG9iai15ICs9IHZkc28ubwogZXh0cmEteSArPSB2ZHNvLmxk
cwogQ1BQRkxBR1NfdmRzby5sZHMgKz0gLVAgLUMgLVUkKEFSQ0gpCkBAIC0zMiw3ICsyNyw3IEBA
ICQob2JqKS92ZHNvLm8gOiAkKG9iaikvdmRzby5zbwogCiAjIExpbmsgcnVsZSBmb3IgdGhlIC5z
byBmaWxlLCAubGRzIGhhcyB0byBiZSBmaXJzdAogJChvYmopL3Zkc28uc28uZGJnOiAkKG9iaikv
dmRzby5sZHMgJChvYmotdmRzbykgRk9SQ0UKLQkkKGNhbGwgaWZfY2hhbmdlZCx2ZHNvbGQpCisJ
JChjYWxsIGlmX2NoYW5nZWQsbGQpCiAKICMgU3RyaXAgcnVsZSBmb3IgdGhlIC5zbyBmaWxlCiAk
KG9iaikvJS5zbzogT0JKQ09QWUZMQUdTIDo9IC1TCkBAIC01Miw4ICs0Nyw2IEBAICQob2JqLXZk
c28pOiAlLm86ICUuUyBGT1JDRQogCSQoY2FsbCBpZl9jaGFuZ2VkX2RlcCx2ZHNvYXMpCiAKICMg
QWN0dWFsIGJ1aWxkIGNvbW1hbmRzCi1xdWlldF9jbWRfdmRzb2xkID0gVkRTT0wgICAkQAotICAg
ICAgY21kX3Zkc29sZCA9ICQoQ0MpICQoY19mbGFncykgLVdsLC1uIC1XbCwtVCAkKHJlYWwtcHJl
cmVxcykgLW8gJEAKIHF1aWV0X2NtZF92ZHNvYXMgPSBWRFNPQSAgICRACiAgICAgICBjbWRfdmRz
b2FzID0gJChDQykgJChhX2ZsYWdzKSAtYyAtbyAkQCAkPAogCi0tIAoyLjE3LjEKCg==
--0000000000002794cc0585c5cb81--
