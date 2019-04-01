Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0780E20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iixba3cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDAThe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:37:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38212 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDAThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:37:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so13583717wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7i8nmQINuK3Gl4VH0vFn0aJHWVeWdKukHeAWWsHnKs=;
        b=Iixba3ccGYPKqYKtGoQhkyLvdtsJYDTo9jpqq6VCdyvUGqvLbB9afzYYwUvvWme7gF
         hu7f2B8/PokpNyYKHmRoY9jCB4UYjYJ34/B/CIebx1qbhPePAFLSH6ALjBS6NtZnJ3zO
         P1REobHDkO91dtqOu/8BHTgPV2B+iBiJcBF4XQqgx9fNElVlweed6rG/IoXtqH9e43EK
         Ss/M7Lc+0hjWLvzlEhAMQmBQRFG9xVvWoZZK0p1UvB5AptpJ0AZCvjMHjVECSJVol1eI
         ATWzztageWOaQ79+Lo8XvqGWnZdc3UzjNpzBzJAVlRZjaGDd1McNs20IkTiWfiTTmvZc
         OqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7i8nmQINuK3Gl4VH0vFn0aJHWVeWdKukHeAWWsHnKs=;
        b=pkDW8pTY3yX8ZjxAv9Tsr8TqDs1SdSyeWe3eOuPwNJuky+F2h3HxCWJLROiIN2q3I1
         xVjgtJ9Ud/xeY6ATCdiKq5V6nUgpGdfoeNIXnyOorRBTL9LQEIegj+N/5R76/i2ZG+jv
         FZchAgZu7bf8WVDaO5rKPKHXeE6Y7PVL4CfSSsRYEl9Z+8jZHtGnHQ1TGCkpxiE112VV
         bvXNWWsjyw0UwBsV1JFcuda202Q99BYR3OHCbqe/WcvmeVNp5m/P374kStU5etYMGrO0
         6PeJCNKb6qBRyUGHCV2rca1HQiQSJaLeOEwZ0TXWolfK0yWdbL9dS2IkreYOI+GL3og+
         om6w==
X-Gm-Message-State: APjAAAWOLBlNDDHeJ7IvdcH791LAgWdhJrFiblHoihLcyR+vLGMZSrkl
        EXeuRmD4Li05vmQ6n0UBZ+ABy/SXZ6K6+N7Sbc28
X-Google-Smtp-Source: APXvYqzPV8zNZen57fIvoP+2/wWM5hrTF5Kp89a1lG04OWwXByCeovMHzQPuHFWsWGMYN16KOaCFX9Ke41wldLhEKoc=
X-Received: by 2002:adf:828f:: with SMTP id 15mr44629864wrc.17.1554147451897;
 Mon, 01 Apr 2019 12:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190325183652.252175-1-helgaas@kernel.org> <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
 <20190401140806.GB4570@kunai>
In-Reply-To: <20190401140806.GB4570@kunai>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 1 Apr 2019 14:37:19 -0500
Message-ID: <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: multipart/mixed; boundary="000000000000cda31005857d26e9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cda31005857d26e9
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 1, 2019 at 9:08 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > > convert i2c-isch to platform_device") removed the use of
> > > acpi_check_region() but not the include.
> > >
> > > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > > intended.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Added
> >
> >     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> >     Reviewed-by: Jean Delvare <jdelvare@suse.de>
> >     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> >
> > on my local branch.
> >
> > Jean, would you like me to repost this with the updates?  I assume you
> > will merge this (just based on get_maintainer.pl)?
>
> I will apply it, now that it has Jean's Rev-by. I assume this is
> for-next material despite the Fixes tag?

Definitely for-next material, not for the current release.  Jean
suggested the Fixes tag, I think since it's related to a specific
commit and could be backported together with that commit.

Should there be a MAINTAINERS update to clarify who applies patches to
drivers/i2c/busses/i2c-isch.c?  Right now, get_maintainers.pl doesn't
mention you (Wolfram).

Patch with tags attached in case it's useful to you (sorry, I'm
saddled with gmail right now and can't include it inline).

--000000000000cda31005857d26e9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-i2c-isch-Remove-unnecessary-acpi.h-include.patch"
Content-Disposition: attachment; 
	filename="0001-i2c-isch-Remove-unnecessary-acpi.h-include.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtyr8zu10>
X-Attachment-Id: f_jtyr8zu10

RnJvbSAzNmZiZGFiODlmNWI4YWEyZDM2MTZiZDI4OWUyYzY5NWZkM2MwZjliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgpE
YXRlOiBUdWUsIDMwIE9jdCAyMDE4IDE0OjEyOjM2IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gaTJj
OiBpc2NoOiBSZW1vdmUgdW5uZWNlc3NhcnkgYWNwaS5oIGluY2x1ZGUKCjU0ZmI0YTA1YWYwYSAo
ImkyYzogQ2hlY2sgZm9yIEFDUEkgcmVzb3VyY2UgY29uZmxpY3RzIikgaW5jbHVkZWQKPGxpbnV4
L2FjcGkuaD4gc28gd2UgY291bGQgdXNlIGFjcGlfY2hlY2tfcmVnaW9uKCkuICBmZDQ2YTAwNjRh
ZjEgKCJpMmM6CmNvbnZlcnQgaTJjLWlzY2ggdG8gcGxhdGZvcm1fZGV2aWNlIikgcmVtb3ZlZCB0
aGUgdXNlIG9mCmFjcGlfY2hlY2tfcmVnaW9uKCkgYnV0IG5vdCB0aGUgaW5jbHVkZS4KClJlbW92
ZSB0aGUgbm93LXVubmVjZXNzYXJ5IGluY2x1ZGUgb2YgPGxpbnV4L2FjcGkuaD4uICBObyBmdW5j
dGlvbmFsIGNoYW5nZQppbnRlbmRlZC4KCkZpeGVzOiBmZDQ2YTAwNjRhZjEgKCJpMmM6IGNvbnZl
cnQgaTJjLWlzY2ggdG8gcGxhdGZvcm1fZGV2aWNlIikKU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KUmV2aWV3ZWQtYnk6IEplYW4gRGVsdmFyZSA8amRl
bHZhcmVAc3VzZS5kZT4KUmV2aWV3ZWQtYnk6IE11a2VzaCBPamhhIDxtb2poYUBjb2RlYXVyb3Jh
Lm9yZz4KLS0tCiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlzY2guYyB8IDEgLQogMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LWlzY2guYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaXNjaC5jCmluZGV4IDVjNzU0YmY2NTll
Mi4uZjY0YzFkNzJmNzNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlzY2gu
YworKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlzY2guYwpAQCAtMzAsNyArMzAsNiBAQAog
I2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPgogI2luY2x1ZGUgPGxpbnV4L2kyYy5oPgogI2luY2x1
ZGUgPGxpbnV4L2lvLmg+Ci0jaW5jbHVkZSA8bGludXgvYWNwaS5oPgogCiAvKiBTQ0ggU01CdXMg
YWRkcmVzcyBvZmZzZXRzICovCiAjZGVmaW5lIFNNQkhTVENOVAkoMCArIHNjaF9zbWJhKQotLSAK
Mi4yMS4wLjM5Mi5nZjhmNjc4NzE1OWUtZ29vZwoK
--000000000000cda31005857d26e9--
