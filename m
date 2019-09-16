Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C5C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7D20650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vI2PVFhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbfIPO4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:56:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38290 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfIPO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:56:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so48415pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tbvdI1KEcoCVEqb+5uLFuhkHtCX00hOQTsHVqNsSDkc=;
        b=vI2PVFhZi7iDUdd08j6HFXuEnWqYKPBcXWNhkCfc9NgGN/JoGM08pAhXuBOAAQta0r
         1pxQZiKzWoJC/aSI490PHTHpH+0xL/eaJG/KFlyGRmqQpRMA3o1qd556rzJVVnr1yoAq
         PO0zKnN9H6JZWLiJmWYBh7/dbLfMsL0Nh+bFH0WTnH9kCx/Zd070+McaXFGI5AN2F9Vf
         GdbadfSsE3JUJYXqHthd0xTafOGx9dqsBNZHEPdw93uY3UWrP0Ys+Z+eQyzVesze4jol
         xyyJPJMDXiOTm85XFn28p/FlyXu12eZS3EBbOXVcL4FcJLT6b1ZwYpl2VMtzLQqodQup
         BoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tbvdI1KEcoCVEqb+5uLFuhkHtCX00hOQTsHVqNsSDkc=;
        b=HZULvR6k0Jk0JffRY0eo0VGCgxyAp5TgU+mgvELgMrPaX5oEy5zWc3ytje9UH4UeU8
         p2vKJcIiNx+q68I3N0VFzvWWLwZjoqIeOFyN1zIuTmY746nvcV9Of7pBAOMJCUmz2NKA
         fk/+ft/DyieoFiBNRitkQtTeGh8mKhl7cZdyx8mn8VOcYHI8EDBkJ1/yP5za1Qm11GO3
         i10yXqNy5bcGv0APH9ccM/o3Ug6MIh9wgSsKdHK5pfzkJvOEhrFs2Br/C5Z7ZtLB33cZ
         wK6w2ccAWOVC3RvniQxXOIVCkNtm42jmAZPf25ltstqFPI3O3sJo/kJbr1Ixu3B5QhK7
         SywQ==
X-Gm-Message-State: APjAAAVR89ZlOF4s2j4OkQ8JObkb/pNKeL+DY74NjUsoNx+ZfBKcOCJT
        3S/ZEdVxLVA87KRWFxB5Xr1xXPDB6PEVZQ==
X-Google-Smtp-Source: APXvYqxB+O+EAw9F+m1mV5co70kkG7U0Yy/z/RBYPRuhfPkMTpmWuSEPbdcy2z+1O4PaPDKX7JFX7Q==
X-Received: by 2002:a17:90a:183:: with SMTP id 3mr94767pjc.63.1568645759440;
        Mon, 16 Sep 2019 07:55:59 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:30f3:8cde:93f5:74f2? ([2605:e000:100e:83a1:30f3:8cde:93f5:74f2])
        by smtp.gmail.com with ESMTPSA id 129sm42195763pfd.173.2019.09.16.07.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 07:55:58 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] null_blk: fixes around nr_devices and log
 improvements
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20190916140759.52491-1-andrealmeid@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdf31a88-95f0-5b0a-401c-d526afbe6284@kernel.dk>
Date:   Mon, 16 Sep 2019 08:55:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916140759.52491-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 8:07 AM, André Almeida wrote:
> Hello,
> 
> This patch series address feedback for a previous patch series sent by
> me "docs: block: null_blk: enhance document style"[1].
> 
> First patch removes a restriction that prevents null_blk to load with
> (nr_devices == 0). This restriction breaks applications, so it's a bug. I
> have tested it running the kernel with `null_blk.nr_devices=0`.
> 
> In the previous series I have changed the type of var nr_devices, but I
> forgot to change the type at module_param(). The second patch fix that.
> 
> The third patch uses a cleaver approach to make log messages consistent
> using pr_fmt and the last one add a note on how to do that at the
> coding style documentation.

Applied, thanks.

-- 
Jens Axboe

