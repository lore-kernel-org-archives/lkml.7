Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B3C206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJ8kvIHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLJAmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:42:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38462 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfLJAmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:42:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so14967999qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZSjeR0TOWiNnS13x7P+J574D6JiqVJY1zgnBAULjNw=;
        b=PJ8kvIHhxdpilR3u6wl/8IY1EtKCrX7nvnNxzG93F4VYb0DdI9zX7k/tKrsEYNFAWx
         ZHCkU4ic/S8o+5V0b2KSykdZH41eFLahQ03LIIF+oO99z9NTgtY29VqCW1yyHcn1HMwi
         qHLDkKJTF7fFOVSWXKDSvZC3PMFh2Q125FNLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZSjeR0TOWiNnS13x7P+J574D6JiqVJY1zgnBAULjNw=;
        b=WnvmNAaYES8aGb9jkaHTN1kloZiv/9aiDXWFgopYKWYT2H/x9eyOFnU7gpWpDMaUXP
         KNHZ+DjZuvq7lvovIY4gcHjcN0jPGpJmlm4pXgC6GPCIgQPsAKYWQ8FzfiA/aqH2l+Uz
         6fQZW/iZh+GY9pBjC/X8hKJ6hOF8uzpGGd2Y2nEC7VrivMarGTZ6xG+08CtOPd5P3MsB
         aevnbcppezGhdpYC7r+rVBTeY9hSfquMEhGEJBLNed7ZOGh8S5+UXwNYrZVj4ccDp1YD
         qShNgGRRL7VU0PjMLEHhVITU6utGXNSTYWBUh6Chw4ZdwUnNlUXZ1mqFpmewf0XoAcPr
         2BSQ==
X-Gm-Message-State: APjAAAVZYwE8FXfiQMuapyGPLk13hTIme2bQeKi4vOF5KiBrx9w3kpOZ
        SgZ2aqt2FySm8wTa0O3ScZUQbiZAGeQ=
X-Google-Smtp-Source: APXvYqzGfqOiNRGM7rnWZ07jMJxBECxXS/gYgs6jSS2DB3GOevV0tkjsJXNm50w+XhR6fcrZ7OdTyg==
X-Received: by 2002:a37:5a44:: with SMTP id o65mr30407121qkb.327.1575938527285;
        Mon, 09 Dec 2019 16:42:07 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id p188sm410806qkb.94.2019.12.09.16.42.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 16:42:06 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id v23so15003067qkg.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 16:42:06 -0800 (PST)
X-Received: by 2002:a37:9547:: with SMTP id x68mr31715256qkd.206.1575938525894;
 Mon, 09 Dec 2019 16:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20191209235116.142692-1-briannorris@chromium.org>
In-Reply-To: <20191209235116.142692-1-briannorris@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 9 Dec 2019 16:41:54 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMszUwnVPNWQ42nPnvfHE9x42vaO76Bk=qs5gD+AYxdMw@mail.gmail.com>
Message-ID: <CA+ASDXMszUwnVPNWQ42nPnvfHE9x42vaO76Bk=qs5gD+AYxdMw@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: start out with BSS type ANY, not STA
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 3:52 PM Brian Norris <briannorris@chromium.org> wrote:
> Let's make mwifiex_get_intf_num() give a proper answer, by making its
> initial value the proper uninitialized value -- ANY.

I should have noticed that this function was recently neutered in a
patch which actually fixes the bug I cared about anyway:
7afb94da3cd8 ("mwifiex: update set_mac_address logic")

So the following is probably a better patch now :)

[PATCH] mwifiex: delete unused mwifiex_get_intf_num()
https://lkml.kernel.org/linux-wireless/20191210003911.28066-1-briannorris@chromium.org/T/#u
https://patchwork.kernel.org/patch/11281155/

I'll mark $subject patch as Superseded in Patchwork.

Brian
