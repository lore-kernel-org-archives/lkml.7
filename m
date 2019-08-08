Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3202C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AF0214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291692;
	bh=KPQBSynjcqEhiWtkdwLiA7gtKgaZmE57BZNxqsU6Oyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KGvPsyJqYri84owGYMbyAamCKMy9iep8Nrd56dGc/IWc7Wd810U25CZmOSI+jjlI3
	 Fl9dqrm3R1agInPEIYxYTYfu9snlnplvFRsQJAJCDO/44ALEuT8sQdDcqpO8Emn6mU
	 AxBUwXIP9jgjpI8BWh3ZxWe7Wp3gJXXNeUcbn0tU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbfHHTOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:14:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33762 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404734AbfHHTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:07:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id z17so1457839ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRHlDhtUbcgIRAJD8WQ0b9Jyc4BU2Ni837QHoXwlDfw=;
        b=BW1E7M2bFIR9mDv7LibCNf8xRcZluqgnyTqZ1eQ909N/rvNlTBz0CNVmfPumcS3pf6
         /tOFOill8a6yLerkedIcLjF5QL1wuLVqqScJivAhgNwMnRVnZjP07CD6VxUJ8POx97WT
         +1wn+v9x8izH26Bme0qSoBpoQCrmEG0haMrN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRHlDhtUbcgIRAJD8WQ0b9Jyc4BU2Ni837QHoXwlDfw=;
        b=XgK1n5+IMlxtcoRBqVMKyrLVWnSSAz9Bt2m7+LZFEclbhc9QlDIdB/DDyMDjsA996o
         wbzHKQMvtL8uS0zwjnpW88saqf++GCXhrllQoAqU6a6IXtDAipo7lB8Ha1zJWGMnrMMI
         PEudCVqr39QxWPWMJtSjclKD7zMuB4enNnm2VrsE+If2uAkGwwE+9hs8DGYU40hw6Dbr
         6J2eYgi9wkPH4QlLGDhlxKRazcpAzbvLLJA/UPJU7xnmGkOWjqEHmidWqPKe6zfMm7p4
         aT57FR3VG5Tp5DmDx+99ILyaBO/6EXPaMLl7m+D5H9dmYOG0TJseiMRhFdyZ3h6CCP69
         6rJw==
X-Gm-Message-State: APjAAAXQka2yz4ohoHH9SRFj0Kg7FrA5TScLjo9aWlH9AcwaCQJkj+Mz
        /aLVjsinqdLaOwnUKcOu6JhCqeTas14=
X-Google-Smtp-Source: APXvYqz0a88+YVW3aH6VU+lpAO+wHHKV7/fYnW0S3J2IOGbblA5+Ie8tP5fyXF4FL0mYA8lHpwIUDA==
X-Received: by 2002:a2e:9dca:: with SMTP id x10mr8956501ljj.17.1565291266597;
        Thu, 08 Aug 2019 12:07:46 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t25sm17057918lfg.7.2019.08.08.12.07.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 12:07:45 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id i21so10650666ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:07:45 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr9261055ljj.165.1565291264803;
 Thu, 08 Aug 2019 12:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de> <20190807222634.1723-10-john.ogness@linutronix.de>
In-Reply-To: <20190807222634.1723-10-john.ogness@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Aug 2019 12:07:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
Message-ID: <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: multipart/mixed; boundary="000000000000cf4977058f9fc5cf"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cf4977058f9fc5cf
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 7, 2019 at 3:27 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> 2. For the CONFIG_PPC_POWERNV powerpc platform, kernel log buffer
>    registration is no longer available because there is no longer
>    a single contigous block of memory to represent all of the
>    ringbuffer.

So this is tangential, but I've actually been wishing for a special
"raw dump" format that has absolutely *no* structure to it at all, and
is as a result not necessarily strictly reliable, but is a lot more
robust.

The background for that is that we have a class of bugs that are
really hard to debug "in the wild", because people don't have access
to serial consoles or any kind of special hardware at all (ie forget
things like nvram etc), and when the machine locks up you're happy to
just have a reset button (but more likely you have to turn power off
and on).

End result: a DRAM buffer can work, but is not "reliable".
Particularly if you turn power on and off, data retention of DRAM is
iffy. But it's possible, at least in theory.

So I have a patch that implements a "stupid ring buffer" for thisa
case, with absolutely zero data structures (because in the presense of
DRAM corruption, all you can get is "hopefully only slightly garbled
ASCII".

It actually does work. It's a complete hack, but I have used this on
real hardware to see dumps that happened after the machine could no
longer send them to any device.

I actually suspect that this kind of "stupid non-structured secondary
log" can often be much more useful than the existing nvram special
cases - yes the output can be garbled for multi-cpu cases because it
not only is lockless, it's lockess without even any data structures -
but it also works somewhat reliably when the machine is _really_
borked. Which is exactly when you want a log that isn't just the
normal "working machine syslog".

NOTE! This is *not* a replacement for a lockless printk. This is very
much an _additional_ "low overhead buffer in RAM" for post-mortem
analysis when anything fancier doesn't work.

So I'm throwing this patch out there in case people have interest in
looking at that very special case. Also note how right now the example
code just steals a random physical memory area at roughly physical
location 12GB - this is a hack and would need to be configurable
obviously in real life, but it worked for the machines I tested (which
both happened to have 16GB of RAM).

Those parts are marked with "// HACK HACK HACK" and just a hardcoded
physical address (0x320000000).

              Linus

--000000000000cf4977058f9fc5cf
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Trial-power-off-buffer-for-printk-data-retention.patch"
Content-Disposition: attachment; 
	filename="0001-Trial-power-off-buffer-for-printk-data-retention.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz31zr4j0>
X-Attachment-Id: f_jz31zr4j0

RnJvbSAwNzRlYTY3YWZjYWJhMzc5OTZhNjE1YzQxNjg1Y2Q3MmIwODhmNTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMzAgTWF5IDIwMTkgMTk6NTY6MTMgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBUcmlhbCAicG93ZXIgb2ZmIGJ1ZmZlciIgZm9yIHByaW50ayBkYXRhIHJldGVudGlv
bgoKVGhpcyBjaXJjdW12ZW50cyBBQ1BJIGFuZCBqdXN0IGZvcmNlcyBhIHJhbmRvbSBwaHlzaWNh
bCBhZGRyZXNzICh3aGljaApoYXBwZW5zIHRvIGJlIGF0IDB4MzIwMDAwMDAwKSB0byBjb250YWlu
IGEgNjRrQiBidWZmZXIgdGhhdCB3ZSB0YWtlCm92ZXIuCgpOb3QteWV0LXNpZ25lZC1vZmYtYnk6
IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBhcmNo
L3g4Ni9rZXJuZWwvc2V0dXAuYyAgICAgICAgIHwgICA3ICsrCiBpbmNsdWRlL2xpbnV4L3ByaW50
ay5oICAgICAgICAgIHwgICAzICsKIGluaXQvbWFpbi5jICAgICAgICAgICAgICAgICAgICAgfCAg
MTEgKysKIGtlcm5lbC9wcmludGsvTWFrZWZpbGUgICAgICAgICAgfCAgIDIgKy0KIGtlcm5lbC9w
cmludGsvcG93ZXJvZmZfYnVmZmVyLmMgfCAxNzkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIGtlcm5lbC9wcmludGsvcHJpbnRrLmMgICAgICAgICAgfCAgIDIgKwogNiBmaWxlcyBj
aGFuZ2VkLCAyMDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGtlcm5lbC9wcmludGsvcG93ZXJvZmZfYnVmZmVyLmMKCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvc2V0dXAuYyBiL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jCmluZGV4IDA4YTVmNGEx
MzFmNS4uMmExZDdkN2YzZjRmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYwor
KysgYi9hcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYwpAQCAtMTA0Miw2ICsxMDQyLDEzIEBAIHZvaWQg
X19pbml0IHNldHVwX2FyY2goY2hhciAqKmNtZGxpbmVfcCkKIAllYXJseV9nYXJ0X2lvbW11X2No
ZWNrKCk7CiAjZW5kaWYKIAorCS8vIEhBQ0sgSEFDSyBIQUNLCisJLy8gTWFnaWMgInRoaXMgUkFN
IHN1cnZpdmVzIGJvb3QiIGZha2UKKwllODIwX19yYW5nZV91cGRhdGUoMHgzMjAwMDAwMDAsIDY1
NTM2LCBFODIwX1RZUEVfUkFNLCBFODIwX1RZUEVfUkVTRVJWRUQpOworCWU4MjBfX3VwZGF0ZV90
YWJsZShlODIwX3RhYmxlKTsKKwlwcmludGsoS0VSTl9JTkZPICJmaXhlZCBwaHlzaWNhbCBSQU0g
bWFwOlxuIik7CisJZTgyMF9fcHJpbnRfdGFibGUoImZha2UgYm9vdC1zYWZlIGJ1ZmZlcnMiKTsK
KwogCS8qCiAJICogcGFydGlhbGx5IHVzZWQgcGFnZXMgYXJlIG5vdCB1c2FibGUgLSB0aHVzCiAJ
ICogd2UgYXJlIHJvdW5kaW5nIHVwd2FyZHM6CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3By
aW50ay5oIGIvaW5jbHVkZS9saW51eC9wcmludGsuaAppbmRleCBjZWZkMzc0YzQ3YjEuLjkwNWM0
N2VmYjk4YyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9wcmludGsuaAorKysgYi9pbmNsdWRl
L2xpbnV4L3ByaW50ay5oCkBAIC0xNzAsNiArMTcwLDkgQEAgaW50IHZwcmludGsoY29uc3QgY2hh
ciAqZm10LCB2YV9saXN0IGFyZ3MpOwogYXNtbGlua2FnZSBfX3ByaW50ZigxLCAyKSBfX2NvbGQK
IGludCBwcmludGsoY29uc3QgY2hhciAqZm10LCAuLi4pOwogCit2b2lkIHBvd2Vyb2ZmX2J1ZmZl
cl9sb2coY29uc3QgY2hhciAqYnVmLCBzaXplX3QgbGVuKTsKK3ZvaWQgcG93ZXJvZmZfYnVmZmVy
X3JlZ2lzdGVyKGNoYXIgKmJ1Ziwgc2l6ZV90IHNpemUpOworCiAvKgogICogU3BlY2lhbCBwcmlu
dGsgZmFjaWxpdHkgZm9yIHNjaGVkdWxlci90aW1la2VlcGluZyB1c2Ugb25seSwgX0RPX05PVF9V
U0VfICEKICAqLwpkaWZmIC0tZ2l0IGEvaW5pdC9tYWluLmMgYi9pbml0L21haW4uYwppbmRleCA2
NmExOTZjNWU0YzMuLjIzMjc3ODYwMzQ5MCAxMDA2NDQKLS0tIGEvaW5pdC9tYWluLmMKKysrIGIv
aW5pdC9tYWluLmMKQEAgLTExMDAsNiArMTEwMCwxNyBAQCBzdGF0aWMgaW50IF9fcmVmIGtlcm5l
bF9pbml0KHZvaWQgKnVudXNlZCkKIAlzeXN0ZW1fc3RhdGUgPSBTWVNURU1fUlVOTklORzsKIAlu
dW1hX2RlZmF1bHRfcG9saWN5KCk7CiAKKwkvLworCS8vIEhBQ0sgSEFDSyBIQUNLCisJLy8KKwl7
CisJCXZvaWQgKmJhc2UgPSBpb3JlbWFwX2NhY2hlKDB4MzIwMDAwMDAwLDY1NTM2KTsKKwkJaWYg
KGJhc2UpCisJCQlwb3dlcm9mZl9idWZmZXJfcmVnaXN0ZXIoYmFzZSwgNjU1MzYpOworCQllbHNl
CisJCQlwcmludGsoImlvcmVtYXAgZmFpbGVkXG4iKTsKKwl9CisKIAlyY3VfZW5kX2lua2VybmVs
X2Jvb3QoKTsKIAogCWlmIChyYW1kaXNrX2V4ZWN1dGVfY29tbWFuZCkgewpkaWZmIC0tZ2l0IGEv
a2VybmVsL3ByaW50ay9NYWtlZmlsZSBiL2tlcm5lbC9wcmludGsvTWFrZWZpbGUKaW5kZXggNGQw
NTJmYzZiY2RlLi43Y2ExMWQ5MmYyODAgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9wcmludGsvTWFrZWZp
bGUKKysrIGIva2VybmVsL3ByaW50ay9NYWtlZmlsZQpAQCAtMSw0ICsxLDQgQEAKICMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQogb2JqLXkJPSBwcmludGsubwotb2JqLSQo
Q09ORklHX1BSSU5USykJKz0gcHJpbnRrX3NhZmUubworb2JqLSQoQ09ORklHX1BSSU5USykJKz0g
cHJpbnRrX3NhZmUubyBwb3dlcm9mZl9idWZmZXIubwogb2JqLSQoQ09ORklHX0ExMVlfQlJBSUxM
RV9DT05TT0xFKQkrPSBicmFpbGxlLm8KZGlmZiAtLWdpdCBhL2tlcm5lbC9wcmludGsvcG93ZXJv
ZmZfYnVmZmVyLmMgYi9rZXJuZWwvcHJpbnRrL3Bvd2Vyb2ZmX2J1ZmZlci5jCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uNzkwMjNiNDk0NzBiCi0tLSAvZGV2L251bGwK
KysrIGIva2VybmVsL3ByaW50ay9wb3dlcm9mZl9idWZmZXIuYwpAQCAtMCwwICsxLDE3OSBAQAor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQorI2luY2x1ZGUgPGxpbnV4
L3ByaW50ay5oPgorI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPgorCisjaW5jbHVkZSA8YXNtL3Vu
YWxpZ25lZC5oPgorCisvKgorICogVGhlIGxvY2FsIGJ1ZmZlciBsb2cgaXMgaW5jcmVkaWJseSBz
aW1wbGlzdGljOiBpdCdzIGp1c3QKKyAqIGEgY2lyY3VsYXIgYnVmZmVyIHRoYXQgZ2V0cyBmaWxs
ZWQgd2l0aCB0ZXh0IChmcm9tIHByaW50aworICogb3IgZXhwbGljaXQgbG9jYWwgYnVmZmVyIGxv
Z2dpbmcpLCBhbmQgdGhhdCBpbnRlbnRpb25hbGx5CisgKiBkb2VzIG5vdCBwZXJmb3JtIGFueSBs
b2NraW5nIChhbHRob3VnaCBwcmludGsgd2lsbCBpdHNlbGYKKyAqIHNlcmlhbGl6ZSB0aGluZ3Mg
YSBiaXQgLSBvdGhlciB1c2VzIG1heSBub3QpLgorICoKKyAqIFRoZSBidWZmZXIgLSBpZiBpdCBl
eGlzdHMgLSBpcyBpbnRlbmRlZCB0byBzdXJ2aXZlIGEgcG93ZXIKKyAqIGV2ZW50IC0gYWx0aG91
Z2ggcG9zc2libHkgY29ycnVwdGVkIGJ5IGxhY2sgb2YgRFJBTSByZWZyZXNoLAorICogYW5kIGhh
cyBhYnNvbHV0ZWx5IG5vIHN0cnVjdHVyZS4gIEl0IGdldHMgbG9nZ2VkIGF0IGJvb3QsIHNvCisg
KiB0aGF0IHRoZSBsYXN0IG1lc3NhZ2VzIGZyb20gYSBwcmV2aW91cyBrZXJuZWwgdGhhdCBjcmFz
aGVkCisgKiBtYXkgYmUgcmVjb3ZlcmVkLgorICoKKyAqIE5PVEUhIFRoZSBleGlzdGVuY2Ugb2Yg
dGhlIGJ1ZmZlciBpcyBpbmRpY2F0ZWQgYnkgYSBub24temVybworICogbG9nIHBvc2l0aW9uLiBB
IHplcm8gJ3BvcycgbWVhbnMgIm5vIGJ1ZmZlciIsIHdoaWxlIGEgJ3BvcycKKyAqIHRoYXQgaXMg
YXQgdGhlIGJ1ZmZlciBzaXplIG1lYW5zICJuZXh0IHdyaXRlIGdvZXMgdG8gdGhlIHN0YXJ0Cisg
KiBvZiB0aGUgYnVmZmVyIi4KKyAqCisgKiBOT1RFMiEgVGhpcyBpcyBub3QgZXZlbiB0cnlpbmcg
dG8gYmUgdGhyZWFkLXNhZmUuIE11bHRpcGxlCisgKiBDUFUncyB3cml0aW5nIGF0IHRoZSBzYW1l
IHRpbWUgbWF5IG92ZXJ3cml0ZSBlYWNoIG90aGVyLgorICogSXQncyBub3QgdHJ5aW5nIHRvIGJl
IGxlc3MgY29uZnVzaW5nIHRoYW4gd2hhdCBtaWdodCBzaG93CisgKiB1cCBvbiB0aGUgc2NyZWVu
LCBpdCdzIHRyeWluZyB0byBiZSBzaW1wbGVyLgorICoKKyAqIEJ1dCB3aGlsZSB0aGUgb3V0cHV0
IG1heSBiZSBnYXJibGVkIGluIHRoZSBwcmVzZW5zZSBvZgorICogbXVsdGlwbGUgdGhyZWFkcyBs
b2dnaW5nIGNvbmN1cnJlbnRseSwgd2UncmUgc3RpbGwgdGhyZWFkLQorICogc2FmZSBlbm91Z2gg
dG8gbm90IHVzZSBhIGJ1ZmZlciBiZWZvcmUgaXQncyBpbml0aWFsaXplZCwKKyAqIGFuZCBub3Qg
d3JpdGUgdG8gYmV5b25kIHRoZSBidWZmZXIuIFNvIHRoZSBjb250ZW50cyBtYXkKKyAqIGJlIGdh
cmJsZWQsIGJ1dCBub3Qgb3RoZXIgbWVtb3J5LgorICovCitzdGF0aWMgc3RydWN0IHsKKwl2b2lk
ICpiYXNlOworCXVuc2lnbmVkIGxvbmcgc2l6ZTsKKwl1bnNpZ25lZCBsb25nIHBvczsKK30gYnVm
ZmVyOworCisvLyBPcHRpbWlzdGljIGVuZCBtYXJrZXIgc28gdGhhdCBwZW9wbGUgY2FuCisvLyB0
cnkgdG8gbWFrZSBzZW5zZSBvZiB0aGUgY2lyY3VsYXIgcGFydAorLy8gb2YgdGhlIGJ1ZmZlciwg
ZXZlbiBpZiB3ZSBjYW4ndCBwdXQgcmVhbAorLy8gcmVsaWFibGUgZGF0YSBpbiBpdC4KKy8vCisv
LyBOb3RlIHRoYXQgcG93ZXJfYnVmZmVyX3JlZ2lzdGVyKCkgaGFzIGV4cGxpY3RseQorLy8gbGVm
dCBzcGFjZSBmb3IgdGhpcywgYW5kICdzaXplJyBpcyBub3QgdGhlCisvLyBhY3R1YWwgZnVsbCBw
aHlzaWNhbCBzaXplIG9mIHRoZSBidWZmZXIuIFRoZQorLy8gZW5kIG1hcmtlciBkb2VzIG5vdCB3
cmFwLgorc3RhdGljIHZvaWQgc2V0X2VuZF9tYXJrZXIodm9pZCAqYmFzZSwgdW5zaWduZWQgbG9u
ZyBwb3MpCit7CisJcHV0X3VuYWxpZ25lZCgtMSwgKHVuc2lnbmVkIGludCAqKShiYXNlICsgcG9z
KSk7Cit9CisKKy8qCisgKiBJZiB3ZSBoYXZlIGEgbG9jYWwgQ1BVIGJ1ZmZlciB0aGF0IHN1cnZp
dmVzIGEgcG93ZXIgY3ljbGUgKHBvc3NpYmx5CisgKiBjb3JydXB0IGR1ZSB0byBsYWNrIG9mIHJl
ZnJlc2gpLCBlbWl0IGxvZyBtZXNzYWdlcyBpbnRvIGl0IHRoYXQgdGhlCisgKiBuZXh0IGJvb3Qg
bWF5IHJlcGxheS4KKyAqCisgKiBOb3RlIHRoYXQgdGhlIGJ1ZmZlciBiYXNlIG9yIHNpemUgd2ls
bCBub3QgY2hhbmdlIG9uY2UgdGhlIGJ1ZmZlcgorICogZXhpc3RzLCBzbyB0aGUgb25seSB0aGlu
ZyB0aGF0IG5lZWRzIHNvbWUgY2FyZSBpcyAncG9zJy4KKyAqLwordm9pZCBwb3dlcm9mZl9idWZm
ZXJfbG9nKGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGxlbikKK3sKKwl2b2lkICpiYXNlOworCXVu
c2lnbmVkIGxvbmcgcG9zLCBzaXplLCBsZWZ0OworCisJaWYgKCFsZW4pCisJCXJldHVybjsKKwlw
b3MgPSBSRUFEX09OQ0UoYnVmZmVyLnBvcyk7CisJaWYgKCFwb3MpCisJCXJldHVybjsKKwlzbXBf
cm1iKCk7CisJYmFzZSA9IGJ1ZmZlci5iYXNlOworCXNpemUgPSBidWZmZXIuc2l6ZTsKKworCS8q
IE11c3Qgbm90IGhhcHBlbiEgQnV0IGxldCdzIGNoZWNrIGFuZCBhYm9ydCAqLworCWlmIChwb3Mg
PiBzaXplKQorCQlyZXR1cm47CisJbGVmdCA9IHNpemUgLSBwb3M7CisJaWYgKGxlbiA+IGxlZnQp
IHsKKwkJbWVtY3B5KGJhc2UgKyBwb3MsIGJ1ZiwgbGVmdCk7CisJCWJ1ZiArPSBsZWZ0OworCQls
ZW4gLT0gbGVmdDsKKworCQkvLyBEaWQgd2UgaGF2ZSBtb3JlIGRhdGEgdGhhbiB0aGUgd2hvbGUg
YnVmZmVyPworCQkvLyBKdXN0IHRydW5jYXRlIGl0IGlmIHNvLgorCQlpZiAobGVuID4gcG9zKQor
CQkJbGVuID0gcG9zOworCQlwb3MgPSAwOworCX0KKwltZW1jcHkoYmFzZSArIHBvcywgYnVmLCBs
ZW4pOworCisJLy8gTk9URSEgImxlbitwb3MiIGlzIG5vdCB6ZXJvLCBhbmQgbm90IGxhcmdlciB0
aGFuICdzaXplJy4KKwkvLyBBbHNvIG5vdGUgdGhhdCBSRUFEX09OQ0UgLT4gV1JJVEVfT05DRSBp
c24ndCBhdG9taWMsIHNvCisJLy8gaW4gdGhlIHByZXNlbnNlIG9mIHJhY2VzLCBvbmUgdGhyZWFk
IHdpbGwgd2luIChidXQgaXQKKwkvLyBtaWdodCBub3QgYmUgdGhlIG9uZSB0aGF0IHdvbiB0aGUg
c2V0X2VuZF9tYXJrZXIgYW5kIHRoZQorCS8vIG1lbWNweSByYWNlcy4KKwlwb3MgKz0gbGVuOwor
CXNldF9lbmRfbWFya2VyKGJhc2UsIHBvcyk7CisJV1JJVEVfT05DRShidWZmZXIucG9zLCBwb3Mp
OworfQorCisjZGVmaW5lIE1BWERNUExJTkUgODAKKy8vIER1bXAgdGhlIHBvc3NpYmx5IGNvcnJ1
cHRlZCB0ZXh0IGluIHRoZSBhcmVhLgorc3RhdGljIHZvaWQgZHVtcF9hcmVhKHVuc2lnbmVkIGNo
YXIgKnAsIHNpemVfdCBzaXplKQoreworCXVuc2lnbmVkIGNoYXIgbGluZVtNQVhETVBMSU5FKzFd
OworCWludCBsZW4gPSAwLCBpOworCisJZm9yIChpID0gMDsgaSA8IHNpemU7IGkrKykgeworCQkv
LyBJZ25vcmUgaGlnaCBiaXQKKwkJdW5zaWduZWQgY2hhciBjID0gcFtpXSAmIDB4N2Y7CisJCS8v
IElnbm9yZSBOVUwgb3IgYWxsIGJpdHMgc2V0IGJ5dGVzCisJCWlmICghYyB8fCBjID09IDB4N2Yp
CisJCQljb250aW51ZTsKKwkJLy8gT3RoZXJ3aXNlIHRyeSB0byB0dXJuIGl0IHByaW50YWJsZQor
CQlpZiAoYyA8IDMyKSB7CisJCQlpZiAoYyA9PSAnXG4nKSB7CisJCQkJaWYgKCFsZW4pCisJCQkJ
CWNvbnRpbnVlOworCQkJCXByaW50aygiQkRNUDogJXNcbiIsIGxpbmUpOworCQkJCWxlbiA9IDA7
CisJCQkJY29udGludWU7CisJCQl9CisJCQlpZiAoYyAhPSAnXHQnKQorCQkJCWNvbnRpbnVlOwor
CQl9CisJCWxpbmVbbGVuKytdID0gYzsKKwkJbGluZVtsZW5dID0gMDsKKwkJaWYgKGxlbiA8IE1B
WERNUExJTkUpCisJCQljb250aW51ZTsKKwkJcHJpbnRrKCJCRE1QOiAlcytcbiIsIGxpbmUpOwor
CQlsZW4gPSAwOworCX0KKwlpZiAobGVuKQorCQlwcmludGsoIkJETVA6ICVzXG4iLCBsaW5lKTsK
K30KKworc3RhdGljIHZvaWQgYnVmZmVyX2R1bXAodW5zaWduZWQgY2hhciAqcCwgc2l6ZV90IHNp
emUpCit7CisJdW5zaWduZWQgaW50IG1hcmtlcjsKKworCS8vIFNlZSBpZiBhdCBsZWFzdCBvbmUg
b2YgdGhlIGVuZCBtYXJrZXIgYnl0ZXMgaGF2ZQorCS8vIHN1cnZpdmVkLgorCWZvciAobWFya2Vy
ID0gMDsgbWFya2VyIDwgc2l6ZTsgbWFya2VyKyspIHsKKwkJaWYgKHBbbWFya2VyXSA9PSAweGZm
KSB7CisJCQlkdW1wX2FyZWEocCttYXJrZXIsIHNpemUgLSBtYXJrZXIpOworCQkJc2l6ZSA9IG1h
cmtlcjsKKwkJCWJyZWFrOworCQl9CisJfQorCWR1bXBfYXJlYShwLCBzaXplKTsKK30KKwordm9p
ZCBwb3dlcm9mZl9idWZmZXJfcmVnaXN0ZXIoY2hhciAqYnVmLCBzaXplX3Qgc2l6ZSkKK3sKKwlp
ZiAoc2l6ZSA8IDEwMjQpCisJCXJldHVybjsKKworCWlmIChSRUFEX09OQ0UoYnVmZmVyLnBvcykp
CisJCXJldHVybjsKKworCXByaW50aygiUmVnaXN0ZXJpbmcgcG93ZXJvZmYgYnVmZmVyXG4iKTsK
KworCS8vIER1bXAgYW5kIF90aGVuXyBjbGVhciB0aGUgY29udGVudHMgZnJvbSB0aGUgcHJldmlv
dXMgYm9vdAorCWJ1ZmZlcl9kdW1wKGJ1Ziwgc2l6ZSk7CisJbWVtc2V0KGJ1ZiwgMCwgc2l6ZSk7
CisKKwkvLyBMZWF2ZSByb29tIGZvciBlbmQgbWFya2VyCisJc2l6ZSAtPSBzaXplb2YodW5zaWdu
ZWQgaW50KTsKKworCWJ1ZmZlci5iYXNlID0gYnVmOworCWJ1ZmZlci5zaXplID0gc2l6ZTsKKwlz
ZXRfZW5kX21hcmtlcihidWYsIDApOworCXNtcF93bWIoKTsKKwlXUklURV9PTkNFKGJ1ZmZlci5w
b3MsIHNpemUpOworfQpkaWZmIC0tZ2l0IGEva2VybmVsL3ByaW50ay9wcmludGsuYyBiL2tlcm5l
bC9wcmludGsvcHJpbnRrLmMKaW5kZXggMTg4OGY2YTNiNjk0Li42NWYxNzYzOGI5NDQgMTAwNjQ0
Ci0tLSBhL2tlcm5lbC9wcmludGsvcHJpbnRrLmMKKysrIGIva2VybmVsL3ByaW50ay9wcmludGsu
YwpAQCAtMTkwNiw2ICsxOTA2LDggQEAgaW50IHZwcmludGtfc3RvcmUoaW50IGZhY2lsaXR5LCBp
bnQgbGV2ZWwsCiAJICovCiAJdGV4dF9sZW4gPSB2c2NucHJpbnRmKHRleHQsIHNpemVvZih0ZXh0
YnVmKSwgZm10LCBhcmdzKTsKIAorCXBvd2Vyb2ZmX2J1ZmZlcl9sb2codGV4dCwgdGV4dF9sZW4p
OworCiAJLyogbWFyayBhbmQgc3RyaXAgYSB0cmFpbGluZyBuZXdsaW5lICovCiAJaWYgKHRleHRf
bGVuICYmIHRleHRbdGV4dF9sZW4tMV0gPT0gJ1xuJykgewogCQl0ZXh0X2xlbi0tOwotLSAKMi4y
Mi4wLjQ1Ny5nZjdhMzdiMmQ3NgoK
--000000000000cf4977058f9fc5cf--
