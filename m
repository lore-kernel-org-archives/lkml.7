Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BCA21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXGKcSn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfD3R02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:26:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34086 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfD3R00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:26:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck18so2754919plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bs5X7Iibdz9o1xQ5xU77R8AeJdh4gzQBAsKMHV6sbaQ=;
        b=CXGKcSn62AeReTYymbEMWJpRCQAUGIUYJ6jujKBRaezB0HYqfK3exW46W/GnKqd2ce
         0K7QtyG9wK1id2v5YLT2RkM7JTZI84gX9OS51Xrmix8cLT7uTwAWbPPQybZoZ3gogmbT
         eEB0fvQW2aUWn0A8WPMSIKFvSNUbaOLybhULoyHX/TzFF1U6v9CyTRZYkYpAM/s6RbXR
         UzYmuJn5qWRoMvlHBXkjodmNRVujYY/qytrnLtv26zcjcZTvgzMhI0p/k3UllCA2W2dH
         NS5EnyN4S2JDW+t7Cqx6woC7sZ7P158vPRJGbUW1hSL+5TlL/YagKh3C5tCKvthMHVs+
         4D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bs5X7Iibdz9o1xQ5xU77R8AeJdh4gzQBAsKMHV6sbaQ=;
        b=iPS3qQwOhq2axhIQl9+EUaYKQ4Wk4w0JKml+slBEWl2Z6jg1RDMxrVLjWhJ5fgQB+K
         91bS8eu5SwWQeJYSRFJ+QzTA3mzOP6B/mZHE5tww8ttU5+juN6xoSeeypdj/3zY006mC
         YYoV1Sf1GSWv723iwARnug+Bx9qHGZ8YQZdH3vR6OzJlsgfukOT6ivoPhYyLJcQLetuR
         x5BBjMPii4QCq811FlkE1pnHz5Bv4MU1eUbEe/nd13RZkSXt+NknkCuOicBs1yp3Vxas
         PsGFkKzxB/aG6AzL+l6FofgwIUNmNDO4Kj3Fxc8FOT75v/c0L/OVyBDB5wjCcmaUKLCw
         NcOA==
X-Gm-Message-State: APjAAAWs3EPBWxzkIMvEQhcO63DQr08npH1Uuf/vFYVlu1Coo4RoBVCb
        wCww4j3w7+S/FRx4i/wFt0AqOi84pw27zxcHncdZ/PmQ0vEtXQ==
X-Google-Smtp-Source: APXvYqyqEuRumZ25aIJGjeNWrMpTdO7Blva4fZ9CGJMBFDR7/KiCGcO+8AVxa6p9ixobAx6ee+PwMufIphWSSzOPawg=
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr25981080plb.236.1556645185329;
 Tue, 30 Apr 2019 10:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000048aa750587c052ef@google.com>
In-Reply-To: <00000000000048aa750587c052ef@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 30 Apr 2019 19:26:13 +0200
Message-ID: <CAAeHK+xAqa9Mz6y0ug8KxYuMYN7D2xP9xYbccKwJyjk_B4ew3g@mail.gmail.com>
Subject: Re: WARNING: Detected a wedged cx25840 chip; the device will not work.
To:     syzbot <syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="00000000000050981a0587c2b34c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000050981a0587c2b34c
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 30, 2019 at 4:36 PM syzbot
<syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=12df67c3200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> dashboard link: https://syzkaller.appspot.com/bug?extid=170a86bf206dd2c6217e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108a28f3200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145d8a2d200000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com
>
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> pvrusb2: Hardware description: Gotview USB 2.0 DVD 2
> pvrusb2: Invalid write control endpoint
> usb 1-1: USB disconnect, device number 2
> pvrusb2: Invalid write control endpoint
> pvrusb2: WARNING: Detected a wedged cx25840 chip; the device will not work.
> pvrusb2: WARNING: Try power cycling the pvrusb2 device.
> pvrusb2: WARNING: Disabling further access to the device to prevent other
> foul-ups.
> pvrusb2: Device being rendered inoperable
> cx25840 0-0044: Unable to detect h/w, assuming cx23887
> cx25840 0-0044: cx23887 A/V decoder found @ 0x88 (pvrusb2_a)
> pvrusb2: Attached sub-driver cx25840
> pvrusb2: Attempted to execute control transfer when device not ok
> pvrusb2: Attempted to execute control transfer when device not ok

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

--00000000000050981a0587c2b34c
Content-Type: text/x-patch; charset="US-ASCII"; name="pvrusb2.patch"
Content-Disposition: attachment; filename="pvrusb2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jv42ce1v0>
X-Attachment-Id: f_jv42ce1v0

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
--00000000000050981a0587c2b34c--
