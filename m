Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E11CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9962820854
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="A5WNHkaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfDTOmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:42:36 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44022 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfDTOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:42:36 -0400
Received: by mail-pl1-f182.google.com with SMTP id n8so3826133plp.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jtQiDjgJaQcnYiNwR370yhgoL1iAUs5lw3h3s7iJths=;
        b=A5WNHkaAEt/QDwWci5NDVBWgeliXCQ8Wqvs57tc4EA3/pvrfMgUc8Rz8WyOkQChl75
         j+KFbOQP08pGPQuS0mgKx7eX1WCE1DFMUEAFa+J14OdZFJPLHODTEDQ8eMpYTVVf3C4m
         +SifLJ426sH3xMOfcqUG3zxXuSAs9Cl2vuJ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jtQiDjgJaQcnYiNwR370yhgoL1iAUs5lw3h3s7iJths=;
        b=RhV/GCxnvSyudwlpirleAqZmq38v/CG7lZDPZyPfmrdO/v9kKKIRdv75mSgwiedERZ
         8bHQS75UeY/EqCc0KfznGMalTfYsZydj+J8L/XUyg6nbewwEO1ekSoekPLxHswXlzuyx
         qwS/aAHvFmqGSbHpB8mOW8xNknhyyG+4C05ZiOlJkr4xt3qY8xWGccGWvfI/4EijsYZ0
         6SPdWAzMqm9Q2pwVmNeV3pc06IrbIdlToGjOJt17rfe8c9ZyRCKsstUxvnqc4pHLlE+H
         j6w4EoxkHkMbNOofOy1owdsL9+NPq0CP3QYmwNfrms22PiZiNTkDHfyID6wQHTfFMZbd
         LU/w==
X-Gm-Message-State: APjAAAVFXcPAl8yxZY3M0eMGFXF6zjTiMqSlACJ10fjX/A1AWhtp8j7G
        dgbA+63KQYgDPt9cMqtoQYXjmQ==
X-Google-Smtp-Source: APXvYqyF9SSg12VxjwSRQvqyVmmaZZkn+okaqo3p5ap/9SebE6BGohbTgDJbsN1Hscr7am6xIDHmWA==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr3831022ply.44.1555771355710;
        Sat, 20 Apr 2019 07:42:35 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:4524:90cc:ba64:efb8? ([2601:282:800:fd80:4524:90cc:ba64:efb8])
        by smtp.googlemail.com with ESMTPSA id k18sm3718657pgj.0.2019.04.20.07.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 07:42:34 -0700 (PDT)
Subject: Re: [PATCH] net: vrf: Fix operation not supported when set vrf mac
To:     linmiaohe <linmiaohe@huawei.com>, shrijeet@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mingfangsen <mingfangsen@huawei.com>
References: <4e8a50df-bf96-3ef7-2977-71495d80643c@huawei.com>
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <e758e1a7-c086-1200-d24b-349f79c2ccfe@cumulusnetworks.com>
Date:   Sat, 20 Apr 2019 08:42:30 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4e8a50df-bf96-3ef7-2977-71495d80643c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 10:09 PM, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Vrf device is not able to change mac address now because lack of
> ndo_set_mac_address. Complete this in case some apps need to do
> this.
> 

mac on a VRF device is irrelevant so what is the point of allowing apps
to change it?
