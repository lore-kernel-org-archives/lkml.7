Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376ACC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68662086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzCgYFPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfI2GgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 02:36:24 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:42514 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfI2GgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 02:36:23 -0400
Received: by mail-io1-f52.google.com with SMTP id n197so28948232iod.9;
        Sat, 28 Sep 2019 23:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iDVkqOh00Gu1t88eatQYlGFJCHixlykrMMQFxTtFYFg=;
        b=hzCgYFPKvBEobLhYvXZR5S1mo8QeleXmppOkCtehseCbc1OlH7MJ03a2NG7gZMQiN/
         k+0oHQ8qtK/S/G3k1a/S5cbVjbc8ygpOBurC4y6GP60ZIHBxTavZes1LRG6HPj5PVv/b
         RscP/OyvKVsgerpFXMhWsAxDS+TOOJuWssBoV19c64Yi9XyD0zkNCBRQVSC5D0+maYnc
         f8U7XSWQBbwGp6OVgHw7KuDiEtDkTu9wFVQiHilO0dYQcs+w/8hFDXRawiBGbJWMNg27
         oWdmAIu2VSzA8IfCkb9jWbWHV/G6ND3PIvVpCDwhe8kH2cmsHtWxi6UmFvNZVHdZm/HA
         vf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iDVkqOh00Gu1t88eatQYlGFJCHixlykrMMQFxTtFYFg=;
        b=UA9NjPhtBap6zIMZwIHxAEnI8aAbYye/GF5A0Ed7UN+nSuWiepNc69im58e6Hmmxb4
         zlDVYekh0CG+Psx3LkhShT6psUegSGt1G03JqEvBoBAM/R8k0rPG/Voj46yviza1PInG
         f+mggPr5VXTzDJUR9oLZGZO9q0SAd9qPGEr5MTbYcZdjGRww9WX13UZ/kFreRJ2ZCXvG
         AwUTlqlqt4zweb83irBEh39mhRy/9tsKDENoDMLr15/fOgrXhLHml28ogEQ29JCf8zji
         0s7kO3a1etMA5foCxxKl9brpmKjpgwpecJdemStZ/P57CVg5sDoPtV4D/Mx0zjyFMD7u
         cZVg==
X-Gm-Message-State: APjAAAWMbLPw0snwSq5aygVfzrd3x0qFUgWVC06Ikv3qE6QqNxnoZ4C7
        W8dYh5zmlxQ6hNfulN7yMFgpIJHbmS4b9cngmv8=
X-Google-Smtp-Source: APXvYqy7MnzpDoWCaQwB4PVeuO6/SdKp4zr9nmvtloH/bmgSv21Yw0NytNjVHSKVzZiGItMZTkbjQ/kKAKDwzoaYdW0=
X-Received: by 2002:a5d:91d1:: with SMTP id k17mr8907186ior.237.1569738982780;
 Sat, 28 Sep 2019 23:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <DB8PR04MB682649CA98B0704FAF037A40F1840@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <Pine.LNX.4.44L0.1909271305030.4732-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909271305030.4732-100000@iolanthe.rowland.org>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Sun, 29 Sep 2019 14:36:10 +0800
Message-ID: <CAL411-o-dRJ+fQTxXhVBzwdd0L6B26B_75+DKxUaLziwLkuCtg@mail.gmail.com>
Subject: Re: [PATCH] usb: hub add filter for device with specific VID&PID
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 1:11 AM Alan Stern <stern@rowland.harvard.edu> wrot=
e:
>
> On Tue, 24 Sep 2019, Ran Wang wrote:
>
> > Hi Greg,
> >
> > On Monday, September 23, 2019 19:07, Greg Kroah-Hartman wrote:
> > >
> > > On Mon, Sep 23, 2019 at 06:51:02PM +0800, Ran Wang wrote:
> > > > USB 2.0 Embedded Host PET Automated Test (CH6) 6.7.23 A-UUT
> > > > "Unsupported Device" Message require to stop enumerating device wit=
h
> > > > VID=3D0x1a0a PID=3D0x0201 and pop message to declare this device is=
 not
> > > supported.
> > >
> > > Why is this a requirement?
> >
> > This comes from <USB On-The-Go and Embedded Host Automated Compliance P=
lan
> > for the On-The-Go& Embedded Host Supplement Revision2.0>
>
> How much do we care about our support for USB OTG?  Isn't it dying off?
>

Hi Alan,

The OTG Compliance is really dead, but for non-PC host product, if we
would like to
pass USB certification, it needs to pass EH compliance test. Before
going to Lab,
the vendor will fill Compliance Checklist, it could declare HNP, SRP
and ADP are not
supported, then the PET test will bypass related test items.

Peter

> > Below is related description I quote from it:
> > 6.7.23 A-UUT "Unsupported Device" Message
> > Purpose: This test verifies that an A-UUT produces a device non-support=
ed error message
> >       when a device it doesn't recognize, and does not support HNP, con=
nects to it.
> > Applies to: All Targeted Hosts
> > Description: Get VBUS turned on, and connect to the A-UUT. Get enumerat=
ed and respond
> >       as an unknown device not supporting HNP. Check that a suitable er=
ror message is generated.
> > Pass Criteria: Message "Unsupported Device"or similar is displayed on U=
UT
> >
> > 6.7.23.1 Test Procedure
> > 1. Start with cable still attached, PET applying 10=C3=ACF capacitance =
and 10k=C3=99 pull-down
> >     resistance between VBUS and ground, data lines not pulled up.
> > 2. Get VBUS turned on, using the method described in Section6.7.1.
> > 3. Wait for almost TB_SVLD_BCON max (1s - 0.1s =3D 0.9s) from VBUS reac=
hing VOTG_SESS_VLD max.
> > 4. Connect PET using D+ pull-up.
> > 5. Allow A-UUT to enumerate PET, responding with a VID / PID combinatio=
n not on the TPL
> >     of the UUT and also with the OTG descriptor stating that it does no=
t support HNP.
> > 6. Start 30s timer when Device Descriptor is read.
> > 7. Display Message "Click OK if 'Unsupported Device' indication display=
ed on UUT".
> > 8. If operator clicks OK before 30s timer expires, then UUT passes test=
.
> > 9. If 30selapses first, then UUT fails test.
> > 10. PET disconnects by removing any termination on the data lines, but =
leaves a capacitance of
> >     10=C3=ACF and a pull-down resistance of 10k=C3=99 connected across =
VBUS.
> > 11. Wait 2s to allow disconnection to be detected.
> > End of Test.
>
> In fact, the system should respond the same way to any unrecognized
> device that doesn't support HNP, right?  There's nothing special about
> these VID/PID values.
>
> > > And why those specific vid/pid values?  What do they refer to?
> >
> > For step 5, we got the VID / PID number from USB IF certified lab(Allio=
n.inc at Taiwang). Looks like
> > this is a reserved ID pair and will not be allocated to any vendor for =
their products. So it's hence used for this
> > case test (like saying: you should be able to pop a not-support message=
 for this reserved VID&PID).
>
> Don't we do this already?
>
> Alan Stern
>
