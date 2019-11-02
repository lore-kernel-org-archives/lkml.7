Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E32CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766D520862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S9aQj9/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfKBOAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 10:00:03 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:39581 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKBOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 10:00:02 -0400
Received: by mail-pf1-f175.google.com with SMTP id x28so5713272pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YkgkpM6rwpKhInhmv279J+9Kvjd52sspbeAhQDcOtxQ=;
        b=S9aQj9/adNLAAqb38APVXxuapMOnLHH5vVqCyPKn1M4oYwlYMwtW5ebeeN1kmWNDE/
         7zO3WhfUQRaTbSjvIw7cCKV43G1VLGZ7qV8LbwTCnMHJGos2TsmP+D6g0tkid2tkylPe
         hoS1JqUoDAoqW/T9C5Ji+4vVnMDBz968nf3+nc5mCLqEKlBs30ijCBcAHUFIuLslR2cg
         KeeJTlq7VwqKrE+IPRxDuDmtODPP13aWtTi+gXEwU7Cv7xDoqGCd/YH1d/NVttt1axl1
         0LdEaSOYLXtftRsuVdGeM5AtimES+WvEnmL574RDuzqxvpYfpFivzjKiRt1eQIK77CRc
         8iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YkgkpM6rwpKhInhmv279J+9Kvjd52sspbeAhQDcOtxQ=;
        b=bR1R2eeTTI7WE9Hqpa1VX6aYHteEjVVlV6T1xSzShB/iiq65Pf6Qs/SxeiuW5r2nj6
         EDwE5t6EhXor8p9MidtWJBJET4EEn+EP90XYs8Sc4smfU8p4gDi+bAbO8ui8WGo2Ghx/
         8th/1T+1BgZeKL+06ERiw1JqN/GyqKXDxDPkuw8PGS2pf/HAmVgi4gQqupkDzAIx+XLf
         Jo6vxs+1ZgrxM4Jbtt2lG2Wu6AOANbKJemRoQB1zqTXEsE894qjWzUDND/SZ3E67Hfg0
         679pjM23xFzyBjqaDzobCaQ3fdz2lnNUMUX9vIxQ+6LiAnv3h0CE2Bx8yTcSES7F7YDr
         vPoA==
X-Gm-Message-State: APjAAAV7X6swiCnozqjVo/YBsyjxs5I879Rt7xTDCmnojzvuXUNrPLZD
        l+vxyK6WowFSiSOs/xBLgB1QBsYiqZ5kyw==
X-Google-Smtp-Source: APXvYqwgSl9QBIMdqNY7ABFpVXj2TZMK5CoNaFUKtey+cS9tniBzpqSC+JdUC/67/b+V2T68w077vw==
X-Received: by 2002:a17:90a:3b0d:: with SMTP id d13mr11461726pjc.86.1572703199826;
        Sat, 02 Nov 2019 06:59:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r11sm13371435pjp.14.2019.11.02.06.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 06:59:58 -0700 (PDT)
Subject: Re: [PATCH -next] io-wq: using kfree_rcu() to simplify the code
To:     YueHaibing <yuehaibing@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191102075501.38972-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c94b1d80-fee1-1d80-9d55-693fbc49bf8a@kernel.dk>
Date:   Sat, 2 Nov 2019 07:59:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102075501.38972-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/19 1:55 AM, YueHaibing wrote:
> The callback function of call_rcu() just calls a kfree(),
> so can use kfree_rcu() instead of call_rcu() + callback function.

Applied, thanks.

-- 
Jens Axboe

