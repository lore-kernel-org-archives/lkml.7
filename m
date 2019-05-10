Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2CCC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D592020850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgvDTPys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfEJWR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:17:27 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33887 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfEJWR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:17:27 -0400
Received: by mail-lj1-f181.google.com with SMTP id j24so5537457ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yudu0KGXXEen/gu0MZhWVgl3gR7S4SxzP867FLT6q8s=;
        b=HgvDTPysoCGI0N+DjelK+v+fAx0H5D7NXc+VzMhcZNPtcqtU70tS9Y3nVgstHQkc8u
         AVlNwZ8G6sVz6S44hB+JQnFmKymMDeR65I8iOCh4SbDZ5aJbP9QjDo+wXaWcnh7Sh7Hi
         TStDY3yx7I8mwQ0ITsVs9gDZ27yh6BoHZb9AYmWny0qlUFDl9gm0l9h/PI+CdWR7wapx
         UG3rmoz3dw09hBKDzzbNUFNmrrvxrqQYBnpTDbOWM6axAhFFyVT/2Nvc2CDWqAgEbNc9
         neLQ7fk6vBJDhWXSgbFfU2mNCl/3KuyyPTAoGHB0pDMS6+wn5FvHzqXzrpOfB8tBkmvp
         URvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yudu0KGXXEen/gu0MZhWVgl3gR7S4SxzP867FLT6q8s=;
        b=AZpMj5d1MsBkTCQXU/NbDZAYfFzwpstPZOtnEiYDf5xE590V0brg7cSZhcso8gfGC5
         MuOsbSPlBMv7uq/4p/ZxJkaYwI6mvjGQeYSKKTOmb3zZE8cFtUcAr/irqZOFSRRw1Uni
         YHMJDib7q1svgVtaJgRg4qqselfPVzfp3pal0IQMYekRiVcbF1OMJ44CbvgKYT2RbL9Z
         IOqNS0EyiUMNDXJxDIvfxHzcy/tk4nLK+d5DASUVTzLAakgmw/T5N6CLk4850SNaigqo
         5sZFYqBwd8lby65dPJl0HBaYVS8QNZerIdKd267RYrq2b4OGiFch7Va2Lz/IsNWhlqC+
         zOmQ==
X-Gm-Message-State: APjAAAWuPA4Gz3R7VFTQubxXtW0ew+YvrgAMsl433GxmQOChHZzVt0uL
        XkI6muZhnScvVrtiXM4DP7EmHxiA6a8=
X-Google-Smtp-Source: APXvYqwlzP6chpnDG46VCyG/MNBNPMlj+6eV/Ak4YfHW0ioefB7axcgo/6NoiiFTwmyPIf/HOVox1w==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr7195713ljd.65.1557526645640;
        Fri, 10 May 2019 15:17:25 -0700 (PDT)
Received: from rimwks ([2001:470:1f15:3d8:7285:c2ff:fe37:5722])
        by smtp.gmail.com with ESMTPSA id l14sm1860937lfc.61.2019.05.10.15.17.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 15:17:24 -0700 (PDT)
From:   Rozhuk Ivan <rozhuk.im@gmail.com>
X-Google-Original-From: Rozhuk Ivan <Rozhuk.IM@gmail.com>
Date:   Sat, 11 May 2019 01:17:23 +0300
To:     Steffen Nurpmeso <steffen@sdaoden.eu>
Cc:     ossobserver@redchan.it, linux-kernel@vger.kernel.org,
        misc@openbsd.org, freebsd-current@freebsd.org
Subject: Re: Danish FreeBSD Developer hates jews collectively
Message-ID: <20190511011723.2e25dade@rimwks>
In-Reply-To: <20190510182231.k24xb%steffen@sdaoden.eu>
References: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it>
        <20190510073249.73a17721@rimwks>
        <20190510182231.k24xb%steffen@sdaoden.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 20:22:31 +0200
Steffen Nurpmeso <steffen@sdaoden.eu> wrote:

>  |> Background: Apparently a FreeBSD developer, a viking looking
> fellow, |> has been hiding a secret: just as many of his predecessors
> in the |> Danish cities during WWII (collaborators); He has a disdain
> for "the |> jews" collectively.
>  |>   
>  |
>  |Who cares!?
> 
> I want to point out one thing.  No, two.  One is that i concur
> with all left hand side arguments of PHKs blog post that was
> linked a 100 percent.  But that is my personal opinion.

I mean that this is "tech" resource about freebsd.
Who and what doing outside source tree is irrelivant.

ossobserver@redchan.it - idiot.
CoC - stupid thing.


PS: sorry for offtopic.
