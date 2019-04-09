Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421CFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119D620833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eePaY2AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDIJSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:18:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39594 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDIJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:18:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so13783637ljg.6;
        Tue, 09 Apr 2019 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=g9xvehuoZCs8mO8Frm3eeGdFaSiWTWH0MwvbkGHp+qQ=;
        b=eePaY2AFKERTrz+0Z9UUYVfY1YvbBugUFgcCFIceN5pP1Pt/bNuectb7h0OnDV3mpv
         po1M8HNFYGmo4caz6w/jZODm0a6ZQ5yO8djx99UiXkE2SckFpR5IS3gCtOO/Y0VhQhPL
         pXPiV5WxJZBBa1nX3wQd5rWyWY33ILpfpAJXhxVx+9x7byXZo9woqHoCCMgmAZsNpkLd
         9jYyyjU+FKhMrqwaZFqK8Rm98PC5WSiFblZVp4kMS92r/PWDnreG1jUZ7i2SoZEUpYFy
         /N++bVho4zdTfdGA3SSXKhS7owJNEyd7WIDwEbaDqRrmfs+FKD0BQHy0fQl7e4wr3Mwt
         7OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g9xvehuoZCs8mO8Frm3eeGdFaSiWTWH0MwvbkGHp+qQ=;
        b=liHSReHBK3E/q76kHwQeHqJH3IwOz205yVwhvP/Xg1lZcLTXmAgPhY1yvMHcUvEjL3
         k/7RBDLlKvg9o0/VFo2Bt0OQybQ+mqIV1s9OPh17aeIP5tROIh3CaWEnYGLDeLj1aGGX
         9RQ4H4o+4A5fVtlNK/ezGYkqGdAGRnnbhbt16xUQ2TOsj7RByB3O+aNDkP/Op9jjuMvH
         L/r7ejHjKzfa6Ttt+g0ckDaG2kIXGl+GAxm1y05RATURCWc3dVSkx/W3KVnVjh0iFV5b
         5teEHx0rT7v1tfpSkdWR2McVDLfp66sQ3bn7qT6GXUDlFy5iYU2ZEZObXM8Arv4DWB/G
         WD0A==
X-Gm-Message-State: APjAAAUfP3CqeKz4rF5Nut8qw9dsaRTuhHXMcXoReqPiRPhlSqNdjaWE
        EJqvdyVZYDd7Kk9trEiYBM4=
X-Google-Smtp-Source: APXvYqz5Fg+UtkdndRx+Y6d1eStsEc2weg8foTKgYd4dL9gCMUxhQ7lHn6Gr1b58EdsfhspTedov6g==
X-Received: by 2002:a2e:8991:: with SMTP id c17mr18645661lji.83.1554801488021;
        Tue, 09 Apr 2019 02:18:08 -0700 (PDT)
Received: from [10.17.182.20] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id y17sm7357604ljd.54.2019.04.09.02.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:18:07 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] xen/cameraif: add ABI for para-virtual camera
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, konrad.wilk@oracle.com,
        jgross@suse.com, hverkuil@xs4all.nl, boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190409091546.9606-1-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <fc116cfb-833e-e734-fcb4-4f93bd9371b4@gmail.com>
Date:   Tue, 9 Apr 2019 12:18:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409091546.9606-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the sync up with the camera protocol definition in Xen

On 4/9/19 12:15 PM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> This is the ABI for the two halves of a para-virtualized
> camera driver which extends Xen's reach multimedia capabilities even
> further enabling it for video conferencing, In-Vehicle Infotainment,
> high definition maps etc.
>
> The initial goal is to support most needed functionality with the
> final idea to make it possible to extend the protocol if need be:
>
> 1. Provide means for base virtual device configuration:
>   - pixel formats
>   - resolutions
>   - frame rates
> 2. Support basic camera controls:
>   - contrast
>   - brightness
>   - hue
>   - saturation
> 3. Support streaming control
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> ---
>   include/xen/interface/io/cameraif.h | 1365 +++++++++++++++++++++++++++
>   1 file changed, 1365 insertions(+)
>   create mode 100644 include/xen/interface/io/cameraif.h
>

