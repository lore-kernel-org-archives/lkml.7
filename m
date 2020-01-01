Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65213C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 14:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75392072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="w0uZKgAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgAAOwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 09:52:17 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:28391 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgAAOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 09:52:16 -0500
Date:   Wed, 01 Jan 2020 14:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1577889982;
        bh=T8FitbDzab8rolKo3AvZBRjfivDw+/pmx6LxDnYYhBo=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=w0uZKgAYKvdWnvKUdXS9+uAPbvpWKEjyTo8y7IAdMxdq4BRvdBLXGmHlzNCXWrAQs
         OSMXrgSebXx/dC2MrheKfbNS5kp+GNGkMn4mM3/mIn2RqWfeUchWAwfTa9Y92D3NSv
         VHuZRZJhwg2pnagRjQikFzoSLHS64DyQAEeXyF/M=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   atmgnd <atmgnd@protonmail.com>
Reply-To: atmgnd <atmgnd@protonmail.com>
Subject: Fw: usbcore missing parentheses in USE_NEW_SCHEME
Message-ID: <S5_bTeKG4QYpmSUODHFha_LSjMOM5NMirKYBTHik11iEynJ-WjOAofdiOboo502BpM9CV2Z9xkU93MnoqGz7zdCzwLY7fpqiL5PZZ0-ByQk=@protonmail.com>
In-Reply-To: <7sP4K0IcPrf4Z5urpZjWaiquSFhnNSNGLGsuYj8jbRl8aGGboUyknXW1w7DSBIYNUY308G2QnfDOTmblnyPKyoWMeiYwtqS6mdTxKZqfBO8=@protonmail.com>
References: <7sP4K0IcPrf4Z5urpZjWaiquSFhnNSNGLGsuYj8jbRl8aGGboUyknXW1w7DSBIYNUY308G2QnfDOTmblnyPKyoWMeiYwtqS6mdTxKZqfBO8=@protonmail.com>
Feedback-ID: py-oVO8Vt0vS1FKaKugS2_MTpFC3lKhHMurhoXPAalWk9Eh40Mo1lZOn2CI1vswSSKJBwBLYgn_VKFu9qW3csg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="b1_75cbd74c8b9beee31bf8ab7672b19bdd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--b1_75cbd74c8b9beee31bf8ab7672b19bdd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I think there is missing parentheses in macro USE_NEW_SCHEME, it should be:
#define USE_NEW_SCHEME(i, scheme)      ((i) / 2 =3D=3D (int)(scheme))

causes a fail wiht "device descriptor read/64, error -110" using my usb dri=
ve on vmware using usb 3.0 hub.
from https://github.com/torvalds/linux/commit/25244227158e1502062041365a439=
a54cb8fe673#diff-28615d62e1250eadc353d804f49bc6d6

someone changed USE_NEW_SCHEME, but without parentheses for second paramete=
r. as result. in fuction use_new_scheme when old_scheme_first is 1, use_new=
_scheme will return 1 always(actullay is should return 0). it also make htt=
ps://github.com/torvalds/linux/commit/bd0e6c9614b95352eb31d0207df16dc156c52=
7fa#diff-28615d62e1250eadc353d804f49bc6d6 fails.

I cannot use git send-mail, there some issue with my network provider. patc=
h below, :


From 85f01b89d050a988f4d9fc78232de47e793c6a7c Mon Sep 17 00:00:00 2001
From: atmgnd <atmgnd@outlook.com>
Date: Wed, 1 Jan 2020 21:27:13 +0800
Subject: [PATCH] usb: hub: missing parentheses in USE_NEW_SCHEME

accroding to bd0e6c9#diff-28615d62e1250eadc353d804f49bc6d6, will try old en=
umeration
scheme first for high speed devices. for example, when a high speed device =
pluged in,
line 2720 should expand to 0 at the first time. USE_NEW_SCHEME(0, 0 || 0 ||=
 1) =3D=3D=3D 0.
but it wrongly expand to 1(alway expand to 1 for high speed device), and ch=
ange
USE_NEW_SCHEME to USE_NEW_SCHEME((i) % 2 =3D=3D (int)(scheme)) may be bette=
r ?

Signed-off-by: atmgnd <atmgnd@outlook.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f229ad6952c0..7d17deca7021 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2692,7 +2692,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define SET_ADDRESS_TRIES 2
 #define GET_DESCRIPTOR_TRIES 2
 #define SET_CONFIG_TRIES (2 * (use_both_schemes + 1))
-#define USE_NEW_SCHEME(i, scheme) ((i) / 2 =3D=3D (int)scheme)
+#define USE_NEW_SCHEME(i, scheme) ((i) / 2 =3D=3D (int)(scheme))

 #define HUB_ROOT_RESET_TIME 60 /* times are in msec */
 #define HUB_SHORT_RESET_TIME 10
--
2.17.1

--b1_75cbd74c8b9beee31bf8ab7672b19bdd
Content-Type: text/x-patch; name="0001-usb-hub-missing-parentheses-in-USE_NEW_SCHEME.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-usb-hub-missing-parentheses-in-USE_NEW_SCHEME.patch

RnJvbSA4NWYwMWI4OWQwNTBhOTg4ZjRkOWZjNzgyMzJkZTQ3ZTc5M2M2YTdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhdG1nbmQgPGF0bWduZEBvdXRsb29rLmNvbT4KRGF0ZTogV2Vk
LCAxIEphbiAyMDIwIDIxOjI3OjEzICswODAwClN1YmplY3Q6IFtQQVRDSF0gdXNiOiBodWI6IG1p
c3NpbmcgcGFyZW50aGVzZXMgaW4gVVNFX05FV19TQ0hFTUUKCmFjY3JvZGluZyB0byBiZDBlNmM5
I2RpZmYtMjg2MTVkNjJlMTI1MGVhZGMzNTNkODA0ZjQ5YmM2ZDYsIHdpbGwgdHJ5IG9sZCBlbnVt
ZXJhdGlvbgpzY2hlbWUgZmlyc3QgZm9yIGhpZ2ggc3BlZWQgZGV2aWNlcy4gZm9yIGV4YW1wbGUs
IHdoZW4gYSBoaWdoIHNwZWVkIGRldmljZSBwbHVnZWQgaW4sCmxpbmUgMjcyMCBzaG91bGQgZXhw
YW5kIHRvIDAgYXQgdGhlIGZpcnN0IHRpbWUuIFVTRV9ORVdfU0NIRU1FKDAsIDAgfHwgMCB8fCAx
KSA9PT0gMC4KYnV0IGl0IHdyb25nbHkgZXhwYW5kIHRvIDEoYWx3YXkgZXhwYW5kIHRvIDEgZm9y
IGhpZ2ggc3BlZWQgZGV2aWNlKSwgYW5kIGNoYW5nZQpVU0VfTkVXX1NDSEVNRSB0byBVU0VfTkVX
X1NDSEVNRSgoaSkgJSAyID09IChpbnQpKHNjaGVtZSkpIG1heSBiZSBiZXR0ZXIgPwoKU2lnbmVk
LW9mZi1ieTogYXRtZ25kIDxhdG1nbmRAb3V0bG9vay5jb20+Ci0tLQogZHJpdmVycy91c2IvY29y
ZS9odWIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMgYi9kcml2ZXJzL3VzYi9j
b3JlL2h1Yi5jCmluZGV4IGYyMjlhZDY5NTJjMC4uN2QxN2RlY2E3MDIxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL3VzYi9jb3JlL2h1Yi5jCisrKyBiL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMKQEAgLTI2
OTIsNyArMjY5Miw3IEBAIHN0YXRpYyB1bnNpZ25lZCBodWJfaXNfd3VzYihzdHJ1Y3QgdXNiX2h1
YiAqaHViKQogI2RlZmluZSBTRVRfQUREUkVTU19UUklFUwkyCiAjZGVmaW5lIEdFVF9ERVNDUklQ
VE9SX1RSSUVTCTIKICNkZWZpbmUgU0VUX0NPTkZJR19UUklFUwkoMiAqICh1c2VfYm90aF9zY2hl
bWVzICsgMSkpCi0jZGVmaW5lIFVTRV9ORVdfU0NIRU1FKGksIHNjaGVtZSkJKChpKSAvIDIgPT0g
KGludClzY2hlbWUpCisjZGVmaW5lIFVTRV9ORVdfU0NIRU1FKGksIHNjaGVtZSkJKChpKSAvIDIg
PT0gKGludCkoc2NoZW1lKSkKIAogI2RlZmluZSBIVUJfUk9PVF9SRVNFVF9USU1FCTYwCS8qIHRp
bWVzIGFyZSBpbiBtc2VjICovCiAjZGVmaW5lIEhVQl9TSE9SVF9SRVNFVF9USU1FCTEwCi0tIAoy
LjE3LjEKCg==


--b1_75cbd74c8b9beee31bf8ab7672b19bdd--

