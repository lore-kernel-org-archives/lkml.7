Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70907C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E9220C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMzlPd4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfHFMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:51:04 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:37969 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731163AbfHFMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:51:03 -0400
Received: by mail-pl1-f174.google.com with SMTP id az7so37814798plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/Of7gnFjNlYZMBf78waHqPimHfP3RU+CQjMntOpVvM=;
        b=eMzlPd4EBCnV+s/Ums9HwV+WL/jKoe1IKYlCEww1YgLdJ6/QiSxZeRizXYpixzAUxG
         92GzDVmn4VtHpwVQ9/WVESJFdBIKqCR8rYd5UietWb4T/ss+gam86/P2HkyZmjhYodnS
         5OnIoAM+Xvb66xOs1Gt2vB8vAxJpkyk/hdnnO5rDsM8Mj+0evcH+QOqX7Rr1KjHSMuj1
         kbJ+xBj7d1HgpwcJSrKKQzQ478XUAxmZiSCaraq/7vVfdDv6BzyCga9yJ6Z3sdIa6LEB
         ZsE5Sc45brqqHENg4ZU57PkT2L+/t9FdwerTRCRcydjOFllj0fTHlJCH/VvRysP58GVu
         Mo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/Of7gnFjNlYZMBf78waHqPimHfP3RU+CQjMntOpVvM=;
        b=fmlQeve3XMRyDGGZ9YLK235jT2FxfF0ux9a0uKIr2GdRYESV5fxwM5WTL8xb4m1rd/
         kZwnay7/oFwAKvhw8uVYN8K+DWLBQtWdVOyXroIE3+44Cl3ov3ewDrCddhbH8eS3GppG
         59TM//OKeFjjsreQI8RxsOatM3fXikXAPXzY6xKvG5JjU2VL0I8Q3Gq/hRa2FU4X5hdA
         CcEy7Tj8C5nQu2Fw1taUnFpnSfH8GW3e08NojqfeuVdAUs0uCZ64yC9mvtnUazXARe1/
         S+riFw7aJEXYWOqnwyH76I2kzZ44475H3YXtPGuy+bRGcK03JOffpuR+fbiGKUGFVGXz
         cF5A==
X-Gm-Message-State: APjAAAUXPvUrbhkzXaXvkmy+PLetkpwc7bUgYiUytv5NjwTmFyGfSnEI
        IYS6e5amT8M4ILWQxxPSTBlGltaccGxCdlSaYy5WJw==
X-Google-Smtp-Source: APXvYqzihCoaFQUPrkbjQsOtc0LFfMF/L5IY24117UvLqAZecCOTru0wu7N7UYzsH6gvCzbMwvpY85OkRbx6duvMjkA=
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr2992398plk.336.1565095861407;
 Tue, 06 Aug 2019 05:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1908011359580.1305-100000@iolanthe.rowland.org> <1565095011.8136.20.camel@suse.com>
In-Reply-To: <1565095011.8136.20.camel@suse.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 6 Aug 2019 14:50:50 +0200
Message-ID: <CAAeHK+wyvJbi08ruuOn1qF0O1Jubz_BhZz5wXdNg4Vy5XeyQmw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000dd87f8058f7246cd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dd87f8058f7246cd
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 6, 2019 at 2:36 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Donnerstag, den 01.08.2019, 14:47 -0400 schrieb Alan Stern:
> >
> > I think this must be caused by an unbalanced refcount.  That is,
> > something must drop one more reference to the device than it takes.
> > That would explain why the invalid access occurs inside a single
> > bus_remove_device() call, between the klist_del() and
> > device_release_driver().
> >
> > The kernel log indicates that the device was probed by rndis_wlan,
> > rndis_host, and cdc_acm, all of which got errors because of the
> > device's bogus descriptors.  Probably one of them is messing up the
> > refcount.
>
> Hi,
>
> you made me look at cdc-acm. I suspect
>
> cae2bc768d176bfbdad7035bbcc3cdc973eb7984 ("usb: cdc-acm: Decrement tty port's refcount if probe() fail")
>
> is buggy decrementing the refcount on the interface in destroy()
> even before the refcount is increased.
>
> Unfortunately I cannot tell from the bug report how many and which
> interfaces the emulated test device has. Hence it is unclear to me,
> when exactly probe() would fail cdc-acm.
>
> If you agree. I am attaching a putative fix.

Let's see if it fixes the issue.

#syz fix: https://github.com/google/kasan.git 6a3599ce

>
>         Regards
>                 Oliver

--000000000000dd87f8058f7246cd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-usb-cdc-acm-make-sure-a-refcount-is-taken-early-enou.patch"
Content-Disposition: attachment; 
	filename="0001-usb-cdc-acm-make-sure-a-refcount-is-taken-early-enou.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jyztngtt0>
X-Attachment-Id: f_jyztngtt0

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
--000000000000dd87f8058f7246cd--
