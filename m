Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1310C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A644A20700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAYqZnf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfC2A7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:59:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35700 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfC2A7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:59:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so812559qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ke6WThcmB0DO5fvasc8RvsEiirs2/ACHMR2kRjHXfI=;
        b=QAYqZnf9WBvtO9KfdxTLgMHmhLKHUWcBa1KXLJE5no9pPg66oS/tbKhFZy5TN1z76F
         p2BXl+UfjVFvVewLO14FjViGOOQq2R3ce+jq/wC0Ce35CT6VHOGWq3Hd/HRrlOiZQNbk
         6cFyn1UrGqF4mQYWUMbTzo8fmN+8s2XD2tvz6PFG4zZawpFdzVG3QEEqt48p0P4iiSjE
         henj0tUTWv0dk2oiluqQXRT11UwDcXc1LTLgtqtzbkNxhFA3p7187/3JueqQYzbgnJ5I
         XjdvYZp+PetmTISjt2ZO12rLAMftcZZNjhXtalUeSIZjve3OdNX9i5Mqvcvvc2C+LOsg
         iBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ke6WThcmB0DO5fvasc8RvsEiirs2/ACHMR2kRjHXfI=;
        b=GEmrnYhMiBpMw5tW2TY27JmFCExpzUMz3iIUowlZEDAc0FF3gsCmEGUHOTqBGIAh2E
         wEjihIpRMAStGu2U2BH/BrNWjlCps7B4exqNp3ItmHRBL/TlxK2xmnyxquHBZ057w8Xs
         fbRCrL66HKODJc3KjqL/axUqiqxv72iFALKxCNobTyMCj1DRthWcQKEwx2YWb2clMOXe
         SE63Sh6lcRRgVjJc6OTMNyizXIxCb9qFZVzAQTqcMDYCW3Z75Xd1R7//dSVWe7PUBb8Z
         ywgNcy7gts0UGcXVIZviqYOn+TR9f+TT0BweMD1gafKG9Uq8NCLR3BEK3vFlHyi/vf9k
         0E0A==
X-Gm-Message-State: APjAAAUdi/NrWO/R1Sk6UmgcRm+PtOh0u2jrD1kLAizT0VvPW/jyaWJP
        mxRyBbo3trcbNeHKsjD8n2BuiHJq8wpByfONCyc3yQ==
X-Google-Smtp-Source: APXvYqx9FUKcFcoTcTFcNeKQTaPtKZUNfKOpgfnBqMamfcWTLjsMI4xe/xR2UPXpHHxNS8hhYO4Ywhu1eIdomBtXYQQ=
X-Received: by 2002:a0c:9906:: with SMTP id h6mr38693883qvd.45.1553821175225;
 Thu, 28 Mar 2019 17:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRSSEzGaZw4y4gKzyJzxmrkL20NpTAtB8mDeDs+JzsTWeDZKA@mail.gmail.com>
 <000000000000a8bbbb058530a12a@google.com>
In-Reply-To: <000000000000a8bbbb058530a12a@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 28 Mar 2019 17:59:23 -0700
Message-ID: <CAHRSSEy3od0-7HMCOjbHprc9ihu3VqkJi1-5OKew0oN-2BcPvA@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
To:     syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs@googlegroups.com, Todd Kjos <tkjos@android.com>
Content-Type: multipart/mixed; boundary="00000000000033183c0585312fec"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000033183c0585312fec
Content-Type: text/plain; charset="UTF-8"

Sigh. One more try... master with the same patch as an attachment.
(the patch is already queued up in gregkh's 'char-misc-linus' branch).

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
master

On Thu, Mar 28, 2019 at 5:20 PM syzbot
<syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but build/boot failed:
>
> timed out
>
>
>
>
>
>
> Tested on:
>
> commit:         0532a1b0 virt: vbox: Implement passing requestor info to t..
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> char-misc-linus
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>

--00000000000033183c0585312fec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-binder-fix-crash-in-binder_alloc_do_buffer_copy.patch"
Content-Disposition: attachment; 
	filename="0001-binder-fix-crash-in-binder_alloc_do_buffer_copy.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jttcy0c60>
X-Attachment-Id: f_jttcy0c60

RnJvbSBkNDljOTVjOTQ0YzE1NzMyZWY1N2YxYzg3NmUyNDgzOGIyZGRmMzRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUb2RkIEtqb3MgPHRram9zQGdvb2dsZS5jb20+CkRhdGU6IFR1
ZSwgMTkgTWFyIDIwMTkgMDk6NTM6MDEgLTA3MDAKU3ViamVjdDogW1BBVENIXSBiaW5kZXI6IGZp
eCBCVUdfT04gZm91bmQgYnkgc2VsaW51eC10ZXN0c3VpdGUKClRoZSBzZWxpbnV4LXRlc3RzdWl0
ZSBmb3VuZCBhbiBpc3N1ZSByZXN1bHRpbmcgaW4gYSBCVUdfT04oKQp3aGVyZSBhIGNvbmRpdGlv
bmFsIHJlbGllZCBvbiBhIHNpemVfdCBnb2luZyBuZWdhdGl2ZSB3aGVuCmNoZWNraW5nIHRoZSB2
YWxpZGl0eSBvZiBhIGJ1ZmZlciBvZmZzZXQuCgpGaXhlczogN2E2N2EzOTMyMGRmICgiYmluZGVy
OiBhZGQgZnVuY3Rpb24gdG8gY29weSBiaW5kZXIgb2JqZWN0IGZyb20gYnVmZmVyIikKUmVwb3J0
ZWQtYnk6IFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+ClRlc3RlZC1ieTogUGF1bCBN
b29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT4KU2lnbmVkLW9mZi1ieTogVG9kZCBLam9zIDx0a2pv
c0Bnb29nbGUuY29tPgotLS0KUGxlYXNlIGFkZCB0byA1LjEgKGZpeGVzIHByb2JsZW0gaW50cm9k
dWNlZCBpbiA1LjEtcmMxKQoKIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyB8IDMgKystCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jCmluZGV4
IDg2ODU4ODJkYTY0Y2QuLjRiOWM3Y2E0OTJlNmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYW5kcm9p
ZC9iaW5kZXIuYworKysgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMKQEAgLTIwNTcsNyArMjA1
Nyw4IEBAIHN0YXRpYyBzaXplX3QgYmluZGVyX2dldF9vYmplY3Qoc3RydWN0IGJpbmRlcl9wcm9j
ICpwcm9jLAogCXNpemVfdCBvYmplY3Rfc2l6ZSA9IDA7CiAKIAlyZWFkX3NpemUgPSBtaW5fdChz
aXplX3QsIHNpemVvZigqb2JqZWN0KSwgYnVmZmVyLT5kYXRhX3NpemUgLSBvZmZzZXQpOwotCWlm
IChyZWFkX3NpemUgPCBzaXplb2YoKmhkcikgfHwgIUlTX0FMSUdORUQob2Zmc2V0LCBzaXplb2Yo
dTMyKSkpCisJaWYgKG9mZnNldCA+IGJ1ZmZlci0+ZGF0YV9zaXplIHx8IHJlYWRfc2l6ZSA8IHNp
emVvZigqaGRyKSB8fAorCSAgICAhSVNfQUxJR05FRChvZmZzZXQsIHNpemVvZih1MzIpKSkKIAkJ
cmV0dXJuIDA7CiAJYmluZGVyX2FsbG9jX2NvcHlfZnJvbV9idWZmZXIoJnByb2MtPmFsbG9jLCBv
YmplY3QsIGJ1ZmZlciwKIAkJCQkgICAgICBvZmZzZXQsIHJlYWRfc2l6ZSk7Ci0tIAoyLjIxLjAu
MjI1Lmc4MTBiMjY5ZDFhYy1nb29nCgo=
--00000000000033183c0585312fec--
