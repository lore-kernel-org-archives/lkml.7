Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C07C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B87F206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightbitslabs-com.20150623.gappssmtp.com header.i=@lightbitslabs-com.20150623.gappssmtp.com header.b="huaPCnBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCSQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:43:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40641 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfCSQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:43:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so14229037pgo.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=huaPCnBuQR0aj7ToSKosp/PQQB7PVl5vKRXYkzd1vIwrmSFzvaIdAefIXpTiNbaWss
         y41GXIMNWTfkTVUq3OPm7lGhDNbE5olBhAwR7/GI03ezHPXs+GpSoutM63pkwb4NxmGn
         2hGryboSqYlr6sWPwFIuaq9DMU8V2Zh4DEzBsyr57HotwdwA2Ni+iwx5Xu0e88AgXJng
         J9xHKiGBg8MCTC8s7WFOGX1P32KyhtVHRIJXWO44EaAzhec71RUrfBXIsKnw6ADAHQ4s
         pRS/8B5uzaiqBCUT703shXXgtmMRTNl5GAYbbCWwOI3xpDSA0K/47Ndopzc6b81E2joS
         VZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=m4VFqGS1hp2qVlFYTITdH6P9y+V10V8+ZHGl57D8qKWOqz8OlfVGUEgECnLeS8muhy
         JYcVwrrX3Q752PPJQ1Bxvd4mgqrJb3k6/nDo8/xjBzxbLGK6ulTs05Pn7JuQWXzmwVYj
         55FkxWxi3VRd8uZlQwAydbyJlFA3XBJwn/NFMLezJAP50dWKLJKAioufS78X8vvIyl2b
         xxCrV0rFbzLIog+hrQdSPaoObh0tjnCjGssMgMaXFX+4adJtm/B4l1CzI5c8mdwLieOo
         nVADmZRBD/Ncl7SMbIyT44A9UBetVKeqVV3isu/xrp3rbx2KPDfG/9AMCvliAVDhz7iX
         vEsw==
X-Gm-Message-State: APjAAAWa6kgcJSUsveSxoiraU8EDmEVlZgUTzZqbMnu+tZy/5xmxgAAD
        rAbwpbohsg7KX341EX+xqbR2pQ==
X-Google-Smtp-Source: APXvYqx2L0uPd72Z7iTE+VE7A/41iM+wB8JwIfUnJUcVJanss8ntkLdDUI0HOFs5R3v+2JkOqylcaA==
X-Received: by 2002:a63:5622:: with SMTP id k34mr23852433pgb.123.1553013833338;
        Tue, 19 Mar 2019 09:43:53 -0700 (PDT)
Received: from [172.20.40.56] (50-207-206-41-static.hfc.comcastbusiness.net. [50.207.206.41])
        by smtp.gmail.com with ESMTPSA id q7sm22281704pfa.119.2019.03.19.09.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 09:43:52 -0700 (PDT)
Subject: Re: [PATCH net-next] datagram: Make __skb_datagram_iter static
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        xiyou.wangcong@gmail.com, kgraul@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190319145946.20504-1-yuehaibing@huawei.com>
From:   Sagi Grimberg <sagi@lightbitslabs.com>
Message-ID: <7bc20b05-ff45-2d00-98bf-77fc24cdaf7f@lightbitslabs.com>
Date:   Tue, 19 Mar 2019 09:43:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319145946.20504-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
