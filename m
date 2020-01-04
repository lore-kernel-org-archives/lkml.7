Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD1DC00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D4021734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 03:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mpDobPHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgADDYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 22:24:14 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:19923 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgADDYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 22:24:14 -0500
Date:   Sat, 04 Jan 2020 03:24:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578108250;
        bh=VdseeMBzHGRC0ODSp5TYUOy1uhNPZvnSaTxlOa+pGws=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=mpDobPHWu5BOFhP/RA1e2bBpIrAPEAL8RWqLHNJCw1OaARVlxyFQz1RnOD+3bRCK0
         RVpcbg4uk4WCET4ZxdK7LPZmWlw23k/q9TSw0Z8NUApaUyZNMIYyJ9GpiuuA6JtkY8
         befq7qvwTZJQVa9wHv3fMbbzThY+VhOvtE70dBhM=
To:     Alan Stern <stern@rowland.harvard.edu>
From:   atmgnd <atmgnd@protonmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Reply-To: atmgnd <atmgnd@protonmail.com>
Subject: Re: Fw: usbcore missing parentheses in USE_NEW_SCHEME
Message-ID: <SHQhnDsmKIpzyLJUY7lJlcdb9DLUPl8gGALB1h82ePlEPUQN9l5cHWxUWyqCcUaMRMGoq6dXRZA3e2gTvG4-HkJDxH994zTiHdeuaKJ6m-c=@protonmail.com>
In-Reply-To: <Pine.LNX.4.44L0.2001021018330.1546-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.2001021018330.1546-100000@iolanthe.rowland.org>
Feedback-ID: py-oVO8Vt0vS1FKaKugS2_MTpFC3lKhHMurhoXPAalWk9Eh40Mo1lZOn2CI1vswSSKJBwBLYgn_VKFu9qW3csg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman:
here is the new patch:


From 85f01b89d050a988f4d9fc78232de47e793c6a7c Mon Sep 17 00:00:00 2001
From: Qi.Zhou <atmgnd@outlook.com>
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

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Qi.Zhou <atmgnd@outlook.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f229ad6952c0..7d17deca7021 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2692,7 +2692,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define SET_ADDRESS_TRIES=092
 #define GET_DESCRIPTOR_TRIES=092
 #define SET_CONFIG_TRIES=09(2 * (use_both_schemes + 1))
-#define USE_NEW_SCHEME(i, scheme)=09((i) / 2 =3D=3D (int)scheme)
+#define USE_NEW_SCHEME(i, scheme)=09((i) / 2 =3D=3D (int)(scheme))

 #define HUB_ROOT_RESET_TIME=0960=09/* times are in msec */
 #define HUB_SHORT_RESET_TIME=0910
--
2.17.1



Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, January 2, 2020 11:22 PM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:

> On Wed, 1 Jan 2020, Randy Dunlap wrote:
>
> > [adding linux-usb mailing list]
> > On 1/1/20 6:46 AM, atmgnd wrote:
> >
> > > I think there is missing parentheses in macro USE_NEW_SCHEME, it shou=
ld be:
> > > #define USE_NEW_SCHEME(i, scheme) ((i) / 2 =3D=3D (int)(scheme))
> > > causes a fail wiht "device descriptor read/64, error -110" using my u=
sb drive on vmware using usb 3.0 hub.
> > > from https://github.com/torvalds/linux/commit/25244227158e15020620413=
65a439a54cb8fe673#diff-28615d62e1250eadc353d804f49bc6d6
> > > someone changed USE_NEW_SCHEME, but without parentheses for second pa=
rameter. as result. in fuction use_new_scheme when old_scheme_first is 1, u=
se_new_scheme will return 1 always(actullay is should return 0). it also ma=
ke https://github.com/torvalds/linux/commit/bd0e6c9614b95352eb31d0207df16dc=
156c527fa#diff-28615d62e1250eadc353d804f49bc6d6 fails.
> > > I cannot use git send-mail, there some issue with my network provider=
. patch below, :
> > > From 85f01b89d050a988f4d9fc78232de47e793c6a7c Mon Sep 17 00:00:00 200=
1
> > > From: atmgnd atmgnd@outlook.com
> > > Date: Wed, 1 Jan 2020 21:27:13 +0800
> > > Subject: [PATCH] usb: hub: missing parentheses in USE_NEW_SCHEME
> > > accroding to bd0e6c9#diff-28615d62e1250eadc353d804f49bc6d6, will try =
old enumeration
> > > scheme first for high speed devices. for example, when a high speed d=
evice pluged in,
> > > line 2720 should expand to 0 at the first time. USE_NEW_SCHEME(0, 0 |=
| 0 || 1) =3D=3D=3D 0.
> > > but it wrongly expand to 1(alway expand to 1 for high speed device), =
and change
> > > USE_NEW_SCHEME to USE_NEW_SCHEME((i) % 2 =3D=3D (int)(scheme)) may be=
 better ?
> > >
> > > Signed-off-by: atmgnd atmgnd@outlook.com
> > >
> > > -----------------------------------------
> > >
> > > drivers/usb/core/hub.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index f229ad6952c0..7d17deca7021 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -2692,7 +2692,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub=
)
> > > #define SET_ADDRESS_TRIES 2
> > > #define GET_DESCRIPTOR_TRIES 2
> > > #define SET_CONFIG_TRIES (2 * (use_both_schemes + 1))
> > > -#define USE_NEW_SCHEME(i, scheme) ((i) / 2 =3D=3D (int)scheme)
> > > +#define USE_NEW_SCHEME(i, scheme) ((i) / 2 =3D=3D (int)(scheme))
> > >
> > > #define HUB_ROOT_RESET_TIME 60 /* times are in msec */
> > > #define HUB_SHORT_RESET_TIME 10
> > >
> > > ---------------------------------------------------------------------=
------------------
> > >
> > > 2.17.1
>
> atmgnd:
>
> Please resend this patch to Greg Kroah-Hartman
> gregkh@linuxfoundation.org with the appropriate CC's. Also, your
> Signed-off-by: line should contain a real name, not an email userid
> (you probably don't use "atmgnd" as your signature on legal
> documents!).
>
> When you resend the patch, you can include:
>
> Acked-by: Alan Stern stern@rowland.harvard.edu
>
> Alan Stern


