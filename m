Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE66C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A00320869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxB0pyZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfDTSEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:04:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38221 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfDTSEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:04:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id f14so10133227wrj.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXy3muRIOs/YR24OX4VqJvJCa12VG7sXXh5d60ySxxo=;
        b=ZxB0pyZgCfgFU5loP7DkLE2W5rcwgOQIIe+e90FLDwcOK9oYy1Kz9c7UptxZG+ExMl
         w+gzyVzuYESn+rucQbqxcd67a6jr4i4HQ06uVOevMtOljDEBWAjm/yfVlMPM7JFCuDRd
         Ig/zLDtkAy/RINnkwOo9/029N76fnSGPfhVQa9jZzJspGQRtdmGMRiHf73/SWMXORhv1
         QpaLKGLITO/0i6bYzwUXEKjSNWOJ4CI14L1JpS/D1KGjWF0VxUuVcJgAAA4y+fXq3ous
         usKmPDg09y6TJoy8o8Yn04NPx71rOQh//IoKXuugFVvSN+SJjeWfgv9DwMcFxKVlXfan
         /T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXy3muRIOs/YR24OX4VqJvJCa12VG7sXXh5d60ySxxo=;
        b=EFVCgzXA8OMGXmT6wcckg0DgZ7fCVs9nulh0y8UYSvK4lmOoeXvgSAAEjN+B1CKHlB
         PkbGb+rz1lU84YCbdUrxyIm8oEf7qKrRWypUwybMnfexzoS+72OIqF1Rac4/2mjDxwnW
         S13U0/Xx0hXQlTqxBfMJLeWSzG/dj4T3OVDkVFrKiwKCqsug0ovEvHl9on3UCNmlweQn
         WtCxsbg2ocDGY8QewlCwyScHtz+UEjVbtQA7hprg+NcOvw7qCWgf8BwVQAWAzz8+MbPD
         nQltPc+CgwnFYXofWCdfU0EnwTicERlviJA1axjAqUbLDr7qPJCe2TyQCX2i3jlx7zMk
         HzxQ==
X-Gm-Message-State: APjAAAXZKhEw/to/jtxVBUm4oNLutguCp3OrYW3UfM/tZyQN50m5IESE
        KvF3Ctwc4s/DfKq0BxiTq1yinXa7
X-Google-Smtp-Source: APXvYqyjTcDDsmwoGxCul/euCvdvj+fJIloSTkmFscKEkei+P3PAKUgbxcJH3iRhAWEhQBFTGe8Gbg==
X-Received: by 2002:a5d:53d0:: with SMTP id a16mr1484300wrw.250.1555783459876;
        Sat, 20 Apr 2019 11:04:19 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id o1sm8929592wmh.47.2019.04.20.11.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 11:04:19 -0700 (PDT)
Date:   Sat, 20 Apr 2019 20:04:17 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     airlied@linux.ie, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] agp: Misc fix
Message-ID: <20190420180417.GB19319@Red>
References: <20170901121332.7219-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901121332.7219-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2017 at 02:13:29PM +0200, Corentin Labbe wrote:
> Hello
> 
> The first patch goal is to regroup all miscdevice number in the same place.
> The two subsequent patch are build warning fix found when working on the first.
> 
> Corentin Labbe (3):
>   agp: move AGPGART_MINOR to include/linux/miscdevice.h
>   agp: add compat_ioctl.h to frontend.c
>   agp: remove unused variable num_segments
> 
>  drivers/char/agp/frontend.c | 4 ++--
>  include/linux/agpgart.h     | 2 --
>  include/linux/miscdevice.h  | 1 +
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> -- 
> 2.13.5
> 

Hello

Gentle ping

Regards
