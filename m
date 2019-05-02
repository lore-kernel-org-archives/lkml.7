Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED762085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhyNhPER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEBC3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:29:44 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:37322 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfEBC3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:29:44 -0400
Received: by mail-yw1-f45.google.com with SMTP id a62so493377ywa.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1U2mJXBbnkWOnvmjM7JApU8kCjuCk0GAzDiJe0SSQ8=;
        b=HhyNhPER21cKXrmuPmPHmnjvXbBpYYCdGpMAWXbBnuVSKm35ii3+zr47c07qUIxCtE
         kpxIKagdzxPIIgRSrfKgEd7BwxlESTY+lWAn8RzsWw/E5ZP3yQHRL57GtD5cUsViV5Ot
         16t1lQ///dE+3A/FI39hvUZadgfIhWD+VnHI3SP5Ic6H3azruGl+VZUqFPILyyadS6GG
         lbI30N99yOtU5qE+sWz7oKl0fK3kaT7ATJxWt4D+HG+tch1RA93Yegpx2wuD41x0ktMP
         mETEUEtXJHfn0qPrOI6JGR0o9Z0gRRWQzUZryzc1ph6iwNmK8KVCUivX9qKk/5mEwU33
         gdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1U2mJXBbnkWOnvmjM7JApU8kCjuCk0GAzDiJe0SSQ8=;
        b=X5g+AjFiZO3EzLEj9EWrIZO9EgW0E1LBKTtlRTE+Ew0/MT4VDVplDM2oRnpDv2DeLK
         t+TKKuy/ZKyMFv3G2MSUTQgNpOULJ8gOU9HwDZ1WrCK5GMucmvl2ywiByI5fUYs+JMVr
         oyDByDkOUtoiyWW08WGqHoucLN6slwnnqPK3A7b/QZI8WxFSLbgozip4XkvZE7kaP2mN
         eKwqlDrbrBDaCbpooar9C9YZ1/Vs5WBTq9FUCdqHbyrte16Xywm+Ww025+yyAu4gNO7Q
         3GVwpIELAfTAASXUYEKb6HhATWl60/Ivohh1aK4Qw63R9sgn2UNbmLiGhsgfVK8vO97C
         ptFw==
X-Gm-Message-State: APjAAAVnr1c/eaKrVt8VhxCJxf8v3QF2mV+tQ5P/AudylZB0pQSmYuDn
        dyLiMD/qBcgHHheR0E43o2Q=
X-Google-Smtp-Source: APXvYqwiqBdAZ2Op0tTtlyQx/W77Z7fZU/x3DkLyj8DO/TL4D0NenRU2IltJnGLYqvLRkaPf6n34xA==
X-Received: by 2002:a81:9203:: with SMTP id j3mr933715ywg.511.1556764183630;
        Wed, 01 May 2019 19:29:43 -0700 (PDT)
Received: from [10.230.25.168] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id h3sm7436807ywb.87.2019.05.01.19.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 19:29:42 -0700 (PDT)
Subject: Re: [PATCH v2] mtd: rawnand: brcmnand: fix bch ecc layout for large
 page nand
To:     Kamal Dasu <kdasu.kdev@gmail.com>, linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
References: <1556738544-29857-1-git-send-email-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <baffcda4-84f8-cd5f-8872-a2e2572024ff@gmail.com>
Date:   Wed, 1 May 2019 19:29:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556738544-29857-1-git-send-email-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2019 12:22 PM, Kamal Dasu wrote:
> The oobregion->offset for large page nand parts was wrong, change
> fixes this error in calculation.
> 
> Fixes: ef5eeea6e911 ("mtd: nand: brcm: switch to mtd_ooblayout_ops")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
