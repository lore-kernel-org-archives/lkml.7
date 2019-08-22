Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8BCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0953A21744
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566511707;
	bh=Koh7HkMYVGdGvQW3FvIT+LRKy/KBWgZl1b0gcAim7ec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=11KwJTuns9uTduZM9PyF+L4JlYI9+kyxqKMu1ao1ohJKxHOAA1kLhxhW7jnm0Pvn5
	 h08TnhvYqXYeKRCWtCfQ1rQAWKPSetWRG5GDTWL1HlTx/RndlVEbmt0jdFwViR8jxk
	 szpo+1pa3tH/1BziZyq71d7x4iwFk2WHCV3CRPr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393795AbfHVWIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:08:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37096 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbfHVWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:08:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id t14so7018588lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zCqG9kaqag09Gd9IQTZXhybfqQIEN7mPZUA86U3hnc=;
        b=cxnt7WW09BdfSn0tEHEnZ0rVaKU+m56Pgfz9NhHEZYHfvV1h7SvlSAiw7e6x+1JvDf
         XBb/Z4vt5+OseALDB+SzicgheCJz8pNn9LsmCrQMiH7WA+Jxi6F5L5nT2O0oZvZiiplY
         lQwW7k6hSEbLhHigSE3/ytbNE67w71f9e/ys4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zCqG9kaqag09Gd9IQTZXhybfqQIEN7mPZUA86U3hnc=;
        b=mr48LTfAP+oJPANNf+5i3hhcLoz9sdjXu2iaSOTk9rQbU8Dk+dfYi6/syF/UFl6nC9
         q7VuNes+EUz83mubM1xaK86FDFlwUXsnVkoLZnnC67XxNa5JQST8/d7aIhSztbEo1y+e
         9JtopEQ6fKSKwaXcWlzyZ8h6EN3/TRQISPVu6Clru3tRRSUreQP7T9NS3dPAJ0Vqybb0
         HmySKBCP7qYI0HFcZ8tuyBu5YxAkqcKaGicIziAnwkEruCnOROddpBTKoE3whKV/fY+7
         jD8du++UTHej5Fhy8gjjj2row7ptaHP/6K++3c0jO43B6wH7ZfdLmsM0wIIDqEFw1WP7
         +Cug==
X-Gm-Message-State: APjAAAX6YWyWIss81eZx2SLRz/e3rA+pjz4FwOa/SHuoDOHE9KjNJWTs
        58/oUTDRfeJwcJY0FmNXbKaeQtGDN9M=
X-Google-Smtp-Source: APXvYqySSloBjxBKlq7GaOew5/FY8/tPnH1boQAArdl2JcdyGVcoS3ecP3OFxez0zRckdscUR8Uq2A==
X-Received: by 2002:a2e:8591:: with SMTP id b17mr885770lji.200.1566511701610;
        Thu, 22 Aug 2019 15:08:21 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t69sm231678lje.44.2019.08.22.15.08.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 15:08:20 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id u15so7010052ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:08:20 -0700 (PDT)
X-Received: by 2002:a2e:88c7:: with SMTP id a7mr921435ljk.72.1566511699983;
 Thu, 22 Aug 2019 15:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Aug 2019 15:08:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
Message-ID: <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Content-Type: multipart/mixed; boundary="0000000000006a32f00590bbed31"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006a32f00590bbed31
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 20, 2019 at 3:07 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot found that a thread can stall for minutes inside read_mem()
> after that thread was killed by SIGKILL [1]. Reading 2GB at one read()
> is legal, but delaying termination of killed thread for minutes is bad.

Side note: we might even just allow regular signals to interrupt
/dev/mem reads. We already do that for /dev/zero, and the risk of
breaking something is likely fairly low since nothing should use that
thing anyway.

Also, if it takes minutes to delay killing things, that implies that
we're probably still faulting in pages for the read_mem(). Which
points to another possible thing we could do in general: just don't
bother to handle page faults when a fatal signal is pending.

That situation might happen for other random cases too, and is not
limited to /dev/mem. So maybe it's worth trying? Does that essentially
fix the /dev/mem read case too in practice?

COMPLETELY untested patch attached, it may or may not make a
difference (and it may or may not work at all ;)

                Linus

--0000000000006a32f00590bbed31
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jzn8lx910>
X-Attachment-Id: f_jzn8lx910

IGFyY2gveDg2L21tL2ZhdWx0LmMgfCAxNSArKysrKysrKysrKystLS0KIG1tL21lbW9yeS5jICAg
ICAgICAgfCAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2ZhdWx0LmMgYi9hcmNoL3g4Ni9t
bS9mYXVsdC5jCmluZGV4IDljZWFjZDExNTZkYi4uZDZjMDI5YTZjYjkwIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9tbS9mYXVsdC5jCisrKyBiL2FyY2gveDg2L21tL2ZhdWx0LmMKQEAgLTEwMzMsOCAr
MTAzMywxNSBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZAogbW1fZmF1bHRfZXJyb3Ioc3RydWN0IHB0
X3JlZ3MgKnJlZ3MsIHVuc2lnbmVkIGxvbmcgZXJyb3JfY29kZSwKIAkgICAgICAgdW5zaWduZWQg
bG9uZyBhZGRyZXNzLCB2bV9mYXVsdF90IGZhdWx0KQogewotCWlmIChmYXRhbF9zaWduYWxfcGVu
ZGluZyhjdXJyZW50KSAmJiAhKGVycm9yX2NvZGUgJiBYODZfUEZfVVNFUikpIHsKLQkJbm9fY29u
dGV4dChyZWdzLCBlcnJvcl9jb2RlLCBhZGRyZXNzLCAwLCAwKTsKKwkvKgorCSAqIElmIHdlIGFs
cmVhZHkgaGF2ZSBhIGZhdGFsIHNpZ25hbCwgZG9uJ3QgYm90aGVyIGFkZGluZworCSAqIGEgbmV3
IG9uZS4gSWYgaXQncyBhIGtlcm5lbCBhY2Nlc3MsIGp1c3QgbWFrZSBpdCBmYWlsLAorCSAqIGFu
ZCBpZiBpdCdzIGEgdXNlciBhY2Nlc3MganVzdCByZXR1cm4gdG8gbGV0IHRoZSBwcm9jZXNzCisJ
ICogZGllLgorCSAqLworCWlmIChmYXRhbF9zaWduYWxfcGVuZGluZyhjdXJyZW50KSkgeworCQlp
ZiAoIShlcnJvcl9jb2RlICYgWDg2X1BGX1VTRVIpKQorCQkJbm9fY29udGV4dChyZWdzLCBlcnJv
cl9jb2RlLCBhZGRyZXNzLCAwLCAwKTsKIAkJcmV0dXJuOwogCX0KIApAQCAtMTM4OSw3ICsxMzk2
LDggQEAgdm9pZCBkb191c2VyX2FkZHJfZmF1bHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsCiAJCQly
ZXR1cm47CiAJCX0KIHJldHJ5OgotCQlkb3duX3JlYWQoJm1tLT5tbWFwX3NlbSk7CisJCWlmIChk
b3duX3JlYWRfa2lsbGFibGUoJm1tLT5tbWFwX3NlbSkpCisJCQlnb3RvIGZhdGFsX3NpZ25hbDsK
IAl9IGVsc2UgewogCQkvKgogCQkgKiBUaGUgYWJvdmUgZG93bl9yZWFkX3RyeWxvY2soKSBtaWdo
dCBoYXZlIHN1Y2NlZWRlZCBpbgpAQCAtMTQ1NSw2ICsxNDYzLDcgQEAgdm9pZCBkb191c2VyX2Fk
ZHJfZmF1bHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsCiAJCQkJZ290byByZXRyeTsKIAkJfQogCitm
YXRhbF9zaWduYWw6CiAJCS8qIFVzZXIgbW9kZT8gSnVzdCByZXR1cm4gdG8gaGFuZGxlIHRoZSBm
YXRhbCBleGNlcHRpb24gKi8KIAkJaWYgKGZsYWdzICYgRkFVTFRfRkxBR19VU0VSKQogCQkJcmV0
dXJuOwpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1vcnkuYwppbmRleCBlMmJiNTFi
NjI0MmUuLjdhZDYyZjk2YjA4ZSAxMDA2NDQKLS0tIGEvbW0vbWVtb3J5LmMKKysrIGIvbW0vbWVt
b3J5LmMKQEAgLTM5ODgsNiArMzk4OCwxMSBAQCB2bV9mYXVsdF90IGhhbmRsZV9tbV9mYXVsdChz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBhZGRyZXNzLAogCQkJCQkg
ICAgZmxhZ3MgJiBGQVVMVF9GTEFHX1JFTU9URSkpCiAJCXJldHVybiBWTV9GQVVMVF9TSUdTRUdW
OwogCisJaWYgKGZsYWdzICYgRkFVTFRfRkxBR19LSUxMQUJMRSkgeworCQlpZiAoZmF0YWxfc2ln
bmFsX3BlbmRpbmcoY3VycmVudCkpCisJCQlyZXR1cm4gVk1fRkFVTFRfU0lHU0VHVjsKKwl9CisK
IAkvKgogCSAqIEVuYWJsZSB0aGUgbWVtY2cgT09NIGhhbmRsaW5nIGZvciBmYXVsdHMgdHJpZ2dl
cmVkIGluIHVzZXIKIAkgKiBzcGFjZS4gIEtlcm5lbCBmYXVsdHMgYXJlIGhhbmRsZWQgbW9yZSBn
cmFjZWZ1bGx5Lgo=
--0000000000006a32f00590bbed31--
