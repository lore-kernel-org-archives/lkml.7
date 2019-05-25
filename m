Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB6DC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C37B20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 12:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMDw8eSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfEYM7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 08:59:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36466 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfEYM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 08:59:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so11114918otr.3;
        Sat, 25 May 2019 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtQTuMfATWXiK2KsTqvrmBV015lDA1qcyuiicuIi0vA=;
        b=RMDw8eSGj+mSLywZgF2YVM3V88/obPnHf2Y5qE2tGnMQuxg1KUitGTXqbpra8UAY4F
         iL/9EKNFEx/t65gZ1+iyTD9zo28S0oIcIU8sXqEb/fCAFW4glZK+vr0Ymdy9svKSeG1r
         n4F4Zn+SDVawAjeSnJvFXqdzOo6kGBWyrYfZZMAWAAQhQ/SIv5SyeJ/ct7zThVxeb2yQ
         vQ+CB16LyQNs4QTbiSQbYAraZAqaZbTd981NeyrlS3Z9bMlr8FKcLh+/3PBQuJ0+oEBY
         DmrkqjWhRjoMbnseUHKTFHKghbplHnpXkexkHyWSaa4Tl5d4d7eX/JPnZ0LFWKAZNXdy
         T8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtQTuMfATWXiK2KsTqvrmBV015lDA1qcyuiicuIi0vA=;
        b=gwEj0bmT1+vV+o0tYJu0LyYN96YB9ZuRnHRBDHIq3tXVHKjBg+jIiC/4kXazmoNcuY
         EHUukevw2QsVcDicCQE4vY4EOVVP/1b94tuLfdZKIeO8IAaZ+3b6WOsBYYtbnaEmLQhN
         +r17Hce0/oPBINtgIxg5eP2bT9BOMuT59PujISUkeh+kl5BRH0jmf6KuRpEoysD+ZqS/
         WJHd4SSLlZb5dxzOeVgw0xbNIQOucwerwSlXLIKC5p2v/wNorYfuG5mttcKKs5Yn7k3Q
         cNq4Jr5g8N+N0qqGM4kA9Tdfnpy7H7HrZrSFErnZ/k3m+7oqZskzLlE/2miPJj48dcE8
         nclQ==
X-Gm-Message-State: APjAAAVNY+bweGpYmqHJI+qDNsvXMoLOMBdevrGi+1X6mOty66cfXsKt
        SOpDBwZbtibK8/cVSeZuwGfp9NyIAOcByzj1P7w=
X-Google-Smtp-Source: APXvYqyOxYb9KGXupIouUlbnXLWlQ3BdKVA8gjHY4z+gTj3DWLA44KWiOPwIW9eLNLODIq5iS6L/1oncgUFQX9wbIDs=
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr50298032otg.116.1558789159170;
 Sat, 25 May 2019 05:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190525042642.78482-1-maowenan@huawei.com>
In-Reply-To: <20190525042642.78482-1-maowenan@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 25 May 2019 08:59:08 -0400
Message-ID: <CAGngYiX04W+-jxqnWUD6CLh8LAr61FhtADGM0zbGcdeArqzC-Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_net=5D_staging=3A_Remove_set_but_not_used_var?=
        =?UTF-8?Q?iable_=E2=80=98status=E2=80=99?=
To:     Mao Wenan <maowenan@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Matt Sickler <matt.sickler@daktronics.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 12:20 AM Mao Wenan <maowenan@huawei.com> wrote:
>
> The variable 'status' is not used any more, remve it.

>      /* do the transfers for this message */
>      list_for_each_entry(transfer, &m->transfers, transfer_list) {
>          if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
> -            status = -EINVAL;
>              break;
>          }

This looks like an error condition that's not reported to the spi core.

Instead of removing the status variable (which also removes the error value!),
maybe this should be reported to the spi core instead ?

Other spi drivers appear to do the following on the error path:
m->status = status;
return status;

>
> @@ -370,7 +368,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>
>              if (count != transfer->len) {
> -                status = -EIO;
>                  break;

Same issue here.
