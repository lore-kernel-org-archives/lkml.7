Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A4C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D382E2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5CaxFLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfD3RZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:25:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41062 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3RZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:25:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so7146682pgs.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1DzYDHHMbPUeqMoDW3yyKVFzl5dp1X1tpd8mfSFUCM=;
        b=g5CaxFLepwBRV+fZdbdUIzpj8w2kHwz9ygdaWgBIEjAcbZyjM9cWhm0nLyITorTmSY
         ExdaN2iDSLgn+2lfNQJ9mLJS1qVnJIMXcx1PNoVeZpMGp2w44MUfNilKAt1WyNMDnfAc
         s3uSvru5O80ScQqYEs6MPJ//qet6xLhNrMqi5ZZGnIpYHuJcgPRfyvghnCoEoV6rUj5F
         MnxiXDNKcJ77JCmSM2I++I5dU1g9uLwj26Nmo94pOSBCdwONccqfrK3Y7U8+AH7Vvedb
         Q/RaqTdzZvJA+27E6AvRJ2Fw82sQKPgYfuyS+RvaV5uHu8gWxPhL/JizsfraWfeHH5qH
         FmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1DzYDHHMbPUeqMoDW3yyKVFzl5dp1X1tpd8mfSFUCM=;
        b=B10d1kgZqP9f1d++t9VUOgHHWSpplWQ5rkdClFs67ZRLGUr2VnNlAOGCl+BQBooJhc
         49xc7cl9TV16iYLTZVNg0Jr1pbmlVLtf57BzFDapDt4KSNziJ83Yk772DF/mW6hNeV6/
         6hIsskts/5VjG9tqYAAfGKHo6rAjj7eXtndlSFoXYMjU29lxC7XRKd+F/y/f1xBSdPXK
         kFu7IqgpkYA3yobrxC8z+cu+CG21iJh2bZ2XCpnwmEEPGO9dcNb80FqsYA9m0AMelnmr
         wxZ9kIoX04ULbk+M7RRI8/xv/HEL1EpCcezA3vrra6jXD/SUdhbmtNgiH+zKwTPVwO89
         ybBA==
X-Gm-Message-State: APjAAAXZuuWPi+RRj51OQjZhp+nAutDCeldM69vhA9nqoy7gfz1iwiFd
        5ZB/Kg/vcTjj01HTLh1hCTcofAaWiDwU35K8w8vjTQ==
X-Google-Smtp-Source: APXvYqxKoFOLcBHV9onh2oXJOsDo42NNxClYegTos4ScfdggCUdMvMzUJpr+4tr+0OZA48aC5U9cQc80U3ISbHps4Kc=
X-Received: by 2002:a62:46c7:: with SMTP id o68mr12353818pfi.54.1556645157228;
 Tue, 30 Apr 2019 10:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004101370587c052fb@google.com>
In-Reply-To: <0000000000004101370587c052fb@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 30 Apr 2019 19:25:45 +0200
Message-ID: <CAAeHK+zn-26NHw8seueTyQV1o=O9x0U3m9-jV4V70Ctfutk8Fg@mail.gmail.com>
Subject: Re: WARNING: Support for this device (Terratec Grabster AV400) is experimental.
To:     syzbot <syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000a3be3f0587c2b106"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a3be3f0587c2b106
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 30, 2019 at 4:36 PM syzbot
<syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=141ca62d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> dashboard link: https://syzkaller.appspot.com/bug?extid=af8f8d2ac0d39b0ed3a0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1405bedd200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ce3bbb200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com
>
> usb 1-1: New USB device found, idVendor=0ccd, idProduct=0039, bcdDevice=
> d.3c
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> pvrusb2: Hardware description: Terratec Grabster AV400
> pvrusb2: **********
> pvrusb2: WARNING: Support for this device (Terratec Grabster AV400) is
> experimental.
> pvrusb2: Important functionality might not be entirely working.
> pvrusb2: Please consider contacting the driver author to help with further
> stabilization of the driver.
> pvrusb2: **********

#syz test: https://github.com/google/kasan.git usb-fuzzer

>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

--000000000000a3be3f0587c2b106
Content-Type: text/x-patch; charset="US-ASCII"; name="pvrusb2.patch"
Content-Disposition: attachment; filename="pvrusb2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jv42brmq0>
X-Attachment-Id: f_jv42brmq0

Y29tbWl0IGYxNWNmYTgwOWVjMDM1ZWViYzBiZWMwN2JjOWUxZGQyMTIzMjgxYTUKQXV0aG9yOiBB
bmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2dsZS5jb20+CkRhdGU6ICAgV2VkIEFwciAx
NyAxOTo0MDo0MCAyMDE5ICswMjAwCgogICAgbWVkaWE6IHB2cnVzYjI6IHVzZSBhIGRpZmZlcmVu
dCBmb3JtYXQgZm9yIHdhcm5pbmdzCiAgICAKICAgIFdoZW4gdGhlIHB2cnVzYjIgZHJpdmVyIGRl
dGVjdHMgdGhhdCB0aGVyZSdzIHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoZQogICAgZGV2aWNlLCBp
dCBwcmludHMgYSB3YXJuaW5nIG1lc3NhZ2UuIFJpZ2h0IG5vdyB0aG9zZSBtZXNzYWdlIGFyZSBw
cmludGVkCiAgICBpbiB0d28gZGlmZmVyZW50IGZvcm1hdHM6CiAgICAKICAgIDEuICoqKldBUk5J
TkcqKiogbWVzc2FnZSBoZXJlCiAgICAyLiBXQVJOSU5HOiBtZXNzYWdlIGhlcmUKICAgIAogICAg
VGhlcmUncyBhbiBpc3N1ZSB3aXRoIHRoZSBzZWNvbmQgZm9ybWF0LiBTeXprYWxsZXIgcmVjb2du
aXplcyBpdCBhcyBhCiAgICBtZXNzYWdlIHByb2R1Y2VkIGJ5IGEgV0FSTl9PTigpLCB3aGljaCBp
cyB1c2VkIHRvIGluZGljYXRlIGEgYnVnIGluIHRoZQogICAga2VybmVsLiBIb3dldmVyIHB2cnVz
YjIgcHJpbnRzIHRob3NlIHdhcm5pbmdzIHRvIGluZGljYXRlIGFuIGlzc3VlIHdpdGgKICAgIHRo
ZSBkZXZpY2UsIG5vdCB0aGUgYnVnIGluIHRoZSBrZXJuZWwuCiAgICAKICAgIFRoaXMgcGF0Y2gg
Y2hhbmdlcyB0aGUgcHZydXNiMiBkcml2ZXIgdG8gY29uc2lzdGVudGx5IHVzZSB0aGUgZmlyc3QK
ICAgIHdhcm5pbmcgbWVzc2FnZSBmb3JtYXQuIFRoaXMgd2lsbCB1bmJsb2NrIHN5emthbGxlciB0
ZXN0aW5nIG9mIHRoaXMKICAgIGRyaXZlci4KICAgIAogICAgU2lnbmVkLW9mZi1ieTogQW5kcmV5
IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1oZHcuYyBiL2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVz
YjIvcHZydXNiMi1oZHcuYwppbmRleCA0NDZhOTk5ZGQyY2UuLmEwZjdiMTAwNDVkMiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9tZWRpYS91c2IvcHZydXNiMi9wdnJ1c2IyLWhkdy5jCisrKyBiL2RyaXZl
cnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1oZHcuYwpAQCAtMTY3OCw3ICsxNjc4LDcgQEAg
c3RhdGljIGludCBwdnIyX2RlY29kZXJfZW5hYmxlKHN0cnVjdCBwdnIyX2hkdyAqaGR3LGludCBl
bmFibGVmbCkKIAl9CiAJaWYgKCFoZHctPmZsYWdfZGVjb2Rlcl9taXNzZWQpIHsKIAkJcHZyMl90
cmFjZShQVlIyX1RSQUNFX0VSUk9SX0xFR1MsCi0JCQkgICAiV0FSTklORzogTm8gZGVjb2RlciBw
cmVzZW50Iik7CisJCQkgICAiKioqV0FSTklORyoqKiBObyBkZWNvZGVyIHByZXNlbnQiKTsKIAkJ
aGR3LT5mbGFnX2RlY29kZXJfbWlzc2VkID0gITA7CiAJCXRyYWNlX3N0Yml0KCJmbGFnX2RlY29k
ZXJfbWlzc2VkIiwKIAkJCSAgICBoZHctPmZsYWdfZGVjb2Rlcl9taXNzZWQpOwpAQCAtMjM2NCw3
ICsyMzY0LDcgQEAgc3RydWN0IHB2cjJfaGR3ICpwdnIyX2hkd19jcmVhdGUoc3RydWN0IHVzYl9p
bnRlcmZhY2UgKmludGYsCiAJaWYgKGhkd19kZXNjLT5mbGFnX2lzX2V4cGVyaW1lbnRhbCkgewog
CQlwdnIyX3RyYWNlKFBWUjJfVFJBQ0VfSU5GTywgIioqKioqKioqKioiKTsKIAkJcHZyMl90cmFj
ZShQVlIyX1RSQUNFX0lORk8sCi0JCQkgICAiV0FSTklORzogU3VwcG9ydCBmb3IgdGhpcyBkZXZp
Y2UgKCVzKSBpcyBleHBlcmltZW50YWwuIiwKKwkJCSAgICIqKipXQVJOSU5HKioqIFN1cHBvcnQg
Zm9yIHRoaXMgZGV2aWNlICglcykgaXMgZXhwZXJpbWVudGFsLiIsCiAJCQkJCQkJICAgICAgaGR3
X2Rlc2MtPmRlc2NyaXB0aW9uKTsKIAkJcHZyMl90cmFjZShQVlIyX1RSQUNFX0lORk8sCiAJCQkg
ICAiSW1wb3J0YW50IGZ1bmN0aW9uYWxpdHkgbWlnaHQgbm90IGJlIGVudGlyZWx5IHdvcmtpbmcu
Iik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3VzYi9wdnJ1c2IyL3B2cnVzYjItaTJjLWNv
cmUuYyBiL2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1pMmMtY29yZS5jCmluZGV4
IDhmMDIzMDg1YzJkOS4uNDNlNTRiZGJkNGFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL21lZGlhL3Vz
Yi9wdnJ1c2IyL3B2cnVzYjItaTJjLWNvcmUuYworKysgYi9kcml2ZXJzL21lZGlhL3VzYi9wdnJ1
c2IyL3B2cnVzYjItaTJjLWNvcmUuYwpAQCAtMzQzLDExICszNDMsMTEgQEAgc3RhdGljIGludCBp
MmNfaGFja19jeDI1ODQwKHN0cnVjdCBwdnIyX2hkdyAqaGR3LAogCiAJaWYgKChyZXQgIT0gMCkg
fHwgKCpyZGF0YSA9PSAweDA0KSB8fCAoKnJkYXRhID09IDB4MGEpKSB7CiAJCXB2cjJfdHJhY2Uo
UFZSMl9UUkFDRV9FUlJPUl9MRUdTLAotCQkJICAgIldBUk5JTkc6IERldGVjdGVkIGEgd2VkZ2Vk
IGN4MjU4NDAgY2hpcDsgdGhlIGRldmljZSB3aWxsIG5vdCB3b3JrLiIpOworCQkJICAgIioqKldB
Uk5JTkcqKiogRGV0ZWN0ZWQgYSB3ZWRnZWQgY3gyNTg0MCBjaGlwOyB0aGUgZGV2aWNlIHdpbGwg
bm90IHdvcmsuIik7CiAJCXB2cjJfdHJhY2UoUFZSMl9UUkFDRV9FUlJPUl9MRUdTLAotCQkJICAg
IldBUk5JTkc6IFRyeSBwb3dlciBjeWNsaW5nIHRoZSBwdnJ1c2IyIGRldmljZS4iKTsKKwkJCSAg
ICIqKipXQVJOSU5HKioqIFRyeSBwb3dlciBjeWNsaW5nIHRoZSBwdnJ1c2IyIGRldmljZS4iKTsK
IAkJcHZyMl90cmFjZShQVlIyX1RSQUNFX0VSUk9SX0xFR1MsCi0JCQkgICAiV0FSTklORzogRGlz
YWJsaW5nIGZ1cnRoZXIgYWNjZXNzIHRvIHRoZSBkZXZpY2UgdG8gcHJldmVudCBvdGhlciBmb3Vs
LXVwcy4iKTsKKwkJCSAgICIqKipXQVJOSU5HKioqIERpc2FibGluZyBmdXJ0aGVyIGFjY2VzcyB0
byB0aGUgZGV2aWNlIHRvIHByZXZlbnQgb3RoZXIgZm91bC11cHMuIik7CiAJCS8vIFRoaXMgYmxv
Y2tzIGFsbCBmdXJ0aGVyIGNvbW11bmljYXRpb24gd2l0aCB0aGUgcGFydC4KIAkJaGR3LT5pMmNf
ZnVuY1sweDQ0XSA9IE5VTEw7CiAJCXB2cjJfaGR3X3JlbmRlcl91c2VsZXNzKGhkdyk7CmRpZmYg
LS1naXQgYS9kcml2ZXJzL21lZGlhL3VzYi9wdnJ1c2IyL3B2cnVzYjItc3RkLmMgYi9kcml2ZXJz
L21lZGlhL3VzYi9wdnJ1c2IyL3B2cnVzYjItc3RkLmMKaW5kZXggNmI2NTFmOGI1NGRmLi4zN2Rj
Mjk5YTFjYTIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWVkaWEvdXNiL3B2cnVzYjIvcHZydXNiMi1z
dGQuYworKysgYi9kcml2ZXJzL21lZGlhL3VzYi9wdnJ1c2IyL3B2cnVzYjItc3RkLmMKQEAgLTM1
Myw3ICszNTMsNyBAQCBzdHJ1Y3QgdjRsMl9zdGFuZGFyZCAqcHZyMl9zdGRfY3JlYXRlX2VudW0o
dW5zaWduZWQgaW50ICpjb3VudHB0ciwKIAkJYmNudCA9IHB2cjJfc3RkX2lkX3RvX3N0cihidWYs
c2l6ZW9mKGJ1ZiksZm1zayk7CiAJCXB2cjJfdHJhY2UoCiAJCQlQVlIyX1RSQUNFX0VSUk9SX0xF
R1MsCi0JCQkiV0FSTklORzogRmFpbGVkIHRvIGNsYXNzaWZ5IHRoZSBmb2xsb3dpbmcgc3RhbmRh
cmQocyk6ICUuKnMiLAorCQkJIioqKldBUk5JTkcqKiogRmFpbGVkIHRvIGNsYXNzaWZ5IHRoZSBm
b2xsb3dpbmcgc3RhbmRhcmQocyk6ICUuKnMiLAogCQkJYmNudCxidWYpOwogCX0KIAo=
--000000000000a3be3f0587c2b106--
