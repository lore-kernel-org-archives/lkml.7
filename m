Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F08C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE5120674
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH95SWZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKWSAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:00:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42220 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfKWSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:00:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so2922097otd.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G/yt7BM7SPeRzWvT43FwJp3d79dRs3zulFAVmB+daeM=;
        b=KH95SWZLrbowHQJFobDZXNAKSaEX5/CU2T4mM9LPMFrZXsZRgcVijf7Pc6fyxZDqOu
         6+qrgORQ1GIIKGa809LlTbhKOpq90ZrVwICUl2iit/CkIzEq7j0cAwOH24rJKTiDXws0
         SjWN1peXA9x/38RXYZD6+SlLB0LkLQnRSiBXA6Ksml8evlytzdNxg8yu7lSqqakuEHqQ
         49VyE6YFBv+PHUIwseK/g2ZSFyGIDqJ1ssYFOeoiOBymyYDstfhWWiL9lmaavlw1VLWB
         sdxDVtq01tfyzXekFVOMtWgBer5HGu5OwGFmNf+d5XYYUM9iCTbHZ8QUBFZF7ARVGd/K
         uohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G/yt7BM7SPeRzWvT43FwJp3d79dRs3zulFAVmB+daeM=;
        b=RSHFmY4WqMm/dNRfszzTOTIkAnflrvQdJKMogzOeJ2hr7H5VtJUXbUSYJG/OYjb/eI
         iztV4onQKskeJN/DDoTulN9vjEafFxqow1mzOXc3mWMVYbImoUX1ybJjjGfeeuMX+Nas
         bQn/3a4Pw8a2W7UgMwYN63Ud4R7QVq465DUWgcZWH4rq11CBOFwRRgEbPpsojNHxxTsZ
         RRDv3MFOPCyUzvvkt5VB4L50RM7fj2evqkUGjwJXS5KExEuWNBvMdsF+/hnbXeSOk0tT
         hz+QLfxw4COnKevTXxV4AywYQ6BxntyuDJwLCmvec2N2wyP80L9oFFwhx8guxQIyZaKo
         FdfQ==
X-Gm-Message-State: APjAAAXPvu+KFcXA2xz3yG/BlPowKpv83KSlz82l8UdLcM2ANOJHqa2a
        WJ+pwlQlzAIt0TS2veMhRrm20OtF
X-Google-Smtp-Source: APXvYqzXQz1WuQ8o84lBXSlNBZV5pikgdP4pn6zYQi+7SMBgwRfUQo0Ew8aLdCLxY8ZIPRMxv+slWg==
X-Received: by 2002:a9d:5c84:: with SMTP id a4mr773862oti.319.1574532030042;
        Sat, 23 Nov 2019 10:00:30 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id g18sm475965otg.50.2019.11.23.10.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 10:00:29 -0800 (PST)
Subject: Re: [PATCH 2/3] staging: rtl8188eu: cleanup declarations in
 rtw_pwrctrl.c
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20191123151635.155138-1-straube.linux@gmail.com>
 <20191123151635.155138-2-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <13416470-46b0-5b53-5a23-f8177b611126@lwfinger.net>
Date:   Sat, 23 Nov 2019 12:00:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191123151635.155138-2-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/19 9:16 AM, Michael Straube wrote:
> Replace tabs with spaces in declarations to cleanup whitespace.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry


