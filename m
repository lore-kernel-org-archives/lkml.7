Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33604C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008DF206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574738538;
	bh=2b6MHJphVT1B7dbK/oqUJgs+XBJBO4MpiWz2rXyY+94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kv7auJ6WJyJxFHXZ4HtOud1wfuCZyQeJnF+4dwHwBliWPg1MOEYgNMeiAhbVYKhvr
	 ZfKzWNQaqQ9XLa7UhWkoCmsQZZ1RaIm8eNAfySJhH7ZgRiNQhBJU5P/J/PF1Yvlpbb
	 yoVprb0Lwq/qo9H+Yw07NLUHShI4AdPBBjLrqS/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKZDWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:22:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32890 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfKZDWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:22:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id d6so12811105lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 19:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mWh4zHOpJuBz4S9adg+rZZ8a37OLbsX8O3eNwWxZ6U=;
        b=PIBz9DkIcX7+LqItZzpiHfN1ECzE8Em4WA4leISipGNVTIqLcfdkWyCjkh2gpU1Xfs
         lmAMPIPXNnkBrKLEkzMGfZ1hDISC3NTKbzma62gZ0cBp4qgpSnojMe7QE6aQdkbc04QO
         9+B5XDU6183f3S18qW/yJcRbKrD/YBvIxcHTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mWh4zHOpJuBz4S9adg+rZZ8a37OLbsX8O3eNwWxZ6U=;
        b=Zg9a4sjJCIpU0w9dcvOYfX/K11wZY92RFkBjJQuz6iQuaS/Q1RNetN4SD2bZUDbGTC
         Ef+GFj1QO9nYOWiE70YYEtZUv+kn+jMUTlHezxaPf0q0eEc8DQMVtJ+ipL2D7w/AIjQ4
         mgH7bMUB4hpowBSGUedQKSk+EtOEk0eTif2Bzf8RF25KxqJVvtEI4tEcjxDbyuVPMzc6
         nSxaYjuDTbAHuoqpkTx4JzUwiKXN/Qmx8cpDkNPKHcG4KfexlpYBX0Vax/4KF3zWznHB
         oLHYJmp0+qlia3pPHpGBvs2iYMc62q7Ye0o4mgYYLya4ZT8xB81oCR9Sb6aVEfbnGN46
         /Afg==
X-Gm-Message-State: APjAAAWO6nn5VS6+gI7xBjs3dHe/n7gYrMisjSL4jEn5/4RW9vdiVSdH
        uxv0j7eqNy6BowokanOhL2NvAU8496c=
X-Google-Smtp-Source: APXvYqweyU28xHRwvVW1cGfl/uDqo01Y0wRfRG9EfMHGFv+Hc6X/YhdRUHhrYf2cnXIH3PpZhdVT5g==
X-Received: by 2002:ac2:5616:: with SMTP id v22mr12936695lfd.84.1574738533889;
        Mon, 25 Nov 2019 19:22:13 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id i23sm4496753lfj.71.2019.11.25.19.22.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 19:22:12 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id a17so12760844lfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 19:22:12 -0800 (PST)
X-Received: by 2002:a19:4949:: with SMTP id l9mr22319881lfj.52.1574738532324;
 Mon, 25 Nov 2019 19:22:12 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n> <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
 <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com>
In-Reply-To: <CAHk-=whn2Dp44tjUpLo9ogs=p-v-Vn7c2Xdo4p+2V=d1hTaiuA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 19:21:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com>
Message-ID: <CAHk-=wj3YSFT+C3n=7CTsB-8U0NUpTpT3xEH866H4-1qbQGw7Q@mail.gmail.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Content-Type: multipart/mixed; boundary="000000000000d582d60598376238"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d582d60598376238
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 25, 2019 at 5:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It might still be a bit noisy even with the above, but I think it will
> at least be better.

Yeah, I think I see what's going on.

I for some reason entirely missed the tty case. Oops. That was just
stupid of me, I should have thought of it.

There are other things that trigger the new informational line in that
hacky patch, and they _might_ matter, but I suspect it's the tty and
sound cases that causes the worst problems.

I suspect Kirill Smelkov even might have mentioned the tty case at one
point, and I just spaced out.

There are other things too that trigger that debug check, like the
sound file descriptors, and they might well matter too.

Anyway, I think the thing to do (for now) is to just say "character
devices are FMODE_STREAM files if they have no llseek operations".
That should take care of both tty's and the sound devices.

You can certainly have a character device that can do llseek, but it
sounds like a reasonable base rule.

Of course, this may fix the f_pos locking issue, but replace it with a
"oops, the character device driver tried to look at *pos anyway", and
that will give you a nice OOPS instead.

So this patch might just replace the failure mode with another failure
mode instead. At which point I think I'd have to revert that "get rid
of FMODE_ATOMIC_POS" trial balloon, but let's see if this patch solves
your problem and is sufficient..

I'd suggest using it _together_ with that "pr_info()" debug patch I
sent, to see what else might be going on..

                Linus

--000000000000d582d60598376238
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k3famq520>
X-Attachment-Id: f_k3famq520

IGZzL2NoYXJfZGV2LmMgfCAxMiArKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2hhcl9kZXYuYyBiL2Zz
L2NoYXJfZGV2LmMKaW5kZXggMDBkZmUxNzg3MWFjLi5lNWZmZWJkZjgwZDUgMTAwNjQ0Ci0tLSBh
L2ZzL2NoYXJfZGV2LmMKKysrIGIvZnMvY2hhcl9kZXYuYwpAQCAtMzY3LDYgKzM2NywxNiBAQCB2
b2lkIGNkZXZfcHV0KHN0cnVjdCBjZGV2ICpwKQogCX0KIH0KIAorc3RhdGljIGludCBtaWdodF9i
ZV9zdHJlYW0oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCit7CisJY29u
c3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyAqZm9wcyA9IGZpbGUtPmZfb3A7CisKKwlpZiAoZm9w
cy0+bGxzZWVrICYmIGZvcHMtPmxsc2VlayAhPSBub19sbHNlZWspCisJCXJldHVybiAwOworCisJ
cmV0dXJuIHN0cmVhbV9vcGVuKGlub2RlLCBmaWxlKTsKK30KKwogLyoKICAqIENhbGxlZCBldmVy
eSB0aW1lIGEgY2hhcmFjdGVyIHNwZWNpYWwgZmlsZSBpcyBvcGVuZWQKICAqLwpAQCAtNDE2LDcg
KzQyNiw3IEBAIHN0YXRpYyBpbnQgY2hyZGV2X29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGZpbGUgKmZpbHApCiAJCQlnb3RvIG91dF9jZGV2X3B1dDsKIAl9CiAKLQlyZXR1cm4gMDsK
KwlyZXR1cm4gbWlnaHRfYmVfc3RyZWFtKGlub2RlLCBmaWxwKTsKIAogIG91dF9jZGV2X3B1dDoK
IAljZGV2X3B1dChwKTsK
--000000000000d582d60598376238--
