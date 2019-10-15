Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB641ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8909520640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u+qaMwgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfJOQN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:13:59 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:45689 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJOQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:13:59 -0400
Received: by mail-io1-f45.google.com with SMTP id c25so47117894iot.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rU/+8akjRAvTL7N8wg4KbTqoywqv6btBqqn9U4LLFqE=;
        b=u+qaMwgfXAfVKV0E+B4XMOdHhl4FUf12KD075kgSX5lRTPiGAR0R1Rr0cYKqN3R0oN
         cdh+qNDmfo7hBQvMMuK2Lh2xio7Ju7CJkA5uuKlF1F9nCitSHJl5x0Pbh6dx/tet7UyR
         TY8dLSFHx0qXag5LNqxNsRbiDVHeUTCsbOTwEv9iY3KcMP0V2fvhVYMelTaoiDRD7Q3Q
         U7Uv1ooByljjegb9WNJRTwFLWtX/+5qRCeWhAQGpOAIWq93iPq3Hdl90w884D0U54mxa
         QC4JgKYU6s3/reDXJuuMiQF/FaikxHX81KdLpzgJjnIGY2CkltlK/uNG0sIb1/aP3Owq
         UqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rU/+8akjRAvTL7N8wg4KbTqoywqv6btBqqn9U4LLFqE=;
        b=hiflGAcXnW/rjdaMIfoX92WGM5tFBwpDCABj9L20jW7MGVv97Bf8uKb3rPEmPxTKly
         bZtCnl61Sd9OWLj20kRfX/DOpNVDmTLfTXfTvias+KE/BSeTEqY8FZR3EFvCgAimY6lI
         lUVQrckLVFhfbk2ufU8459sdYMC96GeSwfK9HEU8Sb1QGiIPXEFkrfPy3W4tWJ5TUk/u
         uWViqFP6bSaA8XG+WhIdMdtKS3DSulJVA4IhV76Y31APtfY8fOdwj8XujHTOz0uPcoOM
         Ehvvbuje6i2wq9iQxTW4pLsqCPbw54p6hUTN2SJ+vdVgaFP9BNrs82oNcOvLxVKLLOiy
         0EfQ==
X-Gm-Message-State: APjAAAWDqUFUdfyMt8Ygl6pnGZueAWq0P7JqMP+C1s4kRj/1jcc5Sg7K
        mG6XNnj29HQ+7EfJIbESMCOj8g==
X-Google-Smtp-Source: APXvYqzA6cG1fMcPKnZtqMNSW9pHLqrz5GDW6l3mVkAYSA6+aaPICjTTfIRIXd3Uc62TcRRCFWbGVQ==
X-Received: by 2002:a6b:8e11:: with SMTP id q17mr42771166iod.194.1571156036827;
        Tue, 15 Oct 2019 09:13:56 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 26sm3036267ilx.47.2019.10.15.09.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:13:55 -0700 (PDT)
Subject: Re: [PATCH block/for-linus] blk-rq-qos: fix first node deletion of
 rq_qos_del()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
References: <20191015154927.GL18794@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3c4f871-b241-d18f-08eb-9bd1cf1c6d0a@kernel.dk>
Date:   Tue, 15 Oct 2019 10:13:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015154927.GL18794@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 9:49 AM, Tejun Heo wrote:
> rq_qos_del() incorrectly assigns the node being deleted to the head if
> it was the first on the list in the !prev path.  Fix it by iterating
> with ** instead.

Well, that's unfortunate... Applied.

-- 
Jens Axboe

