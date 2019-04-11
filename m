Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B09C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnMP5fzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDKSly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:41:54 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36672 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDKSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:41:54 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so11244761itc.1;
        Thu, 11 Apr 2019 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpIolUR+iAf7QWpl8TV6dT53FTJqIb8Gk3vTuoP/yYM=;
        b=TnMP5fzymuZvpwi26W2dDqT5Ruz7jsl7JOs2IycM+ZmmXd/8ZoMCAlHEPvn8HoBNfK
         V1Jx3u/72d39NPcWbJLZ945usisVJT3gHF2ygMD6BDTQwF9EaeeuvPdayVIGqE8WuDbN
         5riw/gNfwlJGYnkgihBf8NFq93AyNdhnNxbKUPNc08oQEjh2e4x72CStquFtoVJb4nF0
         Um7kSs8ztNuN5BujthY+KxXkShBArSFK+FwlL1wqhA+HdAP9Dstz0PgqWeL9lTBsSm8w
         Vviotb9pQpHcdysK/kaKLp2zD5udry5yupvKYGnQ+eilAfEV8/dw2c7Okn2DZLKkSCyb
         /s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpIolUR+iAf7QWpl8TV6dT53FTJqIb8Gk3vTuoP/yYM=;
        b=ovb1XsA/G/u5PwbLPz3PPK6gookiZgG+yi9cLLK/4GfMiWlc1cem5fb2lO0MyeE8k1
         rkBEEPgzDlndC62wYbZFWDEDaUmGK7JlE/79UJ8064f9cogY6yczI80QbHLl1sPFXrlT
         JmpqA7zYF/kJXiYdP8ticeikNMRGzZADXqFThhe2hhsS4o4b7iKx48aGspJQN9s5e1nh
         tNS6QmQmubZ448BVRdoRmQDEtKXxH3ZecjXOQUJOVtuUp5J53uDbFUFcq/4pxSTzFHgR
         I+nU4ZzrfRweOmY/jHeDZHRTDgj2kg5VBXnJlSTSrG/oP35FvAZbAZ3+faufN1SsVNrB
         qwnQ==
X-Gm-Message-State: APjAAAUYo4sQ/6WD99rxR0EXRJaEqFpyvZEkcNLA6K+ZWPy9RUrf40ih
        GTMhEVle3HmVBIJA1bWsFdGN1EtjqSt0HwBEMOE=
X-Google-Smtp-Source: APXvYqzRRTrIZadBt21XAHR8KrPobn+CILUzIMORYFc1L6U8/9ziWagARiyTQ/dAUyBQ8L7+ajzj4HPjBNOOddq1+H4=
X-Received: by 2002:a24:9b8b:: with SMTP id o133mr9877923itd.74.1555008112409;
 Thu, 11 Apr 2019 11:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190410174139.20012-1-tiny.windzz@gmail.com> <20190410174139.20012-2-tiny.windzz@gmail.com>
 <20190411080955.ysp3wreifwqrpn3n@flea> <CAEExFWvcoK+C=_+knCw4nZQso2Frz0-CpbECQbVzKPS11P9RUw@mail.gmail.com>
In-Reply-To: <CAEExFWvcoK+C=_+knCw4nZQso2Frz0-CpbECQbVzKPS11P9RUw@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 12 Apr 2019 02:41:41 +0800
Message-ID: <CAEExFWszJ36=5+2iKE1a7Zgoscn4DYH+=DiPx0si+e9C_5K=yw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002a09b20586458a8c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002a09b20586458a8c
Content-Type: text/plain; charset="UTF-8"

Hi,
    Changes:
    1. I removed this sunxi_cpufreq_soc_data structure for now.
    2. Convert to  less generic name.
    3. Update soc_bin xlate. (LINE:484
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/soc/sunxi/sunxi-sid.c)

    (maybe attach a file is better)

    Now temporarily consider it as supporting only one platform.
    Anything else to modify?

THx,
Yangtao

--0000000000002a09b20586458a8c
Content-Type: text/x-csrc; charset="US-ASCII"; name="sun5i-cpufreq-nvmem.c"
Content-Disposition: attachment; filename="sun5i-cpufreq-nvmem.c"
Content-Transfer-Encoding: base64
Content-ID: <f_juczo34n0>
X-Attachment-Id: f_juczo34n0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLyoKICogQWxsd2lubmVyIENQVUZy
ZXEgbnZtZW0gYmFzZWQgZHJpdmVyCiAqCiAqIFRoZSBzdW41aS1jcHVmcmVxLW52bWVtIGRyaXZl
ciByZWFkcyB0aGUgZWZ1c2UgdmFsdWUgZnJvbSB0aGUgU29DIHRvCiAqIHByb3ZpZGUgdGhlIE9Q
UCBmcmFtZXdvcmsgd2l0aCByZXF1aXJlZCBpbmZvcm1hdGlvbi4KICoKICogQ29weXJpZ2h0IChD
KSAyMDE5IFlhbmd0YW8gTGkgPHRpbnkud2luZHp6QGdtYWlsLmNvbT4KICovCgojZGVmaW5lIHBy
X2ZtdChmbXQpIEtCVUlMRF9NT0ROQU1FICI6ICIgZm10CgojaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+CiNpbmNsdWRlIDxsaW51eC9udm1lbS1jb25zdW1lci5oPgojaW5jbHVkZSA8bGludXgvb2Zf
ZGV2aWNlLmg+CiNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KI2luY2x1ZGUgPGxp
bnV4L3BtX29wcC5oPgojaW5jbHVkZSA8bGludXgvc2xhYi5oPgoKI2RlZmluZSBNQVhfTkFNRV9M
RU4JNwoKI2RlZmluZSBOVk1FTV9NQVNLCTB4NwojZGVmaW5lIE5WTUVNX1NISUZUCTUKCnN0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjcHVmcmVxX2R0X3BkZXYsICpzdW54aV9jcHVmcmVx
X3BkZXY7CgovKioKICogc3VueGlfY3B1ZnJlcV9nZXRfZWZ1c2UoKSAtIFBhcnNlIGFuZCByZXR1
cm4gZWZ1c2UgdmFsdWUgcHJlc2VudCBvbiBTb0MKICogQHZlcnNpb25zOiBTZXQgdG8gdGhlIHZh
bHVlIHBhcnNlZCBmcm9tIGVmdXNlCiAqCiAqIFJldHVybnMgMCBpZiBzdWNjZXNzLgogKi8Kc3Rh
dGljIGludCBzdW54aV9jcHVmcmVxX2dldF9lZnVzZSh1MzIgKnZlcnNpb25zKQp7CglzdHJ1Y3Qg
bnZtZW1fY2VsbCAqc3BlZWRiaW5fbnZtZW07CglzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOwoJc3Ry
dWN0IGRldmljZSAqY3B1X2RldjsKCXUzMiAqc3BlZWRiaW4sIGVmdXNlX3ZhbHVlOwoJc2l6ZV90
IGxlbjsKCWludCByZXQ7CgoJY3B1X2RldiA9IGdldF9jcHVfZGV2aWNlKDApOwoJaWYgKCFjcHVf
ZGV2KQoJCXJldHVybiAtRU5PREVWOwoKCW5wID0gZGV2X3BtX29wcF9vZl9nZXRfb3BwX2Rlc2Nf
bm9kZShjcHVfZGV2KTsKCWlmICghbnApCgkJcmV0dXJuIC1FTk9FTlQ7CgoJcmV0ID0gb2ZfZGV2
aWNlX2lzX2NvbXBhdGlibGUobnAsCgkJImFsbHdpbm5lcixzdW41MGktaDYtb3BlcmF0aW5nLXBv
aW50cyIpOwoJaWYgKCFyZXQpIHsKCQlvZl9ub2RlX3B1dChucCk7CgkJcmV0dXJuIC1FTk9FTlQ7
Cgl9CgoJc3BlZWRiaW5fbnZtZW0gPSBvZl9udm1lbV9jZWxsX2dldChucCwgTlVMTCk7CglvZl9u
b2RlX3B1dChucCk7CglpZiAoSVNfRVJSKHNwZWVkYmluX252bWVtKSkgewoJCWlmIChQVFJfRVJS
KHNwZWVkYmluX252bWVtKSAhPSAtRVBST0JFX0RFRkVSKQoJCQlwcl9lcnIoIkNvdWxkIG5vdCBn
ZXQgbnZtZW0gY2VsbDogJWxkXG4iLAoJCQlQVFJfRVJSKHNwZWVkYmluX252bWVtKSk7CgkJcmV0
dXJuIFBUUl9FUlIoc3BlZWRiaW5fbnZtZW0pOwoJfQoKCXNwZWVkYmluID0gbnZtZW1fY2VsbF9y
ZWFkKHNwZWVkYmluX252bWVtLCAmbGVuKTsKCW52bWVtX2NlbGxfcHV0KHNwZWVkYmluX252bWVt
KTsKCWlmIChJU19FUlIoc3BlZWRiaW4pKQoJCXJldHVybiBQVFJfRVJSKHNwZWVkYmluKTsKCgll
ZnVzZV92YWx1ZSA9ICgqc3BlZWRiaW4gPj4gTlZNRU1fU0hJRlQpICYgTlZNRU1fTUFTSzsKCXN3
aXRjaCAoZWZ1c2VfdmFsdWUpIHsKCWNhc2UgMGIwMDAxOgoJCSp2ZXJzaW9ucyA9IDE7CgkJYnJl
YWs7CgljYXNlIDBiMDAxMToKCQkqdmVyc2lvbnMgPSAyOwoJCWJyZWFrOwoJZGVmYXVsdDoKCQkv
KgoJCSAqIEZvciBvdGhlciBzaXR1YXRpb25zLCB3ZSB0cmVhdCBpdCBhcyBiaW4wLgoJCSAqIFRo
aXMgdmYgdGFibGUgY2FuIGJlIHJ1biBmb3IgYW55IGdvb2QgY3B1LgoJCSAqLwoJCSp2ZXJzaW9u
cyA9IDA7CgkJYnJlYWs7Cgl9CgoJa2ZyZWUoc3BlZWRiaW4pOwoJcmV0dXJuIDA7Cn07CgpzdGF0
aWMgaW50IHN1bnhpX2NwdWZyZXFfbnZtZW1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKewoJc3RydWN0IG9wcF90YWJsZSAqKm9wcF90YWJsZXM7CgljaGFyIG5hbWVbTUFYX05B
TUVfTEVOXTsKCXVuc2lnbmVkIGludCBjcHU7Cgl1MzIgc3BlZWQgPSAwOwoJaW50IHJldDsKCglv
cHBfdGFibGVzID0ga2NhbGxvYyhudW1fcG9zc2libGVfY3B1cygpLCBzaXplb2YoKm9wcF90YWJs
ZXMpLAoJCQkgICAgIEdGUF9LRVJORUwpOwoJaWYgKCFvcHBfdGFibGVzKQoJCXJldHVybiAtRU5P
TUVNOwoKCXJldCA9IHN1bnhpX2NwdWZyZXFfZ2V0X2VmdXNlKCZzcGVlZCk7CglpZiAocmV0KQoJ
CXJldHVybiByZXQ7CgoJc25wcmludGYobmFtZSwgTUFYX05BTUVfTEVOLCAic3BlZWQlZCIsIHNw
ZWVkKTsKCglmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7CgkJc3RydWN0IGRldmljZSAqY3B1
X2RldiA9IGdldF9jcHVfZGV2aWNlKGNwdSk7CgoJCWlmIChjcHVfZGV2ID09IE5VTEwpIHsKCQkJ
cmV0ID0gLUVOT0RFVjsKCQkJZ290byBmcmVlX29wcDsKCQl9CgoJCW9wcF90YWJsZXNbY3B1XSA9
IGRldl9wbV9vcHBfc2V0X3Byb3BfbmFtZShjcHVfZGV2LCBuYW1lKTsKCQlpZiAoSVNfRVJSKG9w
cF90YWJsZXNbY3B1XSkpIHsKCQkJcmV0ID0gUFRSX0VSUihvcHBfdGFibGVzW2NwdV0pOwoJCQlw
cl9lcnIoIkZhaWxlZCB0byBzZXQgcHJvcCBuYW1lXG4iKTsKCQkJZ290byBmcmVlX29wcDsKCQl9
Cgl9CgoJY3B1ZnJlcV9kdF9wZGV2ID0gcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyX3NpbXBsZSgi
Y3B1ZnJlcS1kdCIsIC0xLAoJCQkJCQkJICBOVUxMLCAwKTsKCWlmICghSVNfRVJSKGNwdWZyZXFf
ZHRfcGRldikpIHsKCQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBvcHBfdGFibGVzKTsKCQly
ZXR1cm4gMDsKCX0KCglyZXQgPSBQVFJfRVJSKGNwdWZyZXFfZHRfcGRldik7Cglwcl9lcnIoIkZh
aWxlZCB0byByZWdpc3RlciBwbGF0Zm9ybSBkZXZpY2VcbiIpOwoKZnJlZV9vcHA6Cglmb3JfZWFj
aF9wb3NzaWJsZV9jcHUoY3B1KSB7CgkJaWYgKElTX0VSUl9PUl9OVUxMKG9wcF90YWJsZXNbY3B1
XSkpCgkJCWJyZWFrOwoJCWRldl9wbV9vcHBfcHV0X3Byb3BfbmFtZShvcHBfdGFibGVzW2NwdV0p
OwoJfQoJa2ZyZWUob3BwX3RhYmxlcyk7CgoJcmV0dXJuIHJldDsKfQoKc3RhdGljIGludCBzdW54
aV9jcHVmcmVxX252bWVtX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQp7Cglz
dHJ1Y3Qgb3BwX3RhYmxlICoqb3BwX3RhYmxlcyA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYp
OwoJdW5zaWduZWQgaW50IGNwdTsKCglwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3RlcihjcHVmcmVx
X2R0X3BkZXYpOwoKCWZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpCgkJZGV2X3BtX29wcF9wdXRf
cHJvcF9uYW1lKG9wcF90YWJsZXNbY3B1XSk7CgoJa2ZyZWUob3BwX3RhYmxlcyk7CgoJcmV0dXJu
IDA7Cn0KCnN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHN1bnhpX2NwdWZyZXFfZHJpdmVy
ID0gewoJLnByb2JlID0gc3VueGlfY3B1ZnJlcV9udm1lbV9wcm9iZSwKCS5yZW1vdmUgPSBzdW54
aV9jcHVmcmVxX252bWVtX3JlbW92ZSwKCS5kcml2ZXIgPSB7CgkJLm5hbWUgPSAic3VueGktY3B1
ZnJlcS1udm1lbSIsCgl9LAp9OwoKc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgc3Vu
eGlfY3B1ZnJlcV9tYXRjaF9saXN0W10gPSB7Cgl7IC5jb21wYXRpYmxlID0gImFsbHdpbm5lcixz
dW41MGktaDYiIH0sCgl7fQp9OwoKc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKnN1
bnhpX2NwdWZyZXFfbWF0Y2hfbm9kZSh2b2lkKQp7Cgljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
ICptYXRjaDsKCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7CgoJbnAgPSBvZl9maW5kX25vZGVfYnlf
cGF0aCgiLyIpOwoJbWF0Y2ggPSBvZl9tYXRjaF9ub2RlKHN1bnhpX2NwdWZyZXFfbWF0Y2hfbGlz
dCwgbnApOwoJb2Zfbm9kZV9wdXQobnApOwoKCXJldHVybiBtYXRjaDsKfQoKLyoKICogU2luY2Ug
dGhlIGRyaXZlciBkZXBlbmRzIG9uIG52bWVtIGRyaXZlcnMsIHdoaWNoIG1heSByZXR1cm4gRVBS
T0JFX0RFRkVSLAogKiBhbGwgdGhlIHJlYWwgYWN0aXZpdHkgaXMgZG9uZSBpbiB0aGUgcHJvYmUs
IHdoaWNoIG1heSBiZSBkZWZlcmVkIGFzIHdlbGwuCiAqIFRoZSBpbml0IGhlcmUgaXMgb25seSBy
ZWdpc3RlcmluZyB0aGUgZHJpdmVyIGFuZCB0aGUgcGxhdGZvcm0gZGV2aWNlLgogKi8Kc3RhdGlj
IGludCBfX2luaXQgc3VueGlfY3B1ZnJlcV9pbml0KHZvaWQpCnsKCWNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgKm1hdGNoOwoJaW50IHJldDsKCgltYXRjaCA9IHN1bnhpX2NwdWZyZXFfbWF0Y2hf
bm9kZSgpOwoJaWYgKCFtYXRjaCkKCQlyZXR1cm4gLUVOT0RFVjsKCglyZXQgPSBwbGF0Zm9ybV9k
cml2ZXJfcmVnaXN0ZXIoJnN1bnhpX2NwdWZyZXFfZHJpdmVyKTsKCWlmICh1bmxpa2VseShyZXQg
PCAwKSkKCQlyZXR1cm4gcmV0OwoKCXN1bnhpX2NwdWZyZXFfcGRldiA9IHBsYXRmb3JtX2Rldmlj
ZV9yZWdpc3Rlcl9zaW1wbGUoCgkJInN1bnhpLWNwdWZyZXEtbnZtZW0iLCAtMSwgTlVMTCwgMCk7
CglyZXQgPSBQVFJfRVJSX09SX1pFUk8oc3VueGlfY3B1ZnJlcV9wZGV2KTsKCWlmIChyZXQgPT0g
MCkKCQlyZXR1cm4gMDsKCglwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3Rlcigmc3VueGlfY3B1ZnJl
cV9kcml2ZXIpOwoJcmV0dXJuIHJldDsKfQptb2R1bGVfaW5pdChzdW54aV9jcHVmcmVxX2luaXQp
OwoKc3RhdGljIHZvaWQgX19leGl0IHN1bnhpX2NwdWZyZXFfZXhpdCh2b2lkKQp7CglwbGF0Zm9y
bV9kZXZpY2VfdW5yZWdpc3RlcihzdW54aV9jcHVmcmVxX3BkZXYpOwoJcGxhdGZvcm1fZHJpdmVy
X3VucmVnaXN0ZXIoJnN1bnhpX2NwdWZyZXFfZHJpdmVyKTsKfQptb2R1bGVfZXhpdChzdW54aV9j
cHVmcmVxX2V4aXQpOwoKTU9EVUxFX0RFU0NSSVBUSU9OKCJTdW54aSBjcHVmcmVxIGRyaXZlciIp
OwpNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7Cg==
--0000000000002a09b20586458a8c--
