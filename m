Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A3CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE3520684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p6ugOiNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440581AbfJYPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:13:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34375 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436893AbfJYPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:13:31 -0400
Received: by mail-io1-f67.google.com with SMTP id q1so2842405ion.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dD6BcQbkl37x2zUmQrNPDOSQYZ9HPHN6qwCOBIVJVXQ=;
        b=p6ugOiNr7N8mWotSAFMiTEeObFbForvf2/vnMeQz+WCPKpsLWpOHposXC4GLTAGiha
         z2NZKEdYdz2mrzv15de3apm+w2azUJixxRIzwPwhMlCUQyay3XzbmdTVu6H3ju6mhtMX
         njJP5QjptbRSeFCkR5DSE0XK0jkvRCvl+SqXXDc3lQRGAC58K88os2panYMmrcpr7ryT
         8KVITXJuu+KF6PfHznD0vf3EuCIiXUJnHU/I5Y0VqhMPeW/3ttnJFS1W+yyHiinWzDZC
         2jVm9OvRrY73QPDDLmMalZkF1/uGdzAXSTu4xc8bG/MSaGQ+isMIvdP95ulrKLKi3J++
         qcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dD6BcQbkl37x2zUmQrNPDOSQYZ9HPHN6qwCOBIVJVXQ=;
        b=FZYXSbhUYlBcqH1VU9/wUXuUA6/RAzPCg8Btzoc+Xm3kLEv3lJo42wBnIXx+Syc5ro
         5nKPFj7G/+oeEBWymKAtFknw3AEVShgXV86wQ3YrbrOxdYOpoTBpn0ojbet/3URVMSA1
         W/VSiQLK+VJv7yhkBv4REoCLX8JPSLfEk0iA14end/driodumSudBqScS3V+U95Uzx6J
         bB63vEusOcndVTnBkeOfoFiXqvdcd5H45lpQKX5eGdWvaXbNLqcTnBC7qzhE/+5TXqa9
         4431WkXYX4ArYGROptH9Gc6Xta1TMZ1FLBUx1cLU4PA5v3A/712Et2p/n4X5KTOCDUjC
         NytQ==
X-Gm-Message-State: APjAAAUMe66dL4lLzV79ubvnsVuc26xiTwMyH3lkDeFiN3+RO2gUzJ4V
        S+hZ9YrDkH+h/adzDUHw1f1pSCC1wHy3CQ==
X-Google-Smtp-Source: APXvYqxPyXwJO654kUKVe04NYXEzWMJtlOt45t2X4fjYphUoEzDoWRED6PMUGpTGnu7VP0TbCZJeIw==
X-Received: by 2002:a6b:fb0a:: with SMTP id h10mr4074154iog.270.1572016409966;
        Fri, 25 Oct 2019 08:13:29 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f25sm352725ila.71.2019.10.25.08.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:13:28 -0700 (PDT)
Subject: Re: [PATCH liburing 1/1] test/defer: Test deferring with drain and
 links
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b9509294fde6425b000d71613bd352059334c60d.1571995330.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d2e8533-6085-b328-7e27-9a5be2027b7f@kernel.dk>
Date:   Fri, 25 Oct 2019 09:13:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b9509294fde6425b000d71613bd352059334c60d.1571995330.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 3:48 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> 1. test user_data integrity with cancelled links
> 2. test the whole link is cancelled by sq_thread
> 3. hunging io_uring based on koverflow and kdropped
> 
> Be aware, that this test may leave unkillable user process, or
> unstopped actively polling kthread.

That's fine, that's what the test suite is for! Thanks, applied.

BTW, you need to update your liburing repo, you're several tests
behind and I need to hand apply the test/Makefile every time.

-- 
Jens Axboe

