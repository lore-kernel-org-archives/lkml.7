Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B4C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336542171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvT+MSaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390161AbfHHSFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:05:16 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45703 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHSFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:05:12 -0400
Received: by mail-lj1-f175.google.com with SMTP id t3so1194058ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbEj/s4Tx5wIXE+SY1pzM8Qf03LU/ete9pY8L1PQHXE=;
        b=AvT+MSaIHBDHYkJ+ctBaOd2evvkvglU1eysonnwBIzXmlTfamY+Yrf0lQn/a7WIiSI
         SEEzSFFq++6lPqsgGgpxuxSGLsre7xJ7VrQqbWlpMBKIZ0Lb+zxbGctVjAqH1FWBMLl9
         6Or95PUAMebiXEmERKC1baBwqclvWmnvlWC/1J9/t0GL9SRCl5irFrbUhdACYRZlVZpY
         3sRdO3Fd7S2L/uSJPvXpVqFKq2w6Io0jPsp6e6mwJ8O+TdJ7MPbb8/YmUlYTnqSgWzLb
         UaBTcFyLk7goTAXhmfjWPnpYlKAq+TjqLCdM+im6uHmO2wY/NGNQFXYEBN6QoCYZJLQX
         6SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbEj/s4Tx5wIXE+SY1pzM8Qf03LU/ete9pY8L1PQHXE=;
        b=KQIsSBDnxM3op2aycBFPrIARP2HS6uzahF/c/U5tgd6TGl5otEEP6SjF5GCHPRhRLL
         otVadrmTuwPr7lFH6puVznqo13kJl7xcQ63ObRhgXz2OCVTlJnXs7WgFtV7QxKmxgpsg
         zrJfvKws2TgVlwzR8XoyYX2Vm0IlA/PeugBc8tKOzUROjaEd1UsV8pSbU9y3irbCBFUd
         cVVp4Su/2nksm0dBCCGkHsn1wY9kfdZSnXfuO/g1dXZUlTHSWYHsunalVS/7x439aXQZ
         6RpyzGEzUrdnGVIefSRHoKOqjCvTidOimGcnqq2gAZGz4RvRgO/SoQ0qL2I9r031MZ8m
         XwjA==
X-Gm-Message-State: APjAAAVj/MFI7yJuLw8QMWnrCkPni9Y7UD0d+W5AfuY61K3idqYeeFoB
        rygIVG5w9eeScx8JPmlS9xIP4fxG9v64lCXjsrE=
X-Google-Smtp-Source: APXvYqxSEWTuZiEeYG5JYWdWK6BqvZYLqfV/Ycnv4qhV8ZTLHCPklpf+LG2Uw1bKaBpBCbUCUoQRkNiJNUC8jGwg9cg=
X-Received: by 2002:a2e:8849:: with SMTP id z9mr8928700ljj.203.1565287510630;
 Thu, 08 Aug 2019 11:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <1562589738-10595-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1562589738-10595-1-git-send-email-zhengbin13@huawei.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 8 Aug 2019 20:04:59 +0200
Message-ID: <CANiq72kOHyg4ckZS6DcxeFZVjj7cO+qnc7hXRzEe6zkudz8OBg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: panel: need to delete scan_timer when
 misc_register fails in panel_attach
To:     zhengbin <zhengbin13@huawei.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:37 PM zhengbin <zhengbin13@huawei.com> wrote:
>
> In panel_attach, if misc_register fails, we need to delete scan_timer,
> which was setup in keypad_init->init_scan_timer.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Picked it up, thanks!

Cheers,
Miguel
