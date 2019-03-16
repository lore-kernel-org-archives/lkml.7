Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC439C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5DA20693
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Y5b+PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCPKGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 06:06:10 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34188 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfCPKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 06:06:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id o10so10822523wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8D8D5LRHSugU8pShPjVwcDk9VzEUbHEEjWqUOMvNdsU=;
        b=D+Y5b+PF2VvFSiZrpw4RUtVKfdz9l26kOSDXIP3apoXPIJC9PsyPkVAUZ2r0t0WRJv
         gEOCfhNz8s17konh9PiGoVDCqUVsq1IcAgV6GlQniEXuWyP9i+dyDecwVsF2C6q+bG6G
         v89Uwd3O5OuGFgk/prr7z+yrV3z9O1HSwmBqPps4OnQgRc9PlTko8hzvdRs2lnd1op+t
         IBbCySWbCL6XbCnFzPy8uDU/xOALJ/hCsmOKknMd4zwlBwWOJGuDkZGQuxuFiNv4bI/A
         73sSZ6YF4Wd1kGQE9US5qt7pRFkaAv04r+R51YMQpJpylrx1LlWpuCAaLgppICA+fndZ
         s+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8D8D5LRHSugU8pShPjVwcDk9VzEUbHEEjWqUOMvNdsU=;
        b=CKNcwXQZEN/3yYNL6lxg+xmtnidGYZfKxfo9nSCwGzbZUNkd0x0QJTDjXfMjmTE/zw
         pWrEa9e24D+5JKtWTD+XtYQv2ILBY4YP9lxiEaxde0h3Uif27EidtFvvxLY86qIxj6Vy
         R8LBEVc8+H1H5fl2kdRr3RFgL1zGOuGRV7qhCTjbfJPzxAjZ1vOQi1qe5/ov3jEgfLHA
         BvzwAt8YBM+QOARBgbjkMYzUVNcAApvZNwFkOgGp0chYmq6QVcqRykJ/VtAqiw0DbVA7
         8Oie6+cFNgMTWjerk8KBHjdz57ruh4lf6gdsthn85FiIijEXgIFLZ1mtDLfSRqcS1XUG
         6Z8Q==
X-Gm-Message-State: APjAAAX7kRPDGWjeRpTPk9CVwBfu/U2iNGNAZacO2vUhH7t2Fk4Z83vE
        kVim0pm+PJvijTTjlgCAo9E=
X-Google-Smtp-Source: APXvYqz74dCjfFRQHYcrt0cmVLWgQRDE+LgfuMkLvK+H+JdjdJoP18T1TTg+CvgPYwIf/lMuQ4cSfw==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr5168870wmh.53.1552730767803;
        Sat, 16 Mar 2019 03:06:07 -0700 (PDT)
Received: from narunkot ([94.11.212.65])
        by smtp.gmail.com with ESMTPSA id n11sm10889867wra.94.2019.03.16.03.06.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 03:06:06 -0700 (PDT)
Date:   Sat, 16 Mar 2019 10:05:57 +0000
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Chris Brannon <chris@the-brannons.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
        "William Hubbs" <w.d.hubbs@gmail.com>,
        "Kirk Reiser" <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190316100557.0479c42d@narunkot>
In-Reply-To: <87ef77obtg.fsf@cmbmachine.messageid.invalid>
References: <20190315130035.6a8f16e9@narunkot>
        <87ef77obtg.fsf@cmbmachine.messageid.invalid>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Mar 2019 18:19:39 -0700
Chris Brannon <chris@the-brannons.com> wrote:

> Okash Khawaja <okash.khawaja@gmail.com> writes:
> 
> > Finally there is an issue where text in output buffer sometimes gets
> > garbled on SMP systems, but we can continue working on it after the
> > driver is moved out of staging, if that's okay. Basically we need a
> > reproducer of this issue.  
> 
> What kind of reproducer do you need here?  It's straightforward to
> reproduce in casual use, at least with a software synthesizer.  I
> don't know whether it affects hardware synths.
I meant if we can reproduce it at will. Then we will be very close to
the root cause of the race which is what it seems like.

Btw I haven't started investigating it yet.

Thanks,
Okash
