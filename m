Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1322C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB112146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIQ3MYop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCMQeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:34:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37549 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMQeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:34:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id b3so2329222otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjyj99JG3Ny/PihcAGrp5c2cYQReI0DjyeaAR3NO0DI=;
        b=qIQ3MYopWQDSXG8cafFg9A36LEWRiou5XIKuitht9aulUiAQpWEOLU0P8S55T/r7U0
         0RAhAunaxmhcEb7hx3nxRWSdcM7wLhAfbUThPtiewawcn3uLsPrI46SNi9S0u90sTtjf
         yTBoQbyNd90x+aDH43heA8Syp1SWG9KCWGcn0E2iBvZmWEFsQm5q0fZ5Ib5EV2eQG4GH
         YMPMKpECMuZUsWkCj5cSFS8zN47M/U4qP42UCjJhjKZGoDIMjRtZr+pqX5s230aebca7
         BwWDgrH8D2ti0saJB2Bxlqt9RRHxivts2b1GB6RtmFNYLPmUO8IeieTrteulZku6ciN4
         voCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjyj99JG3Ny/PihcAGrp5c2cYQReI0DjyeaAR3NO0DI=;
        b=QL96uNKe002A7n1h+MzJ4p5oFqDRn/3yFZY2VcVkSjb+Jv2k0lBwZAESgCohXq9tLy
         4vDZolgh6t6F+c9ftkDBJItCygt3frMGxnBOO27bQGWGa3hQRfWK7H+J49/gpA3I6hQ8
         dknfQKdNBhJ/91EW1+GtU1vDN2/tJZez+M7neWljUIf5MFtLGmr7s2ml1XsNX2BdgWmi
         0azu0oFxOfL2zY+zZ1HITu1BpEq5FRMwM4DCPN9daDj5vgAcSTBGCCBsjKB4KZ0uzyiZ
         u0SbrNjb8Bd1RCxEmPBWi0yTASsiS0PD+OpOlqfIff0eLqRGd6aZWavls/L+0jc3ZA4F
         IgEA==
X-Gm-Message-State: APjAAAWoE58WkJgoWQYlwBzIG9Q5PzJyKEe++oyrQqm1jqW75BlxvYgP
        oPlJ+8bZ/5Inq10Rufr2pe0wJEHYaba0Z/x8VCQ=
X-Google-Smtp-Source: APXvYqzzmUugSd/iAcw4/HfnO9V4ei+MHk7kFlJYfNU29StwsymzKJ9yZLyikaVNPMcpBzxfBr40525nnGQSjlvHRWY=
X-Received: by 2002:a9d:403:: with SMTP id 3mr27519048otc.110.1552494862495;
 Wed, 13 Mar 2019 09:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190313122403.248873-1-armax@google.com> <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com>
In-Reply-To: <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 14 Mar 2019 00:34:11 +0800
Message-ID: <CAJsYDVKF-3jZo4E3EMiYOqeWXVLu0hBra6Qp0sFoCz8y=BAjSw@mail.gmail.com>
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in spi-mt7621.c
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Armando Miraglia <arma2ff0@gmail.com>, NeilBrown <neil@brown.name>,
        Armando Miraglia <armax@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Roese <sr@denx.de>, sankalpnegi2310@gmail.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Wed, Mar 13, 2019 at 8:28 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 13/03/2019 13:24, Armando Miraglia wrote:
> [...]
> Apart from fixing styling issues it would be usefull to see if we can add
> support for mt7621 to drivers/spi/spi-mt65xx.c
It's impossible. They are completely different IPs.
>
> Not sure if that is something you want to work on :)
>
> Regards,
> Matthias
