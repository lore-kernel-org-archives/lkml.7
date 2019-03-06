Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EC820684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551916054;
	bh=vmOdSl6Ux8FUHNIT/9FHSnoLe2UZ3Cuy+ob+irKmgIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1UtQSyCwaLKl6E2TE6HOJh8WtthbPmEZmuLDcIlUKVM15qF8WE4eEiNBHlcgRcNoX
	 7UXtApVgHFnlrHtW8Is0dEJgBtqKLXV/xd5zmjGGQlFn7FOgzR300qZ5rt/urSRAOg
	 9jeg3wbx/uidoFvIVd730mp+5lJcOkXOu0mAIL2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCFXrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:47:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33214 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:47:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id z7so12551997lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufjy9rpQDCna/NYjYU0YyEDFBe58iup/lFs8RUEQGNI=;
        b=PzVMLFroM1lg0QqLEmTWE5MtFkSJEbQ9t6GQ9kA+HPouqRxGO+e6EBwgdFpJTc3A3y
         +TILbi/eZaCJezvJpsp+jZ8Hh5nK0bal5cz4vtj6khFFWbQCV60wZ2dZw/E3sTZGzZws
         KZnzy3tjAYn/38gddniGchgAu2MV9XOEZUB6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufjy9rpQDCna/NYjYU0YyEDFBe58iup/lFs8RUEQGNI=;
        b=b9pUS7pIh0aO83EQW24N+nIHOoaGqkhKeAi19+Y+fdnJzDrHfxFqUP6MLmEHojbbcx
         gLP/PZYU7IDbmpGUarPWeS/YgY/OsBmzsWBJo9kURyQb2hLEnNCSEw3RErUFPo/JRbbs
         Dr+CYtmfuPmvIEvgXeX5koThdBAGJkhs+dOGkuhThXFVM7V0+oDOlLX3QGQQS1fi6WSu
         0h6jrwUP3zuw4IWPbPgwiQdqe6jd0tY3wSpOfQsTv55ykm6kPDLGtI3qT84TfqEAvaZI
         fjAlGrnl3AtOIrphXNrzM2q8GRj5+3nyd9yMUud17smoD9EMSG8hAyoIoBIcqb3uB2Zs
         kLEw==
X-Gm-Message-State: APjAAAW3BRNH4YW0xGoFStMbFmWdGr+DZKGAddBlykfZBoJwWUSr/m/b
        ML8xlWJpSXKtiRdnTyh8Xauj8BFY7Eo=
X-Google-Smtp-Source: APXvYqw6SdINzV5UnyDm7LWxlZh5LojNVFkVPcVreCMfF4fTcjxdCB5KflMPAat58b2q+xuZOhxg3g==
X-Received: by 2002:a2e:8847:: with SMTP id z7mr3608918ljj.99.1551916049624;
        Wed, 06 Mar 2019 15:47:29 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v13sm559038ljd.31.2019.03.06.15.47.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 15:47:28 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id g80so12528807ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:47:28 -0800 (PST)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr3859852ljg.94.1551916047792;
 Wed, 06 Mar 2019 15:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20190306103350.GA10570@kroah.com>
In-Reply-To: <20190306103350.GA10570@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 15:47:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
Message-ID: <CAHk-=wjT+pPxi8favCu9V5ZtGZuTZybLuwnwtNLspFPmKgr42g@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.1-rc1
To:     Greg KH <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: multipart/mixed; boundary="000000000000c0358f0583759c4c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c0358f0583759c4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2019 at 2:33 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Joe Perches (1):
>       device.h: Add __cold to dev_<level> logging functions

This is very funky, but that commit generates a new warning in a
totally unrelated area:

  drivers/iio/adc/qcom-pm8xxx-xoadc.c: In function =E2=80=98pm8xxx_xoadc_pr=
obe=E2=80=99:
  drivers/iio/adc/qcom-pm8xxx-xoadc.c:633:8: warning: =E2=80=98ch=E2=80=99 =
may be used
uninitialized in this function [-Wmaybe-uninitialized]
    ret =3D pm8xxx_read_channel_rsv(adc, ch, AMUX_RSV4,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             &read_nomux_rsv4, true);
             ~~~~~~~~~~~~~~~~~~~~~~~
  drivers/iio/adc/qcom-pm8xxx-xoadc.c:426:27: note: =E2=80=98ch=E2=80=99 wa=
s declared here
    struct pm8xxx_chan_info *ch;
                             ^~

and it all looks entirely insane if you look at that line 633 where
the ostensibly uninitialized variable is (it clearly _is_ initialized
there), but if you then look at that line 426 you notice that it
actually makes some kind of sense. The value comes from another
function that was apparently inlined, and that other function does not
"obviously" initialize it.

I wonder why this wasn't seen in linux-next? Yes, the connection is
odd, and maybe it's very compiler version dependent, but I do hope
people react to new warnings. The kernel is entirely warning-free for
me for an x86-64 allmodconfig build, and I want to keep it that way.

And _because_ I want to keep it that way (one of the things I do
during the merge window is look for oddities coming in during pulls,
and new warnings is a big deal for me), I applied the attached patch.
Just FYI.

                   Linus

--000000000000c0358f0583759c4c
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-iio-adc-fix-warning-in-Qualcomm-PM8xxx-HK-XOADC-driv.patch"
Content-Disposition: attachment; 
	filename="0001-iio-adc-fix-warning-in-Qualcomm-PM8xxx-HK-XOADC-driv.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jsxup73m0>
X-Attachment-Id: f_jsxup73m0

RnJvbSBlMGYwYWU4MzhhMjU0NjQxNzlkMzdmMzU1ZDc2M2Y5ZWMxMzlmYzE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFdlZCwgNiBNYXIgMjAxOSAxNTo0MToyOSAtMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIGlpbzogYWRjOiBmaXggd2FybmluZyBpbiBRdWFsY29tbSBQTTh4eHggSEsvWE9BREMg
ZHJpdmVyCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNl
dD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpUaGUgcG04eHh4X2dldF9j
aGFubmVsKCkgaW1wbGVtZW50YXRpb24gaXMgdW5jbGVhciwgYW5kIGNhdXNlcyBnY2MgdG8Kc3Vk
ZGVubHkgZ2VuZXJhdGUgb2RkIHdhcm5pbmdzLiAgVGhlIHRyaWdnZXIgZm9yIHRoZSB3YXJuaW5n
IChhdCBsZWFzdApmb3IgbWUpIHdhcyB0aGUgZW50aXJlbHkgdW5yZWxhdGVkIGNvbW1pdCA3OWE0
ZTkxZDFiYjIgKCJkZXZpY2UuaDogQWRkCl9fY29sZCB0byBkZXZfPGxldmVsPiBsb2dnaW5nIGZ1
bmN0aW9ucyIpLCB3aGljaCBhcHBhcmVudGx5IGNoYW5nZXMgZ2NjCmNvZGUgZ2VuZXJhdGlvbiBp
biB0aGUgY2FsbGVyIGZ1bmN0aW9uIGVub3VnaCB0byBjYXVzZSB0aGlzOgoKICBkcml2ZXJzL2lp
by9hZGMvcWNvbS1wbTh4eHgteG9hZGMuYzogSW4gZnVuY3Rpb24g4oCYcG04eHh4X3hvYWRjX3By
b2Jl4oCZOgogIGRyaXZlcnMvaWlvL2FkYy9xY29tLXBtOHh4eC14b2FkYy5jOjYzMzo4OiB3YXJu
aW5nOiDigJhjaOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24g
Wy1XbWF5YmUtdW5pbml0aWFsaXplZF0KICAgIHJldCA9IHBtOHh4eF9yZWFkX2NoYW5uZWxfcnN2
KGFkYywgY2gsIEFNVVhfUlNWNCwKICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgICAgICAgICZyZWFkX25vbXV4X3JzdjQsIHRydWUpOwog
ICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICBkcml2ZXJzL2lpby9hZGMvcWNv
bS1wbTh4eHgteG9hZGMuYzo0MjY6Mjc6IG5vdGU6IOKAmGNo4oCZIHdhcyBkZWNsYXJlZCBoZXJl
CiAgICBzdHJ1Y3QgcG04eHh4X2NoYW5faW5mbyAqY2g7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn4KCmJlY2F1c2UgZ2NjIGZvciBzb21lIHJlYXNvbiB0aGVuIGlzbid0IGFibGUgdG8g
c2VlIHRoYXQgdGhlIHRlcm1pbmF0aW9uCmNvbmRpdGlvbiBmb3IgdGhlICJmb3IoICkiIGxvb3Ag
aW4gdGhhdCBmdW5jdGlvbiBpcyBhbHNvIHRoZSBjb25kaXRpb24KZm9yIHJldHVybmluZyBOVUxM
LgoKU28gaXQncyBub3QgX2FjdHVhbGx5XyB1bmluaXRpYWxpemVkLCBidXQgdGhlIGZ1bmN0aW9u
IGlzIGFkbWl0dGVkbHkKanVzdCB1bm5lY2Vzc2FyaWx5IG9kZGx5IHdyaXR0ZW4uCgpTaW1wbGlm
eSBhbmQgY2xhcmlmeSB0aGUgZnVuY3Rpb24sIG1ha2luZyBnY2MgYWxzbyBzZWUgdGhhdCBpdCBh
bHdheXMKcmV0dXJucyBhIHZhbGlkIGluaXRpYWxpemVkIHZhbHVlLgoKQ2M6IEpvZSBQZXJjaGVz
IDxqb2VAcGVyY2hlcy5jb20+CkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPgpDYzogQW5keSBHcm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPgpDYzog
RGF2aWQgQnJvd24gPGRhdmlkLmJyb3duQGxpbmFyby5vcmc+CkNjOiBKb25hdGhhbiBDYW1lcm9u
IDxqaWMyM0BrZXJuZWwub3JnPgpDYzogSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdteC5kZT4K
Q2M6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPgpDYzogUGV0ZXIgTWVlcndh
bGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZh
bGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBkcml2ZXJzL2lpby9hZGMv
cWNvbS1wbTh4eHgteG9hZGMuYyB8IDEwICsrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L3Fjb20tcG04eHh4LXhvYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvcWNvbS1wbTh4eHgteG9hZGMu
YwppbmRleCBjMzBjMDAyZjFmZWYuLjQ3MzVmOGExY2E5ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9p
aW8vYWRjL3Fjb20tcG04eHh4LXhvYWRjLmMKKysrIGIvZHJpdmVycy9paW8vYWRjL3Fjb20tcG04
eHh4LXhvYWRjLmMKQEAgLTQyMywxOCArNDIzLDE0IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBwbTh4
eHhfZW9jX2lycShpbnQgaXJxLCB2b2lkICpkKQogc3RhdGljIHN0cnVjdCBwbTh4eHhfY2hhbl9p
bmZvICoKIHBtOHh4eF9nZXRfY2hhbm5lbChzdHJ1Y3QgcG04eHh4X3hvYWRjICphZGMsIHU4IGNo
YW4pCiB7Ci0Jc3RydWN0IHBtOHh4eF9jaGFuX2luZm8gKmNoOwogCWludCBpOwogCiAJZm9yIChp
ID0gMDsgaSA8IGFkYy0+bmNoYW5zOyBpKyspIHsKLQkJY2ggPSAmYWRjLT5jaGFuc1tpXTsKKwkJ
c3RydWN0IHBtOHh4eF9jaGFuX2luZm8gKmNoID0gJmFkYy0+Y2hhbnNbaV07CiAJCWlmIChjaC0+
aHdjaGFuLT5hbXV4X2NoYW5uZWwgPT0gY2hhbikKLQkJCWJyZWFrOworCQkJcmV0dXJuIGNoOwog
CX0KLQlpZiAoaSA9PSBhZGMtPm5jaGFucykKLQkJcmV0dXJuIE5VTEw7Ci0KLQlyZXR1cm4gY2g7
CisJcmV0dXJuIE5VTEw7CiB9CiAKIHN0YXRpYyBpbnQgcG04eHh4X3JlYWRfY2hhbm5lbF9yc3Yo
c3RydWN0IHBtOHh4eF94b2FkYyAqYWRjLAotLSAKMi4yMS4wLnJjMC4zMy5nZmFkMWYxMTRjZAoK
--000000000000c0358f0583759c4c--
