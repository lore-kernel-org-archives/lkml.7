Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B844C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F22217D8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="UdrWy5ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfGAHpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:45:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33329 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGAHpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:45:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so10281818qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+o+3A6MehkTrwlHzPltAkDqnU8gp0GmaahhvYz3RFyM=;
        b=UdrWy5ns7RKotFmMefez/oD/AycEJAzAu1LjvzFxXzIV4kW8lF6C5E/yvkt5ySrF2j
         VZDVpG1ExkBJNYT4TPy37N15aHPWJOKrG0nY9m4OjJLRSTfTGqcpMiJnTdMJsEmz+Wvp
         k9akBzRMejSTu+YvWpnerRXCUEi7t8r6qcHD8BX0XETVMQXi0yDhP7wJf3HiIxA7M11z
         l/qTa/6tXlTHU7hBV6uY0/UktA+siFSqUlbatFBKeu7DEyO7kMrEUwX12d0HM0dHm0MB
         Qe+bwPd7IUi30U/ZSU50pUaYEzBaHpIS4/QJE/CAxYsfIeyBM4LDj9P1KUP01THV2dp7
         pnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+o+3A6MehkTrwlHzPltAkDqnU8gp0GmaahhvYz3RFyM=;
        b=tAjSKTSw9ocU3IOS/TMaQrY29bSPVsKsUg13aoAF5yORgZ4Qx/evqlhju4PnTCccMa
         EiQnUCYPRr1B5Kcud1fVjGspITUIrBt7AthqMdgZHvzT4JLYjtDHlWzVpWxGL7GF7BKL
         fFhz1IfvBzXYPKqtNIjLcoa9FYxm7k1jtrA+sCjzylmgWj2zQKKLQjsSJhyFv9eCTafQ
         +4N3LU2XrFcuxRfbp7v11T/OpB8TbGX7OuZv67b6ndRQ+9aDZYakaZPpnFlhM1EzeJ6e
         PYzWIM1lVEvwNADNfVmS+2dyXK9oD0sl63mpWgcM49sADNn5oWGXom6ZzFtjJEAhYhuR
         iU/A==
X-Gm-Message-State: APjAAAUz60O8z+RhwhUS0frsbmLkjOUBZ2e3LYgyO6bNtxUPRCu2YJzo
        aszWjyJYVYjc5N1YfRN1jkV2xDpbXnuUu9MKUiVkFQ==
X-Google-Smtp-Source: APXvYqyXMdwt3gy6gqvDfkjOmeiiPp0dk+UezJGobEGYLzx6o98gaaTwQAzlig0mzlY7lUACwRRaawq+a4PtpXv8WBg=
X-Received: by 2002:a37:6808:: with SMTP id d8mr18821969qkc.478.1561967149291;
 Mon, 01 Jul 2019 00:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <B8AD29F1-444A-4BB7-8C12-9C31EB974D11@holtmann.org> <20190625083051.7525-1-jian-hong@endlessm.com>
In-Reply-To: <20190625083051.7525-1-jian-hong@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 1 Jul 2019 15:45:38 +0800
Message-ID: <CAD8Lp44ZZZGf58XKZ1PFJrC5UqdQ17v17-nnEYC-Ro0-G_u1=Q@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btrtl: HCI reset on close for Realtek BT chip
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 4:32 PM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
> after on-off several times. Bluetooth daemon sets BT mode failed when
> this issue happens. Scanning must be active while turning off for this
> bug to be hit.
>
> bluetoothd[1576]: Failed to set mode: Failed (0x03)
>
> If BT is turned off, then turned on again, it works correctly again.
>
> According to the vendor driver, the HCI_QUIRK_RESET_ON_CLOSE flag is set
> during probing. So, this patch makes Realtek's BT reset on close to fix
> this issue.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203429
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>

Reviewed-by: Daniel Drake <drake@endlessm.com>
