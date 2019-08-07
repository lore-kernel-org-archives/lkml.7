Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B2C32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498B421E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3rxTwlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbfHGNp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:45:29 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:39904 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbfHGNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:45:28 -0400
Received: by mail-pl1-f173.google.com with SMTP id b7so40961910pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGozOpTwz7r33+UgCnv6PDoFG7HR7Ng6mD304Zn3sQQ=;
        b=f3rxTwlU4DwyCrg+98aA0mPnuo8JUtEUDt/964TINtNbhWV5wFeRJMO1RSaMmnVydF
         mlnr/COOlAWhh0l1yFWi9VEOeXd7aBqIhu6hlWHWzDMD1GuKcdJhQVnQH3DGLSx0mC2Y
         yZMl15K0tp0XrN6DJGQwqCClZCo64rzKmqnQntDjJGWR8+vfQeE2OPZusMSaziYgYCmN
         RHLBtIM5emU4UvUzbOG4qhfvQ8EZAM20s4lTSKcJgpWVW61JuN+3NpyKW+gahzBsZ7BU
         Lg1mtM3Zag9JLmtujVMO3z6P7yQblLQCpi89X+gFrg73vmDCgtXXlnK22thZfuCESC7t
         02VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGozOpTwz7r33+UgCnv6PDoFG7HR7Ng6mD304Zn3sQQ=;
        b=hY2yaERxevH5zAnpWMk9Oe+4KFB9kHZluYo/+GmUMd/ND/TOBo/oUtqPOLWPja12MC
         3RFeBBXBLPje03JS+FvPmJURraJwxDgjWwQxu/m5EjwPcxg3modRGamXdQFXU050zTnj
         smGt+Cz7RtVJTDl+f206UYPuK6EjBuMtDUVFFLsCLIjocfBa7g9cNIvccEcyhAb+ZuD6
         XSZJnbaZp92KhT9tOu+lPaW5mesH5y4giIUwT2cu0bd8kBGizdH5TwPMCMaszPUrDjye
         A/WVk4E+d4XtvJ+lHWeN5b21gWc2/unc8szFEbRSSPdBWe3zddt3bM+zZ2iQ4ZwaOc51
         WVGA==
X-Gm-Message-State: APjAAAXBK/uvPQsfNtejDfuRoCAYNwI1X31kJIuGkLNDDaYVMGuJgrrl
        ckhfCURqBPWOPiTbpn/5sM8wGcyGEO5ZDpArG5ngWQ==
X-Google-Smtp-Source: APXvYqwF3PHg2rMle6J7ykxw88eJAiXiZrI858/1MAa+WAkcos1LQx6+vMctqv/neGGQkJlxs6MyUL1deOmcKB9U2O8=
X-Received: by 2002:a63:3006:: with SMTP id w6mr7892865pgw.440.1565185527670;
 Wed, 07 Aug 2019 06:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1908011359580.1305-100000@iolanthe.rowland.org>
 <1565095011.8136.20.camel@suse.com> <CAAeHK+wyvJbi08ruuOn1qF0O1Jubz_BhZz5wXdNg4Vy5XeyQmw@mail.gmail.com>
 <1565185131.15973.1.camel@suse.com> <CAAeHK+yv-oy_GqMYch7WoVXKOkzpWUmrY9mVY0_FU_0FXjS4nA@mail.gmail.com>
 <CAAeHK+zDVmxgjkZ6dR-sk1=99-Aj=Z4wwxaRCaOXeuYYG3-bUw@mail.gmail.com>
In-Reply-To: <CAAeHK+zDVmxgjkZ6dR-sk1=99-Aj=Z4wwxaRCaOXeuYYG3-bUw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Aug 2019 15:45:16 +0200
Message-ID: <CAAeHK+wV_w6f=zG4XSJkDRhR6b0aNPH0UTkBF3hmRQ6wxy9p2w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000632ebd058f872772"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000632ebd058f872772
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 7, 2019 at 3:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Aug 7, 2019 at 3:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Aug 7, 2019 at 3:38 PM Oliver Neukum <oneukum@suse.com> wrote:
> > >
> > > Am Dienstag, den 06.08.2019, 14:50 +0200 schrieb Andrey Konovalov:
> > > > On Tue, Aug 6, 2019 at 2:36 PM Oliver Neukum <oneukum@suse.com> wrote:
> > > > >
> > > > > Am Donnerstag, den 01.08.2019, 14:47 -0400 schrieb Alan Stern:
> > > > > >
> > > > > > I think this must be caused by an unbalanced refcount.  That is,
> > > > > > something must drop one more reference to the device than it takes.
> > > > > > That would explain why the invalid access occurs inside a single
> > > > > > bus_remove_device() call, between the klist_del() and
> > > > > > device_release_driver().
> > > > > >
> > > > > > The kernel log indicates that the device was probed by rndis_wlan,
> > > > > > rndis_host, and cdc_acm, all of which got errors because of the
> > > > > > device's bogus descriptors.  Probably one of them is messing up the
> > > > > > refcount.
> > > > >
> > > > > Hi,
> > > > >
> > > > > you made me look at cdc-acm. I suspect
> > > > >
> > > > > cae2bc768d176bfbdad7035bbcc3cdc973eb7984 ("usb: cdc-acm: Decrement tty port's refcount if probe() fail")
> > > > >
> > > > > is buggy decrementing the refcount on the interface in destroy()
> > > > > even before the refcount is increased.
> > > > >
> > > > > Unfortunately I cannot tell from the bug report how many and which
> > > > > interfaces the emulated test device has. Hence it is unclear to me,
> > > > > when exactly probe() would fail cdc-acm.
> > > > >
> > > > > If you agree. I am attaching a putative fix.
> > > >
> > > > Let's see if it fixes the issue.
> > > >
> > > > #syz fix: https://github.com/google/kasan.git 6a3599ce
> > >
> > > Hi,
> > >
> > > did this ever produce a result? I saw none.
> >
> > Hm, that's weird, maybe that's caused by putting the bot into CC. Let
> > me try that again.
> >
> > #syz fix: https://github.com/google/kasan.git 6a3599ce
>
> Oh, wait, it should be syz test =)
>
> #syz test: https://github.com/google/kasan.git 6a3599ce

And now I forgot the patch :(

#syz test: https://github.com/google/kasan.git 6a3599ce

>
> >
> > >
> > >         Regards
> > >                 Oliver
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/1565185131.15973.1.camel%40suse.com.

--000000000000632ebd058f872772
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-usb-cdc-acm-make-sure-a-refcount-is-taken-early-enou.patch"
Content-Disposition: attachment; 
	filename="0001-usb-cdc-acm-make-sure-a-refcount-is-taken-early-enou.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz1b1jpz0>
X-Attachment-Id: f_jz1b1jpz0

RnJvbSA2YjMxOTA0ZTZjZjc1Zjg5NDQxZTMwOGI5ZTQyOGExZGU3NzI4ZmQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUdWUsIDYgQXVnIDIwMTkgMTQ6MzQ6MjcgKzAyMDAKU3ViamVjdDogW1BBVENIXSB1c2I6IGNk
Yy1hY206IG1ha2Ugc3VyZSBhIHJlZmNvdW50IGlzIHRha2VuIGVhcmx5IGVub3VnaAoKZGVzdHJv
eSgpIHdpbGwgZGVjcmVtZW50IHRoZSByZWZjb3VudCBvbiB0aGUgaW50ZXJmYWNlLCBzbyB0aGF0
Cml0IG5lZWRzIHRvIGJlIHRha2VuIHNvIGVhcmx5IHRoYXQgaXQgbmV2ZXIgdW5kZXJjb3VudHMu
CgpTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgotLS0KIGRy
aXZlcnMvdXNiL2NsYXNzL2NkYy1hY20uYyB8IDEyICsrKysrKystLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9jbGFzcy9jZGMtYWNtLmMgYi9kcml2ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmMKaW5kZXgg
MTgzYjQxNzUzYzk4Li4yOGUzZGU3NzVhZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NsYXNz
L2NkYy1hY20uYworKysgYi9kcml2ZXJzL3VzYi9jbGFzcy9jZGMtYWNtLmMKQEAgLTEzMDEsMTAg
KzEzMDEsNiBAQCBzdGF0aWMgaW50IGFjbV9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50
ZiwKIAl0dHlfcG9ydF9pbml0KCZhY20tPnBvcnQpOwogCWFjbS0+cG9ydC5vcHMgPSAmYWNtX3Bv
cnRfb3BzOwogCi0JbWlub3IgPSBhY21fYWxsb2NfbWlub3IoYWNtKTsKLQlpZiAobWlub3IgPCAw
KQotCQlnb3RvIGFsbG9jX2ZhaWwxOwotCiAJY3RybHNpemUgPSB1c2JfZW5kcG9pbnRfbWF4cChl
cGN0cmwpOwogCXJlYWRzaXplID0gdXNiX2VuZHBvaW50X21heHAoZXByZWFkKSAqCiAJCQkJKHF1
aXJrcyA9PSBTSU5HTEVfUlhfVVJCID8gMSA6IDIpOwpAQCAtMTMxMiw2ICsxMzA4LDEzIEBAIHN0
YXRpYyBpbnQgYWNtX3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLAogCWFjbS0+d3Jp
dGVzaXplID0gdXNiX2VuZHBvaW50X21heHAoZXB3cml0ZSkgKiAyMDsKIAlhY20tPmNvbnRyb2wg
PSBjb250cm9sX2ludGVyZmFjZTsKIAlhY20tPmRhdGEgPSBkYXRhX2ludGVyZmFjZTsKKworCXVz
Yl9nZXRfaW50ZihhY20tPmNvbnRyb2wpOyAvKiB1bmRvbmUgaW4gZGVzdHJveSgpICovCisKKwlt
aW5vciA9IGFjbV9hbGxvY19taW5vcihhY20pOworCWlmIChtaW5vciA8IDApCisJCWdvdG8gYWxs
b2NfZmFpbDE7CisKIAlhY20tPm1pbm9yID0gbWlub3I7CiAJYWNtLT5kZXYgPSB1c2JfZGV2Owog
CWlmIChoLnVzYl9jZGNfYWNtX2Rlc2NyaXB0b3IpCkBAIC0xNDU4LDcgKzE0NjEsNiBAQCBzdGF0
aWMgaW50IGFjbV9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZiwKIAl1c2JfZHJpdmVy
X2NsYWltX2ludGVyZmFjZSgmYWNtX2RyaXZlciwgZGF0YV9pbnRlcmZhY2UsIGFjbSk7CiAJdXNi
X3NldF9pbnRmZGF0YShkYXRhX2ludGVyZmFjZSwgYWNtKTsKIAotCXVzYl9nZXRfaW50Zihjb250
cm9sX2ludGVyZmFjZSk7CiAJdHR5X2RldiA9IHR0eV9wb3J0X3JlZ2lzdGVyX2RldmljZSgmYWNt
LT5wb3J0LCBhY21fdHR5X2RyaXZlciwgbWlub3IsCiAJCQkmY29udHJvbF9pbnRlcmZhY2UtPmRl
dik7CiAJaWYgKElTX0VSUih0dHlfZGV2KSkgewotLSAKMi4xNi40Cgo=
--000000000000632ebd058f872772--
