Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A7C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E600218C3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 09:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDFJdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 05:33:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42358 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFJdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 05:33:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so7505713edc.9
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 02:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5x4t8JwzAcxYyISovK3KWqC+KqpMC6fj+T045sm+YBg=;
        b=Q+e0I5S/TjLCq41podHteTLL1I/CsspRZmhdBH991iNrfZywOort+seUqOU8wJQgfk
         xRkvPrVFWuc/4EheIHBLrgjiyngC65EHfodaA/w7XyfE460ux9SEH0iT3PG38mWiRDHD
         JwUYm424mthpM/DZN4hF7Fdc4jEU2SD1dSZ6COVi1UTP1JXxrAS6gw2sYuNEM0/IPNk9
         6YFGuA+en6IQOo7Y/KPFb+9bVmSSk4v6LgrSmwS98gCKamEobG41IgqjRs7Go3m4uQfS
         B9IZsWvY3QKTgCw0yK4lTss25CJtgsdQED3L4bC/KlVjn4zzlv4UWhsYVhETDV/lkBUv
         t/RQ==
X-Gm-Message-State: APjAAAU8vfuDfkRWbiVsI76tz405uIqemwf2/qTVFuLp25OWrmc+yshv
        eAu2BTqwEafyr/kFgPe+3Hp8NA==
X-Google-Smtp-Source: APXvYqymgga5cITRZH6sTe+8lEJX/P7+zG2Lv7OteAiDV1q59Lr33P8zgZ3Fho181d34rRvYD1jV0w==
X-Received: by 2002:a50:ca87:: with SMTP id x7mr9415743edh.237.1554543230427;
        Sat, 06 Apr 2019 02:33:50 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id p20sm6920165edq.62.2019.04.06.02.33.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 02:33:49 -0700 (PDT)
Subject: Re: [PATCH] virt: vbox: Sanity-check parameter types for hgcm-calls
 coming from userspace
To:     Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190404123909.30684-1-hdegoede@redhat.com>
 <20190405141526.6035D21872@mail.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4667d465-15aa-178d-dcbe-9b70d093d55c@redhat.com>
Date:   Sat, 6 Apr 2019 11:33:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405141526.6035D21872@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-04-19 16:15, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.0.6, v4.19.33, v4.14.110, v4.9.167, v4.4.178, v3.18.138.
> 
> v5.0.6: Build OK!
> v4.19.33: Build OK!
> v4.14.110: Failed to apply! Possible dependencies:
>      0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> 
> v4.9.167: Failed to apply! Possible dependencies:
>      0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> 
> v4.4.178: Failed to apply! Possible dependencies:
>      0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> 
> v3.18.138: Failed to apply! Possible dependencies:
>      0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> 
> 
> How should we proceed with this patch?

4.14 and older do not have the vboxguest driver, so just applying this to 4.19+ is
fine.

Regards,

Hans
