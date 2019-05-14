Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D85C04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE52F2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CP1BLuEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfENAJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:09:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53167 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfENAJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:09:08 -0400
Received: by mail-it1-f195.google.com with SMTP id q65so2101387itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 17:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HphT3qTvq5UdCdGPdQO1TQeURllKBKA+AUqyDn7/1x0=;
        b=CP1BLuEj7GtUX8yOGSqFVWuCbXWttADOva4sWa9vu8tC6BQvUAYKviT6WDwvIM3O5r
         Etob3Moc5MxCOFv5xvTaSEOMksUNHQJg12UYNnL9s4YT/2gYGDVLSEIXAC5QOyH9j56I
         oBmx3V0G8BVII55FlQoe57BwP8YbgXNoBycnPU+oumsWNPizYDo2dOuuPDYlV9rlgCJO
         tWM3J+78NG7fMPrIFhrx9ISUolraR85pa4+9VO6nRCIisXHPHXwXqlx0DaTHDnNgm+QQ
         /iWNvE4qnxPh/+y8yl7DJcquptQItkx2Tw6yPnEA+c1B2QFWJmf5+K2ZZ635G1GEzDJN
         AlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HphT3qTvq5UdCdGPdQO1TQeURllKBKA+AUqyDn7/1x0=;
        b=ElHvqUOIcnJ7vAsc+juybHdC1Lsx8p2eh7+nCy/AiFPBDFMRnQC1GmZCdzmg1Ubura
         aywq/x72aRxXyCrKcA0EYEYlC6Cs6mZd8wqa78gdFsnFUTuQGc6tmGu+O81vhWw+enT5
         1ndfk7awRolltbYUwt061RhdfhwvlF72rpCyxx4tEpnYqJnqPkp/PF0qSn91wsrMVsRA
         XPes6qkcdbSrYtNxC4v4N1A4unpOqK9D5BGq4NNmYk7XKeHURHbp+FIIHakkKB/wFgVP
         k1opGC6j7b/vgRnZZBgRaXIQ0iSgjs2+upnmk3S8kPX+yE0tD/B2KsY/sc7l8ZSmdEFr
         h/GA==
X-Gm-Message-State: APjAAAU+OrnfUX0c/3ujF5xAdmC1VhBmt9IkZ8cYAPn9efXWZRk6z0vk
        hZSpq08KskGElLkz5irtkRTC1A==
X-Google-Smtp-Source: APXvYqzHyts8OBQyxsw5e8kZG39QfbMC8l/0UaPuk4TeHRNezcNJrMMGzSEE63spk8rJ9uYAOmmJcQ==
X-Received: by 2002:a02:1dc7:: with SMTP id 190mr19786726jaj.62.1557792547471;
        Mon, 13 May 2019 17:09:07 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e2sm456547ith.39.2019.05.13.17.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 17:09:06 -0700 (PDT)
Date:   Mon, 13 May 2019 17:09:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "merker@debian.org" <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
In-Reply-To: <a498967c-cdc8-637a-340b-202d216c5360@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1905131704371.21198@viisi.sifive.com>
References: <20190501195607.32553-1-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com> <a498967c-cdc8-637a-340b-202d216c5360@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019, Atish Patra wrote:

> On 5/13/19 3:31 PM, Paul Walmsley wrote:
> > On Wed, 1 May 2019, Atish Patra wrote:
> > 
> > > Currently, last stage boot loaders such as U-Boot can accept only
> > > uImage which is an unnecessary additional step in automating boot flows.
> > > 
> > > Add a PE/COFF compliant image header that boot loaders can parse and
> > > directly load kernel flat Image. The existing booting methods will
> > > continue
> > > to work as it is.
> > > 
> > > Another goal of this header is to support EFI stub for RISC-V in future.
> > > EFI specification needs PE/COFF image header in the beginning of the
> > > kernel
> > > image in order to load it as an EFI application. In order to support
> > > EFI stub, code0 should be replaced with "MZ" magic string and res5(at
> > > offset 0x3c) should point to the rest of the PE/COFF header (which will
> > > be added during EFI support).
> > > 
> > > Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
> > > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > 
> > Seems like we're stuck with this basic format for EFI, etc.  Even though
> > we may be stuck with it, I think we should take the opportunity to add the
> > possibility to extending this header format by adding fields after the
> > basic PE/COFF header ends.
> > 
> > In particular, at the very least, I'd suggest adding a u32 after the
> > PE/COFF header ends, to represent a "RISC-V header format version number".
> > Then if we add more fields that follow the PE/COFF header -- for example,
> > to represent the RISC-V instruction set extensions that are required to
> > run this binary -- we can just bump that RISC-V-specific version number
> > field to indicate to bootloaders that there's more there.
> > 
> That would be inventing our RISC-V specific header format.  However, we 
> can always use the one of the reserved fields in proposed header (res4) 
> for this purpose.

What are the semantics of those reserved fields?

> Do we need to add it now or add it later when we actually need a version
> number. My preference is to add it later based on requirement.

If it isn't added now, how would bootloaders know whether it was there or 
not?


- Paul
