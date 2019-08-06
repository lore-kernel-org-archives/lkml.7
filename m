Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D633FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD24E2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfHFMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:36:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:46616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfHFMgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:36:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D8A3AF8C;
        Tue,  6 Aug 2019 12:36:52 +0000 (UTC)
Message-ID: <1565095011.8136.20.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 06 Aug 2019 14:36:51 +0200
In-Reply-To: <Pine.LNX.4.44L0.1908011359580.1305-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1908011359580.1305-100000@iolanthe.rowland.org>
Content-Type: multipart/mixed; boundary="=-CqgVn5zigmmeKrUOHL2S"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CqgVn5zigmmeKrUOHL2S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Donnerstag, den 01.08.2019, 14:47 -0400 schrieb Alan Stern:
> 
> I think this must be caused by an unbalanced refcount.  That is,
> something must drop one more reference to the device than it takes.
> That would explain why the invalid access occurs inside a single
> bus_remove_device() call, between the klist_del() and
> device_release_driver().
> 
> The kernel log indicates that the device was probed by rndis_wlan,
> rndis_host, and cdc_acm, all of which got errors because of the
> device's bogus descriptors.  Probably one of them is messing up the
> refcount.

Hi,

you made me look at cdc-acm. I suspect

cae2bc768d176bfbdad7035bbcc3cdc973eb7984 ("usb: cdc-acm: Decrement tty port's refcount if probe() fail")

is buggy decrementing the refcount on the interface in destroy()
even before the refcount is increased.

Unfortunately I cannot tell from the bug report how many and which
interfaces the emulated test device has. Hence it is unclear to me,
when exactly probe() would fail cdc-acm.

If you agree. I am attaching a putative fix.

	Regards
		Oliver

--=-CqgVn5zigmmeKrUOHL2S
Content-Disposition: attachment;
	filename*0=0001-usb-cdc-acm-make-sure-a-refcount-is-taken-early-enou.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-usb-cdc-acm-make-sure-a-refcount-is-taken-early-enou.patch";
	charset="UTF-8"

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


--=-CqgVn5zigmmeKrUOHL2S--

