Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F018CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EB020857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554844096;
	bh=flW+ZTk0MyIVVSAiGBmqj0p+5/Po7g05SxaCK9SbD9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I1bvxy+KjJZomFCLqoZKE/Wxr/p17r7aatM7NtzQPlfqThBxHgJ4r1rm4y2PCs5eE
	 l7R6Tqx7lp8orpvyleJfNBHOOipHpkDVC5kMBBRqgVE5ptKwMiC89b1R5QKVWQZQj9
	 FE1pGySRc3n8B5V4422T3sGxle7DgVAUTGn71Xak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDIVIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfDIVIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:08:15 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F222133D;
        Tue,  9 Apr 2019 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554844094;
        bh=flW+ZTk0MyIVVSAiGBmqj0p+5/Po7g05SxaCK9SbD9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QE9aiUHWcVD2+9Kyu/CJmISh/61X+hEYjQKdbjDsmkRs95/9VjoX+T361TYr3LzJU
         zW3PHizaeA7LUSnkwFaJ4IOugRbaUhX4QMaxxqfEw/1iLRUv70yyR2j5sOP7KFKh2E
         U6uPpATCCQGxtuL0logKCFnjrPxXGN1XnPHBPjxw=
Received: by mail-qt1-f173.google.com with SMTP id v32so359052qtc.10;
        Tue, 09 Apr 2019 14:08:14 -0700 (PDT)
X-Gm-Message-State: APjAAAUeko8a0wsAuVhPe3RsjcGMdaAUMxfwVZy6cAHr0mx4aml14SWo
        Z9VCD0xXD7pyPLocm2xYQgksgN7fKmRH30ewVw==
X-Google-Smtp-Source: APXvYqx6oXyHWP5WaLWnBs9dwdvRncxZHXoixJyQpHhfUodkxhCSJQeB2r5eT5LH4P5kygohscAE3OxMpa3yMvdHsok=
X-Received: by 2002:a0c:c950:: with SMTP id v16mr32214458qvj.204.1554844093544;
 Tue, 09 Apr 2019 14:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190409191054.va6y2l5lyhyoo5p4@arbad>
In-Reply-To: <20190409191054.va6y2l5lyhyoo5p4@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Apr 2019 16:08:02 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+k+JDsm=3cX6UeRCyD4k1YnWxbkoYm49GMO5mOgsGoqg@mail.gmail.com>
Message-ID: <CAL_Jsq+k+JDsm=3cX6UeRCyD4k1YnWxbkoYm49GMO5mOgsGoqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] devantech-srf04.yaml: add Maxbotix ultrasonic iio
 proximity sensors
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 2:11 PM Andreas Klinger <ak@it-klinger.de> wrote:
>
> add compatibles for Maxbotix ultrasonic iio sensor types to yaml
> documentation
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/devantech-srf04.yaml    | 25 ++++++++++++++--------
>  1 file changed, 16 insertions(+), 9 deletions(-)

In the future, 'dt-bindings: iio: ...' for the subject please.

Reviewed-by: Rob Herring <robh@kernel.org>
