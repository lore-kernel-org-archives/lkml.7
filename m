Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D6F2073F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfWmUc2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfLBStw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:49:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727978AbfLBStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575312591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nOlZklbXEP/MfMud/ZUPVb3jHYNuzoALbQz6584AH8=;
        b=JfWmUc2RX14/O87FfXSLO1zBiEsaxRjqDs7Kqpr9M1SqW5NGbQ+Xrgzz9Z0vXTArIS77JJ
        eoI/Oif0kkUX7K43funi8Xgq03JnhYCfBYm9lWfisyA0e4Tc6na6iR96A/PsAdVp7R57X1
        cL8P1HToU1hnhBjyN+BhjNk+urVFoHo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-4D_gwrroP6ugE2UW0JeYnA-1; Mon, 02 Dec 2019 13:49:50 -0500
Received: by mail-qv1-f71.google.com with SMTP id w7so349505qvs.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=8nOlZklbXEP/MfMud/ZUPVb3jHYNuzoALbQz6584AH8=;
        b=gEPiM8vFewKtDT2JAdzpv1ybYXg5Q6X6Gl2/K5gZ3EDXtu1mKBufImh1RKGwca5L9a
         V+ns3jbPrsGSLCoX9bx5fuVCr3glCWUXz8100FWljUYnT4PwJ7qNo0jmdvFbCzLU1ZqE
         V1HI7eY5j0jtRX1SgvUq0XJHLDTCbWjrVvK2ytzurdeyjqZBBcprQRXY9LOqp5Gl7tch
         GbArS+rgTdKif6dDE6ZZRXa3BaCiU0D4K2HBL7Mn1aVo2g4/r19rAXAI24N9+fz/bUh3
         0GmIR4ZB8CCizj7CKhjCG72rZLdvI7ICHEyZmxTgvbEP0e00WJMR5QuZsEiYLl/WTODC
         g/EQ==
X-Gm-Message-State: APjAAAXQSkMQh+mVwtQKOrxWlt2QAX7UX2hguCmmduD3PJHMaCHEHz5O
        7FMWkyStbpB0+6lsgyHQZtKCQ0XPvJ6d3Y/7TqCU+8aBbNoTEix2c24i5S3PIMv7/LcXqbRpsyy
        ib/LqY/eXdjKYVvrLjko07rlL
X-Received: by 2002:a37:4b06:: with SMTP id y6mr348923qka.14.1575312589758;
        Mon, 02 Dec 2019 10:49:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJRF1Uj8hXpkhpro16Z/MJEwD9ISyeLmMqcRIU5Abi4M9QOoQSdoBpNoTX1Z/vjA6P7T3A3A==
X-Received: by 2002:a37:4b06:: with SMTP id y6mr348899qka.14.1575312589488;
        Mon, 02 Dec 2019 10:49:49 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id y187sm245824qkd.11.2019.12.02.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:49:48 -0800 (PST)
Message-ID: <837a221f0fc89b9ef6d3fbd2ceae479a5c98818a.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Fix build on systems with
 STACKTRACE_SUPPORT=n
From:   Lyude Paul <lyude@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Dec 2019 13:49:47 -0500
In-Reply-To: <CAMuHMdUz7gewcFPE=cnVENGdwVp6AZD7U4y1PtwXTAmoGmvGUg@mail.gmail.com>
References: <20191202133650.11964-1-linux@roeck-us.net>
         <CAMuHMdUz7gewcFPE=cnVENGdwVp6AZD7U4y1PtwXTAmoGmvGUg@mail.gmail.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: 4D_gwrroP6ugE2UW0JeYnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

I'll go ahead and push this to drm-misc-next, thanks!

On Mon, 2019-12-02 at 16:20 +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 2, 2019 at 2:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On systems with STACKTRACE_SUPPORT=n, we get:
> > 
> > WARNING: unmet direct dependencies detected for STACKTRACE
> >   Depends on [n]: STACKTRACE_SUPPORT
> >   Selected by [y]:
> >   - STACKDEPOT [=y]
> > 
> > and build errors such as:
> > 
> > m68k-linux-ld: kernel/stacktrace.o: in function `stack_trace_save':
> > (.text+0x11c): undefined reference to `save_stack_trace'
> > 
> > Add the missing deendency on STACKTRACE_SUPPORT.
> > 
> > Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking for
> > debugging")
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
-- 
Cheers,
	Lyude Paul

