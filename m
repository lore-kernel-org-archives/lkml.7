Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USB_DRIVES autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F14C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AD0206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 19:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="oTq68OHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfHCThV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 15:37:21 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33590 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfHCThT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 15:37:19 -0400
Received: by mail-ot1-f42.google.com with SMTP id q20so81440887otl.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Tv2T/5LhQExvr0Ft3hxbrMy7PyDH7uXIbhau7p31o/4=;
        b=oTq68OHW2mUyOqBxFjqGKh69Fi/JUissXQlzSE28d8cBGqVKIMfPdrXIDwxQbmR9nn
         Z5xCzbBXxN3n3al4fsxJ9aZA3vOmmWP0ryDRkhf6CTZuozaJ08f17h/GXaGef37EcA15
         HTxcNxpqK9iAKbki+RynYG0B4pMEQ5GkUSc4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Tv2T/5LhQExvr0Ft3hxbrMy7PyDH7uXIbhau7p31o/4=;
        b=kiEN8Bcf/924WGlYUy31PEzviY0KaXnJCXFDu/dpwbLak3ya/FxlOV+iK4y7qQ571S
         yksUw5dk7twKO2fgmVXKSpMj0gXaEt4DCVNqp/YTkwL+4lr0jva7PR8KSRU5zABYmhtX
         8Zi+V5NGHKU3UlRpDkq/JPOcm6nSOO2KTzub7EiJCUO+LhJqK7DTC7ZFbX5scnhlSRAm
         A5gZqfqLtdVzfUCopSEr/VNOiDJ0NbKWTFY3tcawbIwf3EzRw0qkYsPU/k1+wr5EAyhQ
         66I8gziyxKvi+gRzsFiBULe5vQDnYdPK0Knr2igw+xT3z/Uqw+XBk/bEkH3oYnGbnpQt
         ejwg==
X-Gm-Message-State: APjAAAX/OWYdUda3NF7f4Mmpob2cOuIgvbmhBN2nJqrWCHnBm/x13her
        3wHjk0eFNLBHYhbXH2/agpM=
X-Google-Smtp-Source: APXvYqxGrk3LpN098P1GH7zuwOKodMYCU32/4wSnYHzjKuE76mDNxMbKISVxiA6bKHx20Sr/wZNGDg==
X-Received: by 2002:a9d:63c7:: with SMTP id e7mr108610344otl.165.1564861038121;
        Sat, 03 Aug 2019 12:37:18 -0700 (PDT)
Received: from WARPC (pool-173-72-201-135.clppva.fios.verizon.net. [173.72.201.135])
        by smtp.gmail.com with ESMTPSA id 98sm28670948oti.18.2019.08.03.12.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 12:37:17 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     <damien.lemoal@wdc.com>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>
References: <006d01d549db$54e42140$feac63c0$@lucidpixels.com> <Pine.LNX.4.44L0.1908031458330.22056-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908031458330.22056-100000@netrider.rowland.org>
Subject: RE: 5.2.x kernel: WD 8TB USB Drives: Unaligned partial completion (resid=78, sector_sz=512)
Date:   Sat, 3 Aug 2019 15:37:16 -0400
Message-ID: <001b01d54a32$dbb09260$9311b720$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJuodioyS95OAww8I/7mT9ERbmjcKW3HLjQ
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu]=20
Sent: Saturday, August 3, 2019 3:00 PM
To: Justin Piszcz
Cc: 'LKML'; linux-usb@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: Re: 5.2.x kernel: WD 8TB USB Drives: Unaligned partial =
completion (resid=3D78, sector_sz=3D512)

On Sat, 3 Aug 2019, Justin Piszcz wrote:

> Attached 2 x brand new Western Digital 8TB USB 3.0 drives awhile back =
and
> ran some file copy tests and was getting these warnings-- is there any =
way
> to avoid these warnings?=EF=BF=BD I did confirm with parted that the =
partition was
> aligned but this appears to be something related to the firmware on =
the
> device according to [1] and [2]?
>=20
> [1]=EF=BF=BDhttps://patchwork.kernel.org/patch/9573203/
> [2] https://patchwork.kernel.org/patch/9597797/

Just out of curiosity, why did you not address your email to the author=20
or committer of this patch?  Surely they would be the people in the=20
best position to answer your questions.

[ .. ]

Fixed.

I had been researching this issue and did not find any useful notes on =
the mailing lists--hopefully this will help others if there's a copy of =
the response on the mailing list.

These drives [1] [2] are the ones noted as affected when used on Linux =
[1] plugged in directly to a Linux PC (w/USB 3.0/XHCI) and [2] when in a =
USB enclosure with a JMicron SATA Bridge.

[1] WDBBGB0080HBK-NESN - =
https://www.wd.com/products/external-storage/my-book-new.html#WDBBGB0080H=
BK-NESN
[2] WD40EZRZ-22GXCB0 - =
https://www.wd.com/products/internal-storage/wd-blue-pc-desktop-hard-driv=
e.html  (In a USB enclosure with a JMicron SATA Bridge - per Markus)

Regards,

Justin.

