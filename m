Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E45CA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1198521897
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfiY+y0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfJUCuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:50:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43969 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUCuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:50:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so1889400pgh.10;
        Sun, 20 Oct 2019 19:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Ac26mhO4I98weHmoVOALPgytaZM+twFLffztvIiT6I=;
        b=PfiY+y0vmNCU/QfJb6JcA2iRLHNi0OcYCv6w3jMlZ9Jk1iZuREc+1Ds3V3bWT4oYu1
         Y7nuH3eJi5yygj1gZDP8l3VjAhJISOuSzb5YjQrVipReAVdxIVz08PseB2St4B9+Q6O+
         TnL6de20zvPFuKHVZBhvx7SmKyNcm4qHkuJBuZjC3TWdpgg0cET2CFBxbqSdhhp7vU40
         5XMAimG9+QMXjXRVVyK7NEYf3ZMLT2amGT1KRCcxGKjBVjm7abylE49J2lMc2Cw/KG2h
         yzdQKDGYDKZDCKwRftSDzjvuRZkNRiEswHfPluQbnewd7KKRD7w+lkevXuSu+sv/aCOI
         b7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Ac26mhO4I98weHmoVOALPgytaZM+twFLffztvIiT6I=;
        b=th76Bl2CWkdqBL2euVE4X41RS/ypuzT9LEfAk+vQ+6BQPPkz830qdFDxWVUN/G/0B9
         EWLMY46ACKNImCUPERbCb6N3PIQmwV50JPqvmwYgW0RXptbdVeMgxlr3SVK3cWpXBvQR
         9TGJklkypfFrB5n3M9k2yGg5rwxZPKBbH3CT1ZhJRVn0fjGtKMaqZGhbR9BrEPYwhdYx
         EDu2IJiwZdBuUWSSf3D7Ee+WVEKbZQ3fezy7DjP28VQbNKFTz7ckHbNtQUhlWl7aoDE1
         Q63S1PSsn2nySq08Is8bsov400562C2eu29JzGUmxzLN4BqFMctAgGneIjjAnUCuZN15
         4pgw==
X-Gm-Message-State: APjAAAXhrDHZ/tzif02ifC7oXxwOJEExEnLa8/N956RvIu6PcjtxDWyq
        PKIVNYjg/68+6rs18l+FhpjIGF6b
X-Google-Smtp-Source: APXvYqzdPK9mNtHUE6CuW49roSJKlSRyX9KmEXpr0ps17zNt1NJyvDa0tsmFXQIqq1vG1yiNSNDKqg==
X-Received: by 2002:a63:7a54:: with SMTP id j20mr23546065pgn.355.1571626213137;
        Sun, 20 Oct 2019 19:50:13 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id w11sm15211345pfd.116.2019.10.20.19.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:50:12 -0700 (PDT)
Subject: Re: [PATCH net-next 12/16] net: dsa: mv88e6xxx: use ports list to map
 port VLAN
To:     Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
References: <20191020031941.3805884-1-vivien.didelot@gmail.com>
 <20191020031941.3805884-13-vivien.didelot@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <071ecbb1-4c1f-6e18-55ee-3e36b7c15843@gmail.com>
Date:   Sun, 20 Oct 2019 19:50:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191020031941.3805884-13-vivien.didelot@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2019 8:19 PM, Vivien Didelot wrote:
> Instead of digging into the other dsa_switch structures of the fabric
> and relying too much on the dsa_to_port helper, use the new list of
> switch fabric ports to define the mask of the local ports allowed to
> receive frames from another port of the fabric.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
