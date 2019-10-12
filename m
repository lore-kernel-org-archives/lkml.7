Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D3C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0142F206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 15:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z40kAoLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfJLPBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 11:01:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35091 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfJLPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 11:01:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so14891536wrt.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wVHcI9lSX8uaanGOnUjTf6lBkgZpFUQiHj5D28R77UI=;
        b=Z40kAoLXOa7xNeMlvgjV/XN8StTUUqzxN+pH0LjQpN9c4e/UkTuBbt26vsmjr5uqRj
         4YMMxQ+eHT22lGwozUzw8P9hyw97FaX7Qj4RhdbFgjkNoQ+pIv6HTrJHiBvhcCu6aW/R
         D304+7rWRCWMSCd6OtCCLA0qvDiwwaLzYQl5Dri6dTMVMkxn+Oazp+4NFKYLfYKT2tK+
         lWp1UUUol393Oqr2L+PNLOC71Uv7Zp9kxH+tsvMbj0WT+5kecjiuSvRA1DwcLUreVE9S
         ubLwyURpWBG8OLEjGEqYG45IMtXOxhkdKxGQR4XlPWRiMxBdY8+jq/bMJO4lwV2N2YfT
         Ukgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wVHcI9lSX8uaanGOnUjTf6lBkgZpFUQiHj5D28R77UI=;
        b=XWgLoJL1uwAFHdrKYijfee/BpDMB8T7rwSxzj7worA7Ei8LNjoxE8L+E+5LDc4JnL+
         lU3FgaJb8nnfq0etI3FF5F0dHz1TQaRelLxGUQDtbSkwE35/nrjJ1UnJ896vhTBtNEIz
         17d8+C7Ytz1SaBHzI6tYGLIYXlu+5FrjDxx/Ifkb0id2qBb6Z7wyJXvXXi6TroQthqnS
         85PPq0eFDNJu4aZZ4u2qSQn6rEnBM4ixGNvX0bNXDiGQ5eEF7bXb+DIZn2nyW0mJv02q
         Eq5oym1O+sZ01xy+TWpTFokwi0fI29iIKvDd7cwb//55BNCKiLZtvb2+RgkfiwGNcAPz
         FF7A==
X-Gm-Message-State: APjAAAXKTsHW8WqODC7xpANh2iEFQL1bkbxz0mzTuYEQGZdOPRDDnxeQ
        ByJSbmD+fPZJLSrREsxHpg==
X-Google-Smtp-Source: APXvYqyPqpqzbP3XnFoMi2/Pw8QbR40wew29pTMGd6u41ZdKzpdyoEoKHixDywvu/gSA1r4Y94rusw==
X-Received: by 2002:adf:bd8f:: with SMTP id l15mr17498773wrh.362.1570892473305;
        Sat, 12 Oct 2019 08:01:13 -0700 (PDT)
Received: from ninjabhubz.org (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.gmail.com with ESMTPSA id u2sm5154279wml.44.2019.10.12.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 08:01:12 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Sat, 12 Oct 2019 16:00:59 +0100 (BST)
To:     Julia Lawall <julia.lawall@lip6.fr>
cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        eric@anholt.net, wahrenst@gmx.net, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, daniela.mormocea@gmail.com,
        dave.stevenson@raspberrypi.org, hverkuil-cisco@xs4all.nl,
        mchehab+samsung@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        sbranden@broadcom.com, rjui@broadcom.com, f.fainelli@gmail.com
Subject: Re: [Outreachy kernel] [PATCH] staging: vc04_services: fix warning
 of Logical continuations should be on the previous line
In-Reply-To: <alpine.DEB.2.21.1910112336440.3284@hadrien>
Message-ID: <alpine.LFD.2.21.1910121551090.15982@ninjahub.org>
References: <20191011212745.20262-1-jbi.octave@gmail.com> <alpine.DEB.2.21.1910112336440.3284@hadrien>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Oct 2019, Julia Lawall wrote:

>
>
> On Fri, 11 Oct 2019, Jules Irenge wrote:
>
>> Fix warning of logical continuations should be on the previous line.
>> Issue detected by checkpatch tool.
>
> There seem to be several changes mixed together in this patch.
>
> Don't have a subject line that is identical to a line in the log message.
> The subject line should be short.
>
> Keeping the arguments of && on the same line, but breaking the line after
> a == doesn't seem to be a good idea.  It would be better to have the left
> argument of == on one line and the right argument on another, if that is
> needed.
>
> julia
>

Apology,
Yesterday was my bday, I was reckless.
I am resending now. Please do not hesitate to give me a feedback if 
possible.
Thanks
Jules
