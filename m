Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C554CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E579720684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFxnT8dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408566AbfJXH0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:26:48 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45742 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407153AbfJXH0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:26:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id l5so4272560vsh.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUomV4NKm5feOyCKiprxveYg7vZ2wgnhBDMrhdx0nIM=;
        b=gFxnT8dlqP/lGdkch6//3BBHhDqglBib2whMUWpVJIsROUsP/77APdKqriRJS4XLqO
         wTly8BXNtStUR9+6C5V53UmJYaetuKzvVDlcAZfP8YT7khCQF39z5CLCQHMx2GGh5nE1
         mo2H/EQJfk4EK4waMt4diiJ/ktNT3r3j5QRgR2m60hVISxyk1by28DIQ+qlQONl5l4CY
         9ly2ruACmk3o/dBszYvHsBT7x4mhiiK9LpUVglrkROKB5OEhPexb7XpklT8cvsZS7eVd
         58/Hp9cCqvEnPfHaJXm/rjO0Sr02rWKA2oqT+AAo/DqjyiDunc8owynk6zEhr506rIV+
         p4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUomV4NKm5feOyCKiprxveYg7vZ2wgnhBDMrhdx0nIM=;
        b=BhgeYodCt1VUsGXi7BgbJAV8WnMVWp5Zg5PGk5iyHQlEbhFFNYYnh2EFp8dOrH6/09
         JNJSOUkYeOyLKsi4TQEUFQArbFQ2bqZC6ofrMmX+nMfsy6dI2jUXkZcHM2jsVsXU1IrI
         telZwUZ3FhlkRRzEx7fpeRjtPXdeB7S2KbieHoReDdjTtsNL2Kn/lTTcm2knEERvSsW0
         FSAF3WGeL32OsSPDVC8RAm0u+t6sWRAD2HZEReQondWEJsjxWsweAAtXnIsfKFeoDR1L
         i2ktrSrolJUx6MXc92u1qpBuMG7XH3XLyhNcmk0KPvXGKQHKhqfa+2kqWmupfk95hl8K
         HYHg==
X-Gm-Message-State: APjAAAXCXychnx9YeDZsnloxJKXOHL1tk5y8Uq7Cn8356nuZDszebhsP
        C4g9NtxKdf3qL98snL6Mh31qptQDzl4amqg6f2r6Dw==
X-Google-Smtp-Source: APXvYqxN+aIO2XD2M6+HQH0XizWdoSREtq9zxsin6Retg4BsRB4/GR2sJ0UQYx2Zrj041naS7bM1ORU/wvdUB3uw180=
X-Received: by 2002:a05:6102:505:: with SMTP id l5mr8122513vsa.9.1571902005508;
 Thu, 24 Oct 2019 00:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191022102334.67e5d3d1@canb.auug.org.au> <CAP245DXChLoSUkj49FrYq4HVkcP2pS8=qamWDDUNOg7aygDwpA@mail.gmail.com>
 <20191022221406.298ccd6a@canb.auug.org.au>
In-Reply-To: <20191022221406.298ccd6a@canb.auug.org.au>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 24 Oct 2019 12:56:34 +0530
Message-ID: <CAHLCerOkeOEEUgtJ=YgDKKXDiyFXHQ4LBdzg3-3VtKvpyceqFg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the thermal tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a929510595a2f4b9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a929510595a2f4b9
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

On Tue, Oct 22, 2019 at 4:48 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Amit,
>
> On Tue, 22 Oct 2019 15:20:00 +0530 Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > What compiler version do you use? Any additional flags to make? I'm
> > not seeing this, even with W=1.
>
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909
>
> No special flags to make.

So this warning only shows up with gcc 9.x. I was using 8.x from my
distro. Will upgrade.

I believe the "fix" is to simply initialize the three variables to
zero (See attached diff). I'll squash that into the patch unless
someone disagrees.

In practice though, we depend on the enum tsens_irq_type irq_type
function parameter to throw a compilation error if we use anything not
defined in the enum. That is also the reason we removed the 'default'
case during review - we should never end up with an undefined value at
runtime.

Regards,
Amit

--000000000000a929510595a2f4b9
Content-Type: text/x-patch; charset="US-ASCII"; name="variable_init.patch"
Content-Disposition: attachment; filename="variable_init.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k24doiz50>
X-Attachment-Id: f_k24doiz50

ZGlmZiAtLWdpdCBpL2RyaXZlcnMvdGhlcm1hbC9xY29tL3RzZW5zLWNvbW1vbi5jIHcvZHJpdmVy
cy90aGVybWFsL3Fjb20vdHNlbnMtY29tbW9uLmMKaW5kZXggMDNiZjFiODEzM2VhYy4uNDM1OWE0
MjQ3YWMzMSAxMDA2NDQKLS0tIGkvZHJpdmVycy90aGVybWFsL3Fjb20vdHNlbnMtY29tbW9uLmMK
KysrIHcvZHJpdmVycy90aGVybWFsL3Fjb20vdHNlbnMtY29tbW9uLmMKQEAgLTE4MCw3ICsxODAs
NyBAQCBzdGF0aWMgaW5saW5lIGVudW0gdHNlbnNfdmVyIHRzZW5zX3ZlcnNpb24oc3RydWN0IHRz
ZW5zX3ByaXYgKnByaXYpCiBzdGF0aWMgdm9pZCB0c2Vuc19zZXRfaW50ZXJydXB0X3YxKHN0cnVj
dCB0c2Vuc19wcml2ICpwcml2LCB1MzIgaHdfaWQsCiAJCQkJICAgZW51bSB0c2Vuc19pcnFfdHlw
ZSBpcnFfdHlwZSwgYm9vbCBlbmFibGUpCiB7Ci0JdTMyIGluZGV4OworCXUzMiBpbmRleCA9IDA7
CiAKIAlzd2l0Y2ggKGlycV90eXBlKSB7CiAJY2FzZSBVUFBFUjoKQEAgLTE5Niw3ICsxOTYsNyBA
QCBzdGF0aWMgdm9pZCB0c2Vuc19zZXRfaW50ZXJydXB0X3YxKHN0cnVjdCB0c2Vuc19wcml2ICpw
cml2LCB1MzIgaHdfaWQsCiBzdGF0aWMgdm9pZCB0c2Vuc19zZXRfaW50ZXJydXB0X3YyKHN0cnVj
dCB0c2Vuc19wcml2ICpwcml2LCB1MzIgaHdfaWQsCiAJCQkJICAgZW51bSB0c2Vuc19pcnFfdHlw
ZSBpcnFfdHlwZSwgYm9vbCBlbmFibGUpCiB7Ci0JdTMyIGluZGV4X21hc2ssIGluZGV4X2NsZWFy
OworCXUzMiBpbmRleF9tYXNrID0gMCwgaW5kZXhfY2xlYXIgPSAwOwogCiAJLyoKIAkgKiBUbyBl
bmFibGUgdGhlIGludGVycnVwdCBmbGFnIGZvciBhIHNlbnNvcjoK
--000000000000a929510595a2f4b9--
