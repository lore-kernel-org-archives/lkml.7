Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1510EC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57C8207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7OQWdNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfFJMvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:51:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45013 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389075AbfFJMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:51:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so8120132otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGLWNA0OQOG5wWyxB9H8Hgmax5IuBsIxNtuEDQ1Ho3c=;
        b=l7OQWdNRtoQUdMIL/J3aLdcLG7lwN1wQG3eVC8xnOnhEcL0e2LZzQQ9vk85dW/M4XI
         QIUJNVgxJJse3crYXW4d4seEx+Piw6ZsqJgoGoM2XzXPkCgO/L2xCk/A+MRxS16nzjmz
         rNsEDpVHpheCwZarHvmp4TlrTDIgnJILy+kJ02CeQINQhAuoCgiWEDJqHEYZf/ofC5qv
         6po8XTmOjPEPsMfDM1oH7UkapXaxsR0j7t3ROLJnGsHlyzgKA9XWVAB1BK3Fr2fzwgis
         eSRwKU0jHp21zpJv0zl8z8XzTkhdRw4V9bVf7cpo9gk40+LDq80YRiVW/O9dXJxVZQ1V
         +dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGLWNA0OQOG5wWyxB9H8Hgmax5IuBsIxNtuEDQ1Ho3c=;
        b=IUqEKgTtCvnKXhewM0pW0X4QXZZ5I6jpmyHOuFyUqmicIJPY6qPxE+rxh0Ez1o65Z0
         RXLxq4tIpxGhMon+naJ8iJbzFz9YDIfyIbv6tPORDy2UrnOpKS0JrBH8uksjrfMBr/mz
         dbIZj+ADzGe7eQamZ7514ADxSOpicZUNhd5WLGXeg0vIRHBDHaPD+8v9GL/cz+BjWtAH
         UK6twoFlTPOmAOGiLiiKNrtE6d3aH6MqsgoP++NnnWdKPBHwklGzufL+YRjmjT11xir9
         h+QC0VN0WAVVRa/pJ7BDfBrPEcMhmYnNR2LewgsWaQgjwjVXFKvTN1e9GJwS5gaH8YvF
         FDNw==
X-Gm-Message-State: APjAAAW5lz4DoXXtwN8fkZIpui2mhinNEX+AFJCXmVpYicLcHPzhjF18
        3fpaBUFSxBfDuoIxQxCovfDHTUz3th6mv73+bMo=
X-Google-Smtp-Source: APXvYqyQXjuj4lGYmy/SumwwBHmFKbZv9SJe8lb9ySDF6TAZi1e1lsa3INyyrtPsmejesuC5xQVc4uw+QcBtPppyHf8=
X-Received: by 2002:a9d:3bb4:: with SMTP id k49mr29303369otc.332.1560171081876;
 Mon, 10 Jun 2019 05:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com> <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
 <3f4c1d4c-656b-8266-38c4-3f7c36a2bd7e@huawei.com> <20190528155956.GA21964@kroah.com>
 <CAGngYiW8Y3jt9ikb5e9LtfSkquZquLgB5iSRVXyka9fUXLrqYQ@mail.gmail.com>
In-Reply-To: <CAGngYiW8Y3jt9ikb5e9LtfSkquZquLgB5iSRVXyka9fUXLrqYQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 10 Jun 2019 08:51:10 -0400
Message-ID: <CAGngYiV9XsPL8Mk9_K9=0a-k6P6JN_waJvk5bDH+mDwGMAYbmw@mail.gmail.com>
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without CONFIG_REGMAP_MMIO
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg, just a friendly ping regarding this patch. It got my Reviewed-by tag
two weeks ago, no further feedback from anyone. Is there anything you would
like us to do before queuing this?

Link to v2 that got the Reviewed-by:
https://lkml.org/lkml/2019/5/28/609

On Tue, May 28, 2019 at 1:31 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> For the v2 patch:
> Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
>
