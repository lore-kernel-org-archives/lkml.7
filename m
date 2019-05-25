Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C927C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060F920863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEw+jbrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfEYN23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 09:28:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34903 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfEYN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 09:28:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id n14so11177415otk.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qj1HvIOBrDiTk1oOhNlE+ryU/65VrTB2Fp4BYdFFTY=;
        b=OEw+jbrAZtZ91LNARltGnB0Ee8aP0JV8ce+cfRyKDZWvmimQWWRSIB/eFSiPqWH/qJ
         KNCI9k3RURHl8m7qbIKe/1XI/6n/Qqs9BRNN9a9UURS8+LN2OtDDXiqGTPvCCq0gpyR7
         h0quJgTZUo1OA/D/ALJcGigWfKLCMysuHHcEWaKRvb7e87TbK9bIMcYvY8igZYmaZXto
         rdYdqmcDqq1NOtDYcNAnbZY17/jjEgCYoi26qeAzQK2WVWbMB5FW/F4UgncBw9mob74M
         DxI1I48cZg5zsxCuAqtzkXKWadGHFoxdT+eOn1iF2WC+dqnmp/WXabrwshj8oawa1oOY
         ItOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qj1HvIOBrDiTk1oOhNlE+ryU/65VrTB2Fp4BYdFFTY=;
        b=GCEMq98KoOrQH6AI+hnO5ebXjeabFvkjk2AHd+edLZyxC2xH7gpIAQHHyWGuybuB+v
         7JWM/gPk0pvsoZu+DtL7cO92gm4so26QUxqGDHXrnR9C4Ww+cAPHglhvkeIT8meHEQd9
         ISuacIQFz9sO4ni7MJzuQGvkP7Bo7MxP3xwZCLiugrnhuP1mTtB85iW3KHi48dwwveq6
         DMadZeB9iyRmQP5ZQ4Ag9pzsESS4qcP1jGdfM/b670HMB9wzNtZ6ouOdszZhgqNjU8wT
         TkTEYV2KSaTHeddGqJ+3RJfGF6FM/SIZmXKytiU0jW2YwViJ6QazHUjtcedJmoNtBjhJ
         6HCg==
X-Gm-Message-State: APjAAAUQAaVyog5KKyiH+UO7hSjK5VJkJMDspCmZo3I/b66VqRP93O4N
        TEFngEnlDGD5nPlyYclA9cqyz7mYq4zSg6w2/3g=
X-Google-Smtp-Source: APXvYqyv/W7CWZEFDJjPt4W8CmN8QSTDN/a1KF93wl7C/cqTB7j2BCU+AoHao8d64vsYOF3FxneCBLtGmh1bD8B6jTo=
X-Received: by 2002:a05:6830:209a:: with SMTP id y26mr36098774otq.232.1558790907820;
 Sat, 25 May 2019 06:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190524060026.3763-1-nishkadg.linux@gmail.com> <20190524060026.3763-2-nishkadg.linux@gmail.com>
In-Reply-To: <20190524060026.3763-2-nishkadg.linux@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 25 May 2019 09:28:16 -0400
Message-ID: <CAGngYiWXH-kjL1wvrH0LcEJ2ADCDBQBCNYh2z4jcsdnixN+HrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: gdm724x: Remove variable
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, colin.king@canonical.com,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 2:04 AM Nishka Dasgupta
<nishkadg.linux@gmail.com> wrote:
>
> The return variable is used only twice (in two different branches), and
> both times it is assigned the same constant value. These can therefore
> be merged into the same assignment, placed at the point that both
> these branches (and no other) go to. The return variable itself can be
> removed.

>  fail:
>         release_usb(udev);
> -       return ret;
> +       return -ENOMEM;
>  }

At the risk of sticking my nose where it doesn't belong...

AFAIK it's a well-established pattern to have a success path returning 0,
and an error path returning ret, where ret gets assigned the err value.

This patch removes the pattern, making it slightly harder for developers
to read. And if the function needs to return different err values in the
future, that future patch will need to add the ret variable back in.

Modern compilers optimize ret away, so the patch won't result in
smaller or more efficient code.

This particular patch sounds like negative work to me.
