Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD37EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8874D22CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlEn9Rfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391410AbfHWHzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:55:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36932 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732838AbfHWHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:55:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so8022906lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L23L8mkAuzJKbYYfAd7CE0VQjkVVjnJ6WWkwaXOISg4=;
        b=OlEn9Rfhmm7ec36B+M3dKYBn+HokEEtWF/cQ1xyjfzwf1AVFvx1RM5uDes+6nCR1SH
         eGGozHJy4nvCserw5X5CCa6F32/RI6f7g+AYMJFHD7luk2ikDn5Yg6pgBQm2iRTyclFx
         07d+2F3IKdjgD7LIfK5OQIaDkwHVhotLZMj8pSfJkXyuE5FO3Ot/D4sr5EoMEPREuDHY
         G11+MA3Rj6yk1xNcCp/r9gnwNvwTm6LNbU6S6RZgdoJfW8tjqoM+D6GoWeYEW6u458tY
         7grKu4FSZfSguz72cWR1IF5O5J2sYRWWq977cQQ9vqRij7w0HBldIFdQg3brHMkTC1X4
         T1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L23L8mkAuzJKbYYfAd7CE0VQjkVVjnJ6WWkwaXOISg4=;
        b=PO+uqSyglt10SqaRUQ1igU/MlL0zujKchd5AhIXDlpMg/FKsLyuiL1vJLjH9boJ0c7
         h+NFwJRezD8ct7TPqlglcscRS5mO/yaEjI97RVN4xZehFYvMoCfClw2TixewaAz9En8G
         PWWw65qbAggerJfJSDKUIemdwuHQRuA1tQqIe5mYDyQTd3ayZag2lmJMgJBctgmK8akx
         JDXJ0EIFhJHxAap9jZ133k9hxGzdbuFbiJYc07J7Ilr+qb4T1Ob0UsX+Bxc+QmlmJtOD
         mRcFUKxsGxxU/Lrjegk4pD8iH4BpRJzgNHNLC/AnO7lgQukoDOgE5luWUFdJcmYx/YF0
         xuQw==
X-Gm-Message-State: APjAAAU12eCbiOKXYP02YGxS0khnq1jFNzW/2Ie5WZkGTiq85Ur2RGsz
        m4s3HO4H/7fPtQAW4LaySTK/qYJ3nnzpHkvZB68mOq1PiAY=
X-Google-Smtp-Source: APXvYqw4jcDtSrQVItY/ZI/ussc812HqTpeUB5hUIzPipT/Ilr23+VdMy+LYWL8YNmKWwRKDpuQ1ju57rC6I4pZbaSQ=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr2076354ljc.28.1566546899996;
 Fri, 23 Aug 2019 00:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813061547.17847-1-efremov@linux.com> <CACRpkdaAE6RA1iQ-iqK3GGHOovTkuDDqi8vcoFnmG8UBwuim8w@mail.gmail.com>
 <e52ce7fa-c4fc-04b4-36fb-a89222024d2e@linux.com>
In-Reply-To: <e52ce7fa-c4fc-04b4-36fb-a89222024d2e@linux.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 09:54:47 +0200
Message-ID: <CACRpkdaWdchHoQpWqFD5crqhGw=yJhUtjL3GmojWdhpX676T5Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove FMC subsystem
To:     Denis Efremov <efremov@linux.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@cern.ch>,
        Pat Riehecky <riehecky@fnal.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:20 PM Denis Efremov <efremov@linux.com> wrote:
> On 13.08.2019 11:54, Linus Walleij wrote:

> > Do you need help to merge the patch? I can take it in the
> > GPIO tree since the subsystem was removed there.
>
> Yes, please. I kindly ask you to take this patch in your tree.

OK patch merged into the GPIO tree.

Yours,
Linus Walleij
