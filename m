Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B684FC04AB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963AC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfE1CuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 22:50:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54902 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfE1CuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 22:50:06 -0400
Received: by mail-it1-f196.google.com with SMTP id h20so1882155itk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 19:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8xDYjwWtMzw7kKK4/8CQKmcJnsMDJUuPxql44H0bgI=;
        b=AMXZYOPd3K0uo+rn8fd/kPI/GoQtv3GxiX5Cy3es2o5H/C3XCrAhooA6oXPMpzAf2L
         O3mnoesEE0Sh02OEwB9I3wXb3SERssI4VQpS9XFQDlHMrnBrVSZvgHRxy9AFc9WmVwq4
         mGQTXfpRIutPOxNX+NyM2ayMhrKzLOcauG5MBVIDDyXRF2kA7PF/p1zBBY55gE/KefYX
         hbBazLXIbkhqmGwD5fBlQZ/0tW/AAR6DNogUuGVKJZke5+8o6Sm9+2k+B639qxxrfuVC
         r4E8XK3k2JRYUFAUB6ZqU/kKXHdHnRZWeODEWc5j2PCLpTzKLJQDRfRkIGshvFAr3WHD
         vzwQ==
X-Gm-Message-State: APjAAAWb7ekqC5tBJs0W2wqcJvikrnb5B5pkugigiD1J9OGVP3aSjiLE
        k+9Ts2ghGbxO/TNlkQrHqXNuj5kQ5WMR2+n0+Jb1KA==
X-Google-Smtp-Source: APXvYqzcrvMD1G/2IfSPGE8fRNddmu61fH78L5xrp4cLcuFruI7q7nk+hb/HK8TTn9wN2yqynY6wWowySagIjUB7tvM=
X-Received: by 2002:a24:6cd5:: with SMTP id w204mr1486520itb.12.1559011805500;
 Mon, 27 May 2019 19:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190429135536.GC2324@zn.tnic> <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic> <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic> <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp> <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp> <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
 <20190521180855.GA7793@cz.tnic>
In-Reply-To: <20190521180855.GA7793@cz.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 28 May 2019 10:49:54 +0800
Message-ID: <CACPcB9fg5RGXcBbESNnn9rV0DSoh4jYkVWZrdcRWay5KKAjLww@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Baoquan He <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 2:09 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, May 21, 2019 at 05:02:59PM +0800, Kairui Song wrote:
> > Hi Boris, would you prefer to just fold Junichi update patch into the
> > previous one or I should send an updated patch?
>
> Please send a patch ontop after Ingo queues your old one, which should
> happen soon. This way it would also document the fact that there are
> machines with NVS regions only.
>
> Thx.
>

Hi, by now, I still didn't see any tip branch pick up this patch yet,
any update?

--
Best Regards,
Kairui Song
