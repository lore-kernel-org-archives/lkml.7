Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F7CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B70C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky3ORpha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKLPSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:18:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbfKLPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573571886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZ/w3v+fPJjhA64sYOvAJQuD2CMUO2/OwSEb5d125yo=;
        b=Ky3ORpha/scxSYq7RqAcrc9y42QHgs1smT0z4yMSPPz0yQF0ZSLHmmG8KkjJxY/kezYe4F
        KjGq4XLtxZ1eKH4se3MOnmcXOWG2yd2YNxiY6v2IIB8hQ2VrL2IkQd6f5XGAlYxEjkw+Om
        2kK7bzXqSwrAU+jOR93kfHm+zSy7blM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-KZYLgQepPK6ipXQI-p5rfA-1; Tue, 12 Nov 2019 10:18:03 -0500
Received: by mail-qk1-f199.google.com with SMTP id p68so10406941qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZ/w3v+fPJjhA64sYOvAJQuD2CMUO2/OwSEb5d125yo=;
        b=MkiRyCqSshgmfVb46HF3S+n4Ta1jy2ICzYUCDXw2MNwoT2gioyM3piEKanWWt3SK5m
         +mk3Ntpm8OYk3slBfFpN1q9sxmPZ1iE1+dfjpGqiFsZk97HJx7ulmlzMx54a9RsfnvAA
         Rdm4PsyDsgxoaOP8CHDYjZd5JaSErhKgpRsfadVOxRtf4zs7h5ViDq8YIMt1Pc0pPki4
         JVuo4irIRuLcJnnWK93dWFBk7Jw7yfxjzEb2AVoYgfRuif2mMp4GjulX+ODLPbnU5gOs
         4mlZP23JtNlN6nPJ4RMj/u1R8Pa784caQd5WS6FNpKailtQRQ01jkhXsbHdrDQdM8MsZ
         wVUQ==
X-Gm-Message-State: APjAAAXJs5qKIqnCz579kjhvo8VWAcni6LOsmszr1663PcVQFRRUun7e
        XesvYzN7Pd3+5trrK5rNpwg6z+6kJwLbYtR0+42eis4HyFEOWFUmWuILdLckp3bX0EKEjTQZQ+0
        83zzF63JkDkBRV2FTlTyzGvQ6K48h0rUJBxbTBkKx
X-Received: by 2002:aed:36a1:: with SMTP id f30mr31845819qtb.154.1573571883379;
        Tue, 12 Nov 2019 07:18:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7AbbV1sBdcbkwhkfsRZEBGRTP+DLdA6rmDz1e1+QvpJX8xRc4WuS8rs8usu0+cQAGd2L1t3PkGc0c/ma7Qx8=
X-Received: by 2002:aed:36a1:: with SMTP id f30mr31845786qtb.154.1573571883103;
 Tue, 12 Nov 2019 07:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20191022142139.16789-1-candlesea@gmail.com> <nycvar.YFH.7.76.1911121457050.1799@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1911121457050.1799@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 12 Nov 2019 16:17:51 +0100
Message-ID: <CAO-hwJKO5u6xUrBe_ne0OqFAHM9dpwtTOWtYW+3z-LxSFT6VWQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: core: check whether Usage Page item is after
 Usage ID items
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Candle Sun <candlesea@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        =?UTF-8?B?57+f5LqsIChPcnNvbiBaaGFpKQ==?= <orson.zhai@unisoc.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
X-MC-Unique: KZYLgQepPK6ipXQI-p5rfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Nov 12, 2019 at 2:57 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 22 Oct 2019, Candle Sun wrote:
>
> > From: Candle Sun <candle.sun@unisoc.com>
> >
> > Upstream commit 58e75155009c ("HID: core: move Usage Page concatenation
> > to Main item") adds support for Usage Page item after Usage ID items
> > (such as keyboards manufactured by Primax).
> [ ... snip ... ]
>
> Benjamin,
>
> are you planning to run this through your testsuite against regressions?
>
> I believe that's the last missing step, otherwise I'd be fine merging
> this.

Sorry I had to deal with family issues 2 weeks ago, and now RHEL is
coming back at me and eating all my time.

The kernel patch is now OK, so we can grab it now (either you take it
Jiri, and add my acked-by or I'll push it later...)

Candle, can you rework
https://gitlab.freedesktop.org/libevdev/hid-tools/merge_requests/58 so
that it mirrors the kernel code (and get rid of the
self.local.usage_page_last logic)?

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

