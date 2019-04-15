Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44073C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075902073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9QBifhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfDONvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:51:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40160 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDONvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:51:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id x12so19116003qts.7;
        Mon, 15 Apr 2019 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSPnncDo1mFhEN6ABkYMgGVlfBcYMv1E23QjBIfu+ew=;
        b=Z9QBifhjz4WriAMttFkMM5nKPVYrZ7xAogJsqIkYXcMENQcwOi7DybaUksFDTezdfQ
         9y5VVh08Zqf//t0jzjcDFde3cLYvNxOuqdw+4toCmD5QhhcQz41lsKANhlVWWsWxbyVK
         1RcPQsu6r5ggAM7E3wHGBTuB+qnR+BbcM3QlyO6iIhLjshPvFrepOsHMZjl9fEwSU1Vl
         rHzgihrAbXdrvfabfuEQsjxeQq8ujJB5n5c9bZgBaCTYii8uRhQDHU9+bufCC1KeBFkQ
         KnujjymNjSqyG2dZNCqbsXp4Yd5R4/8mm3u0NLCsah3rXF8NtKuYTxt1ypIlyc1MufLE
         PMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSPnncDo1mFhEN6ABkYMgGVlfBcYMv1E23QjBIfu+ew=;
        b=pI/WxRGkEQO5xfj9utyS7bsTiJnQxTHoQcjFmhflJL4hbBfe2T3KuBJ7I6azRqXtp+
         2RNemyH1fdk7qeDNlX3x4TqdcYfvl/dwXOKcU5Z3Iwtr5cN9s494kNS8gniBnafcf5bc
         dqCg0VGJcVjiNJKFSzj7d1cbGkzD/HvLPqrHYm9I1W4bmNCrvOKY9sojMa1c8CJNYyb+
         iuOS+hfFcgmztms09icckrFLuDhHVEBwBtFH8onZugjrMzne7/nhVf6oyJVKjX3cE7PL
         q8WZcFTGqNpPo/sTHTqAMuossI7z9PENI9WGVpxri53SVOvlrYQrceAHEOfVxMsju3sa
         DpcQ==
X-Gm-Message-State: APjAAAW0QBGFSpJWQrFe7ggatYLUsxVc/iXfgEhGmyaF9QOtoO3ofzSS
        204ZlQZ5xLmAzfZa/vL+Ns5rfYL/Wh41tRZZ6Oo=
X-Google-Smtp-Source: APXvYqxCmW3ic1Y154tvtrZmiT+soQfL2GjbQQ0W6NS/iLodsgT4QrkhF7lfF2FyUXOfCHgmzgyMgyqzGHKfdgATkbw=
X-Received: by 2002:a0c:9599:: with SMTP id s25mr60082491qvs.119.1555336265322;
 Mon, 15 Apr 2019 06:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <1553183239-13253-1-git-send-email-fabien.dessenne@st.com>
 <1553183239-13253-3-git-send-email-fabien.dessenne@st.com>
 <CAH2Cfb8K5hB=UeMOeTEXud1XZVp12Qbw9NYoxJ0XQK4FFuF3wQ@mail.gmail.com>
 <4857555a-812d-0b96-9a70-2984ffb50ca9@st.com> <CAH2Cfb8NzsOZDt8zBypY9ZiD6oOFWUBkZoPpKfU97ZRF_O0z+A@mail.gmail.com>
 <770c71bc-f387-62b6-f799-07ba6446e7e8@st.com> <CAH2Cfb87Wacgsh=xz9h9kgwYgBkxNBDbcDJ4W3uPs2LiKbTD9A@mail.gmail.com>
 <760819dc-4c26-b492-a0ba-8b27c189d5b1@st.com> <CAH2Cfb-EvWeP28W=Hqzvwaue55hBFCMecqvt3p8mRh52BZMdNg@mail.gmail.com>
 <596f9e4d-2db1-8040-211b-173ad19d9d0e@st.com> <CAH2Cfb87+MR5SNmm2zQU+44mV+3gTv4M2moFxQDXhEGHO00W+A@mail.gmail.com>
 <45511e33-df29-1a3c-66a1-151dc42bf10d@st.com> <CAH2Cfb9vJG=ujkB9G7P6OmgRZQUiKoH6DGfOu4NuwB+cnXOs1A@mail.gmail.com>
 <6351cde2-7470-40f5-9f3a-c872cb193e50@st.com> <0c1d34df-7aeb-648b-b118-cf608e6ba636@metux.net>
In-Reply-To: <0c1d34df-7aeb-648b-b118-cf608e6ba636@metux.net>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Mon, 15 Apr 2019 21:50:54 +0800
Message-ID: <CAH2Cfb-FHAQQcxOfvmD5VYxd6vKK1iCqN2oW5YLr80tCtCx=xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: add rpmsg driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:14 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 12.04.19 18:00, Arnaud Pouliquen wrote:
>
> Hi folks,
>
> <snip>
>
> Haven't followed the whole thread, but I've got the impression that the
> device is emulating an uart - if that's the case wouldn't it be better
> to implement a serial driver, instead of tty directly (which IMHO should
> make it also usable for serbus-based devices) ?

It's more natural to implement rpmsg uart on top of tty core instead
of serial layer, since:
1.Serial layer model the hardware which can just send the data one by one
2.But rpmsg could send a buffer(max 512B) in one packet
On the other hand, it's very easy to support serbus by replace
tty_port_register_device_attr to tty_port_register_device_attr_serdev.

>
>
> --mtx
>
> --
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
