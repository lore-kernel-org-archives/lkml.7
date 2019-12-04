Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D8C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F5D2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=home.nl header.i=@home.nl header.b="SaRSN727"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLDL7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:59:14 -0500
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:54434 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbfLDL7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:59:13 -0500
Received: from [212.54.42.110] (helo=smtp7.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <karsdejong@home.nl>)
        id 1icTJG-0006kQ-EJ
        for linux-kernel@vger.kernel.org; Wed, 04 Dec 2019 12:59:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=home.nl;
        s=201809corplgsmtpnl; h=To:Subject:Date:From;
        bh=ctsngSql8V/68u90oqG+vBHrsckbJGiTkA3lBY91vOI=; b=SaRSN727nU5S+gxITtR6+2S+ul
        KFyuhCD/6cjLU22oc+vGCQkP1mjLN97ofITwZzKvgCZio9r74GCzFu85IDBle1S7mJLe8PG7gDgCv
        qyTgeHdDnQCODZ3QlxeOaIdUBH46nIXNhXAoYIPg+CqV4pnJTaxfqQP3kKvzleQV3ElFBUx1Wl3g9
        uBP5XP/E+y7GLKh3By7EEzIzP3o1PTkaYv28xS7Kd2i+Iz1rNiws5V0pYxNjisC8HcVNc0f3GkvXc
        puDj49B/GZoIT1LoGx5g9EmfTa4nh9M8oypIr2zND52vyGuUpw2P/ZztqcUucL1fOErZXgLgFEUGD
        HnORmc8Q==;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
        by smtp7.tb.mail.iss.as9143.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <karsdejong@home.nl>)
        id 1icTJG-0007h5-91
        for linux-kernel@vger.kernel.org; Wed, 04 Dec 2019 12:59:10 +0100
Received: by mail-wm1-f41.google.com with SMTP id u8so7623692wmu.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 03:59:10 -0800 (PST)
X-Gm-Message-State: APjAAAXUUMw+CMCIDlWPNSbVw6sqePwu1iIsaSWdO2ghA/VVOs6SyN/+
        GB/HW9/2KcA3VooMIv6vvSg9PsduOSvK5hM9USg=
X-Google-Smtp-Source: APXvYqzoOGNqo/C6gUey7nH9NPOkmtnUbyrg2K//qgNr7vxg1TRx1SLn451bLnlEPnxZn5lZKJYvmIVOtPF2pKSgGQI=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr39417372wmh.5.1575460750071;
 Wed, 04 Dec 2019 03:59:10 -0800 (PST)
MIME-Version: 1.0
References: <021330b6-67a2-0b74-c129-5c725dd23810@infradead.org>
 <CAMuHMdVLusDDB5G1R7=-53sK1bd2+3=s42hr9xkgPtWyjOrozg@mail.gmail.com>
 <CACz-3rjOPg_rMt_FbJ5_nKLpjTK-Bv=amGsJpXwqbTBNX4YA7w@mail.gmail.com>
 <CAMuHMdW1iqNkmCztAv93W4eLR5ooxh5m+vRLJHJmCfrjsOmc5g@mail.gmail.com> <20191202160101.GB17203@linux.ibm.com>
In-Reply-To: <20191202160101.GB17203@linux.ibm.com>
From:   Kars de Jong <karsdejong@home.nl>
Date:   Wed, 4 Dec 2019 12:58:59 +0100
X-Gmail-Original-Message-ID: <CACz-3riEr_HFAxQV8aorSqSwCyX9ZutwUqRR0qK8DuWg8ZWsJg@mail.gmail.com>
Message-ID: <CACz-3riEr_HFAxQV8aorSqSwCyX9ZutwUqRR0qK8DuWg8ZWsJg@mail.gmail.com>
Subject: Re: m68k Kconfig warning
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-SourceIP: 209.85.128.41
X-Authenticated-Sender: karsdejong@home.nl (via SMTP)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=J/PUEzvS c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=pxVhFHJ0LMsA:10 a=VnNF1IyMAAAA:8 a=OLL_FvSJAAAA:8 a=jEDXOZ2Y3Er59CGDZ9IA:9 a=QEXdDO2ut3YA:10 a=SJ0VGiGEqQ4A:10 a=q0Gla3feQdIA:10 a=oIrB72frpwYPwTMnlWqB:22
X-Ziggo-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike!

Op ma 2 dec. 2019 om 17:01 schreef Mike Rapoport <rppt@linux.ibm.com>:
> The patches are here:
> https://www.spinics.net/lists/linux-m68k/msg13588.html
>
> Aside from some technicalities we had troubles deciding what should be the
> section size. With larger section size we might end up with wasted memory
> for memory maps and with smaller section size we'll have to limit the
> addressable physical memory...

I read through that thread. I believe our current page->flags needs 22
bits for the normal FLAGS and 2 bits for the ZONES, which leaves 8
bits for the SECTION. This is what Geert found out (it worked with
MAX_PHYSMEM_BITS = 30 and SECTION_SIZE_BITS = 22).
I think we can reduces ZONES to a single bit. We currently put all
memory in ZONE_DMA, so I think we might just as well put it in
ZONE_NORMAL and disable ZONE_DMA.

That would enable us to have 8 MB sections and use the full 32-bit
address space, correct? That may be a working compromise?

Kind regards,

Kars.
