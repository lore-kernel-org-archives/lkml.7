Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15AC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FA82072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YtRa8QvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbgAIReF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:34:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39660 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbgAIReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:34:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so6735471qko.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLZ40X4AYSx/4IufI5neDGOXIt1DrkaYWqpJijj50lU=;
        b=YtRa8QvPTdA4j+IGrYzf5ipFgbr/DCJAJVWKc8q8BT+ICZP0hiqMU61CEmmNrt9Kor
         1IedsTdhwZO2biCYk5RspEZKHbssaZuGMTwt1u/nTHu5kT5nnZ8RqSpE8QD/CJybCbMQ
         60ASxWqybxd7rDSd1T7Q9LX9QjO3f0AB9nP/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLZ40X4AYSx/4IufI5neDGOXIt1DrkaYWqpJijj50lU=;
        b=X2hXbCU7UR3rXzVJzI+/xnaBpbk8zN+fbEctLJbFKIMIfQwgngtfbXJkmEGnN2NLoy
         OLxRsrxPYMrjqY6xw59qYWZVbXBbxzknyQApjhhotF021PWUluuzhrKG+jySraClr/wE
         w9GX7PrsKLIULNNFfoQHiaBmDTQi4+6b0zqoa0QtpIBngrfn8/hDteEKQ4shbeCVgtaO
         3XIKPmn5dbrIVG7KXG4LjBJrG6YLRKgdfDuyLNhQpuV4peR4H1hy0Kip7grU3vKkD/jS
         3lYhycN7X2UJHJF+wwI6HNmc8/rYuRBIf4fWK+Jf5FRDEBwNj+hQW5Ssl5Wg9aFRIA9I
         Y8Ew==
X-Gm-Message-State: APjAAAVAHx1WVhVEo2uKlyCzHu74hyAOanhKl6N97BUR2Z76Bg47f/TW
        ev8K8LVPTuC20O9sw8Ptod3Rksv+K4k=
X-Google-Smtp-Source: APXvYqwN6O8tOThmPKTSZR4qawJG3Elb9gq9Sm5BytfrAKXaHgkBFXVZyGAhkfrSySX44IygFW2p9Q==
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr10333623qkg.71.1578591241930;
        Thu, 09 Jan 2020 09:34:01 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id i90sm3595329qtd.49.2020.01.09.09.34.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 09:34:01 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id j9so6776518qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:34:00 -0800 (PST)
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr10878417qkc.2.1578591240318;
 Thu, 09 Jan 2020 09:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20191227174055.4923-1-sashal@kernel.org> <20191227174055.4923-8-sashal@kernel.org>
 <CA+ASDXM6UvVCDYGq7gMEai_v3d79Pi_ZH=UFs1gfw_pL_BLMJg@mail.gmail.com> <20200109152925.GF1706@sasha-vm>
In-Reply-To: <20200109152925.GF1706@sasha-vm>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 9 Jan 2020 09:33:49 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPy+K2DGYAy+8pXbDQ3e87Vd+KazsS7JneCc5CHa_NaKA@mail.gmail.com>
Message-ID: <CA+ASDXPy+K2DGYAy+8pXbDQ3e87Vd+KazsS7JneCc5CHa_NaKA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 008/187] mwifiex: fix possible heap overflow
 in mwifiex_process_country_ie()
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        huangwen <huangwenabc@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 7:29 AM Sasha Levin <sashal@kernel.org> wrote:
> On Mon, Jan 06, 2020 at 02:51:28PM -0800, Brian Norris wrote:
> >I'd recommend holding off until that gets landed somewhere. (Same for
> >the AUTOSEL patches sent to other kernel branches.)
>
> I'll drop it for now, just ping us when the fix is in and we'll get both
> patches queued back up.

I'll try to do that. The maintainer is seemingly busy (likely
vacation), but I'll try to keep this in mind when they get back to me.

Thanks,
Brian
