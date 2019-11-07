Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE941FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88488217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zlF70s0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbfKGDfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:35:22 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:47099 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733150AbfKGDfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:35:22 -0500
Received: by mail-pf1-f181.google.com with SMTP id 193so1260348pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 19:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MTSqevB9eLaYfcqBeeI8DrNGQzdw1uX8E/KGdMxOgko=;
        b=zlF70s0+khT1/SKNhBOSlJ24dS4oE7e8RIgO/HwP+ODMguxMDJT5+RSx3lyJsvLPlq
         oS1s80+LjsNPcWTDyhoKfRaa//uuIxY7ABejlgv6Be53VQ1zIieogniHL+XHp8uyz+Wk
         ZiEJTHc9LGFjzOXIqGzPnWL5T5gWyYrDlDZj2kozJyL9rlnKtpcvnOAOgQR+w1kfK9vS
         nWwD9JeR3i0DpI0YgyPbfkcQLeUyJVLXQXe7dagc/EXL093xaHYHM7I3aGbA09xDun7b
         VFIOa8+gr0pVsyjKSd0j1D30NaZmvWpzYj44ivfva9hi6o/l8avJOSVOAHT4qNY9cm54
         2sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTSqevB9eLaYfcqBeeI8DrNGQzdw1uX8E/KGdMxOgko=;
        b=EdGm5NLlbQb0bY7eJU5jF1BUcHtlomV0QDLchVjRJ1zbPh6jZfGyXb+c11SSUn+inB
         xP8RSDh1X9m+BZUZjS9nkxBXPTVE8AUPyclajQIIR+3GEk8I50ZxXtinhsM5APwYsxJv
         2IRy0sScpjttpSw6qD7l9jgMxUtx9zAeVLewzE+OmH2xtXYCnsoZlvpAFkxa8MPUUzcg
         IVQaJj8M+4Rwp1leWsjnyRVCI2paaKVeEN5XFkwFxILbTe771bwOyEfiNnsWOf1Idf0b
         sO4pkn+k2sAl4uiJYsaQlxbhxhIfN3fKc+cBEpPZusklWdADmH4XorQekv/geZ5E6SyE
         SlEw==
X-Gm-Message-State: APjAAAW1Rh/7EVe0UlpRC/EWYTlBq13YA9FNZ8GVbfoE26YH/9Za8nkx
        GcU2xvPGEht/eF0zMdXCKvyd3N0QukI=
X-Google-Smtp-Source: APXvYqwmh53QyrTU3Dw6PSgNxnGd1rebMHMeSfQoe3aY8m8YDDvGn4WVyLUO3m34TjppX9BGCicB4A==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr2038950pju.46.1573097719548;
        Wed, 06 Nov 2019 19:35:19 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c16sm465425pfo.34.2019.11.06.19.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:35:18 -0800 (PST)
Subject: Re: [PATCH RESEND] ata_piix: remove open-coded
 dmi_match(DMI_OEM_STRING)
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <a47522045d251146c8f7daaeb18a32716bfc3397.1573097536.git.mirq-linux@rere.qmqm.pl>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <caf4017a-4acf-864e-afd8-c6f66e92eac1@kernel.dk>
Date:   Wed, 6 Nov 2019 20:35:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a47522045d251146c8f7daaeb18a32716bfc3397.1573097536.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 8:32 PM, Michał Mirosław wrote:
> Since de40614de99 ("firmware: dmi_scan: Add DMI_OEM_STRING support to
> dmi_matches") dmi_check_system() can match OEM_STRINGs itself.
> Use the feature.

Looks good, applied, thanks.

-- 
Jens Axboe

