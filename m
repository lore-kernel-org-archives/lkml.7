Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C9CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D274B206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555433408;
	bh=HUztEe8/NHpCh/8k9DC+KNAz8cZsBB3fMKuuugFYNHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ADBZDQ+sYKFKSzx+UIf2hov6tlcfm692PBZnfhDVBRmLnXIf93nHkgpbhf7aEjGHY
	 eZ+aHeVoQj9sD3HsriXzJi1RXu2z31vERdyyIFuvdJLGZ8xjMhYBfmQesmM7w2efUb
	 mibrTIsxH02SiTG8DekBGb2gEU+JYae+8aWrIGjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfDPQuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:50:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38027 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbfDPQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:50:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so7248857lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCNFQh0jTa6sj9k5WIdIdVFNK8z05B2xT/7RvFXhZP8=;
        b=ZEmLI8WMiuJuHU8T3/vTMBZWhWtQVtDoUZX+2U07tSATOdKLcOnw17fuBT3SMvtM6W
         2ICWxu5NxKagoiGd9ISMLrfsqYoHHn9sYbBxP3eQNHKBZ8NsNDKJeCb4HeWzxGgtJayW
         DpkP/A/FSVg8T3ieIk9gP0YymaHl1Ta7ZPwng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCNFQh0jTa6sj9k5WIdIdVFNK8z05B2xT/7RvFXhZP8=;
        b=AMuIRghrX2lNMKjIsLl09WSzQTM1TrDD5YmzdWo7BV9Mes6bQdsMXEc5L9uXGRefW3
         TKtRt82d3Y3WtTEr1AtF7tsjVxVbNiZ5IodH4pregz6l3HuVzDdW30Z3pXGbSaN/Mved
         u8N1YkVWHFgM0m/7NQNdjoFdFKD8PVcqe1OF92Bi0Xb/xJJWO54MytD0skGfmjtwxhaf
         2WjQIFtaTH48czzt55pePYFofkw33Kw2/XWUA2hDLAxLLeNTR6ikpVjqOTTgihpEr/As
         Vmb1d9E/NQEqVJ1I16vG8VtLRyaDY8+J7eHWR2ABRPgheN+995/VSV43xetuMIxoiy20
         r5GQ==
X-Gm-Message-State: APjAAAVTZJrPLgWFva4et12ADEMYkIpmCTYAh8WrqtQaNy2z2wIWuBNl
        i5rN2mtB9XVTt6u5zgnE3T/f21vc3rg=
X-Google-Smtp-Source: APXvYqxhu2n9ry9mEylV0Uz3HbjLMjgaLOxzJkjC0y5obUXcZr7WdmCRwpaElK9mhl9nXlONYVahBg==
X-Received: by 2002:a19:7911:: with SMTP id u17mr12118773lfc.90.1555433404121;
        Tue, 16 Apr 2019 09:50:04 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 18sm11447520lje.81.2019.04.16.09.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:50:03 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y6so19719603ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:50:02 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr18248032ljg.57.1555433402573;
 Tue, 16 Apr 2019 09:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1> <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
In-Reply-To: <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Apr 2019 09:49:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
Message-ID: <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000006f45e80586a88f88"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006f45e80586a88f88
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 16, 2019 at 9:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We actually already *have* this function.
>
> It's called "gup_fast_permitted()" and it's used by x86-64 to verify
> the proper address range. Exactly like s390 needs..
>
> Could you please use that instead?

IOW, something like the attached.

Obviously untested. And maybe 'current' isn't declared in
<asm/pgtable.h>, in which case you'd need to modify it to instead make
the inline function be "s390_gup_fast_permitted()" that takes a
pointer to the mm, and do something like

  #define gup_fast_permitted(start, pages) \
         s390_gup_fast_permitted(current->mm, start, pages)

instead.

But I think you get the idea..

                Linus

--0000000000006f45e80586a88f88
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_juk0utdu0>
X-Attachment-Id: f_juk0utdu0

IGFyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggfCAxMiArKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9zMzkwL2luY2x1
ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKaW5kZXgg
NzZkYzM0NGVkYjhjLi5hMDgyNDg5OTVmNTAgMTAwNjQ0Ci0tLSBhL2FyY2gvczM5MC9pbmNsdWRl
L2FzbS9wZ3RhYmxlLmgKKysrIGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL3BndGFibGUuaApAQCAt
MTY1OSw0ICsxNjU5LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVja19wZ3RfY2FjaGUodm9p
ZCkgeyB9CiAKICNpbmNsdWRlIDxhc20tZ2VuZXJpYy9wZ3RhYmxlLmg+CiAKK3N0YXRpYyBpbmxp
bmUgYm9vbCBndXBfZmFzdF9wZXJtaXR0ZWQodW5zaWduZWQgbG9uZyBzdGFydCwgaW50IG5yX3Bh
Z2VzKQoreworCXVuc2lnbmVkIGxvbmcgbGVuLCBlbmQ7CisKKwlsZW4gPSAodW5zaWduZWQgbG9u
Zylucl9wYWdlcyA8PCBQQUdFX1NISUZUOworCWVuZCA9IHN0YXJ0ICsgbGVuOworCWlmIChlbmQg
PCBzdGFydCkKKwkJcmV0dXJuIGZhbHNlOworCXJldHVybiBlbmQgPD0gY3VycmVudC0+bW0tPmNv
bnRleHQuYXNjZV9saW1pdDsKK30KKyNkZWZpbmUgZ3VwX2Zhc3RfcGVybWl0dGVkIGd1cF9mYXN0
X3Blcm1pdHRlZAorCiAjZW5kaWYgLyogX1MzOTBfUEFHRV9IICovCg==
--0000000000006f45e80586a88f88--
