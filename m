Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8FF206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP0Iq7/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfCFKEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:04:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34253 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:04:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id d26so8462985lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amiCGmOLNrYqhQWPhgnFN7rKslXa829jmZj04RAGSdU=;
        b=sP0Iq7/ZXHxecWdibBUBeXenMqJq6yr28wddmvLt/lt17X+i/NnGPaC9ThZVWSb9cS
         3wGbZeF/naYFOc/0vFVTUxBQahs0nShNu1SkT7M29Ksq0qJCZux4UcmHRdshhWkISEuT
         BAik8aYsXmnCWJnN1kXruml4Nm6AB6+2UkBKMtwIxpwnHwXMKoYodQcLNmSJzUfjVFVQ
         IA36D9qmV0HeQRpVZ6SGKjUj5I88XgT2AnSXHC3aEulHv+C9uJiBLI1VG8m2dxArHvvD
         KqliNeWrMWWQRWh7WuLZQklTizOv/sxTKJjhTE5IoK/oObWHXIiZChSCdUicDe5htRAD
         iktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amiCGmOLNrYqhQWPhgnFN7rKslXa829jmZj04RAGSdU=;
        b=fwNvQ11MMghQYoA3RtPmsRCvc7v8TCPtVBSW/2KtSYLmjbFSa00vF5S5IJBYfydFni
         ciItb6PG6P/vsh/g09Bkau2c+2DY40oLlxVMwUznMETpkBWPxEtbNkrH0UiuriKToEiU
         hEn67D65rs8TdBAVGv8X8OJpaSAwjuWx8x5GxxpIKM0A6XW+77wz/MFOYQ50xCP5T2o7
         SoyLevV/pL3hnjrzvaRDiLu/FBsYqfUdcJMJicYhGsrcPE+G8CW1GshNQMCCa66c0a8n
         3xPEfJkROkc0PVd3nCdNy+W/Zz4hWORtN4MUDidn4VVwoR+EW40nYPMFaacyHVKCINtR
         CtPA==
X-Gm-Message-State: APjAAAXWUZhQli8dhyy8/MjRnXCyNzbEH3zI4eqBicxvYh4j0OygtHTv
        Gti0qoxifU+qtwBDfBR+HKfL6vJRE+GbOyjGSZo=
X-Google-Smtp-Source: APXvYqz9G45DWZagn+J4cOt5hDEGAhnRiZBpsybOBgHY6wudJZrHpCkkO54GlkJzhAaui+qpUSBhhbfctduVjN5IIjo=
X-Received: by 2002:ac2:510e:: with SMTP id q14mr3390283lfb.151.1551866643387;
 Wed, 06 Mar 2019 02:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com> <20190301184816.784-3-mans@mansr.com>
 <CANiq72nFOhrjN0nfBQc28dDyY0XPwWrJwWSkXv0yxGb-B2M-JQ@mail.gmail.com>
In-Reply-To: <CANiq72nFOhrjN0nfBQc28dDyY0XPwWrJwWSkXv0yxGb-B2M-JQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Mar 2019 11:03:52 +0100
Message-ID: <CANiq72k-svkxyUndC7H0+Rc6ZSPX=ZCnFfYDUGfh=KxogWydYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 10:56 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> CC'ing Willy in case he wants to take a look for charlcd.c

(and Geert, sorry!)

Cheers,
Miguel
