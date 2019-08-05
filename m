Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74699C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501CD20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfHEJ1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:27:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37695 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHEJ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:27:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so59515665qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6HFt7/ogxvWwkBGiqBB2NtK9/Gsq8ZSmOkSTfTrSYA=;
        b=R5UNnh4QCNZ0ZqF6BZypLJplbceQfSdzmomS0e3iiTVYkAF0olHgGHFJ82QkrE4laX
         wBLBl5pDGnhHb2YtWXEp2ciXou00XiMyugsifwLNSuPNeFwAMuKzsXcUD1FwvjH9E/x1
         HNxFhHbTIn07NoteQjc6ys+BgnOTSlY/qPe1zPyTfAS/poxhMoeisPNuRIRAmrQg5kTG
         GJTYWgj9YX4Otd1qSKVNfCVMx478mZGFQslvcTUe75wZ43xRN17GLiICAg+Vm6LXOz7d
         3OLLNy7saCgABlz32Yv5veLqkexk11PQZ2JErj8eRzCoCRAPFKKzCej222SJYOThEVrM
         rQ+g==
X-Gm-Message-State: APjAAAW3tb0/wXo9IGOXQcODsloqAEQ28+eyFw4pZGZLCKV7aoXGbfVG
        eg14WberVh39YN0GkPFXwJQ8lLauxMlkvksrK0Uzew==
X-Google-Smtp-Source: APXvYqxqFujP0fyuTrXmLkK2GtWmNxOQfQxffpWW5LxviarCAcn3TPM1FuK26yNLsh8Tr3sHXvlT55jiyB/3Pwdu2GE=
X-Received: by 2002:a37:dcc7:: with SMTP id v190mr53456085qki.169.1564997243999;
 Mon, 05 Aug 2019 02:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190725145719.8344-1-yuehaibing@huawei.com> <20190731105927.GA5092@dell5510>
 <20190731110629.GB5092@dell5510> <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
 <nycvar.YFH.7.76.1908051051080.5899@cbobk.fhfr.pm> <7988688e-8020-3d03-63cd-d844c01e5bf6@redhat.com>
In-Reply-To: <7988688e-8020-3d03-63cd-d844c01e5bf6@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 5 Aug 2019 11:27:12 +0200
Message-ID: <CAO-hwJLstTVmr7+sTXYAjO8H4K00emBdUhRgU1FWD6TpBOSUrg@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-dj: Fix check of logi_dj_recv_query_paired_devices()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Petr Vorel <pvorel@suse.cz>,
        YueHaibing <yuehaibing@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Aug 5, 2019 at 10:55 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Jiri,
>
> On 05-08-19 10:51, Jiri Kosina wrote:
> > On Wed, 31 Jul 2019, Hans de Goede wrote:
> >
> >>>>> In delayedwork_callback(), logi_dj_recv_query_paired_devices
> >>>>> may return positive value while success now, so check it
> >>>>> correctly.
> >>>
> >>>>> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of
> >>>>> Fixes: logi_dj_recv_query_hidpp_devices")
> >>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >>> OK, not only it didn't fix problems with logitech mouse (see below),
> >>> but removing mouses USB dongle effectively crashes kernel, so this one
> >>> probably
> >>> shouldn't be applied :).
> >>>
> >>> [  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with
> >>> error 7
> >>> [  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback:
> >>> logi_dj_recv_query_paired_devices error: 7
> >>
> >> Please test my patch titled: "HID: logitech-dj: Really fix return value of
> >> logi_dj_recv_query_hidpp_devices"
> >> which should fix this.
> >
> > Hans, have I been CCed on that patch? I don't seem to see it in in inbox.
>
> I have "Jiri Kosina <jikos@kernel.org>" in the To: for the patch in the
> copy in my Inbox (I always Cc myself).
>
> Anyways, you can grab it here:
>
> https://patchwork.kernel.org/patch/11064087/
>
> It has gathered 2 Tested-by-s and 2 Reviewed-by-s since posting, so
> assuming you like it too, this is ready for merging.
>

Sorry for being silent on the mailing list.

I have been 2 weeks on PTO, and when I came back, my server that shown
a few corruptions here and there was completely broken.
I spent the last week trying to revive it until I realized that I have
a bad memory chip on it, which introduced random errors.

Anyway, I think Hans' patch should go in, but I am not fully
operational given that my test box is still recovering :(

Cheers,
Benjamin
