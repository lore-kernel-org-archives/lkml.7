Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19CCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DA221744
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="yhlkEo8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfKCSlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 13:41:09 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36749 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:41:09 -0500
Received: by mail-lj1-f182.google.com with SMTP id k15so3101877lja.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AeLf7+pAe1vvcFU5kbeUWFUhzvyDncncA1kLNAYfilw=;
        b=yhlkEo8XRbIzWVnZ1sY51cdqWpxNU/mnal07vUufL9zyAcu+iLxysAy8uDKrcbM1ym
         g3YJC3sR6G0NBGy+M5MD3VKWpvNRbiw0CMVSd888w+VCYj/pR5piSn5Ye5RSNcbVnQdN
         nkv/vNIIt109kS3+4WR9U9Rvroc/0JIuxqdArBuSU+INo7O1cDFrd6iWFGNcAnSObAIm
         /lVLHSxkuCIdXRGm06LQy+cGOgExrLg7A7ZVNkaW6J1a/ti0W5LRa0LsWP51R++yQKZ1
         BECTNfyl2IBS68Fm5LpsM42Ppj9oGb9IjbZtgjufkf/QkOTCK7MaxnZRwiiwmcbTL54s
         wRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AeLf7+pAe1vvcFU5kbeUWFUhzvyDncncA1kLNAYfilw=;
        b=Mjuf9wo6xWsQVbeBnn+np3i8kFosnUYKJ4cy0p7drVzVHk7vo63dK4JcoIiL95Nuqe
         ec2CBOGVsK9KryXvr++RPSh6x/1mNHBth9tNeFnJoN+cEFtAQwh370aO0XfhzSYW6slQ
         ZX+w8cRFcGJYUeth9RT+8dOXKev+XP80HAO9A4A0FU6ordHtxP5UC4owwQrBT9X/rvzo
         NGDuO37ILLf8XFFtmzaBFxTRHASgRkTue67i8FRxkEyG3TmvN/FpRf/7MUSUvmLhZR1Y
         aB2OPQGBj329eMBXSHa+/z7Sv/KodVz0ykPbYTbak4KlenzaGLw5yeFHdDHaJKDn6OFR
         GZxQ==
X-Gm-Message-State: APjAAAWKVZEHAdhCp3ybmWqIi0odyJDmQxm3uF0E67RJfq9+tOVmahXM
        J7fvJQUd+ICx7taqKtkWuC4QHQ==
X-Google-Smtp-Source: APXvYqwVEdztkyW3Md2Zu7fMEpscBqr/wGvRZO3D/UBXplU7SA8fdDtWVQOAbM+BG47zlPErNWxtPw==
X-Received: by 2002:a2e:a409:: with SMTP id p9mr16202253ljn.186.1572806467623;
        Sun, 03 Nov 2019 10:41:07 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:47a:43f6:66fd:82d0:1ef5:f513])
        by smtp.gmail.com with ESMTPSA id r12sm10286481lfp.63.2019.11.03.10.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 10:41:06 -0800 (PST)
Subject: Re: [net v2 3/4] net: sgi: ioc3-eth: simplify setting the DMA mask
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <20191103103433.26826-1-tbogendoerfer@suse.de>
 <20191103103433.26826-3-tbogendoerfer@suse.de>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <da797418-e056-a4bc-52f7-c329e36a879b@cogentembedded.com>
Date:   Sun, 3 Nov 2019 21:41:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191103103433.26826-3-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/03/2019 01:34 PM, Thomas Bogendoerfer wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> There is no need to fall back to a lower mask these days, the DMA mask
> just communictes the hardware supported features.

   Communicates. :-)

> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei
