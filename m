Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2CCC2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 05:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FF322B48
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 05:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="no4ycIih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfLOFmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:42:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44186 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfLOFmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 00:42:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so1729992pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 21:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9HhPA8l94IXF/EFFgYeMxKbVnLjSYDFR2r7OBxJtk6I=;
        b=no4ycIihm5T2BbxlGXQkOjXKRlSKyase0t5W8Vkb99fEUq9OJGF9hOTlyxLWnoKnu3
         MlcaQsF+0kQSzyWfzCq1fLEcB/TLhNL/a13iji9J1qT8EYggNo9RyEdACBnyuu1FB/l5
         se2Qqgt5uzfsLdpi7QviGZUzHSR0zEtqfuPi+IXmIiWOxORbWTlDxyZGq1j8VvDAVz9O
         8alMm6XtHjQBEEjQLElaoFlAJAD439XIFMDc7UHXQbkuFmWf8nL/63WmMTYTtADALdBp
         Go77+dnLNc+L6yaUZ1NuiX/Leve+UxR1mJk8xbDSILVY4FXG0+nsg0tB86XDwRaH0wDJ
         js8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HhPA8l94IXF/EFFgYeMxKbVnLjSYDFR2r7OBxJtk6I=;
        b=so00bj0QAzLmTmcomoXU7PSeIwgNp6K9En8IvmCSvaWq//zLJAbLDj32wdlqdOBnGu
         rtsMLCgd9o8Z8kUbj/+f/uqgwdma8WzZGcM3pjj4E2ZB3Ap0KgP+Qk0l9mzfeQ8t0tmp
         XsJmrKraSHljxyur8toxkl9uyeyrkQNFTAkaTZsDSpko2kMNl0DVV1BdQdzYTrsvw8FW
         5be9rFipVorkV2toIxgXdAJIEH/03HtDvBfR8UXzsP0wnwxEMsftNfl7KIeSUh8v0UXY
         MxqbxGbe5FFRW/l2A/5q/iueVZZvzkaliX4Mu+Gx/XbFizRoloA9pnE9R0joP+2PFj19
         Mhlg==
X-Gm-Message-State: APjAAAWh593C8BMkcv9agSse/6Mz4paQb0Ll8zRPnNIQKPxMdvCicgHM
        ocgxc94PwnlNoNU55hPgqhxE5vd88OKz7g==
X-Google-Smtp-Source: APXvYqzjCjmixrJYCSMvdiMgO/BAt0dJYqSQtexLM8Psn2m+HbCN+l4SjeOD1vixOJG/pvDDqktDhQ==
X-Received: by 2002:a62:e50d:: with SMTP id n13mr8973600pff.201.1576388537187;
        Sat, 14 Dec 2019 21:42:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id j3sm17427875pfi.8.2019.12.14.21.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2019 21:42:16 -0800 (PST)
Subject: Re: [PATCH v3] io_uring: don't wait when under-submitting
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <6256169d519f72fe592e70be47a04aa0e9c3b9a1.1576333754.git.asml.silence@gmail.com>
 <c6f625bdb27ea3b929d0717ebf2aaa33ad5410da.1576335142.git.asml.silence@gmail.com>
 <a1f0a9ed-085f-dd6f-9038-62d701f4c354@kernel.dk>
Message-ID: <3a102881-3cc3-ba05-2f86-475145a87566@kernel.dk>
Date:   Sat, 14 Dec 2019 22:42:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a1f0a9ed-085f-dd6f-9038-62d701f4c354@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/19 11:43 AM, Jens Axboe wrote:
> On 12/14/19 7:53 AM, Pavel Begunkov wrote:
>> There is no reliable way to submit and wait in a single syscall, as
>> io_submit_sqes() may under-consume sqes (in case of an early error).
>> Then it will wait for not-yet-submitted requests, deadlocking the user
>> in most cases.
>>
>> In such cases adjust min_complete, so it won't wait for more than
>> what have been submitted in the current call to io_uring_enter(). It
>> may be less than totally in-flight including previous submissions,
>> but this shouldn't do harm and up to a user.
> 
> Thanks, applied.

This causes a behavioral change where if you ask to submit 1 but
there's nothing in the SQ ring, then you would get 0 before. Now
you get -EAGAIN. This doesn't make a lot of sense, since there's no
point in retrying as that won't change anything.

Can we please just do something like the one I sent, instead of trying
to over-complicate it?

-- 
Jens Axboe

