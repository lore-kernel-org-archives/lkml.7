Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EDBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3824C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556287744;
	bh=Ky5AC051wlkEfcHF2s4LkIQB5jAFFHWvQUVc5iMChdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ogsladIxuLGrzFBZQNqnVBT87YHPrahrLHMsoFUDCk1xEBbhv0VjcbmJ2ISngruFX
	 WJzgwTZBY4trJuW7nSIxggI48OPEcXitHY7V4uOPqcHQVqPC3ELePi0IKbnE8J5Htq
	 tJTN8Iu+88I3zA4Wk110+Oq1tyvooaGXhHx32xhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfDZOJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZOJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:09:03 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F59D2089E;
        Fri, 26 Apr 2019 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556287742;
        bh=Ky5AC051wlkEfcHF2s4LkIQB5jAFFHWvQUVc5iMChdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rw62xWhmnWw52i+gJoQMW5cDmhHBDYmKyxldlnb87q3EMb619NbWeXRB6GbXdXoqR
         kuJkdArt90UQpMo69XlTp1bbHeXT0laj0nA77Yqve6x4DWS2oNxKilQLZb8esejydX
         NMq6hqzn3n7cV8Yui8VZiHCBIdfb6gL9HaFgZ6/I=
Received: by mail-qk1-f180.google.com with SMTP id g1so1939001qki.5;
        Fri, 26 Apr 2019 07:09:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXNf1S7TTY0S4Fm/gVvWBKUV6vlzJQuq5Qr1PuexWuw1/pEOsKM
        jQCfR9FPBejPDRRkzOpopY9PH78ayLDWM3xPmg==
X-Google-Smtp-Source: APXvYqzVddOPT+S6uvLGhEq/5k9ww5fHVcqGq3bG0Teml+vSRDhuS84AuGDcICBEzrZ3ByklBKgSQxKaTLMfxHs2QQY=
X-Received: by 2002:a37:ad14:: with SMTP id f20mr700993qkm.147.1556287741285;
 Fri, 26 Apr 2019 07:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <20190413020111.23400-2-paul.walmsley@sifive.com>
In-Reply-To: <20190413020111.23400-2-paul.walmsley@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 26 Apr 2019 09:08:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLMFmkM3YHS3BK9LBdidmqRMZn0w+_WUGg7zZvyv3g=sw@mail.gmail.com>
Message-ID: <CAL_JsqLMFmkM3YHS3BK9LBdidmqRMZn0w+_WUGg7zZvyv3g=sw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul@pwsan.com>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 9:01 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Add DT binding documentation for the Linux driver for the SiFive
> asynchronous serial IP block.
>
> This revision incorporates changes based on feedback from Rob
> Herring <robh@kernel.org>.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: linux-serial@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
>  .../bindings/serial/sifive-serial.txt         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt

Reviewed-by: Rob Herring <robh@kernel.org>

However, what about flow-control configuration? You'd better think now
about what the default is and overriding that.

Rob
