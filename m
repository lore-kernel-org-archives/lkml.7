Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE73C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E069214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYLZ1DGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfIXTg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:36:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45912 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfIXTg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:36:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so1930530pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JVQqtsy+mKk2waXIHthBqSLO8+9xamj2i8nFWhqynA=;
        b=TYLZ1DGNa1ipb9tkFTuN7m4yb5t+lRAf2jnzkdnivcl+pcoPPxaO//upw2N0N8mxzg
         9RLtQyQ4DWIuEqqkWG8S0CD616YAGnkwVATBZT0QjuNlo2U0+ffDVRMriCSDbTr1qm1g
         sbAvTBMY9CnYnQk9Vp4oea9g71h3jUQ6rq38Q5bw6f77n5KifOoV3RtYVUp8JqKufX+I
         bP4qsJiFisuGleGuU4/i9oj/HY5C0Sqt38itVOAGsQOkhvGlR4pLpUiCT4ZnKd0M+CBB
         yaNmZPLvhl8Vr8s2yIhvRqkgWTvvAE0FwuRalQRGW4vSkRw3Jri7zhA3kQRsB1p2JQQ+
         2prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JVQqtsy+mKk2waXIHthBqSLO8+9xamj2i8nFWhqynA=;
        b=Kwc3Unw6QMXAJWJBbsvBk/NfMvyaBOEKdxHGU7AidGsAY17EVBYhM1sXkw73+hGX35
         8p9K9A4gbXkEkUSWKijKQcVZT83GrmurMk08oQ9EfDYEBgC9UFTHqZsqZCH+/XfU4GSb
         yPFVZo42RbHlzDjinXsHp43HFawK4BLWOXSInhJq3xeaNVg/qkxak7xV8DkWJTjEQHMM
         /EY5WShnmekL9J3QTJxfGEX9MQ+zyBaBKdXsgyyFlkv3HrY6yQXuztElNC1+pbKOdTnz
         sqYm5VdMtsxKEZdLknsu4a38DV2iUgnUgHogZ/hgt6NRS9HTHtHKli7uaxfhC8z56pL4
         ZRrA==
X-Gm-Message-State: APjAAAXRML9oVba0sCzvidE7aQcm6PLN9ahgkxxkZQoUOoJzXYpa31px
        GNTJj6WQNVyeSTO9UIsCL9isVy7jXQt/N1bI9kd7dg==
X-Google-Smtp-Source: APXvYqzHDNAmcX+psqM3CwLXFm7TSuu3PYc5ZPk1pDvkvNaLv7MrzlNbB2TZC97ohk11uAf+MpXo4oSi+IkedCtCdcY=
X-Received: by 2002:a17:90a:178d:: with SMTP id q13mr1845586pja.134.1569353815306;
 Tue, 24 Sep 2019 12:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
 <20190924174728.201464-1-ndesaulniers@google.com> <20190924183827.GA2800937@archlinux-threadripper>
In-Reply-To: <20190924183827.GA2800937@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Sep 2019 12:36:44 -0700
Message-ID: <CAKwvOdmVfyhG85BHdaHgc23RuRkJJnvd2bLUEzNNpZDuqJ79mw@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (applesmc) fix UB and udelay overflow
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        jdelvare@suse.com,
        =?UTF-8?Q?Tomasz_Pawe=C5=82_Gajc?= <tpgxyz@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b0c195059351a8bd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b0c195059351a8bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 11:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Sep 24, 2019 at 10:47:28AM -0700, Nick Desaulniers wrote:
> > Fixes the following 2 issues in the driver:
> > 1. Left shifting a signed integer is undefined behavior. Unsigned
> >    integral types should be used for bitwise operations.
> > 2. The delay scales from 0x0010 to 0x20000 by powers of 2, but udelay
> >    will result in a linkage failure when given a constant that's greate=
r
> >    than 20000 (0x4E20). Agressive loop unrolling can fully unroll the
> >    loop, resulting in later iterations overflowing the call to udelay.
> >
> > 2 is fixed via splitting the loop in two, iterating the first up to the
> > point where udelay would overflow, then switching to mdelay, as
> > suggested in Documentation/timers/timers-howto.rst.
> >
> > Reported-by: Tomasz Pawe=C5=82 Gajc <tpgxyz@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/678
> > Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes V1 -> V2:
> > * The first loop in send_byte() needs to break out on the same conditio=
n
> >   now. Technically, the loop condition could even be removed. The diff
> >   looks funny because of the duplicated logic between existing and newl=
y
> >   added for loops.
> >
> >  drivers/hwmon/applesmc.c | 35 +++++++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> > index 183ff3d25129..c76adb504dff 100644
> > --- a/drivers/hwmon/applesmc.c
> > +++ b/drivers/hwmon/applesmc.c
> > @@ -46,6 +46,7 @@
> >  #define APPLESMC_MIN_WAIT    0x0010
> >  #define APPLESMC_RETRY_WAIT  0x0100
> >  #define APPLESMC_MAX_WAIT    0x20000
> > +#define APPLESMC_UDELAY_MAX  20000
> >
> >  #define APPLESMC_READ_CMD    0x10
> >  #define APPLESMC_WRITE_CMD   0x11
> > @@ -157,14 +158,23 @@ static struct workqueue_struct *applesmc_led_wq;
> >  static int wait_read(void)
> >  {
> >       u8 status;
> > -     int us;
> > -     for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1=
) {
> > +     unsigned int us;
> > +
> > +     for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<=3D=
 1) {
> >               udelay(us);
> >               status =3D inb(APPLESMC_CMD_PORT);
> >               /* read: wait for smc to settle */
> >               if (status & 0x01)
> >                       return 0;
> >       }
> > +     /* switch to mdelay for longer sleeps */
> > +     for (; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
> > +             mdelay(us);
> > +             status =3D inb(APPLESMC_CMD_PORT);
> > +             /* read: wait for smc to settle */
> > +             if (status & 0x01)
> > +                     return 0;
> > +     }
> >
> >       pr_warn("wait_read() fail: 0x%02x\n", status);
> >       return -EIO;
> > @@ -177,10 +187,10 @@ static int wait_read(void)
> >  static int send_byte(u8 cmd, u16 port)
> >  {
> >       u8 status;
> > -     int us;
> > +     unsigned int us;
> >
> >       outb(cmd, port);
> > -     for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1=
) {
> > +     for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_UDELAY_MAX; us <<=3D=
 1) {
> >               udelay(us);
> >               status =3D inb(APPLESMC_CMD_PORT);
> >               /* write: wait for smc to settle */
> > @@ -190,6 +200,23 @@ static int send_byte(u8 cmd, u16 port)
> >               if (status & 0x04)
> >                       return 0;
> >               /* timeout: give up */
> > +             if (us << 1 =3D=3D APPLESMC_UDELAY_MAX)
> > +                     break;
> > +             /* busy: long wait and resend */
> > +             udelay(APPLESMC_RETRY_WAIT);
> > +             outb(cmd, port);
> > +     }
> > +     /* switch to mdelay for longer sleeps */
> > +     for (; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
> > +             mdelay(us);
> > +             status =3D inb(APPLESMC_CMD_PORT);
> > +             /* write: wait for smc to settle */
> > +             if (status & 0x02)
> > +                     continue;
> > +             /* ready: cmd accepted, return */
> > +             if (status & 0x04)
> > +                     return 0;
> > +             /* timeout: give up */
> >               if (us << 1 =3D=3D APPLESMC_MAX_WAIT)
> >                       break;
> >               /* busy: long wait and resend */
> > --
> > 2.23.0.351.gc4317032e6-goog
> >
>
> This resolves the __bad_udelay appearance at -O3 for me. I am not
> familiar enough with this code to give a reviewed by though!

Does that constitute a Tested-by tag?

>
> Also, for some odd reason, I couldn't apply your patch with 'git apply':
>
> % curl -LSs https://lore.kernel.org/lkml/20190924174728.201464-1-ndesauln=
iers@google.com/raw | git apply
> error: corrupt patch at line 117
>
> It looks like some of the '=3D' got changed into =3D3D and some spaces go=
t
> changed into =3D20. Weird encoding glitch?

The text in my email client shows no encoding error; the link above
shows the issue.  Attaching a copy here, in case git-send-email
related.
--=20
Thanks,
~Nick Desaulniers

--000000000000b0c195059351a8bd
Content-Type: text/x-patch; charset="UTF-8"; 
	name="v2-0001-hwmon-applesmc-fix-UB-and-udelay-overflow.patch"
Content-Disposition: attachment; 
	filename="v2-0001-hwmon-applesmc-fix-UB-and-udelay-overflow.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k0y8pzw50>
X-Attachment-Id: f_k0y8pzw50

RnJvbSBlMTEyOTM1Y2I0MzYxYWE4MjBiODk1ODhlNTc2NGJmYzNkZmQ3ZjlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xl
LmNvbT4KRGF0ZTogVHVlLCAyNCBTZXAgMjAxOSAxMDoyNjozNCAtMDcwMApTdWJqZWN0OiBbUEFU
Q0ggdjJdIGh3bW9uOiAoYXBwbGVzbWMpIGZpeCBVQiBhbmQgdWRlbGF5IG92ZXJmbG93Ck1JTUUt
VmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250
ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpGaXhlcyB0aGUgZm9sbG93aW5nIDIgaXNzdWVz
IGluIHRoZSBkcml2ZXI6CjEuIExlZnQgc2hpZnRpbmcgYSBzaWduZWQgaW50ZWdlciBpcyB1bmRl
ZmluZWQgYmVoYXZpb3IuIFVuc2lnbmVkCiAgIGludGVncmFsIHR5cGVzIHNob3VsZCBiZSB1c2Vk
IGZvciBiaXR3aXNlIG9wZXJhdGlvbnMuCjIuIFRoZSBkZWxheSBzY2FsZXMgZnJvbSAweDAwMTAg
dG8gMHgyMDAwMCBieSBwb3dlcnMgb2YgMiwgYnV0IHVkZWxheQogICB3aWxsIHJlc3VsdCBpbiBh
IGxpbmthZ2UgZmFpbHVyZSB3aGVuIGdpdmVuIGEgY29uc3RhbnQgdGhhdCdzIGdyZWF0ZXIKICAg
dGhhbiAyMDAwMCAoMHg0RTIwKS4gQWdyZXNzaXZlIGxvb3AgdW5yb2xsaW5nIGNhbiBmdWxseSB1
bnJvbGwgdGhlCiAgIGxvb3AsIHJlc3VsdGluZyBpbiBsYXRlciBpdGVyYXRpb25zIG92ZXJmbG93
aW5nIHRoZSBjYWxsIHRvIHVkZWxheS4KCjIgaXMgZml4ZWQgdmlhIHNwbGl0dGluZyB0aGUgbG9v
cCBpbiB0d28sIGl0ZXJhdGluZyB0aGUgZmlyc3QgdXAgdG8gdGhlCnBvaW50IHdoZXJlIHVkZWxh
eSB3b3VsZCBvdmVyZmxvdywgdGhlbiBzd2l0Y2hpbmcgdG8gbWRlbGF5LCBhcwpzdWdnZXN0ZWQg
aW4gRG9jdW1lbnRhdGlvbi90aW1lcnMvdGltZXJzLWhvd3RvLnJzdC4KClJlcG9ydGVkLWJ5OiBU
b21hc3ogUGF3ZcWCIEdhamMgPHRwZ3h5ekBnbWFpbC5jb20+Ckxpbms6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzY3OApEZWJ1Z2dlZC1ieTogTmF0aGFu
IENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTmlj
ayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+Ci0tLQpDaGFuZ2VzIFYxIC0+
IFYyOgoqIFRoZSBmaXJzdCBsb29wIGluIHNlbmRfYnl0ZSgpIG5lZWRzIHRvIGJyZWFrIG91dCBv
biB0aGUgc2FtZSBjb25kaXRpb24KICBub3cuIFRlY2huaWNhbGx5LCB0aGUgbG9vcCBjb25kaXRp
b24gY291bGQgZXZlbiBiZSByZW1vdmVkLiBUaGUgZGlmZgogIGxvb2tzIGZ1bm55IGJlY2F1c2Ug
b2YgdGhlIGR1cGxpY2F0ZWQgbG9naWMgYmV0d2VlbiBleGlzdGluZyBhbmQgbmV3bHkKICBhZGRl
ZCBmb3IgbG9vcHMuCgogZHJpdmVycy9od21vbi9hcHBsZXNtYy5jIHwgMzUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vYXBwbGVzbWMuYyBi
L2RyaXZlcnMvaHdtb24vYXBwbGVzbWMuYwppbmRleCAxODNmZjNkMjUxMjkuLmM3NmFkYjUwNGRm
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9od21vbi9hcHBsZXNtYy5jCisrKyBiL2RyaXZlcnMvaHdt
b24vYXBwbGVzbWMuYwpAQCAtNDYsNiArNDYsNyBAQAogI2RlZmluZSBBUFBMRVNNQ19NSU5fV0FJ
VAkweDAwMTAKICNkZWZpbmUgQVBQTEVTTUNfUkVUUllfV0FJVAkweDAxMDAKICNkZWZpbmUgQVBQ
TEVTTUNfTUFYX1dBSVQJMHgyMDAwMAorI2RlZmluZSBBUFBMRVNNQ19VREVMQVlfTUFYCTIwMDAw
CiAKICNkZWZpbmUgQVBQTEVTTUNfUkVBRF9DTUQJMHgxMAogI2RlZmluZSBBUFBMRVNNQ19XUklU
RV9DTUQJMHgxMQpAQCAtMTU3LDE0ICsxNTgsMjMgQEAgc3RhdGljIHN0cnVjdCB3b3JrcXVldWVf
c3RydWN0ICphcHBsZXNtY19sZWRfd3E7CiBzdGF0aWMgaW50IHdhaXRfcmVhZCh2b2lkKQogewog
CXU4IHN0YXR1czsKLQlpbnQgdXM7Ci0JZm9yICh1cyA9IEFQUExFU01DX01JTl9XQUlUOyB1cyA8
IEFQUExFU01DX01BWF9XQUlUOyB1cyA8PD0gMSkgeworCXVuc2lnbmVkIGludCB1czsKKworCWZv
ciAodXMgPSBBUFBMRVNNQ19NSU5fV0FJVDsgdXMgPCBBUFBMRVNNQ19VREVMQVlfTUFYOyB1cyA8
PD0gMSkgewogCQl1ZGVsYXkodXMpOwogCQlzdGF0dXMgPSBpbmIoQVBQTEVTTUNfQ01EX1BPUlQp
OwogCQkvKiByZWFkOiB3YWl0IGZvciBzbWMgdG8gc2V0dGxlICovCiAJCWlmIChzdGF0dXMgJiAw
eDAxKQogCQkJcmV0dXJuIDA7CiAJfQorCS8qIHN3aXRjaCB0byBtZGVsYXkgZm9yIGxvbmdlciBz
bGVlcHMgKi8KKwlmb3IgKDsgdXMgPCBBUFBMRVNNQ19NQVhfV0FJVDsgdXMgPDw9IDEpIHsKKwkJ
bWRlbGF5KHVzKTsKKwkJc3RhdHVzID0gaW5iKEFQUExFU01DX0NNRF9QT1JUKTsKKwkJLyogcmVh
ZDogd2FpdCBmb3Igc21jIHRvIHNldHRsZSAqLworCQlpZiAoc3RhdHVzICYgMHgwMSkKKwkJCXJl
dHVybiAwOworCX0KIAogCXByX3dhcm4oIndhaXRfcmVhZCgpIGZhaWw6IDB4JTAyeFxuIiwgc3Rh
dHVzKTsKIAlyZXR1cm4gLUVJTzsKQEAgLTE3NywxMCArMTg3LDEwIEBAIHN0YXRpYyBpbnQgd2Fp
dF9yZWFkKHZvaWQpCiBzdGF0aWMgaW50IHNlbmRfYnl0ZSh1OCBjbWQsIHUxNiBwb3J0KQogewog
CXU4IHN0YXR1czsKLQlpbnQgdXM7CisJdW5zaWduZWQgaW50IHVzOwogCiAJb3V0YihjbWQsIHBv
cnQpOwotCWZvciAodXMgPSBBUFBMRVNNQ19NSU5fV0FJVDsgdXMgPCBBUFBMRVNNQ19NQVhfV0FJ
VDsgdXMgPDw9IDEpIHsKKwlmb3IgKHVzID0gQVBQTEVTTUNfTUlOX1dBSVQ7IHVzIDwgQVBQTEVT
TUNfVURFTEFZX01BWDsgdXMgPDw9IDEpIHsKIAkJdWRlbGF5KHVzKTsKIAkJc3RhdHVzID0gaW5i
KEFQUExFU01DX0NNRF9QT1JUKTsKIAkJLyogd3JpdGU6IHdhaXQgZm9yIHNtYyB0byBzZXR0bGUg
Ki8KQEAgLTE5MCw2ICsyMDAsMjMgQEAgc3RhdGljIGludCBzZW5kX2J5dGUodTggY21kLCB1MTYg
cG9ydCkKIAkJaWYgKHN0YXR1cyAmIDB4MDQpCiAJCQlyZXR1cm4gMDsKIAkJLyogdGltZW91dDog
Z2l2ZSB1cCAqLworCQlpZiAodXMgPDwgMSA9PSBBUFBMRVNNQ19VREVMQVlfTUFYKQorCQkJYnJl
YWs7CisJCS8qIGJ1c3k6IGxvbmcgd2FpdCBhbmQgcmVzZW5kICovCisJCXVkZWxheShBUFBMRVNN
Q19SRVRSWV9XQUlUKTsKKwkJb3V0YihjbWQsIHBvcnQpOworCX0KKwkvKiBzd2l0Y2ggdG8gbWRl
bGF5IGZvciBsb25nZXIgc2xlZXBzICovCisJZm9yICg7IHVzIDwgQVBQTEVTTUNfTUFYX1dBSVQ7
IHVzIDw8PSAxKSB7CisJCW1kZWxheSh1cyk7CisJCXN0YXR1cyA9IGluYihBUFBMRVNNQ19DTURf
UE9SVCk7CisJCS8qIHdyaXRlOiB3YWl0IGZvciBzbWMgdG8gc2V0dGxlICovCisJCWlmIChzdGF0
dXMgJiAweDAyKQorCQkJY29udGludWU7CisJCS8qIHJlYWR5OiBjbWQgYWNjZXB0ZWQsIHJldHVy
biAqLworCQlpZiAoc3RhdHVzICYgMHgwNCkKKwkJCXJldHVybiAwOworCQkvKiB0aW1lb3V0OiBn
aXZlIHVwICovCiAJCWlmICh1cyA8PCAxID09IEFQUExFU01DX01BWF9XQUlUKQogCQkJYnJlYWs7
CiAJCS8qIGJ1c3k6IGxvbmcgd2FpdCBhbmQgcmVzZW5kICovCi0tIAoyLjIzLjAuMzUxLmdjNDMx
NzAzMmU2LWdvb2cKCg==
--000000000000b0c195059351a8bd--
