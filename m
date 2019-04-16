Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D02C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5FE20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/1WfkNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfDPXqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:46:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41883 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDPXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:46:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so18507740oie.8;
        Tue, 16 Apr 2019 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tY+IpKJnbA0wAjHCnx4suU4nbsWbs4y22pxrUw4SJRI=;
        b=l/1WfkNIZnGyKl16f7yA5rsv6JBjTFdfa6bd1PDHrz3DwGVlkoypItAnwg8Ux3GILz
         d39H65XgMpYRwyos/F6VLRB9wttoeiBtxw38zQ+gKlqg2D7FebbVJ0aD/hJnxK0Iq2vv
         QeV9kFaX0bw2h12UhrYCpPivVLSQMdGzl2PDGjx0nOLVW+iWWoLgHEF8Ii8q/GquhJ51
         CWw1wMbsNe42f0hUjEpAo/EJpyvRzvhMRVT2FCT++qQ+rO5cdOVefyNWYkiBr78mIbga
         92HFNygI/M1t1s4bqBFB0s4eX+Cf9GN7SCPOcUVvDFmDaJSjrvatqu1Ue9LSNHFPTZ81
         ajQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tY+IpKJnbA0wAjHCnx4suU4nbsWbs4y22pxrUw4SJRI=;
        b=kyy2v2CtCJ4Qyy7OJt9lZTTtnDBA4/vdxVKmDUsBST+zDXuyPHAMxvTAhgRg7cQnyB
         JI0h5tglyTwsYk2/lUIbew9c/Foc92SbO/fHS5AW4get5q0ginX4Pwwsb062Uxg0XyOq
         XLEN/IjGf3GHWd9nEKQ3AXOudUVvGMSlcDPgTYMZQvCldTussnKRxH4EKkGRz+INU5IX
         ZJNfMO6XQQcWi4Q/mu9FdFQcn89i2hEn/8q0153Ms7730F9312s5KJyhPJZXfb34rJFC
         TLZB5NupZuUrBtcGnPDw3h8+AZYSc9J7lTr1plZl4dVrnLskyRQW2KF4RGXByWiIfF7F
         f0UQ==
X-Gm-Message-State: APjAAAVseo3FBd1y/3Vjpyqdx9gE+i3L+dxl7K9rlUpwRrYsr0PCnv+z
        W3DJumKGdccHy2SW7qQa21c=
X-Google-Smtp-Source: APXvYqwUffCEKvSAMuKgt1W2R3ON4MtX1hepcV3ueuLMippQ9ZuD6d/JOyknCKk2pBkgvJCxDiFDmA==
X-Received: by 2002:aca:40c3:: with SMTP id n186mr23258802oia.156.1555458392787;
        Tue, 16 Apr 2019 16:46:32 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id m8sm20272524otl.40.2019.04.16.16.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:46:31 -0700 (PDT)
Subject: Re: [PATCH net-next] net: phy: micrel: add Asym Pause workaround
To:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        andrew@lunn.ch, hkallweit1@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
References: <20190416101020.22149-1-antoine.tenart@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b864edfa-9876-4905-1fbb-55c31ad50deb@gmail.com>
Date:   Tue, 16 Apr 2019 16:46:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190416101020.22149-1-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/2019 03:10, Antoine Tenart wrote:
> The Micrel KSZ9031 PHY may fail to establish a link when the Asymmetric
> Pause capability is set. This issue is described in a Silicon Errata
> (DS80000691D or DS80000692D), which advises to always disable the
> capability. This patch implements the workaround by defining a KSZ9031
> specific get_feature callback to force the Asymmetric Pause capability
> bit to be cleared.
> 
> This fixes issues where the link would not come up at boot time, or when
> the Asym Pause bit was set later on.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
