Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66592C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A2520838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGg9JsD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfGKINI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:13:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38365 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfGKINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:13:07 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so10656625ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=30pilBQN5K/2ltdYDfw8gEKWSGfu9hSs2Mdh/j4fb7E=;
        b=SGg9JsD2ZHUvmaIuaZMWifZZ/T5piLkeojgYKoeWYhkiOFdJnRfZLevtFPYpVJYW0x
         +AoHMksHO94btFeT9l9WZwVlqdkiq6A5OW6BAaZAN9sTHk46Zck+eMHEQLz3VY4bX31g
         XawXD5XRTe2z2k2/ebodudqjTSjULPy55AKV+fczidHWQZczWtE4I5wSZn3/vAXPMW3Y
         o+yuuUAcdC2uffEbuHN6McR/nwa9Ryb4mHE8DFSIo9Tkvu0CquHFjbmsLLUi+VQrOwkh
         e5TainhD2beU3j5P/If776x9cr4XQgkt4900RuQqmhFzGE+HP2vH0e19sZQXObCim2hY
         v4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=30pilBQN5K/2ltdYDfw8gEKWSGfu9hSs2Mdh/j4fb7E=;
        b=EjO+2eXXKj+ri4OfVcuF85138XQwPjeT949aNNG8iQFYUK6gt5ciV5y8hJwq9pcwFC
         fBIIWv3EMePa9LDJFhjd603rEIovzF8EnlSROlXbVoi6qmOnTMelPaDksRc/yshAtbP3
         BjkOfMSSdLhdcKKDVMIzh+B3aw1e5bQzTLJYeqGk23PJ0DPzv/oU9li5g/uUN0cVjVUH
         fmkZsU1lySGPRmAns/JPhHYi6J71+Tgp2QUd06bchAj1Q546LYftNBmzKBLnBnIcBJRw
         qEG/8CDIkGYSDNoVYwAhm60dU89rfocSgk3aRo58XotksJyTc1qbbbrhzuFS4m/+9S5s
         LEiA==
X-Gm-Message-State: APjAAAUPOS9GfEha1A+g6gJB1twkFEa1tT2e3f5zp/+izgXko29BClNI
        9slA6g1zGwk/bnHlyV57DIvZjXV1fromPoRBYl9pwPsTG/8=
X-Google-Smtp-Source: APXvYqwDewLl9DbvCamfY8YJry20mEo/IJBKdtJOFavUXcx9Q3H2L5TrJrKktN4dZI9+ZWcjMABAEugR1a1mfssloqk=
X-Received: by 2002:a02:662f:: with SMTP id k47mr3159761jac.4.1562832786713;
 Thu, 11 Jul 2019 01:13:06 -0700 (PDT)
MIME-Version: 1.0
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 11 Jul 2019 10:12:55 +0200
Message-ID: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
Subject: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: multipart/mixed; boundary="000000000000188ebb058d635dff"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000188ebb058d635dff
Content-Type: text/plain; charset="UTF-8"

Recent patch [1] disabled a self-snoop feature on a list of processor
models with a known errata, so we are confident that the feature
should work on remaining models also for other purposes than to speed
up MTRR programming.

I would like to resurrect an old patch [2] that avoids calling clflush
and wbinvd
to invalidate caches when CPU supports selfsnoop.

The patch was ported to latest Fedora kernel (5.1.16) and tested with
CONFIG_CPA_DEBUG on INTEL_FAM6_IVYBRIDGE_X. The relevant ports of
dmesg show:

...
< hundreds of CPA protect messages, resulting from set_memory_rw CPA
undo test in mm/init_64.c >
CPA  protect  Rodata RO: 0xffffffffbd1fe000 - 0xffffffffbd1fefff PFN
1461fe req 8000000000000063 prevent 0000000000000002
CPA  protect  Rodata RO: 0xffff889c461fe000 - 0xffff889c461fefff PFN
1461fe req 8000000000000063 prevent 0000000000000002
Testing CPA: again
Freeing unused kernel image memory: 2016K
Freeing unused kernel image memory: 4K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
rodata_test: all tests were successful
x86/mm: Checking user space page tables
x86/mm: Checked W+X mappings: passed, no W+X pages found.

and from CPA selftest:

CPA self-test:
 4k 36352 large 4021 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
 4k 180224 large 3740 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
 4k 180224 large 3740 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
ok.

[1] https://lkml.org/lkml/2019/6/27/828
[2] https://lkml.org/lkml/2009/4/8/508

Uros.

--000000000000188ebb058d635dff
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Disable-CPA-cache-flush-for-selfsnoop-targets.patch"
Content-Disposition: attachment; 
	filename="0001-Disable-CPA-cache-flush-for-selfsnoop-targets.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jxye9wlt0>
X-Attachment-Id: f_jxye9wlt0

RnJvbSAxN2NiYWQ1ZDQ1YjZhZTI2ZGJjZmUwMmRlYmE1OTdjODNjZDYzYTBkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBVcm9zIEJpemphayA8dWJpempha0BnbWFpbC5jb20+CkRhdGU6
IFdlZCwgMTAgSnVsIDIwMTkgMTU6MDE6NDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBEaXNhYmxl
IENQQSBjYWNoZSBmbHVzaCBmb3Igc2VsZnNub29wIHRhcmdldHMKClNpZ25lZC1vZmYtYnk6IFVy
b3MgQml6amFrIDx1Yml6amFrQGdtYWlsLmNvbT4KLS0tCiBhcmNoL3g4Ni9tbS9wYWdlYXR0ci5j
IHwgNyArKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BhZ2VhdHRyLmMgYi9hcmNoL3g4Ni9tbS9w
YWdlYXR0ci5jCmluZGV4IDZhOWE3N2E0MDNjOS4uODg5M2VmNWY3MGNkIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9tbS9wYWdlYXR0ci5jCisrKyBiL2FyY2gveDg2L21tL3BhZ2VhdHRyLmMKQEAgLTE3
MjUsMTAgKzE3MjUsMTEgQEAgc3RhdGljIGludCBjaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIodW5z
aWduZWQgbG9uZyAqYWRkciwgaW50IG51bXBhZ2VzLAogCQlnb3RvIG91dDsKIAogCS8qCi0JICog
Tm8gbmVlZCB0byBmbHVzaCwgd2hlbiB3ZSBkaWQgbm90IHNldCBhbnkgb2YgdGhlIGNhY2hpbmcK
LQkgKiBhdHRyaWJ1dGVzOgorCSAqIE5vIG5lZWQgdG8gZmx1c2ggd2hlbiBDUFUgc3VwcG9ydHMg
c2VsZiBzbm9vcCBvcgorCSAqIHdoZW4gd2UgZGlkIG5vdCBzZXQgYW55IG9mIHRoZSBjYWNoaW5n
IGF0dHJpYnV0ZXM6CiAJICovCi0JY2FjaGUgPSAhIXBncHJvdDJjYWNoZW1vZGUobWFza19zZXQp
OworCWNhY2hlID0gIXN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX1NFTEZTTk9PUCkgJiYKKwkJ
cGdwcm90MmNhY2hlbW9kZShtYXNrX3NldCk7CiAKIAkvKgogCSAqIE9uIGVycm9yOyBmbHVzaCBl
dmVyeXRoaW5nIHRvIGJlIHN1cmUuCi0tIAoyLjIxLjAKCg==
--000000000000188ebb058d635dff--
