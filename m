Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56C7208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bT7vNF0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDZQgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:36:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46356 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfDZQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:36:37 -0400
Received: by mail-io1-f68.google.com with SMTP id p23so3400958iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8YFSmy43A9WMb2hFNjp4Kp0KhLiSpFsnJWtqoKhqoqA=;
        b=bT7vNF0U7/w5duxS4o8nuiZVTUZeAM6utJZ09nU3kylt4YIKd4F6jX2Od9xtBrbyJ+
         VRI67rUBd+c518GnVHEG8GqqefgWdVV6cMjJFAwF2nLhfbXGqMxA1kxUFHPm9IIsdKib
         EeoSqOYxko/GDwpqDO0vcRltwGTMJKZ/GRfW8y1YvQLNK6naJlA7fj9vJ87nwuTtIW6b
         jbXkm5G7tjU2s/IM6K5TKB5YQIA+k81nDJetHN3OPe+vaWNvuy4cFMw660MxIY5brVBy
         Rwxl5jJ7j9oNNmb9AbmB4lDK2MEZAFkEpCjMdTr0DhSCuaGUGjBluDQR0Vr1vlV3P343
         RVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8YFSmy43A9WMb2hFNjp4Kp0KhLiSpFsnJWtqoKhqoqA=;
        b=UAL2ikDo0X4ftajPL8vFOCTMQYJkHFHRRyc/OcgLIAtfHfquW4lJql1H8RLIfhXech
         xkvRgepxLbG/HYwQNVUa7k62Nqvkn9pc2UoMs6foM+1aW1G08g1Fn0IbKD/RTn62C/gN
         MccPcqYVJp2lgYGhacNaSYbdQyEXYUtMkQVReezrIQbfjZKdf/qaa4rGuBSso7zNgXKY
         iCyHTYql2GzrEC2wfnANDQImJ+c5xi0MP2h5w99O+AHivHeSggJb6XKDaKiQVEdZTK3K
         ez9Hw4lAY+xQcDgSggs0RxntKFgRlfxDvs8Svk2+s1NK0mygRbdYAWYzwB7UJ6r8ZLUm
         zAAQ==
X-Gm-Message-State: APjAAAXH28jZCCfAHgGCyC8xlsa7FUh9PCFUrUtE4WC83rTQi9HMU0Sr
        nNIMUuPelh6xaJbn41iBO1lDyA==
X-Google-Smtp-Source: APXvYqxKBSi+Pat5Kmulifsj2VZcOqjDA96kFYBbMSOjTmeOaripioncPr3pfaotvQ8HYmrODuppVA==
X-Received: by 2002:a6b:ee02:: with SMTP id i2mr4720621ioh.219.1556296596458;
        Fri, 26 Apr 2019 09:36:36 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id l68sm11566550itb.29.2019.04.26.09.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 09:36:35 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:36:34 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh+dt@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul@pwsan.com>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
In-Reply-To: <CAL_JsqLMFmkM3YHS3BK9LBdidmqRMZn0w+_WUGg7zZvyv3g=sw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1904260931310.28496@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <20190413020111.23400-2-paul.walmsley@sifive.com> <CAL_JsqLMFmkM3YHS3BK9LBdidmqRMZn0w+_WUGg7zZvyv3g=sw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019, Rob Herring wrote:

> On Fri, Apr 12, 2019 at 9:01 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > Add DT binding documentation for the Linux driver for the SiFive
> > asynchronous serial IP block.
> >
> > This revision incorporates changes based on feedback from Rob
> > Herring <robh@kernel.org>.
> >
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > ---
> >  .../bindings/serial/sifive-serial.txt         | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob.

> However, what about flow-control configuration? You'd better think now
> about what the default is and overriding that.

The underlying IP doesn't support it.

https://github.com/sifive/riscv-linux/blob/dev/paulw/dts-v5.1-rc6-experimental/drivers/tty/serial/sifive.c#L30


- Paul

