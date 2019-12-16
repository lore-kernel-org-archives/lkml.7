Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD49C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F05206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pJEqQG2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfLPNcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:32:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53257 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLPNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:32:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so5342408wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AlergG06/LQcMMmYPo3XnCRyN7U9O2JUfIg/mU+BPhw=;
        b=pJEqQG2ettSWl5ISnOhumZ7NbNH1XAryH4p1OSA5elDOk4v2mwGmUskVw4360JUisg
         xNDnF0aMe+wmle8Pp4tEoek4y0kWO9XIGzCqbCIvqbtttfXyr6696Yytt5Jy7kZTxa+7
         ucsGdpod8g4RTibYoYsn9l79YIhE3u0ZcPBi6tIi9knazvnbuZPGjCZeAaKtB+zS6RL7
         bUFCd23wy0OAudcBSICTW70GXuD/9UrIDG14bf4c+oA2V7ZUkRVBTCtOHeattkXFDAcz
         +awr04c1qyo6orSY75/KNV2OT/y77qfEg6U3B4G5X/61xgvKBgcX6ZRRYWO98+ms0PPA
         QkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AlergG06/LQcMMmYPo3XnCRyN7U9O2JUfIg/mU+BPhw=;
        b=MpiJCeQVYZno2XdF0fgaQj2B5evowtLAYUuQ2EE07T9QWAscmqjgG22Bs2SKILOe4d
         nSSd36osFPa1A0gf6N/F4kWNX9rEFEenpDQkNQqAS7ti6Ng+Y0uGA7yEYEUW02WkGT4w
         aF4a099ZNw4S1FbpG30lQ7jhQikMbDmfiCdwto3F0872HIBqr5vZCy0kChZL6hG6zst0
         onOwx6wQpVuCCfei0V1nwlyOFz8asel8edCZb9XOLAzMGW3CXfQm/tWrWlytYSPXsUst
         i2C4zATTx6ShsskmJfIhadM+6jH4GpyxJBGXx4Lez+DGopiBikHiASG1PgiHW/904UXX
         Kvcg==
X-Gm-Message-State: APjAAAWRSolc/AEbBROI3vpOwZeMQZ4OJP4jWLCVjc8w6CKStgfgyQxC
        iXTg4EzQpWqFNz85cNOxKdc=
X-Google-Smtp-Source: APXvYqw4TfBbwLqfC3a6Ly4eDGm8UzQzy0kZp9w/UrzITvoiLgE1vN71pHOST3CD8y1WZVj3zO400g==
X-Received: by 2002:a1c:2dcd:: with SMTP id t196mr9678798wmt.22.1576503148875;
        Mon, 16 Dec 2019 05:32:28 -0800 (PST)
Received: from [192.168.1.20] (host86-130-12-236.range86-130.btcentralplus.com. [86.130.12.236])
        by smtp.googlemail.com with ESMTPSA id p17sm21594336wmk.30.2019.12.16.05.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 05:32:28 -0800 (PST)
Subject: Re: Oops booting 5.5.0-rc2
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
References: <3f2f9d0a-887a-6d44-994c-c53bd1c6a4e8@googlemail.com>
 <20191216105439.GB32241@zn.tnic>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <a464989e-7897-e3f8-d517-2c7d6d7f495f@googlemail.com>
Date:   Mon, 16 Dec 2019 13:32:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216105439.GB32241@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/12/2019 10:54, Borislav Petkov wrote:
> On Mon, Dec 16, 2019 at 10:41:18AM +0000, Chris Clayton wrote:
>> I get an oops during boot of 5.5.0-rc2. My root partition is on an SSD - /dev/nvme0n1p5.
> 
> Here's the fix:
> 
> https://lore.kernel.org/lkml/CAHk-=wh8VLe3AEKhz=1bzSO=1fv4EM71EhufxuC=Gp=+bLhXoA@mail.gmail.com/
> 

That's fixed the problem for me.

Tested-by: Chris Clayton chris2553@googlemail.com
