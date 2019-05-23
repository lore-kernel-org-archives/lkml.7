Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858FDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F3920856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="EuoySJLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfEWJCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:02:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39884 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:02:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id a10so4724605ljf.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gj20cOvCKG7FD6jjJZtVF7qSWx9DiKga9phOOUa5uL0=;
        b=EuoySJLXx37Ig1+YyIG4I/3BaQIryrpMyTLOmPHVFfrljh21Kk/gfRyCqL2KRfePZs
         WMzxC70vK9qld+zfU5f87R+8E9i4CYMZYPzyqzZRD/I9tcQY5MN/Nmk05X5MxxxBzUZI
         N8IoXckh1XX1bkvlY5310s2DxqypJ6QtFwxaB31LjPLSgfVzeArJHigGqXal7Rukzyns
         ldmV27ywrVB7Yv7BYzWKGNhgLyVnl985TWcjIFHPdzY0jttTUE0ayLB7GWjxhqexGnRi
         HBT2d1E7Fquudb/RFmE9vTA4z5/6tKQMY+IV6321ZPnZFZdyh2PeruJZdKvJhVs2vQQZ
         1mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gj20cOvCKG7FD6jjJZtVF7qSWx9DiKga9phOOUa5uL0=;
        b=dGKsk0rq5MhxFLEN/UAWlBhSdtDzXrvL+MEKMRuzr89zfSk5iFUhjUVfpiCXEcRgmg
         jYwzV855+GXrRganIwNg4HiIfubnRVX3pCnTtyNfrntrns9yGItC5jzHkR/026NK1qvU
         2FoRxLB5PKwpOHGZiZLTpTX4bx4Sz9Y+WWJyUfkHDlKGhw3QCN6F0bALwCNbcXLRmgSa
         fd3e773UFqO4UAstVRaXRhC3yxWdzfq3uTfkAOys5G1IAKztpgflmenO1RY+21LmjWOu
         eyoE6gbyBrntCl5qQPs1Xe06iHyVDZ6YKjH1Xhua3NBzdVRoGGJelRJIzFLm4kcYeIR8
         CFqQ==
X-Gm-Message-State: APjAAAWDhVO7aiVCuXEolPVZqC05fgVaN3ecTlrqWD4rKo/rDdxW0qQt
        sqYtL+EYuKOopNQ+R51YUQ4naSCNIO8=
X-Google-Smtp-Source: APXvYqxPaMVeCackWtR3g29FOBmPiAoKz56PxWB50NRD/oRvnQhsmUP70kx+ZRAOaYMkgO0PT7HeFQ==
X-Received: by 2002:a2e:8516:: with SMTP id j22mr18222831lji.119.1558602131959;
        Thu, 23 May 2019 02:02:11 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.169])
        by smtp.gmail.com with ESMTPSA id p78sm5847549lja.95.2019.05.23.02.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 02:02:11 -0700 (PDT)
Subject: Re: [PATCH V3] hsr: fix don't prune the master node from the node_db
To:     Andreas Oetken <andreas.oetken@siemens.com>
Cc:     andreas@oetken.name, m-karicheri2@ti.com, a-kramer@ti.com,
        Arvid Brodin <arvid.brodin@alten.se>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190523070238.17560-1-andreas.oetken@siemens.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1ce497cb-f121-7f73-e39f-a0474a33bc90@cogentembedded.com>
Date:   Thu, 23 May 2019 12:02:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523070238.17560-1-andreas.oetken@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 23.05.2019 10:02, Andreas Oetken wrote:

> Don't prune master node in the hsr_prune_nodes function.
> Neither time_in[HSR_PT_SLAVE_A], nor time_in[HSR_PT_SLAVE_B],
> will ever be updated by hsr_register_frame_in for the master port.
> Thus the master node will be repeatedly pruned leading to
> repeated packet loss.
> This bug never appeared because the hsr_prune_nodes function
> was only called once. Since commit 5150b45fd355
> ("net: hsr: Fix node prune function for forget time expiry") this issue
> is fixed unvealing the issue described above.
            ^^^^^^^^^
    My spellchecker trips on this word. I think it should be either 
"unveiling" or "revealing"...

>  Fixes: 5150b45fd355 ("net: hsr: Fix node prune function for forget time expiry")
> Signed-off-by: Andreas Oetken <andreas.oetken@siemens.com>
> Tested-by: Murali Karicheri <m-karicheri2@ti.com>
[...]

MBR, Sergei
