Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE54C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F09A20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 01:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEOq5THp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfDVB4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 21:56:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43892 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfDVB4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 21:56:03 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so8444144iol.10;
        Sun, 21 Apr 2019 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ypYhhMSuHzDY3rgTbd1os8xN/bKHcxL+JfbiXjI4jE=;
        b=dEOq5THpvBM+byAuXjd4iP9QrVp5OVyUgSo4HPpEk7/6Q9E+V/aPZflIhAkjKIeU6c
         3HKPhEJwLn+me2QAHm1H9RU12eXHNUMwulNT/cA2HtgEFCD6n1Ntte+lVxhKILSZWzKU
         UfHv02dm5oaHXiq7fV/OnrcDqkOlAxcQY5HQnCUzfDtJllOCMVe15Eoi3xYZwD7uMFeR
         XmLoNUeAcCNY4EYbNGeFR50ZhKTouM92yGSPPRLbIjTZ3PsyJG0vW2yeiGjKInofQnuW
         9Iyl2NhbQSzFKx9Gw7rweI/p+zTAs4sr9swCVrTDntJju4OzbRDDV+aAXbOxxJ3vnsOw
         OP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ypYhhMSuHzDY3rgTbd1os8xN/bKHcxL+JfbiXjI4jE=;
        b=tRukCkB3OdZtp3WcDPwbqbzzgnME/GOf0ZR3BE2iX4dR3YzdBF8l72+TdVvoiEVa+9
         kDMbNeUz2HIBx8CR7odnNLUVgW7LYxvkm15d6YfuuS+JM6kkWExMyiKo+dbTVHhVyold
         cBuNB3wPssz2Zg8MvBJdNZ+0KrwPdfzobHEjQNWRaZxd24vmHQZdFOoSS8FkceV28BPC
         RPyCRoyELJliNvaQxTZHRgQEVD6u6qf5aJG6y7TPuOYCB2fgBWRZE+TRQ4TYTnKBHOV2
         3VFd44kqPjRkJjinJymlALgJE+8DbWaX89SwTPlXr9VQjlYEYkR6hS/sgubza2dP1QU7
         2ivg==
X-Gm-Message-State: APjAAAXCSwNVMrdYM34S4LtXFwhl5dKOaqH8t719DUX49hZ+s3rwRP62
        npMk9X4VOxpXyXwvDBS+i8KN9B2oTAJFGvpuLXc=
X-Google-Smtp-Source: APXvYqws9sQy52TiO1o6Fib3WKbp/R+hIwHrv/QI2gPb34iq9sX7jyK8GLW7IbrO+CyG94pzCpp3vK4kCpO2LnnaR98=
X-Received: by 2002:a6b:8ed1:: with SMTP id q200mr5305277iod.206.1555898162001;
 Sun, 21 Apr 2019 18:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190419084547.26220-1-crag0715@gmail.com> <20190419193747.GA29188@kroah.com>
In-Reply-To: <20190419193747.GA29188@kroah.com>
From:   Crag Wang <crag0715@gmail.com>
Date:   Mon, 22 Apr 2019 09:55:51 +0800
Message-ID: <CAP-8N0i-47x0ZvuSed7aWm_KcjSF1wn9kMYTKHL6zyHO8pqzAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] r8152: sync sa_family with the media type of network device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hayeswang@realtek.com,
        Mario Limonciello <mario_limonciello@dell.com>,
        "Crag.Wang" <crag.wang@dell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Glass <sjg@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        David Chen <david.chen7@dell.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Charles Hyde <charles.hyde@dell.corp-partner.google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2019=E5=B9=B44=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:37=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Apr 19, 2019 at 04:45:46PM +0800, crag0715@gmail.com wrote:
> > From: "Crag.Wang" <crag.wang@dell.com>
> >
> > Without this patch the socket address family sporadically gets wrong
> > value ends up the dev_set_mac_address() fails to set the desired MAC
> > address.
> >
> > Change-Id: Ib48a303730bee81667a2859be32e48cc8a66f277
>
> No need for this line here, I don't think you ran checkpatch.pl on your
> change before sending it out :(

I added param to skip the verification of gerrit change-id, will
remove this line in v2 and upload.

Crag
