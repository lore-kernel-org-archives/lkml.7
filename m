Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF80C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C72C207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaNRA9k0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgAGMqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:46:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45988 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:46:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so53735269wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pLuEHRJGyuYZ21es9PhlN9IhZbnDG1epHKk/DRLbj4E=;
        b=YaNRA9k08R1pyZK09tCeQxl8Arnavxri5xC0gsDRXbAiUxyVOQpGXRc3FHRxwn3Zpd
         LF4sv6GM/30QdDCv4c2Ihhv9wglO6/HC/llT+fc1pm6YIPkPQiwzEza3gmF2MwLk+HGo
         5TuTsH/VANEjPnN+bza3IAP4zU61ZQvj0oi2BBIEXCmSWN91PD0yscxKl2ddi/I3G2pw
         rzBC7E6AhBBDrU7ZVUJAtNt2VCB/PXmwiEWpMmgelzxepQrck9ng+CHO5Xc+3XajxkE5
         pBEZD+JQCrau8mRQU/zEA38MfzgjTYE+FUm0DwHSnlnxYFkQSCE+WawTGb0uP4co3A0Q
         Cokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=pLuEHRJGyuYZ21es9PhlN9IhZbnDG1epHKk/DRLbj4E=;
        b=ObEsygJd7IlJjB6ytvybIwcOQaxIWmnSO3QMw3jmsJj1YMzn9v/wM5aM/CTmxOBmBu
         ntv2dH5egIOWFtizMsEgFBY40SVYUNbBkK4Ydcvvt1+rzaPR5e+ZlDXfHeVsb8fDXP7V
         Tn45EaY4KJ7P/OOjQwiEqYQ/45v2vnmCdQa9eUszDDla7SwMJt/l8RUaZA34C95MwMeL
         q2ENRMZXVOkc3+krR+8XQTwIszKUuyb3J1axSVFnLuY2BMmyxS3nWXlSmV4GeIERIWP8
         aDn+qN9/iil1mj91jUH3hV+EjkNODM+CaC/zBOKKmqPBPF4gFtP1j7JjWbZcFLntw/hM
         O3IQ==
X-Gm-Message-State: APjAAAWNJXl+q8UcB08gCv5g6G4iTOmah4PaGid5P98+oCYNe7z08GRB
        gFfjOoZ1hDEgyenQ7zjzPvo=
X-Google-Smtp-Source: APXvYqzXnMjxG69Kfig7l7SnYmCyuET+NmyKxhHkb2al/g3bEBoEPhgKL3QN9Mtg5f9bOgNyUbNtKg==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr106966437wrx.102.1578401163499;
        Tue, 07 Jan 2020 04:46:03 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id u8sm26702237wmm.15.2020.01.07.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 04:46:02 -0800 (PST)
From:   Wambui Karuga <wambui@karuga.xyz>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Tue, 7 Jan 2020 15:45:55 +0300 (EAT)
To:     Maxime Ripard <mripard@kernel.org>
cc:     Wambui Karuga <wambui.karugax@gmail.com>, wens@csie.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: use PTR_ERR_OR_ZERO macro.
In-Reply-To: <20200107115737.ybaxsjyvfaledfje@gilmour>
Message-ID: <alpine.LNX.2.21.99999.375.2001071545160.6077@wambui>
References: <20200106140052.30747-1-wambui.karugax@gmail.com> <20200107115737.ybaxsjyvfaledfje@gilmour>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Jan 2020, Maxime Ripard wrote:

> Hi,
>
> On Mon, Jan 06, 2020 at 05:00:52PM +0300, Wambui Karuga wrote:
>> Replace the use of IS_ERR and PTR_ZERO macros by returning the
>> PTR_ERR_OR_ZERO macro.
>> Changes suggested by coccinelle.
>>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>
> Unfortunately, that patch came up a number of time and shouldn't have
> been a coccinelle script in the first place.
>
> I've sent a patch to remove that script:
> https://lore.kernel.org/lkml/20200107073629.325249-1-maxime@cerno.tech/
>
Okay, thanks for the review.
> Maxime
>
