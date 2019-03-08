Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FB020684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LdBIna6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCHIJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:09:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38852 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCHIJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:09:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id k136so3372204lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 00:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=21BnupwjGOgiGMIqfEGd612ooJtzT8k2WiSUSipiwKM=;
        b=LdBIna6n0ApBohJbms063FPVpZhBGU14sagruJHY9mDaT0BO1COp6hjG8CfiyMOH5X
         zkmrzp8prSukv09UGerujPNoV0gpFkiaYpqWlMu28XXZ/OY4ynO2XaA1+dpZpgJqjbfn
         VhlLVPcNJqoBsyngK1dCSeKeSa/oHAIxjBWVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=21BnupwjGOgiGMIqfEGd612ooJtzT8k2WiSUSipiwKM=;
        b=pJUD23H+XfYTHS6P4HGVzofyIE4OvjT2bc/3uRct0pV0lZjJCEcSE8hbHqe5YyeEGT
         lii2cWxQdvJTry7cFpPs/g60Hn8o665AZ4C2b7IDbfVZ7QfRy28jSduqvXWl4rVWZR2W
         /0j7Emg5ofjEUswC4L1qE8lEl7rTCjcA1Z0rFzcQS7b5oJoGbWQbi6C3HGqZK3ky/hYY
         0wiDded9/2CBSGN3Nz0WwmXYDhYzF/W1d8milMUSe6hhGERJ2iBK/uRH6akhwiagZzz9
         V/dWNVz9/1w/sXASviGm/qSGuor+bDUCC59sYTgo88Qj8ziue0Sj8kzbqaLArv27tA1T
         rRJw==
X-Gm-Message-State: APjAAAWYfVGNDmoMy+ACoC78nu1JrQIcibEQJe3tI79GyPd2NR8thnoD
        EY1wu79gFExi6X0ksZvTUyFqlA==
X-Google-Smtp-Source: APXvYqxY52poVGc4G+1v6kL0FX3yaEh3nE3V724ZMkd7CL0xcPJTGv57VQmbTmITMI7dnCK7E6yqoA==
X-Received: by 2002:ac2:4310:: with SMTP id l16mr8126268lfh.58.1552032588406;
        Fri, 08 Mar 2019 00:09:48 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n25sm1349197lfe.70.2019.03.08.00.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 00:09:47 -0800 (PST)
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Leon Romanovsky <leonro@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
 <1552003703.45180.17.camel@acm.org>
 <20190308070107.GE32625@mtr-leonro.mtl.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ca0d8714-3258-3155-247c-af2d63c28273@rasmusvillemoes.dk>
Date:   Fri, 8 Mar 2019 09:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190308070107.GE32625@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2019 08.01, Leon Romanovsky wrote:
> 
> Mathematical therm for discrete numbers greater or equal to zero is
> "normal numbers".

Sorry, WHAT? "Normal" is used and abused for a lot of things in
mathematics, but I have never heard it used that way. When attached to
the word "number", it means a real number with certain properties
related to its digit expansion(s). And then of course there's the
isnormal() thing for floating point values in C/computing.

Strong NAK to using is_normal/is_negative.

Rasmus


