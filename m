Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC2C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD842067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfHMOgN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:36:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43538 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfHMOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:36:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so15523180qkd.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZjanPZgBBEyPxWCrNvo0+y8QHT418sTUREN8w8Bqq60=;
        b=bPD9ni2PnGozJhSf+I9FLzQTX6UKgRIO2y7UxUQgH0+B8OOymsQ+X8ze/9ZIsoHQen
         jmWVCEwHOwKxJ476hYFv8uqmqcXdhuOUoPR38467DixM2aXdKg/yYVAwzTJrWmh5yQh0
         QMCXhnvUx8HlhK5U1aP+t0l75nyGqnQGC6NU9bKHBBvaIVl7A+SFmJmeunx8rWwwBRdJ
         fmuVSRmleDdR3uzuKyl/JypoRVZkrCq9Pdk5WSWTkHZKHhe1sBbtlR4khcJg1muD0iYv
         O/5vkJWs3RF8Sl89w2m5y8Fo8kaQe07Oj81lcmOlLKUpxFZ0DEcZr5iP+1VGNDbg0Ax2
         jRLw==
X-Gm-Message-State: APjAAAUEQY0peeUilgtJyOKLW8ioet7jCutETN/zljWZWPPc3i5+kdqM
        bo3IzEZDOn6g5W+gHi74sIP981f8CUOhNuNyfr3JNw==
X-Google-Smtp-Source: APXvYqzRol019NvPSrNTT/VjJtyRE4DhuaWy8x//z/XoJpF7W6l814UutHYRA0WSSHYSqXPbS+8qa/qvhBuu0aJxris=
X-Received: by 2002:a37:9bce:: with SMTP id d197mr22500298qke.230.1565706972142;
 Tue, 13 Aug 2019 07:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190813133807.12384-1-benjamin.tissoires@redhat.com> <d558b953e88558b8d7955e591fefbe898edeb3ae.camel@archlinux.org>
In-Reply-To: <d558b953e88558b8d7955e591fefbe898edeb3ae.camel@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 13 Aug 2019 16:36:01 +0200
Message-ID: <CAO-hwJL+u+ELM4W5hwzGmh-sDO33wk1yxjqoqf9wz=qn88ROsg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix support of a few Logitech devices broken in 5.3
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 4:21 PM Filipe Laíns <lains@archlinux.org> wrote:
>
> On Tue, 2019-08-13 at 15:38 +0200, Benjamin Tissoires wrote:
> > Hi Jiri,
> >
> > another set of patches to send to Linus ASAP.
> > It turns out that we have been breaking devices, so this should
> > be sent before 5.3 final.
> >
> > Cheers,
> > Benjamin
> >
> > Benjamin Tissoires (2):
> >   Revert "HID: logitech-hidpp: add USB PID for a few more supported
> >     mice"
> >   HID: logitech-hidpp: remove support for the G700 over USB
> >
> >  drivers/hid/hid-logitech-hidpp.c | 22 ----------------------
> >  1 file changed, 22 deletions(-)
> >
>
> Reviewed-by: Filipe Laíns <lains@archlinux.org>

Thanks.

I have schedule those 2 patches into for-5.3/upstream-fixes.

Cheers,
Benjamin
