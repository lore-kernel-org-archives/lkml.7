Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B9120828
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577152720;
	bh=wrDzBWpOKSiwcb+qBm67fhEmniMtsPe08K1CDqJG+aQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KPr70DjvKTAxoXUY8YfLT6AhmGWQulJRORh3EL7trIYDlBmEPewWVHC6MvI2wzSfh
	 CiQmGZD5nD+7TRoL9HiQzsGx8pIeXnP+8tYXykUj5rTAgSrZ3CiVyK/+7iD/lqmBOg
	 Da90XAoayh13VzIGv1sX+ZfS0xwMs9iR9/JWAnWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLXB6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfLXB6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:58:39 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88CAC20CC7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577152718;
        bh=wrDzBWpOKSiwcb+qBm67fhEmniMtsPe08K1CDqJG+aQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oFYra1GnrPYPW0VIb0ihhkc/X1ko+xfQht7/2IKlWIyfO6uNchY0GOmxSOCGWBnY+
         oQU08j1ThgwFiIxFVbPwHNZ4a4Bg8WDDE6yE6w4LCePbFzjER6HYQqZgnlhUqcpAns
         WZQxExfAhEzKuKRq9E0Du+n4NTas+PLc/RJdGJLU=
Received: by mail-wm1-f41.google.com with SMTP id 20so1289621wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 17:58:38 -0800 (PST)
X-Gm-Message-State: APjAAAUByLzJMlpKUwqN2omunnUtwBQ+jcoRUUSYdRL1tYMs91cB2Af2
        yr/V8/OJp/vRLwuiJr/3FwyuRn5AV3chaK1ObOej1g==
X-Google-Smtp-Source: APXvYqxwNlYNszeowAFN0oKu0h4yW9ADusJeScbE5XRItW37UFXluNES85cpW6MmdJIXJdPRzP47hHREp3dIH3wiI6I=
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr1469926wmi.89.1577152716961;
 Mon, 23 Dec 2019 17:58:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577111363.git.christophe.leroy@c-s.fr> <fc1ff722c7cbe63a63ae02ade3a714d2049d54a5.1577111367.git.christophe.leroy@c-s.fr>
In-Reply-To: <fc1ff722c7cbe63a63ae02ade3a714d2049d54a5.1577111367.git.christophe.leroy@c-s.fr>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Dec 2019 17:58:24 -0800
X-Gmail-Original-Message-ID: <CALCETrV1TWD4iMoGFX6abxXFukz081Y2XaXy6p1KJBNLpp6ZTA@mail.gmail.com>
Message-ID: <CALCETrV1TWD4iMoGFX6abxXFukz081Y2XaXy6p1KJBNLpp6ZTA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/10] lib: vdso: don't use READ_ONCE() in __c_kernel_time()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> READ_ONCE() forces the read of the 64 bit value of
> vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec allthough
> only the lower part is needed.

Seems reasonable and very unlikely to be harmful.  That being said,
this function really ought to be considered deprecated -- 32-bit
time_t is insufficient.

Do you get even better code if you move the read into the if statement?

Reviewed-by: Andy Lutomirski <luto@kernel.org>

--Andy
