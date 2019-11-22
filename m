Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C11C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6713F2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v5F6MF9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKVSzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:55:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33316 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfKVSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:55:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so3480967plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X6rPmQDZwe/5i7ZTCvqZcbNZzoAWqfhhq8dBz2pi7Wk=;
        b=v5F6MF9AvTQxk7Vd5aRT1Y9yCCk/Z9IA82/6jCjumROrrWFeFp1LbnUS5FJt9Xc7db
         NEEbLR70LWuDqes2CfBtQ6aUTKTa3SB2WZDmj2X1TaEa7JG03Ov0oOxccgWiam8ANZ9v
         Eme8ZIJlZTJNGSlQ2LoRYWSuhJgV+FRdjjdsymttU5qfRuZMpr5S+CfdK9q5V32uuJk9
         s7spTGMpIFLp1KaoDmWmCcrrqZNnqsDUpcMkn2PrQZjOT5cArAy/2zeoGmp5XTAGBQTc
         RAzOzoIri1O2C2TGJS1yJ14UMeJUn/+FRqi0nUY3jgHvmBRTYJ9eptMHcUQ9eczjbpgJ
         TN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X6rPmQDZwe/5i7ZTCvqZcbNZzoAWqfhhq8dBz2pi7Wk=;
        b=SKpJVXweCHupFkPP+gaQrVUqp1PiRvR3GFrRAsGA2iqkq2lOB9AzAMZgU2k4nFNhDa
         O+psjAhBfqJOrNWU+5ST3tF3wQWuVY2QQj6G3obI/dnYTaTfNKh/1ygjYtjgt6YLpBbb
         n85EFbEhMqi/lPtl8sDUlx5eTwJwxT7E2cT2lgfcBaa6lcArkaV2g7qXmtfFo8T8xA35
         5J81CVPzM3iXPws24i7Gk9cbqc4uXgFzvy7IJd3mX3WOSvXwMueuHV7+G2+APz2AtZuk
         FH4EQADDVaK/d2Kg8oO0oUHyaP1WXxsaf3uSxY64DJWMoWJT4W/R4xVR82YiSSnQ3cyM
         CouQ==
X-Gm-Message-State: APjAAAWhxbX20k8MR4nBmModRA4loWJ7+BVEST4d0m9dyoYfRcz4aYJ2
        zBpJYGUy//LhtPBOt1EK1mk66hy92e4=
X-Google-Smtp-Source: APXvYqx1Uy8tt1rwA8LCWhELsYyAcxykGcj1cwQ1xSbh9BYAAVccoQ2Oqc8lATpIDKDKayjMbyalYg==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr16035047ply.279.1574448913595;
        Fri, 22 Nov 2019 10:55:13 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1132::1126? ([2620:10d:c090:180::835b])
        by smtp.gmail.com with ESMTPSA id c3sm8303326pfi.91.2019.11.22.10.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 10:55:12 -0800 (PST)
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180824211535.GA22251@beast> <201911221052.0FDE1A1@keescook>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <181810c8-657d-d603-a833-215f753be5be@kernel.dk>
Date:   Fri, 22 Nov 2019 11:55:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201911221052.0FDE1A1@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/19 11:53 AM, Kees Cook wrote:
> Friendly ping! I keep tripping over this. Can this please get applied so
> we can silence syzbot and avoid needless WARNs? :)

I'll get it applied, I did see syzbot complain about this again.

-- 
Jens Axboe

