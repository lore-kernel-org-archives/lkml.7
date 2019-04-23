Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A93C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDA1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfDWRPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:15:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55790 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:15:21 -0400
Received: by mail-it1-f194.google.com with SMTP id y134so1420104itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=go/WpspTufvCzyVRSJz1x1OJRk17MOMRcR7MhLrkz+g=;
        b=AYE+289seI14avU0cBWJRmyKmn8/LqOffw/3Dvueqo9CrcYl+t30Y4KRP65g5fd6xJ
         +HC+13lukkkAn64iKBJEK58nM1WMv2z3TDVDcapWhcYPZa/ZYifmW+9ux19014En68nP
         UW1G0Sk44yVZzZCKCkzh9Yq9qCFgWU3VzyT7Hr7R7li+JMZyZp7jdnMhCxKRjO6NVF91
         OrKmDHfM1QXwD1F/myrcNRReREVNTDwiDSLAn3ib0BKDqag2/kDwn5jUlUrHnlr5rNcA
         ujss7UUWNZbQE+hOFwd5kT4BWXl2lWXKd7ejLQVDbVB7qICm+J4QuBsQg/LpwAn4Xr2x
         g1Lw==
X-Gm-Message-State: APjAAAXQ3iQMNLW+A40cDgJHV8isOAVr6iNbE5d7u3ULczDXHl8/VLo/
        3qU5t2uuMJDYoJuKbjvWUpsVwRPjququO1y9GSXlhw==
X-Google-Smtp-Source: APXvYqzxA0QZw0J123f3fEoyl66/SYWBNklyklOfwwSVivihwi5QRR1EfUBPwCCrkNjNzvnWD3UAmfUSFnpd/rhWQkw=
X-Received: by 2002:a02:ba94:: with SMTP id g20mr12015282jao.51.1556039720616;
 Tue, 23 Apr 2019 10:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190422092804.15534-1-kasong@redhat.com> <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
In-Reply-To: <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 23 Apr 2019 10:15:09 -0700
Message-ID: <CACPcB9d-oNvp1Kag1J8X+QBdgqfU0ps1OztjOk8n=Pw2G6ONWA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:21 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>
> On 4/22/19 6:28 PM, Kairui Song wrote:
> > The reason is the systab region is not mapped by the identity mapping
> > provided by kexec. Currently kexec only create identity mapping for
> > mem regions, wihch won't cover the systab. So second kernel will be
> > accessing a not mapped memory region and cause fault.
> > But as kexec tend to pad the map region up to PUD size, the
> > systab could be included in the map by accident, so it worked on
> > some machines, but that will be broken easily and unstable.
>
> Is the mapping of ACPI tables just by luck, too?
>

Good question, they should have same issue with systab, I ignored this one.
Then in first kernel when doing kexec it should ensure both ACPI
tables and the EFI systab are mapped, that should cover everything and
make it work.
Is there anything else missing?

-- 
Best Regards,
Kairui Song
