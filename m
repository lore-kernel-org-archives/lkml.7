Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C0C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0072070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4JnvcHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgAHJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:23:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41110 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbgAHJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578475388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OW+NENTSPQrGIchGYvDqUAB5SzohVckTzCwnqHad2AY=;
        b=J4JnvcHcLbMsMv7wFKfYL2gLYsGXEbuyerXm91R2CEh4ub/JTqe/pbdRjN3N5yBC2c0zJz
        alrCumWIx9Pj3/Sqx6aOVh1CG/clPP/FPOky37vloqVnLXsYOq1sPbZmua69gKNlkOOxMw
        467xz5j7VsDkfiLv6gjVXV7Cx3DKUj4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-6c-OxUd4PW2AuEKeiwFIwQ-1; Wed, 08 Jan 2020 04:23:07 -0500
X-MC-Unique: 6c-OxUd4PW2AuEKeiwFIwQ-1
Received: by mail-wr1-f72.google.com with SMTP id f10so1189963wro.14
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OW+NENTSPQrGIchGYvDqUAB5SzohVckTzCwnqHad2AY=;
        b=IsUNiOLy3uzFU2qcvhOM3om+MY8mI1l0Wu9LQSblFrlCfqhNZRd5WC4RksKd/vTUdY
         bzd8TN58QFGDC0TbUdPTsoF14SdAiiWaeh3JycQdpkBn00lXFIMtB4xOXEGhasviQvWE
         u0ImKamTbnfD0O6/zzacrWCsYNTgPGY4kazbJzkdfNHHb1+so73WHVMzniZZGEH27vh+
         K7nJTQAAAmF3KYP4mDiDWmYOoEaAexsAIgG8bD1VIASUoCsBuHRwfBIyhv/wvcd4+U7C
         l3Pth0jJhHHdNcVWAz8HH9jQ1GvbE0kgQCKr8Gt4uoTjCkEZ7p3k/CrwBr6ElqPFFn8a
         GxDg==
X-Gm-Message-State: APjAAAWIN7CdnvoOKFhRlPbSiUeqsb0whvWoYVysNGiWojlhGVSpoD4+
        xbIcE2ciq55SCvBF11UUIg1SfObECcF6qVGRKonodUsxgGOCG0n2826roNsyk22q8vQ5RmsxGoE
        AS9WIxbyMSJiPbOgDgKvlisQe
X-Received: by 2002:a1c:720a:: with SMTP id n10mr2559836wmc.74.1578475385819;
        Wed, 08 Jan 2020 01:23:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8bUWUwxYaEzXfrHxeu8jFAXDpbz4NbKayx6ImZmFc856nfBE6VK7qEwGhGtpbjvn6DMcTlg==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr2559817wmc.74.1578475385651;
        Wed, 08 Jan 2020 01:23:05 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q19sm2947036wmc.12.2020.01.08.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 01:23:04 -0800 (PST)
Date:   Wed, 8 Jan 2020 10:23:04 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: work around bogus -Wrestrict warning
Message-ID: <20200108092304.6rgulye4zvgptxt7@butterfly.localdomain>
References: <20200107214042.855757-1-arnd@arndb.de>
 <20200107142512.b3d63df56ffee1ef471b6acd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107142512.b3d63df56ffee1ef471b6acd@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, Jan 07, 2020 at 02:25:12PM -0800, Andrew Morton wrote:
> gee, is that even worth "fixing"?  Oleksandr, I've seen a couple of
> these false positives.  Do we know if anyone is taking them to the gcc
> developers?

I'm not aware of such an effort. I tend to blame compiler as an option
of last resort, but if Arnd gathers enough examples (since he's working
on fixing/working around those), it would be reasonable to suggest him to
hand over those findings to gcc bugtracker.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

