Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19272C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D127721872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJnOHrjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDLJhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:37:36 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35597 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfDLJhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:33 -0400
Received: by mail-ua1-f67.google.com with SMTP id a46so3024427uae.2;
        Fri, 12 Apr 2019 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GvmE54vyB2V1TH3b9XcIfl2rFpKkdQtVqNd4bYtbiCw=;
        b=dJnOHrjPYRDcvpIqtkL/Vx7ixEGh6stpJQBfe6bInIfTGw1/UFKXrrc5h3XtStZ+WI
         D4RFBYVZ3Ioa2ti/s94NUIZNnokdaTCkusUEQLFJOTeVOQqUe9xvbYeRNjUR7VoxfYFT
         elHpN7Q5HlMBQkrkte11ZZB9lXce43Ipal188+FUsv7rsS8dFooDDpX3gJ8wp/AgwAUu
         0TCRS7xXv5IEp7Sdcv8C6uMvlJvpV3BOK28/K9W7Hu/9j0/HpzR1Mhgf1AMqm0AOCeDI
         j89/uZlm9yRhy+XB6hWr7kxQf54y0Z/wQDIHp6YQpbglgHk93tMkdFardQMFTFyubXcl
         hXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GvmE54vyB2V1TH3b9XcIfl2rFpKkdQtVqNd4bYtbiCw=;
        b=jiMsWKALDT4Qhk5HRn7TEKmMAo6b8AO1ZVbrD4m/8uWkLemq3lLEnQyGijR8KpPrGv
         +WvtpW7XmpLqUyyihEFnnS+aVkA29dv2Zl3FUUMZaKO/WBmCVg7J3peapPwjDa4B/qdw
         RftzZMJVYBq2d9YU317G6kncGlMPQGpEE/IYQoMLojwVvALJ9ShtyabyVrbQSle4APEl
         QivpyHke1zcFRn1Biz7rvaAMC0isY7HCzvdHr1mEOhoYGbBkJhfN/k5ayx3l6pKSOD+c
         xmvYaaRCLPkuRk0Ui5sEsRywKOLmyAKTEYFJa5dGVe7aIVRCCBAwtFU2A5ASIrhKRpzt
         Nfhw==
X-Gm-Message-State: APjAAAVTSWaHIc8OzhrqKpNCioHsfHkmp/4Fc7dD/E/D7W9F6+je34bq
        FsPhtuanp7duuyPVF2txNoatX15ch7oGtQLJNs8=
X-Google-Smtp-Source: APXvYqwy/aGPPBprRKXvZmdWOFxrVvrjT+0ptLixHM1Ld02+9ohW2hrxc1bvP8ABknl0dIpYXWaDYcejYdUE/nC6Xp0=
X-Received: by 2002:ab0:b90:: with SMTP id c16mr22854602uak.55.1555061852474;
 Fri, 12 Apr 2019 02:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <1555036767-31170-1-git-send-email-92siuyang@gmail.com>
 <878swf645i.fsf@miraculix.mork.no> <CAKgHYH05R2CQ1XmS-KCTtL0J49D2kpnkBgyYxdPc47SNpaf8vA@mail.gmail.com>
 <87mukv4mo6.fsf@miraculix.mork.no>
In-Reply-To: <87mukv4mo6.fsf@miraculix.mork.no>
From:   Yang Xiao <92siuyang@gmail.com>
Date:   Fri, 12 Apr 2019 17:36:48 +0800
Message-ID: <CAKgHYH1=BcnTqwEdmzsiRkyQmuqngCA0YHfbY7M6ObvVbqqj8w@mail.gmail.com>
Subject: Re: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB descriptors
To:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     kbuild-all@01.org, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg@kroah.com, mchehab@kernel.org,
        Kees Cook <keescook@chromium.org>, hans.verkuil@cisco.com,
        Young Xiao <YangX92@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am so sorry. I misunderstood the reason of  CVE-2016-2188.

Sorry again!!!

On Fri, Apr 12, 2019 at 5:07 PM Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
> Yang Xiao <92siuyang@gmail.com> writes:
>
> > If given malicious descritors that spcify 0 for the number of endpoints=
,
> > then there is a null pointer deference when calling function
> > usb_endpoint_is_bulk_in.
> >
> >        for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
>
> Try this:
>
> #include <stdio.h>
> int main()
> {
>         int i;
>         for (i=3D0; i<0; ++i)
>                 printf("%d\n");
>         return 0;
> }
>
> How many lines did it print?
>
>
> Bj=C3=B8rn
