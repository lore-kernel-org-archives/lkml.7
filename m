Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE3BC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A20F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="RBmoo21s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfEWQQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:16:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39262 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbfEWQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:16:00 -0400
Received: by mail-ua1-f65.google.com with SMTP id 79so2389160uav.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXMl9P+TGNueE5euLoOAhBRVyH0nXGkNGXAvhSh7+OU=;
        b=RBmoo21sPuzUV/EQovrxfLit8XjveVUpH/oRQNXVl7Q6wTjT2WhMeju7re3mqz8IBN
         fGdQdayykoLjbugpvir9+tXe/l0zWxJ6gCEaAte21ryH3NxdCpos865hXneKhcdNkwow
         I29SNtgGZwYGEa/J5emaZ+P8ZhtfSl4GL1UyTdj80GPWBCJWSenaQj7B4XRJ09R2a+fh
         +C9erGAG6rC9BLBZiGL+ifwexjPk5kRHwJE2C6SvKk2xFEY/klwYPfG+k1WD1LJ+XPWX
         Cv+wD6cHdbdKCDVNXBvakwQoxcPGeb0X7qvoKYFFJGNz7P6CWVRZGU47e9KNUyuqFZOj
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXMl9P+TGNueE5euLoOAhBRVyH0nXGkNGXAvhSh7+OU=;
        b=tK6fJuGoGdAXVBF7eqxfUj3eLfJNDC6nBcOw+cLDhIcC4DBMgcNk8GY05Er8V2ery+
         k7HoqHYD5lB4rjpEaw8gHStuuN1zu+ybLiScfZSsy7pQGvIbVDXFgG8vFC0msiSG11cD
         pmJD2JdgfJlTNw6aX68ucQGKhwX6Q2F7wOewjd9sg7aAsPNPs+xDgjuknEqKg+vadoPq
         IVK9u4jG56K2Ik20Av3XbMxcwh1cLlsqTXgs/rHmHMQNmYo8KNLjza9eyapkxG63OixF
         60sCHTbBQJf78Clu3gN6lteS6C0m+uaJBA1TWZd6IknplBw9r5okzvQXUEblsp4r0Zj3
         mnXQ==
X-Gm-Message-State: APjAAAVyILjAbKmDXycChIrCqswIURr2fiYXBFJ4zaVvsbMNjqLUQAEG
        Eq7v4xUrCHODw5twgP/7YjNJOFjajoH5bYfLi32PqQ==
X-Google-Smtp-Source: APXvYqyKyrA3Zqk0VgrKQ9df6i2EvyciTk799ILFHCqR2AZ71fV4FIj6HG11qTQ2eMLBgGuo+Uu4fS1QUy9VmXaig2s=
X-Received: by 2002:ab0:670c:: with SMTP id q12mr24858805uam.106.1558628159122;
 Thu, 23 May 2019 09:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 23 May 2019 18:15:48 +0200
Message-ID: <CABLO=+=5D2v2TQ6HWSByJjnb4pzXZxXAs1jJgcFtVNYk5PYrjw@mail.gmail.com>
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:55 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Identical to previous version except without the KSAN workaround - Ard
> has a better solution for that.

Just tested the patchset on aarch64, all works fine.

Reviewed-by: Bartosz Szczepanek <bsz@semihalf.com>
Tested-by: Bartosz Szczepanek <bsz@semihalf.com>
