Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140BAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22242231F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="C0mvaRBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfFDMg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:36:58 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:52738 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfFDMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:36:57 -0400
Received: by mail-it1-f182.google.com with SMTP id l21so11145941ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=a7Q+YZfWc0HPNJRCO1pTkfA49Lox7NSuvtbJIYkeSK8=;
        b=C0mvaRBJzrotq/+PEx0gxWneOq1Hx/OVrQLyiQl8BV1d4YVtqkjdzHIh3KLDauQiAl
         oY3r136wK2riENIyk89Vk+lyALG/oINc+qUWkv1GFMWQeQ7BHNHRd4XLQgmCaj3+CSYa
         cRDfjSWh7PmTfC8eq0BPu/LXpWAZsx9UD2qMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=a7Q+YZfWc0HPNJRCO1pTkfA49Lox7NSuvtbJIYkeSK8=;
        b=UsOg9wonBQ2KDn+Ss2G1imNI+KhydpmoeMm4HQfny6O3huAJdpF7N2v0gBsnP9M2Zc
         d4oGpuUUWE25gPS8rPyF/yzejamULMNUtHAtk5Xi8LUAnG61sZxVzfXm+n6L8ce3BwvZ
         vTlEzpYYcXRKcPckX0uIamFh0lb+QP72hN0YYkDzIw51o9xmS4eZjENtxOhehwQ5gPlJ
         Dvo3bM5WzTCT/iAQpFbczSLIiN7fjf4sjs/QiuupofPSLN2iSmTmrvXgZ/rTU0nDJVd+
         eQJ97SCvpKAu2snA1TWqLMcFIH75fOlwtrQw4QfVV+nAkOWZNfLL1vRFMYt1dbP0R/+6
         Yzgw==
X-Gm-Message-State: APjAAAU5s60cVZ775OhWBYeHTqfw+f/pIm1A6g0cyzp3CiNODaCfkBwf
        FYW2OhfSxNWAvrEkg14992k8/RZ5odk=
X-Google-Smtp-Source: APXvYqzk9LKFZabwC5bZlDDTOGmbmuuar7X7g4B4YlGJK3DBwwZsrCXN566Q8a/Linw8HzV45kUaTA==
X-Received: by 2002:a05:660c:602:: with SMTP id i2mr21754103itk.25.1559651816753;
        Tue, 04 Jun 2019 05:36:56 -0700 (PDT)
Received: from [10.10.3.2] (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id v190sm8540458ita.14.2019.06.04.05.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 05:36:56 -0700 (PDT)
Subject: Re: [PATCH 1/1] udf: Fix incorrect final NOT_ALLOCATED (hole) extent
 length
From:   Steve Magnani <steve.magnani@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190604123158.12741-1-steve@digidescorp.com>
 <20190604123158.12741-2-steve@digidescorp.com>
Message-ID: <fe25ef66-afc0-ddcb-8a65-96f556c48e1b@digidescorp.com>
Date:   Tue, 4 Jun 2019 07:36:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604123158.12741-2-steve@digidescorp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 7:31 AM, Steve Magnani wrote:
> B. The final extent is not shorter than it should be, due to not having

Oops: should have been

B. The final extent is shorter than it should be, due to not having

