Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAE12082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tPINeHbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDJWO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:14:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43659 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJWO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:14:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so2352745pgu.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wg+iQil3DoY9mwTW1mfserS3u376EbXt0yARzUcfgdw=;
        b=tPINeHbrEiszxSoR1taj3mpafE1NWS5DJ89QHSCklWKkcP2kLCHftDwO2UtHFSFNE4
         OtGTXUthULRDybFp+ku6X0sQa0d178t50ANTUtV8PUAbv0a8mq2tKkf8Eb5JogSCUgFL
         HxzBGHng2xubXdR5Q2aKKakGAxLdOC4FctnhEw22YjdyqiR5YFKgwgH/hMpcD5cz0l9i
         eGhEcvmMNo9yBN2IbT8X2yAGNu+Nn0XqbWoWTcLUsPPJ4lSoJq9y3bAEhVd7Wv4Q85jr
         UM9xiIqlv37vgizMVuaFAUHSXlDG/G3bFNvBKH7hB2cSDYwPpM2aSXO4YTFVLw4R0jIf
         fgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wg+iQil3DoY9mwTW1mfserS3u376EbXt0yARzUcfgdw=;
        b=Mb5z3bqke1QdZzfI0zXj811mqCJOJ1eK/phbAko4aE8o0F2yvxzSnIZ3mVrjY6Uw4R
         s/zJrZk8W2sn4dObnLKrgU1zwKwwOBVuBVV+s2z9oV+pNfbGCn28i2D5RN7Z9XUZZ4KL
         QY8zf8kdlB/Xf4XhHI4x1rObAgoZesD3nCloZSTggDSQt2VxK0gVBTv8JOdF4vaIhABW
         CELp3y0qTf70UX1ZjW0bioxtdvjYCl1MwzIQjvLVEMiPEpnOPgV+IKpUHun71DuQaynI
         lUKt1wkb9vqcQFKv+M9IXLgkFfEM4eVPDMrFKkCP+hoWue+OfdiIM1Ckj4PDyoxdNBoN
         WvnA==
X-Gm-Message-State: APjAAAUGGLTbHbKnPo8+VHENx0j8VV3pd/+jjaLNiLEyzCbwyYZ8X5B5
        I78esZ/NfdhmnS66cMGN2BUwZw==
X-Google-Smtp-Source: APXvYqzFap2u/I0lMbg2XZ2uTIfmLdmxN65OJmpxt1g9axofjTKjnjVdwjG6mYSjWp9XuWAKXlOjPg==
X-Received: by 2002:a62:e80f:: with SMTP id c15mr45888215pfi.93.1554934495509;
        Wed, 10 Apr 2019 15:14:55 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c1sm52150997pfd.114.2019.04.10.15.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:14:54 -0700 (PDT)
Subject: Re: [PATCH] block: do not leak memory in bio_copy_user_iov()
To:     jglisse@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
References: <20190410202751.20712-1-jglisse@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e25d90b2-62ff-18bc-efe2-ef37c56bfa52@kernel.dk>
Date:   Wed, 10 Apr 2019 16:14:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410202751.20712-1-jglisse@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 2:27 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> When bio_add_pc_page() fails in bio_copy_user_iov() we should free
> the page we just allocated otherwise we are leaking it.

Applied, thanks.

-- 
Jens Axboe

