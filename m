Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3D1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD7720675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgkptbNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfD2ODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:03:51 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35070 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfD2ODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:03:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id g24so4086855otq.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nbZEajYcruPzq6id7AdlLv792MCTBI+YmufYDAqZQE=;
        b=PgkptbNYlPk21zA0zOFf5tkW6rkz5xS+hwNIxvYrr0Z0FjU9YBtYNjRLq3zmG9Cd5z
         gXZGmwGEHL+kNpaS2c5SSQzkLHHM3grcE3UO/+2bIJ7ca/Hlms4PtMqUk4v60YL3NN0s
         AS69ejY0oud20d0KWzFfLTb9DxnOzHSLZvfJoOdAmkY6XUjLynMCIbD1VkzFu9vOoSLv
         cw2/fAUs7mXzWInnaaAizx4ifEk0KJOioZV6v9kCDkmWwENlI55WCUVMhHsipAXP1meT
         y3MHte2ogcR9GBDl6Be9yzZ1jsdqkG/uLz4VdciQP6d1jxFylBzJK6L3nwS47wBP9n7T
         Vsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nbZEajYcruPzq6id7AdlLv792MCTBI+YmufYDAqZQE=;
        b=kMcC8BmXbnAzWOAVnFBAu9u2lBD5CabpF8EqXEzGd7/JLONke5lDG7lzn3zO/UmaBR
         EzXiC9VPDUfTvXCW5gtn5wYXhxRSpaljez/2NHmzPFJw8TbcS9RtoDw+McX0qWTKcrhy
         jmSpyaf7kWRSLQ4DFmH1F2T2h0im3/v6Q9RrJnjKQkiWiYEmbDpD0WdyfhCVVSjso0FO
         A/w0XZriu4qmU7VjAQH+oPFH59/dZAz6qEWSRgMvU2HG7RDy8Pll38nGJMkGa1XQpeHT
         ToJCvxdW4GE3P0W/FniRMM7mH2PuhAOEOGDP1VpkOqb2KEnaEsUemSmwz1Fc5PKbjYGQ
         3Bjg==
X-Gm-Message-State: APjAAAX5GU48xroY7XlvHX3UJfdscH5h0csTWj4svwRBt4K1RYZAS14B
        G1S8PDYrp8gSgAGdb44nztmHwUQH5nzlKzqozcU=
X-Google-Smtp-Source: APXvYqwLxHRFyKBzklDnAsk9KxDUE2OriDGQD6D1ejNY5+eJLkxalL92B5vaGXkmyDo77QB4gn9kd/Cc4AQjO8Yi84Y=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr23965485otk.95.1556546627790;
 Mon, 29 Apr 2019 07:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 29 Apr 2019 10:03:36 -0400
Message-ID: <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes annotation
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 2:11 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> V2: As requested by Sven Van Asbroeck <thesven73@gmail.com> make the
>     impact of the patch clear in the commit message.

Thank you, but did you miss my comment about creating a local variable
instead? See:
https://lkml.org/lkml/2019/4/28/97
