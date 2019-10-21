Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33492CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F6C2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcZuXBOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfJUC4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:56:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42864 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUC4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:56:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id c16so2140952plz.9;
        Sun, 20 Oct 2019 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxMz0y2W7ERV0cHxluJ83jF2XfjJbXwAQncUIXq9fG8=;
        b=KcZuXBOeExAjM7tEqSfor7pThzloqeH1GLyIVzobO0ubEc55L0Rz0UXjYZ8VDKVcZa
         7IFi3b9vyXts4wPcRKDqYrAiXWYVjU+hzcEerbD6cwQXhQMPT6GO2k++3yd2oi1l+/vR
         /y3rVC/dq6/YM1jIV81I96Ls0FAPD1QsluXoV/O/tA2eKLi7bKjr+3SlyRh9yXSMqjQk
         ls2urqlkRyIBShM/dNx2rcYYIEiRxvostyg0Kdc+I6Io1xiwTuYuI7HpE9Dhrmo2YIOz
         J4KTQYwJq8npEA7kn3PJdlhimN3j6EZz70KdDEareEC/72U9VHK0NxyUWmY27RFBKGos
         N83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxMz0y2W7ERV0cHxluJ83jF2XfjJbXwAQncUIXq9fG8=;
        b=P5cYbUTKG/gxPo/kLNXV8xXkL5LhqxO0lVNvmeSc0Z0uyZadlrsvR5MYwNacPw6zmq
         6UtuO8ME6Ix3z1CCtCDO95JhG1LD29VMk8fCmQWw8rVNnMu4RYSTcMaSUmF7PRQCZGJR
         /hzQnVGVOGgZrgoQqws4snJzgf6977TtQwfaPnbYg4c36wCXe+jMfMjBGmIsEiG6viu6
         icCBc2ahEPZetoeEQKJlODoUsELGgUif3DyHvOsnFgVPRg6tEC5OVsaN/4X7m63apQS0
         RmJG3ZpCJzIfWopwArfqdsjovnaCX2aU6fPopyjGNlnGXfF/POxddYQ8cbk6N+9NEGNu
         no4Q==
X-Gm-Message-State: APjAAAUYRz5nbrO1HxL8alAlKgfVu9D7GahWEy6D/HlNAtgILbcA5cQ4
        UhjoXtn1Ik9cGDL5Dhaq1CXTCtKT
X-Google-Smtp-Source: APXvYqzT9ep2deMoKRtgReGt2eOp0rclfoQyzI+jHhf9TP065Nn5lVrMFvkljc+/q5snRbktdSjFTA==
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr22664889plp.18.1571626573043;
        Sun, 20 Oct 2019 19:56:13 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id v35sm15711929pgn.89.2019.10.20.19.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:56:12 -0700 (PDT)
Subject: Re: [PATCH net-next 15/16] net: dsa: allocate ports on touch
To:     Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
References: <20191020031941.3805884-1-vivien.didelot@gmail.com>
 <20191020031941.3805884-16-vivien.didelot@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f78603c0-82ce-2bc4-87f8-b1586c144f6c@gmail.com>
Date:   Sun, 20 Oct 2019 19:56:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191020031941.3805884-16-vivien.didelot@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2019 8:19 PM, Vivien Didelot wrote:
> Allocate the struct dsa_port the first time it is accessed with
> dsa_port_touch, and remove the static dsa_port array from the
> dsa_switch structure.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
