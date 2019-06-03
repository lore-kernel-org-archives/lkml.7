Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B450C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FED276DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfFCN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:56:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34955 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfFCN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:56:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so9443707qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wn1uNmv3vvFv+zJtpYXE95Rt0JSWOUlf6tE7j92Kf54=;
        b=TuwnGVIJxE9vaQP3YoD0NHe8JA5/qGE9O+CsQ42Kmoqavb7Sz4t/37dm1cVUqxz6An
         WL8B3gWUH0QKRtAu4InSh6+gqWdyhfFgEDqtb2FqVfFXpYyPFOTZRlJqVaEmkm3DCoAC
         herkR4mxF15vRLYqu8LNdvoHwK1d2pU648ZbU7XUWLgZtV6op5eurvn3EowDBF3nULT0
         SDYoZi4PpB4SXn3xNZ8ovIyypRgCSFxNsJ2YWYVEsQ2I7iz5TDKKVaYLRRit7bQOU9SM
         iGt6QLRAcOShBroXBhdmZGvNUvA4SBe0HUQgIeJPdMnk+hHH/geH6AOpm3k8hhSn71Hu
         Cyuw==
X-Gm-Message-State: APjAAAXKhdZSU3RVUToVOrFXQ8WOQXuj4MgoJnNz3gJPRF64/CYTx1Fy
        1coIX4uPJixDpmU9KORd8DEiUaYjtpXuKopmhREuxg==
X-Google-Smtp-Source: APXvYqza8Lsq7PQmFx/3Zks4wKoVfumcwfhQr3+EfEfmsKiGXwN0D4pM+2yvo1usEcyGNfjuknthVTRDvKaonTKWyUc=
X-Received: by 2002:a0c:baa7:: with SMTP id x39mr2966231qvf.100.1559570166745;
 Mon, 03 Jun 2019 06:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com> <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com> <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
In-Reply-To: <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 3 Jun 2019 15:55:53 +0200
Message-ID: <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com>
Subject: Re: hid-related 5.2-rc1 boot hang
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Again,
>
> On 03-06-19 11:11, Hans de Goede wrote:
> <snip>
>
> >> not sure about the rest of logitech issues yet) next week.
> >
> > The main problem seems to be the request_module patches. Although I also

Can't we use request_module_nowait() instead, and set a reasonable
timeout that we detect only once to check if userspace is compatible:

In pseudo-code:
if (!request_module_checked) {
  request_module_nowait(name);
  use_request_module = wait_event_timeout(wq,
        first_module_loaded, 10 seconds in jiffies);
  request_module_checked = true;
} else if (use_request_module) {
  request_module(name);
}


> > have 2 reports of problems with hid-logitech-dj driving the 0xc52f product-id,
> > so we may need to drop that product-id from hid-logitech-dj, I'm working on
> > that one...
>
> Besides the modprobe hanging issue, the only other issues all
> (2 reporters) seem to be with 0xc52f receivers. We have a bug
> open for this:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=203619
>
> And I've asked the reporter of the second bug to add his logs
> to that bug.

We should likely just remove c52f from the list of supported devices.
C52f receivers seem to have a different firmware as they are meant to
work with different devices than C534. So I guess it is safer to not
handle those right now and get the code in when it is ready.

Cheers,
Benjamin
