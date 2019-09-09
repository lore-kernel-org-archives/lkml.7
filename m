Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF8620863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=semmle.com header.i=@semmle.com header.b="m1cb7jr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfIIPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:35:20 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:39481 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfIIPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:35:20 -0400
Received: by mail-lj1-f172.google.com with SMTP id j16so13229768ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semmle.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=1OJ5Ls++kke6dDPvYuq3RzXiUNTgE8GTz0O1j/nW6Gc=;
        b=m1cb7jr/vqsvV2RXgqjMv/eS49bh1YBw88FeJcN5FOBzuV0N5m+s2skCighCh++q2b
         o/mFLsrWb39HurMkLUHO13uankOEWWv+klVcQ6GPWMQpx2PLCYhJkswQN+DSLUFxSwRi
         ptLonsLRqwpiToeDnjvwNA2UwuJGWVGkVzZIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1OJ5Ls++kke6dDPvYuq3RzXiUNTgE8GTz0O1j/nW6Gc=;
        b=MlOAiH+skZlAH1ZZURW9RuF/ZDcyrQHtddzd30ije5A3uG23jz1bini3qUCXlcno1w
         lV8W9lcK0kCwNT7s9lRJxHApE2b+NxlkfYMpUJ1vVzX3T+/1PGIyuSsTFf79MBSdDhDR
         MU2JpoVG3/JyJd7jgbzhUWNfrj4YQwS1twxKpFGNI1URpFg61FZRWDTBrScegF/3+tHT
         5Md+TF6gvIxpKcGPORSXzV35kbB6iH5AX4P8vOEk62rLyJZlOgfKS4Gmz9otftEaetAp
         48sFBZXxx9rsdIr0QAVQWGBCzGeaez5mrGWGzoN6+jCI3EXF+t9aGfilmdAwle/2Fymi
         37Cg==
X-Gm-Message-State: APjAAAXxKgFUzrN4up/jzeHkxK2NKiEM568M0O82jg+Xjh+lAdS+EaTq
        VffnLp/fpIn2trVGeQ6hdtuRU0LKKDL/ekDWCNFr4d/W2que
X-Google-Smtp-Source: APXvYqxbjYbRaG8qWhfQ1nSG6I435cweJ19t5pZ+hYMFcdIt4QRXkF+2T117QGu5UJeJCHiQVXNgqkBkqvahhWszS/Y=
X-Received: by 2002:a2e:8592:: with SMTP id b18mr15548714lji.18.1568043316474;
 Mon, 09 Sep 2019 08:35:16 -0700 (PDT)
MIME-Version: 1.0
From:   Semmle Security Reports <security-reports@semmle.com>
Date:   Mon, 9 Sep 2019 12:35:05 -0300
Message-ID: <CADJ_3a8WFrs5NouXNqS5WYe7rebFP+_A5CheeqAyD_p7DFJJcg@mail.gmail.com>
Subject: Multiple NULL deref on alloc_workqueue
To:     linux-kernel@vger.kernel.org,
        Semmle vulnerability research team - reports 
        <security-reports@semmle.com>
Content-Type: multipart/mixed; boundary="000000000000df67d60592208814"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000df67d60592208814
Content-Type: text/plain; charset="UTF-8"

There are multiple points in the Linux Kernel where alloc_workqueue is
not getting checked for errors and as a result, a potential NULL
dereference could occur.

I'm attaching a patch for some of them.
There are two cases I left untouched that requires a bit more refactoring:
https://github.com/torvalds/linux/blob/master/drivers/net/wireless/intel/iwlwifi/pcie/trans.c#L3656
https://github.com/torvalds/linux/blob/master/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c#L4508

Regards,
Semmle security team

--000000000000df67d60592208814
Content-Type: text/plain; charset="US-ASCII"; name="patch_nullderef.txt"
Content-Disposition: attachment; filename="patch_nullderef.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k0ckh3ee0>
X-Attachment-Id: f_k0ckh3ee0

ZGlmZiAtLWdpdCBhL2xpbnV4L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRlcnJ1
cHQuYyBiL2IvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludGVycnVwdC5jCmluZGV4
IGM1NmFjNDcuLjI1MmM1N2UgMTAwNjQ0Ci0tLSBhL2xpbnV4L2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9pbnRlcnJ1cHQuYworKysgYi9iL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9pbnRlcnJ1cHQuYwpAQCAtNjIsNiArNjIsMTEgQEAgaW50IGtmZF9pbnRlcnJ1cHRfaW5p
dChzdHJ1Y3Qga2ZkX2RldiAqa2ZkKQogCX0KIAogCWtmZC0+aWhfd3EgPSBhbGxvY193b3JrcXVl
dWUoIktGRCBJSCIsIFdRX0hJR0hQUkksIDEpOworCWlmKCAha2ZkLT5paF93cSApIHsKKwkJa2Zp
Zm9fZnJlZSgma2ZkLT5paF9maWZvKTsKKwkJZGV2X2VycihrZmRfY2hhcmRldigpLCAiRmFpbGVk
IHRvIGFsbG9jYXRlIEtGRCBJSCB3b3JrcXVldWVcbiIpOworCQlyZXR1cm4ga2ZkLT5paF93cTsK
Kwl9CiAJc3Bpbl9sb2NrX2luaXQoJmtmZC0+aW50ZXJydXB0X2xvY2spOwogCiAJSU5JVF9XT1JL
KCZrZmQtPmludGVycnVwdF93b3JrLCBpbnRlcnJ1cHRfd3EpOwpkaWZmIC0tZ2l0IGEvbGludXgv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIGIvYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKaW5kZXggYmQ1MmYxNS4uMWE0OTAzMCAxMDA2NDQK
LS0tIGEvbGludXgvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jCisrKyBi
L2IvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jCkBAIC02ODMsNiArNjgz
LDExIEBAIHN0YXRpYyB2b2lkIHJhZGVvbl9jcnRjX2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRl
diwgaW50IGluZGV4KQogCWRybV9tb2RlX2NydGNfc2V0X2dhbW1hX3NpemUoJnJhZGVvbl9jcnRj
LT5iYXNlLCAyNTYpOwogCXJhZGVvbl9jcnRjLT5jcnRjX2lkID0gaW5kZXg7CiAJcmFkZW9uX2Ny
dGMtPmZsaXBfcXVldWUgPSBhbGxvY193b3JrcXVldWUoInJhZGVvbi1jcnRjIiwgV1FfSElHSFBS
SSwgMCk7CisJaWYoICFyYWRlb25fY3J0Yy0+ZmxpcF9xdWV1ZSkgeworCQlrZnJlZShyYWRlb25f
Y3J0Yyk7CisJCXJldHVybjsKKworCX0KIAlyZGV2LT5tb2RlX2luZm8uY3J0Y3NbaW5kZXhdID0g
cmFkZW9uX2NydGM7CiAKIAlpZiAocmRldi0+ZmFtaWx5ID49IENISVBfQk9OQUlSRSkgewpkaWZm
IC0tZ2l0IGEvbGludXgvZHJpdmVycy9uZXQvZmplcy9mamVzX21haW4uYyBiL2IvZHJpdmVycy9u
ZXQvZmplcy9mamVzX21haW4uYwppbmRleCBiYmJjMWRjLi5kODUwYjE3IDEwMDY0NAotLS0gYS9s
aW51eC9kcml2ZXJzL25ldC9mamVzL2ZqZXNfbWFpbi5jCisrKyBiL2IvZHJpdmVycy9uZXQvZmpl
cy9mamVzX21haW4uYwpAQCAtMTIzNyw4ICsxMjM3LDE1IEBAIHN0YXRpYyBpbnQgZmplc19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwbGF0X2RldikKIAlhZGFwdGVyLT5vcGVuX2d1YXJk
ID0gZmFsc2U7CiAKIAlhZGFwdGVyLT50eHJ4X3dxID0gYWxsb2Nfd29ya3F1ZXVlKERSVl9OQU1F
ICIvdHhyeCIsIFdRX01FTV9SRUNMQUlNLCAwKTsKKwlpZighYWRhcHRlci0+dHhyeF93cSkgewor
CQkgZ290byBlcnJfZnJlZV9uZXRkZXY7CQkKKwl9CiAJYWRhcHRlci0+Y29udHJvbF93cSA9IGFs
bG9jX3dvcmtxdWV1ZShEUlZfTkFNRSAiL2NvbnRyb2wiLAogCQkJCQkgICAgICBXUV9NRU1fUkVD
TEFJTSwgMCk7CisJaWYoIWFkYXB0ZXItPmNvbnRyb2xfd3EpIHsKKwkJIGRlc3Ryb3lfd29ya3F1
ZXVlKGFkYXB0ZXItPnR4cnhfd3EpOworCQkgZ290byBlcnJfZnJlZV9uZXRkZXY7CisJfQogCiAJ
SU5JVF9XT1JLKCZhZGFwdGVyLT50eF9zdGFsbF90YXNrLCBmamVzX3R4X3N0YWxsX3Rhc2spOwog
CUlOSVRfV09SSygmYWRhcHRlci0+cmFpc2VfaW50cl9yeGRhdGFfdGFzaywKZGlmZiAtLWdpdCBh
L2xpbnV4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbGliZXJ0YXMvaWZfc2Rpby5jIGIv
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL2xpYmVydGFzL2lmX3NkaW8uYwppbmRleCAy
NDJkODg0Li4wMzA4M2ViIDEwMDY0NAotLS0gYS9saW51eC9kcml2ZXJzL25ldC93aXJlbGVzcy9t
YXJ2ZWxsL2xpYmVydGFzL2lmX3NkaW8uYworKysgYi9iL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21h
cnZlbGwvbGliZXJ0YXMvaWZfc2Rpby5jCkBAIC0xMTc5LDYgKzExNzksMTAgQEAgc3RhdGljIGlu
dCBpZl9zZGlvX3Byb2JlKHN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMsCiAKIAlzcGluX2xvY2tfaW5p
dCgmY2FyZC0+bG9jayk7CiAJY2FyZC0+d29ya3F1ZXVlID0gYWxsb2Nfd29ya3F1ZXVlKCJsaWJl
cnRhc19zZGlvIiwgV1FfTUVNX1JFQ0xBSU0sIDApOworCWlmKCFjYXJkLT53b3JrcXVldWUpIHsK
KwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBmcmVlX2JlZm9yZV9xdWV1ZTo7CisJfQogCUlOSVRf
V09SSygmY2FyZC0+cGFja2V0X3dvcmtlciwgaWZfc2Rpb19ob3N0X3RvX2NhcmRfd29ya2VyKTsK
IAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZjYXJkLT5wd3Jvbl93YWl0cSk7CiAKQEAgLTEyMzAsNiAr
MTIzNCw3IEBAIGVycl9hY3RpdmF0ZV9jYXJkOgogCWxic19yZW1vdmVfY2FyZChwcml2KTsKIGZy
ZWU6CiAJZGVzdHJveV93b3JrcXVldWUoY2FyZC0+d29ya3F1ZXVlKTsKK2ZyZWVfYmVmb3JlX3F1
ZXVlOgogCXdoaWxlIChjYXJkLT5wYWNrZXRzKSB7CiAJCXBhY2tldCA9IGNhcmQtPnBhY2tldHM7
CiAJCWNhcmQtPnBhY2tldHMgPSBjYXJkLT5wYWNrZXRzLT5uZXh0OwpkaWZmIC0tZ2l0IGEvbGlu
dXgvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX29zLmMgYi9iL2RyaXZlcnMvc2NzaS9xbGEyeHh4
L3FsYV9vcy5jCmluZGV4IDk4ZTYwYTMuLjhmMjg1YzUgMTAwNjQ0Ci0tLSBhL2xpbnV4L2RyaXZl
cnMvc2NzaS9xbGEyeHh4L3FsYV9vcy5jCisrKyBiL2IvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxh
X29zLmMKQEAgLTMyMzIsNiArMzIzMiwxMCBAQCBxbGEyeDAwX3Byb2JlX29uZShzdHJ1Y3QgcGNp
X2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQogCSAgICByZXEtPnJl
cV9xX2luLCByZXEtPnJlcV9xX291dCwgcnNwLT5yc3BfcV9pbiwgcnNwLT5yc3BfcV9vdXQpOwog
CiAJaGEtPndxID0gYWxsb2Nfd29ya3F1ZXVlKCJxbGEyeHh4X3dxIiwgMCwgMCk7CisJaWYoIWhh
LT53cSkgeyAKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBwcm9iZV9mYWlsZWQ7CisJfQogCiAJ
aWYgKGhhLT5pc3Bfb3BzLT5pbml0aWFsaXplX2FkYXB0ZXIoYmFzZV92aGEpKSB7CiAJCXFsX2xv
ZyhxbF9sb2dfZmF0YWwsIGJhc2VfdmhhLCAweDAwZDYsCg==
--000000000000df67d60592208814--
