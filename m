Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8CCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED6E20656
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2yDnmY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfKCPL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 10:11:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727648AbfKCPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 10:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572793914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKeQqHTNm2rKMXKnKYnKXv0/Zvs8TwJgyMSIjxTYZk4=;
        b=W2yDnmY7szGa8v+H1u8PGwx/uOGKoOt4nqr3IEj6GDPBrhvzEFtwx+B8csYIa+dAyAkOY3
        Il7bUQzGAhNZCOCfcBWjxhwbvgTIGkAPXhZysfjsLWexuwO7sUUDnHFbn+kYDCo3P1JZ0h
        A16vLBlIV/vrwltAF0Cbkp2qkrQVF+A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-QeFZRFkJO02tuALSiz7RpA-1; Sun, 03 Nov 2019 10:11:52 -0500
Received: by mail-lf1-f70.google.com with SMTP id a4so116417lfg.23
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 07:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYLWafxRH7qP066b4Mp7DMWQe6c3nTG9BEtUCE6Dw9w=;
        b=OtaMB8EZM2V4C2LWNRo7a+Fxb9PcAXSUP3+wxir3Niz7RZNgdGdk2K1brS8KrBBqfo
         RLMtfnIGE/Df+d3e5oP35s8RwFpVdQc30uKj34O37HwJRK4RIM9im+vUy23lJKSjR3br
         z6kksgGyJCjmaXhBPwp8VjiA3KF5SUx1r0Kn4jOFl7zNdO1Lc90U+VVXBS32i/Q5Y/0U
         son0mrAS6JyjyZIRfnW0ic5oHQvje0NGSWnZDE8PQjq3pTrVZPtSftXLqqolVUfQlKSC
         W7toZW2U3bV3iWwmQkIJVropBU8T/m5lRhyOE+Dzd3WY0W76qdLWCI+WmFyV7S+iq5e3
         h+pw==
X-Gm-Message-State: APjAAAVzb5WmUkdW6CXq2dmeMAQGHRwRwMyVRAEt+Px4i8UZN+8yWvGx
        MaJl1mM5tgqJsGfEh+Gs8KAOqLYFzJxMUJwjceC8cpBptyjUebyd2XN9b+lHNMsHC2iSVXzOJ7x
        eO4cln5heq44TUSEi8K8TWbZ1udMQvfd2zKU5hnik
X-Received: by 2002:a2e:85c3:: with SMTP id h3mr2400848ljj.122.1572793911421;
        Sun, 03 Nov 2019 07:11:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJINflfnixbbcQ99J2apjempSeXAlWGD/Q7p/bS1pLZID2PiNqKOal81VXjgLT7btCyZkPFqFUHydQLoy/tN4=
X-Received: by 2002:a2e:85c3:: with SMTP id h3mr2400839ljj.122.1572793911266;
 Sun, 03 Nov 2019 07:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20191009151019.13488-1-mcroce@redhat.com>
In-Reply-To: <20191009151019.13488-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sun, 3 Nov 2019 16:11:15 +0100
Message-ID: <CAGnkfhzj-X-R_4toZdJ2eBfhpq1t0dHYq=P+0w-VD30ZAh59qQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add make dir-pkg build option
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
X-MC-Unique: QeFZRFkJO02tuALSiz7RpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 5:10 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> Add a 'dir-pkg' target which just creates the same directory structures
> as in tar-pkg, but doesn't package anything.
> Useful when the user wants to copy the kernel tree on a machine using
> ssh, rsync or whatever.
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Hi,

any comment on this?

--=20
Matteo Croce
per aspera ad upstream

