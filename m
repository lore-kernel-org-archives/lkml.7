Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7404320856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6BnbfJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390187AbfJ2P6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:58:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46736 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389319AbfJ2P6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:58:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id e66so12715002qkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DM3O9N7/77ihd4L+w4LGNt2vkA69HpxTL+DxOwueRJA=;
        b=b6BnbfJ+LstWB3B2qxirYa9kEcyXhpRBPyALY88QBrlZNUCGlaws1nvgAEUIrgIY/C
         LP0k+/CEbT7pYXip6EoZ6qLf/Qb03UpnXcyOgbjKZPC9tALl+VU0NVAEJHcaXVtgyxD+
         LE+AZHifsnSXuk0bdlkrnhXtvOPnf8b7cGVhibJC6tcttvPKBYC0JZO32bhlWouFIDH8
         smsvbZFgkzwV4H5WIK67VtuKp9VgMm18lVuZRqe6lpFxTa3mpPlRUK+tIBSSyMVDHJTB
         ObvyAviTEnuTCHLVqpLQ8Y6/72dPBYyG1aT9Z+84gsmQgxfZNOG1menHWqyoYCaBO/Qi
         husw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DM3O9N7/77ihd4L+w4LGNt2vkA69HpxTL+DxOwueRJA=;
        b=eraEeNETSu0B82Qc39YpBKmVVYq7RTRAp/7KK8p4yrbZAwYnG9xZgFKNxWqJXmiwuf
         3NMmVUimoeAsqnnxzCcYSrDHaJTPFq1TeeZSXmxOfdDuyoeQqar/9TOKWlKdPDds9iJ9
         WGf60W8EtWfxRHoroZVLSbe3jDG/Y3SHs5FRGKGLQns3mcms/PdJ1SPJnYotHEXmVu65
         U58GVgFJQaF52jkiY2ZjKArUN1hUJJi4VJdjEWoNqKcEmphblDIJuE0JzdEvdGTliHCN
         u+YMScm9eA6jCU2jaDymGPBiAdQhx+8fM/p4vnlnrjZfcRE3VY4vskwEVl09Iwox1EHk
         xIIw==
X-Gm-Message-State: APjAAAVZtbefHaHfgSmA5TK1xNZqkHiIzOVy4IONigWOEcOzlhoAHL9L
        yDop2eDwCj6VtvwhHykesQ==
X-Google-Smtp-Source: APXvYqwk3hOM2W9vhvb+1Oui3nfDrFiyIQB5o9Yfsefz+wb/YUr5n85NBz2VrYyFYXt/THh+rdVBQQ==
X-Received: by 2002:a37:9442:: with SMTP id w63mr21600482qkd.138.1572364691121;
        Tue, 29 Oct 2019 08:58:11 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x38sm9991789qtc.64.2019.10.29.08.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 08:58:10 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:58:07 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Adjust the padding size for KASLR
Message-ID: <20191029155806.gryhjwentwpyqmt4@gabell>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
 <20191029025920.GO8527@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029025920.GO8527@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On Tue, Oct 29, 2019 at 10:59:20AM +0800, Baoquan He wrote:
> Hi Masa,
> 
> On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Any plan about this patchset?

Thank you for pinging me and so sorry for the delay.
I'll post the v4 in this week.

Thanks,
Masa

> 
> Thanks
> Baoquan
> 
> > 
> > The system sometimes crashes while memory hot-adding on KASLR
> > enabled system. The crash happens because the regions pointed by
> > kaslr_regions[].base are overwritten by the hot-added memory.
> > 
> > It happens because of the padding size for kaslr_regions[].base isn't
> > enough for the system whose physical memory layout has huge space for
> > memory hotplug. kaslr_regions[].base points "actual installed
> > memory size + padding" or higher address. So, if the "actual + padding"
> > is lower address than the maximum memory address, which means the memory
> > address reachable by memory hot-add, kaslr_regions[].base is destroyed by
> > the overwritten.
> > 
> >   address
> >     ^
> >     |------- maximum memory address (Hotplug)
> >     |                                    ^
> >     |------- kaslr_regions[0].base       | Hotadd-able region
> >     |     ^                              |
> >     |     | padding                      |
> >     |     V                              V
> >     |------- actual memory address (Installed on boot)
> >     |
> > 
> > Fix it by getting the maximum memory address from SRAT and store
> > the value in boot_param, then set the padding size while KASLR
> > initializing if the default padding size isn't enough.
> > 
> > Masayoshi Mizuma (5):
> >   x86/boot: Wrap up the SRAT traversing code into subtable_parse()
> >   x86/boot: Add max_addr field in struct boot_params
> >   x86/boot: Get the max address from SRAT
> >   x86/mm/KASLR: Cleanup calculation for direct mapping size
> >   x86/mm/KASLR: Adjust the padding size for the direct mapping.
> > 
> >  Documentation/x86/zero-page.rst       |  4 ++
> >  arch/x86/boot/compressed/acpi.c       | 33 +++++++++---
> >  arch/x86/include/uapi/asm/bootparam.h |  2 +-
> >  arch/x86/mm/kaslr.c                   | 77 +++++++++++++++++++++------
> >  4 files changed, 93 insertions(+), 23 deletions(-)
> > 
> > -- 
> > 2.18.1
> > 
> 
