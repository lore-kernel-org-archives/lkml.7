Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D1DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7952148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 07:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCUqeF3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfCQHkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 03:40:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38495 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQHkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 03:40:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id a6so7185150lfl.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qdSk3cyV/A0e9SOz8/hMmrBWhPETRNd8mDDeCA6F9M=;
        b=UCUqeF3lRmC+gISlLUDtLgKnzFY4WB35r+3XmLF3XI7HXY3+U4Dycp/1kX6blCi0jS
         YuErStMsHI6t0PjMCbYMpIKyhjsiZmMGsMmDgLERaIzhreJmjR2qwODcTkh3c2CllPnn
         lx7j3XPPPI2PPfTTxJc2Aw+fkEytHhQpBIH3CLJ7hnld4Tz78uR3Rk6804pcrSwO/1p9
         IeEOIZ9q8kw+RYcNIWXGgeOwoT0H6CGaA1VpBef+jy+I/Bg9bOxfjwUaxb2qFWAHV443
         GmeqOSqkZQzF+ZeJ1Pez35Ub6AGnpk3Wwb5rRcQiiNlw42T0NQmw1mdxK7iAjyS1kGnx
         63zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qdSk3cyV/A0e9SOz8/hMmrBWhPETRNd8mDDeCA6F9M=;
        b=rFASfkLU6SrTz40Y52R6r88gggqn8rrUZqkyAK0GbZTdJbVtfWBboTft/xoNi0zylK
         F+WHfMNxdg3GEwvJrVbO/WamoIr7DeD0zmTpGlPvs1Jp0DVh9LC/4wlxNs+hIobAGMdt
         T/i/M4aCs1CPgnF+Wi1/R4wdWGBqRYEoeybWiZr9t6CSzYv1DiRiSSHu1hcmhZaEXirt
         80Pz26ftHob2vuxLlmeZlOq0Jy0WDwLOqfL6ZXR/VFAIXX8CNJT10mOWUh33ZUXcimz0
         MW2ZtMbJB0364fuJ0ppE91AkN9v9z+wqGbDRoS6YwknOQ975Ko1Y28h0RSjfhSU7uD4L
         12AA==
X-Gm-Message-State: APjAAAUh9BFDQ55PYtZq4FM/QrIf3GYwl7C2TCjIAw/4LLd+voQnsaiG
        k8pT9zko4n5yxpDc5kO02mvQqj90boCBqRHKKcDm0Q==
X-Google-Smtp-Source: APXvYqxPqOUb0uI7vnLkOZes4x+YRxKzE31fhGRzRPYax7SShcfHO7iBfHJ843Xg1NUOTsV+t2+6x9eSMqzO0w6Pny4=
X-Received: by 2002:ac2:44a6:: with SMTP id c6mr1248631lfm.31.1552808418215;
 Sun, 17 Mar 2019 00:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
 <CANiq72mmeCv+mVGjE39OMxaJH9CDmDSDuDkdXo7aG+edxo3ekg@mail.gmail.com> <20190312154647.GK9224@smile.fi.intel.com>
In-Reply-To: <20190312154647.GK9224@smile.fi.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 17 Mar 2019 08:40:07 +0100
Message-ID: <CANiq72mxKbKttrd-YjeYPL8JgU=BhFpL92cipUs8cmyOZp64yQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] auxdisplay: Introduce charlcd_free()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 4:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It seems these two series are orthogonal to each other, so, can be applied
> separately.

Sent to -next for a few days.

Cheers,
Miguel
