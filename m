Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC3C742A2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 05:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A4E20838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 05:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563081095;
	bh=MLzaPrNLyq1bR4oeddlqiFeF07R1EQTi98qHGwoMMyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xfUykq3655Hm5M+WrPOs2i+WO62stFw6PyCB9D6x8FPM1rfGw6zfUZ3U6UJ05hO6j
	 fb+QBhDvszBrmx3h0DMwNfOAQaxKza3kaElISQFVmBEo46Jx7XHX1AFslZKE66XKOM
	 Vbp5RPn9kkD4csVektFtD+JAZPzFBMQeCVw83hiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfGNFCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 01:02:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46866 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfGNFCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 01:02:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so12977588ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 22:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+CLR//OyzM+aYJU6s+9PqtlXqSsNWfyLe2vWBf5AFs=;
        b=MjE58dCrdguAUpOtUkl/U/NSXmQDiCHjFHuxcdtbD7ta0zup4jZpz0IAQVBfVA6kpf
         V+VT+h7mQ+tMcmzLdabkCFPuen8WrxlT9Qeah1NFYVatiCTv/bARuUlzJzO+jUIuIRZu
         nRut479R733DMsKhXl7DDGc8bgL1cXkE2SOB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+CLR//OyzM+aYJU6s+9PqtlXqSsNWfyLe2vWBf5AFs=;
        b=uBIHEWHSB/GigR/8kkqOY/BacNpUDE99pQiWQMl1mxqCANWOHrFOW3xtTLwIrrN3h/
         sZTeJ0c/U/LBb22v+7gH9QJruagveczmwHRO27u1g8ZDww6dnvnqPsoBnW5/qPXfDCA4
         s4cj6FNN9Br+7R5V4Qwil5UtkVbrECfd/vRVhpdOvgQT4s/yaSpIOE1e0sTd4+8Yb3xI
         Wp9p7/K+jc9RzCCyNydRYEaL/dUcG64NdO+whCR2+M8W4quwL/iaZnQzVqpnkdMxPGIs
         bjA1e5BfF43jI7A6Qz7OX2KqU2iT9nz5fRslp4hlnWqrPu1Nem4sz/IpIjLJv2VQ3Mgq
         YKkw==
X-Gm-Message-State: APjAAAXy3tq/1m1H76cONa4ol/aLONFD/MmRVBKN2Bny6crhGrIbBnoS
        LTclz/+i5c1zNsqcerbyeNL5AsyV9FI=
X-Google-Smtp-Source: APXvYqwlhQDQ9EAqrTT8NF6Rm+5/t3COkL76NM4NkIAqt0s31CEQtt/5Gv0AOGiuc0+e0tZdPHNuKw==
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr10435467ljj.53.1563080554094;
        Sat, 13 Jul 2019 22:02:34 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t63sm2326008lje.65.2019.07.13.22.02.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 22:02:32 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id d24so12966415ljg.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 22:02:32 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr9894882lji.84.1563080551761;
 Sat, 13 Jul 2019 22:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190713072855.GB23167@avx2> <20190713073209.GC23167@avx2> <87sgr9gsiq.fsf@xmission.com>
In-Reply-To: <87sgr9gsiq.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jul 2019 22:02:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTmLQuByQmd1-bqN+piBaEMiJCjwLQOXqO5A+mffTwpQ@mail.gmail.com>
Message-ID: <CAHk-=wjTmLQuByQmd1-bqN+piBaEMiJCjwLQOXqO5A+mffTwpQ@mail.gmail.com>
Subject: Re: [PATCH] proc: revert /proc/*/cmdline rewrite
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Kubecek <mkubecek@suse.cz>, shasta@toxcorp.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000b394a058d9d0db5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000b394a058d9d0db5
Content-Type: text/plain; charset="UTF-8"

[ Apparently this thread wasn't on the lists, and I didn't even
notice. So re-sending the patches ]

On Sat, Jul 13, 2019 at 9:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Given that this fixes a regression and a bug.
>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I'd much rather start from scratch. Like the attached.

Alexey Izbyshev has a third patch that then limits the setproctitle()
case to only allow looking into the env[] area, which looks
reasonable.

           Linus

--0000000000000b394a058d9d0db5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-proc-pid-cmdline-remove-all-the-special-cases.patch"
Content-Disposition: attachment; 
	filename="0001-proc-pid-cmdline-remove-all-the-special-cases.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jy2hrimq0>
X-Attachment-Id: f_jy2hrimq0

RnJvbSA1NTYzYTJmYjM5ZmUwYWQ0MmYyMzlkMmY1ODMxMjhkNTAxNTUwMDJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMTMgSnVsIDIwMTkgMTM6NDA6MTMgLTA3MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gL3Byb2MvPHBpZD4vY21kbGluZTogcmVtb3ZlIGFsbCB0aGUgc3BlY2lhbCBj
YXNlcwoKU3RhcnQgb2ZmIHdpdGggYSBjbGVhbiBzbGF0ZSB0aGF0IG9ubHkgcmVhZHMgZXhhY3Rs
eSBmcm9tIGFyZ19zdGFydCB0bwphcmdfZW5kLCB3aXRob3V0IGFueSBvZGRpdGllcy4KCldlJ2xs
IGFkZCBiYWNrIHRoZSBzZXRwcm9jdGl0bGUoKSBzcGVjaWFsIGNhc2UgdmVyeSBkaWZmZXJlbnRs
eSBpbiB0aGUKbmV4dCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9y
dmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0tLQogZnMvcHJvYy9iYXNlLmMgfCA3MSArKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNjMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMv
cHJvYy9iYXNlLmMgYi9mcy9wcm9jL2Jhc2UuYwppbmRleCAyNTVmNjc1NGM3MGQuLjgwNDBmOWQx
Y2YwNyAxMDA2NDQKLS0tIGEvZnMvcHJvYy9iYXNlLmMKKysrIGIvZnMvcHJvYy9iYXNlLmMKQEAg
LTIxMiw3ICsyMTIsNyBAQCBzdGF0aWMgaW50IHByb2Nfcm9vdF9saW5rKHN0cnVjdCBkZW50cnkg
KmRlbnRyeSwgc3RydWN0IHBhdGggKnBhdGgpCiBzdGF0aWMgc3NpemVfdCBnZXRfbW1fY21kbGlu
ZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAkJCSAgICAgIHNpemVf
dCBjb3VudCwgbG9mZl90ICpwcG9zKQogewotCXVuc2lnbmVkIGxvbmcgYXJnX3N0YXJ0LCBhcmdf
ZW5kLCBlbnZfc3RhcnQsIGVudl9lbmQ7CisJdW5zaWduZWQgbG9uZyBhcmdfc3RhcnQsIGFyZ19l
bmQ7CiAJdW5zaWduZWQgbG9uZyBwb3MsIGxlbjsKIAljaGFyICpwYWdlOwogCkBAIC0yMjMsMzYg
KzIyMywxOCBAQCBzdGF0aWMgc3NpemVfdCBnZXRfbW1fY21kbGluZShzdHJ1Y3QgbW1fc3RydWN0
ICptbSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAlzcGluX2xvY2soJm1tLT5hcmdfbG9jayk7CiAJYXJn
X3N0YXJ0ID0gbW0tPmFyZ19zdGFydDsKIAlhcmdfZW5kID0gbW0tPmFyZ19lbmQ7Ci0JZW52X3N0
YXJ0ID0gbW0tPmVudl9zdGFydDsKLQllbnZfZW5kID0gbW0tPmVudl9lbmQ7CiAJc3Bpbl91bmxv
Y2soJm1tLT5hcmdfbG9jayk7CiAKIAlpZiAoYXJnX3N0YXJ0ID49IGFyZ19lbmQpCiAJCXJldHVy
biAwOwogCi0JLyoKLQkgKiBXZSBoYXZlIHRyYWRpdGlvbmFsbHkgYWxsb3dlZCB0aGUgdXNlciB0
byByZS13cml0ZQotCSAqIHRoZSBhcmd1bWVudCBzdHJpbmdzIGFuZCBvdmVyZmxvdyB0aGUgZW5k
IHJlc3VsdAotCSAqIGludG8gdGhlIGVudmlyb25tZW50IHNlY3Rpb24uIEJ1dCBvbmx5IGRvIHRo
YXQgaWYKLQkgKiB0aGUgZW52aXJvbm1lbnQgYXJlYSBpcyBjb250aWd1b3VzIHRvIHRoZSBhcmd1
bWVudHMuCi0JICovCi0JaWYgKGVudl9zdGFydCAhPSBhcmdfZW5kIHx8IGVudl9zdGFydCA+PSBl
bnZfZW5kKQotCQllbnZfc3RhcnQgPSBlbnZfZW5kID0gYXJnX2VuZDsKLQotCS8qIC4uIGFuZCBs
aW1pdCBpdCB0byBhIG1heGltdW0gb2Ygb25lIHBhZ2Ugb2Ygc2xvcCAqLwotCWlmIChlbnZfZW5k
ID49IGFyZ19lbmQgKyBQQUdFX1NJWkUpCi0JCWVudl9lbmQgPSBhcmdfZW5kICsgUEFHRV9TSVpF
IC0gMTsKLQogCS8qIFdlJ3JlIG5vdCBnb2luZyB0byBjYXJlIGlmICIqcHBvcyIgaGFzIGhpZ2gg
Yml0cyBzZXQgKi8KLQlwb3MgPSBhcmdfc3RhcnQgKyAqcHBvczsKLQogCS8qIC4uIGJ1dCB3ZSBk
byBjaGVjayB0aGUgcmVzdWx0IGlzIGluIHRoZSBwcm9wZXIgcmFuZ2UgKi8KLQlpZiAocG9zIDwg
YXJnX3N0YXJ0IHx8IHBvcyA+PSBlbnZfZW5kKQorCXBvcyA9IGFyZ19zdGFydCArICpwcG9zOwor
CWlmIChwb3MgPCBhcmdfc3RhcnQgfHwgcG9zID49IGFyZ19lbmQpCiAJCXJldHVybiAwOwotCi0J
LyogLi4gYW5kIHdlIG5ldmVyIGdvIHBhc3QgZW52X2VuZCAqLwotCWlmIChlbnZfZW5kIC0gcG9z
IDwgY291bnQpCi0JCWNvdW50ID0gZW52X2VuZCAtIHBvczsKKwlpZiAoY291bnQgPiBhcmdfZW5k
IC0gcG9zKQorCQljb3VudCA9IGFyZ19lbmQgLSBwb3M7CiAKIAlwYWdlID0gKGNoYXIgKilfX2dl
dF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCk7CiAJaWYgKCFwYWdlKQpAQCAtMjYyLDQ4ICsyNDQsMTEg
QEAgc3RhdGljIHNzaXplX3QgZ2V0X21tX2NtZGxpbmUoc3RydWN0IG1tX3N0cnVjdCAqbW0sIGNo
YXIgX191c2VyICpidWYsCiAJd2hpbGUgKGNvdW50KSB7CiAJCWludCBnb3Q7CiAJCXNpemVfdCBz
aXplID0gbWluX3Qoc2l6ZV90LCBQQUdFX1NJWkUsIGNvdW50KTsKLQkJbG9uZyBvZmZzZXQ7CiAK
LQkJLyoKLQkJICogQXJlIHdlIGFscmVhZHkgc3RhcnRpbmcgcGFzdCB0aGUgb2ZmaWNpYWwgZW5k
PwotCQkgKiBXZSBhbHdheXMgaW5jbHVkZSB0aGUgbGFzdCBieXRlIHRoYXQgaXMgKnN1cHBvc2Vk
KgotCQkgKiB0byBiZSBOVUwKLQkJICovCi0JCW9mZnNldCA9IChwb3MgPj0gYXJnX2VuZCkgPyBw
b3MgLSBhcmdfZW5kICsgMSA6IDA7Ci0KLQkJZ290ID0gYWNjZXNzX3JlbW90ZV92bShtbSwgcG9z
IC0gb2Zmc2V0LCBwYWdlLCBzaXplICsgb2Zmc2V0LCBGT0xMX0FOT04pOwotCQlpZiAoZ290IDw9
IG9mZnNldCkKKwkJZ290ID0gYWNjZXNzX3JlbW90ZV92bShtbSwgcG9zLCBwYWdlLCBzaXplLCBG
T0xMX0FOT04pOworCQlpZiAoZ290IDw9IDApCiAJCQlicmVhazsKLQkJZ290IC09IG9mZnNldDsK
LQotCQkvKiBEb24ndCB3YWxrIHBhc3QgYSBOVUwgY2hhcmFjdGVyIG9uY2UgeW91IGhpdCBhcmdf
ZW5kICovCi0JCWlmIChwb3MgKyBnb3QgPj0gYXJnX2VuZCkgewotCQkJaW50IG4gPSAwOwotCi0J
CQkvKgotCQkJICogSWYgd2Ugc3RhcnRlZCBiZWZvcmUgJ2FyZ19lbmQnIGJ1dCBlbmRlZCB1cAot
CQkJICogYXQgb3IgYWZ0ZXIgaXQsIHdlIHN0YXJ0IHRoZSBOVUwgY2hhcmFjdGVyCi0JCQkgKiBj
aGVjayBhdCBhcmdfZW5kLTEgKHdoZXJlIHdlIGV4cGVjdCB0aGUgbm9ybWFsCi0JCQkgKiBFT0Yg
dG8gYmUpLgotCQkJICoKLQkJCSAqIE5PVEUhIFRoaXMgaXMgc21hbGxlciB0aGFuICdnb3QnLCBi
ZWNhdXNlCi0JCQkgKiBwb3MgKyBnb3QgPj0gYXJnX2VuZAotCQkJICovCi0JCQlpZiAocG9zIDwg
YXJnX2VuZCkKLQkJCQluID0gYXJnX2VuZCAtIHBvcyAtIDE7Ci0KLQkJCS8qIEN1dCBvZmYgYXQg
Zmlyc3QgTlVMIGFmdGVyICduJyAqLwotCQkJZ290ID0gbiArIHN0cm5sZW4ocGFnZStuLCBvZmZz
ZXQrZ290LW4pOwotCQkJaWYgKGdvdCA8IG9mZnNldCkKLQkJCQlicmVhazsKLQkJCWdvdCAtPSBv
ZmZzZXQ7Ci0KLQkJCS8qIEluY2x1ZGUgdGhlIE5VTCBpZiBpdCBleGlzdGVkICovCi0JCQlpZiAo
Z290IDwgc2l6ZSkKLQkJCQlnb3QrKzsKLQkJfQotCi0JCWdvdCAtPSBjb3B5X3RvX3VzZXIoYnVm
LCBwYWdlK29mZnNldCwgZ290KTsKKwkJZ290IC09IGNvcHlfdG9fdXNlcihidWYsIHBhZ2UsIGdv
dCk7CiAJCWlmICh1bmxpa2VseSghZ290KSkgewogCQkJaWYgKCFsZW4pCiAJCQkJbGVuID0gLUVG
QVVMVDsKLS0gCjIuMjIuMC4xOTMuZzA4MzkzNWY5YTIKCg==
--0000000000000b394a058d9d0db5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-proc-pid-cmdline-add-back-the-setproctitle-special-c.patch"
Content-Disposition: attachment; 
	filename="0002-proc-pid-cmdline-add-back-the-setproctitle-special-c.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jy2hrlpn1>
X-Attachment-Id: f_jy2hrlpn1

RnJvbSA2M2RkMTQ5OTljNmIyMTBmYmUzM2Y3ODBmZWM1M2ZhZWZhODY3ZDk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMTMgSnVsIDIwMTkgMTQ6Mjc6MTQgLTA3MDAKU3ViamVjdDog
W1BBVENIIDIvMl0gL3Byb2MvPHBpZD4vY21kbGluZTogYWRkIGJhY2sgdGhlIHNldHByb2N0aXRs
ZSgpIHNwZWNpYWwKIGNhc2UKClRoaXMgbWFrZXMgdGhlIHNldHByb2N0aXRsZSgpIHNwZWNpYWwg
Y2FzZSB2ZXJ5IGV4cGxpY2l0IGluZGVlZCwgYW5kCmhhbmRsZXMgaXQgd2l0aCBhIHNlcGFyYXRl
IGhlbHBlciBmdW5jdGlvbiBlbnRpcmVseS4KClRoaXMgbWFrZXMgdGhlIGxvZ2ljIGFib3V0IHdo
ZW4gd2UgdXNlIHRoZSBzdHJpbmcgbGVuZ3RocyBldGMgbXVjaCBtb3JlCm9idmlvdXMsIGFuZCBt
YWtlcyBpdCBlYXN5IHRvIHNlZSB3aGF0IHdlIGRvLgoKWyBGaXhlZCBmb3IgbWlzc2luZyAnY291
bnQnIGNoZWNrIG5vdGVkIGJ5IEFsZXhleSBJemJ5c2hldiBdClNpZ25lZC1vZmYtYnk6IExpbnVz
IFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBmcy9wcm9jL2Jh
c2UuYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystCiAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2ZzL3Byb2MvYmFzZS5jIGIvZnMvcHJvYy9iYXNlLmMKaW5kZXggODA0MGY5ZDFj
ZjA3Li4zYWQzZmY0Y2MxMmMgMTAwNjQ0Ci0tLSBhL2ZzL3Byb2MvYmFzZS5jCisrKyBiL2ZzL3By
b2MvYmFzZS5jCkBAIC0yMDksMTIgKzIwOSw1NCBAQCBzdGF0aWMgaW50IHByb2Nfcm9vdF9saW5r
KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IHBhdGggKnBhdGgpCiAJcmV0dXJuIHJlc3Vs
dDsKIH0KIAorLyoKKyAqIElmIHRoZSB1c2VyIHVzZWQgc2V0cHJvY3RpdGxlKCksIHdlIGp1c3Qg
Z2V0IHRoZSBzdHJpbmcgZnJvbQorICogdXNlciBzcGFjZSBhdCBhcmdfc3RhcnQsIGFuZCBsaW1p
dCBpdCB0byBhIG1heGltdW0gb2Ygb25lIHBhZ2UuCisgKi8KK3N0YXRpYyBzc2l6ZV90IGdldF9t
bV9wcm9jdGl0bGUoc3RydWN0IG1tX3N0cnVjdCAqbW0sIGNoYXIgX191c2VyICpidWYsCisJCQkJ
c2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MsCisJCQkJdW5zaWduZWQgbG9uZyBhcmdfc3RhcnQp
Cit7CisJdW5zaWduZWQgbG9uZyBwb3MgPSAqcHBvczsKKwljaGFyICpwYWdlOworCWludCByZXQs
IGdvdDsKKworCWlmIChwb3MgPj0gUEFHRV9TSVpFKQorCQlyZXR1cm4gMDsKKworCXBhZ2UgPSAo
Y2hhciAqKV9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMKTsKKwlpZiAoIXBhZ2UpCisJCXJldHVy
biAtRU5PTUVNOworCisJcmV0ID0gMDsKKwlnb3QgPSBhY2Nlc3NfcmVtb3RlX3ZtKG1tLCBhcmdf
c3RhcnQsIHBhZ2UsIFBBR0VfU0laRSwgRk9MTF9BTk9OKTsKKwlpZiAoZ290ID4gMCkgeworCQlp
bnQgbGVuID0gc3RybmxlbihwYWdlLCBnb3QpOworCisJCS8qIEluY2x1ZGUgdGhlIE5VTCBjaGFy
YWN0ZXIgaWYgaXQgd2FzIGZvdW5kICovCisJCWlmIChsZW4gPCBnb3QpCisJCQlsZW4rKzsKKwor
CQlpZiAobGVuID4gcG9zKSB7CisJCQlsZW4gLT0gcG9zOworCQkJaWYgKGxlbiA+IGNvdW50KQor
CQkJCWxlbiA9IGNvdW50OworCQkJbGVuIC09IGNvcHlfdG9fdXNlcihidWYsIHBhZ2UrcG9zLCBs
ZW4pOworCQkJaWYgKCFsZW4pCisJCQkJbGVuID0gLUVGQVVMVDsKKwkJCXJldCA9IGxlbjsKKwkJ
fQorCX0KKwlmcmVlX3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGFnZSk7CisJcmV0dXJuIHJldDsKK30K
Kwogc3RhdGljIHNzaXplX3QgZ2V0X21tX2NtZGxpbmUoc3RydWN0IG1tX3N0cnVjdCAqbW0sIGNo
YXIgX191c2VyICpidWYsCiAJCQkgICAgICBzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykKIHsK
IAl1bnNpZ25lZCBsb25nIGFyZ19zdGFydCwgYXJnX2VuZDsKIAl1bnNpZ25lZCBsb25nIHBvcywg
bGVuOwotCWNoYXIgKnBhZ2U7CisJY2hhciAqcGFnZSwgYzsKIAogCS8qIENoZWNrIGlmIHByb2Nl
c3Mgc3Bhd25lZCBmYXIgZW5vdWdoIHRvIGhhdmUgY21kbGluZS4gKi8KIAlpZiAoIW1tLT5lbnZf
ZW5kKQpAQCAtMjI4LDYgKzI3MCwxNiBAQCBzdGF0aWMgc3NpemVfdCBnZXRfbW1fY21kbGluZShz
dHJ1Y3QgbW1fc3RydWN0ICptbSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAlpZiAoYXJnX3N0YXJ0ID49
IGFyZ19lbmQpCiAJCXJldHVybiAwOwogCisJLyoKKwkgKiBNYWdpY2FsIHNwZWNpYWwgY2FzZTog
aWYgdGhlIGFyZ3ZbXSBlbmQgYnl0ZSBpcyBub3QKKwkgKiB6ZXJvLCB0aGUgdXNlciBoYXMgb3Zl
cndyaXR0ZW4gaXQgd2l0aCBzZXRwcm9jdGl0bGUoMykuCisJICoKKwkgKiBQb3NzaWJsZSBmdXR1
cmUgZW5oYW5jZW1lbnQ6IGRvIHRoaXMgb25seSBvbmNlIHdoZW4KKwkgKiBwb3MgaXMgMCwgYW5k
IHNldCBhIGZsYWcgaW4gdGhlICdzdHJ1Y3QgZmlsZScuCisJICovCisJaWYgKGFjY2Vzc19yZW1v
dGVfdm0obW0sIGFyZ19lbmQtMSwgJmMsIDEsIEZPTExfQU5PTikgPT0gMSAmJiBjKQorCQlyZXR1
cm4gZ2V0X21tX3Byb2N0aXRsZShtbSwgYnVmLCBjb3VudCwgcHBvcywgYXJnX3N0YXJ0KTsKKwog
CS8qIFdlJ3JlIG5vdCBnb2luZyB0byBjYXJlIGlmICIqcHBvcyIgaGFzIGhpZ2ggYml0cyBzZXQg
Ki8KIAkvKiAuLiBidXQgd2UgZG8gY2hlY2sgdGhlIHJlc3VsdCBpcyBpbiB0aGUgcHJvcGVyIHJh
bmdlICovCiAJcG9zID0gYXJnX3N0YXJ0ICsgKnBwb3M7Ci0tIAoyLjIyLjAuMTkzLmcwODM5MzVm
OWEyCgo=
--0000000000000b394a058d9d0db5--
