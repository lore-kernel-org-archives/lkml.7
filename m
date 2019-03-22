Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D72AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613CD2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcRuptdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfCVSeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:34:17 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34532 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfCVSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:34:17 -0400
Received: by mail-ot1-f49.google.com with SMTP id k21so1421531otf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vf49OeERdQZzLTNAyzVNtnlEUmUWMjlGpg5qQXBpOlw=;
        b=AcRuptdNYZihyosyhHbW/L6TBOLg1z7w30jp4r1jMoMbg0539zAkxZUXUoTGWYlGBz
         SUQr1LrZ5lIGeVe+2vL55KBi3SetofcNTPKxf6O49kI2ErVyokjaNimsa2qhUoVYGZt4
         d5mHkG/ZcbgqAiyi4zNCt4OSWo3/tYoDeu9J5dc79JbcWL2X2jte7raufaajM+JRCmZ5
         MCKczhfahMICTmMHv5dy2xPXZ/e3un8C3hErM2Gl7nVWKd30DSW5j4Hy5XAWf4wF0zSN
         UHwM/NFIaU9qintByVSrrrfvcLKhU6BBYS/cyIeIIv/maZ4NNbaczZQR9QhRj1pWJDso
         1sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vf49OeERdQZzLTNAyzVNtnlEUmUWMjlGpg5qQXBpOlw=;
        b=FRe5g96BdwqOzeqYCzOM0gV68svLkgOd62JmtOTOiHuU80qt0ELl0GdG7X7WAMMVHB
         +bU1OmsTlKsbLp0sRBlBdcHl8aAArYBiPielWvQBPcAZzeGZpDFwzKaKcV67C4VdhaOM
         rbejv4CD+3WV30OFCNTHVNfqZW4h5QVWh2f8TbKmx0rCy1Bb4cRgM5y7O2/b2c6mXfTy
         uG7SyhpdcS/tr/Fj6ZlnOiEBDxrJyCN77RxhiKEGTuXt8QAqBSBDEbUKu96jwddWgnkj
         wAcsKzijbNI6ry8+J7b9jKRuteDB6CDORCpCKUBHekFUwik1PrkfmMNgIUgj5uNPhOzy
         tX5w==
X-Gm-Message-State: APjAAAWVpCPdgIh6fR36MtALWudA1YSlUQ2+ePEPVHhsfcTwLVj6DgoV
        eeY4Aqo1J6SqArdV8007NkeiDvPEzuBWl4a9+18=
X-Google-Smtp-Source: APXvYqxo3/2fy+Yp/DfebnehvxPg5RrBrswAYUg0zPPerNjgDz4mFf6a7ScMHD/x/L0Cu8248fO7zqV9kFNHf4cp5PU=
X-Received: by 2002:a9d:694c:: with SMTP id p12mr6443227oto.242.1553279656781;
 Fri, 22 Mar 2019 11:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190320200702.GA27111@avx2>
In-Reply-To: <20190320200702.GA27111@avx2>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Fri, 22 Mar 2019 14:04:35 +0000
Message-ID: <CAMkWEXPsikD8uvMSxQH=RUx-qPHO1UBtKgXsg=p9hY_bD2u2ow@mail.gmail.com>
Subject: Re: pidfd design
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 8:08 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> pidfd code should be backed out immediately. Forget about /proc.

Seems like Torvalds just merges this sort of "stuff" without reading
it now, or there's something that auto accepted pull request to RC tree?

> The pull request you sent on Tue,  5 Mar 2019 18:13:01 +0100:
>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git tags/pidfd-v5.1-rc1
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/a9dce6679d736cb3d612af39bab9f31f8db66f9b
>
>Thank you!
