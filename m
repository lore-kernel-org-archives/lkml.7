Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BE8C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DA22084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="tA2EL2AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfFTI6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:58:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34709 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:58:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so1872648lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dfxJ4a2QTSJhkHiDqzwqK9Tivfex2EusFAKfwRKgyto=;
        b=tA2EL2AFfZRqDrIIYLfmZxNarz18c+FrlQ9uWa9jZGI2Xz7DlZylft13OUaLaZKFFh
         XsQbVTBSNkhBHWR/ZMnTfshfgmfCSmYhtz59wxZN9OVHXRxxt5CkEQAn5aNXS5PdZHJ/
         H0NpPb+3EpxxnyOjrnDB2IsVRG+jR5J7egrYr+dqo/gf9fDtEbWaKLakQol6Zfa1J0pk
         BIFoi6pCIPadQHBmH9Wq0BDx88ZiZd5R+tINXxFhqiq6F+gIF1QMQXvmFw1tsyC1uhhL
         cgLkRfeP/f8Zy3eW4DOPLZIRQc1fTRKn8lR1qkBBhzTRJBgewbfwPLmxlwuWpQ8A1Z01
         fJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dfxJ4a2QTSJhkHiDqzwqK9Tivfex2EusFAKfwRKgyto=;
        b=XvQnNTmCAxTNHBEhuG1Q/q1ieWwk4p6vRIbNLOILuRuf3pBQap+KCDHCREvSjy96Kp
         60mFJfjf1mt5O4bGqA9Pys0vcux6v3TxoOPrIZpNrjCDVD1LiyJ7tyQqQ+/KQH7EPICR
         jALCoPbG33wh48TLybtdYhbfFvPRcN25BwmXxVpQATDLvE6q6Oo/BFiYwolrBucUDm+r
         rlqCeDzK0z56vdBGajtMq5phSgPMU4p4KgpHL7zsx1jlUUaycnS2iPaq4w7jktPgP9DL
         CAJQd//Fe7t0Pp+YXK3+SygWzmZhStho1ThZRvDd3mNhfmlT9KWftTnlUxIqz223YOeF
         uxug==
X-Gm-Message-State: APjAAAWuB1nDn2To2ennTQKMZ0r2MhrIgg9qel+mAZ5RDXg+w21FUTYI
        X4QVH8IbHNHvSrCOK+Jt6BWBmA==
X-Google-Smtp-Source: APXvYqx5ktYLTZynXGSE+vTJdFLuUIHLNqlOp0FQpxzu8dC2WHR3IFfJrM3Ppk6ii7J96jDCV+r9Nw==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr2537282lfo.63.1561021123413;
        Thu, 20 Jun 2019 01:58:43 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.13])
        by smtp.gmail.com with ESMTPSA id m25sm3062325lfp.97.2019.06.20.01.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 01:58:42 -0700 (PDT)
Subject: Re: [PATCH net] net: mvpp2: prs: Don't override the sign bit in SRAM
 parser shift
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        Alan Winkowski <walan@marvell.com>
References: <20190619145413.21852-1-maxime.chevallier@bootlin.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <64727f68-866b-b2eb-38c9-5670efe68aaf@cogentembedded.com>
Date:   Thu, 20 Jun 2019 11:58:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619145413.21852-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2019 17:54, Maxime Chevallier wrote:

> The Header Parser allows identifying various fields in the packet
> headers, used for for various kind of filtering and classification

    One "for" is enough. :-)

> steps.
> 
> This is a re-entrant process, where the offset in the packet header
> depends on the previous lookup results. This offset is represented in
> the SRAM results of the TCAM, as a shift to be operated.
> 
> This shift can be negative in some cases, such as in IPv6 parsing.
> 
> This commit prevents overriding the sign bit when setting the shift
> value, which could cause instabilities when parsing IPv6 flows.
> 
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
> Suggested-by: Alan Winkowski <walan@marvell.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
[...]

MBR, Sergei
