Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E020873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="tcLpDCeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfJOOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:09:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41355 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbfJOOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:09:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so19263487qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t5eOxqRId8vK3PKebojEYhfcJ3xlCooyWYfL6dKYbRs=;
        b=tcLpDCeXfphikZShTtEOoz73rLOrSAJVb6Q7vKmkhhqZQGFStAsCfUIuQ1LPuxHpkM
         7MunCNYTCEHKbp78o5dkJI9XjFgNGRUhrJq8wS1eBGlCsxeBuIHY9L+qVnWNSFsCyD66
         T3M2/8c+GY5wrTwk+D0f9w0kkdT7WB4p+VAiI56A5izZKaF7B5ZnMiMMRW8MfKuAjePu
         3goVYCxOWsyG1evrQkPNZbB2XdPbwWJpl2Soc+8CEQtvU7CRzVOPiuZybG+yHkAz0F63
         DTSWWt3Zmn1OBWBIdcxwfUmrcmZohEv1OYYgp3+rbBvlkk5Bo53H54j7risx0FviFOWZ
         sJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t5eOxqRId8vK3PKebojEYhfcJ3xlCooyWYfL6dKYbRs=;
        b=qrp8EpeDhXR9djkGozG6zzg0N7aWu1fJLjJQWkyJCbjWyWnYsnrXDcSVlQRPpiRd5M
         job7/ExYAns7knDbffaVDxo1L+WmDow/AZ1ifdmkVAO6XoDIGfnY0riVSaGJB9No5TE0
         WfAK2jzmzHJ4xtpE1S7jkzWGsEcL2fq4HqS+CW0/qVljv3Y+WDYqo5+oCTDLb3rhCsJ5
         7WLZo02A1iN9zHqbPOKMTAHzD9p4xRnkmeYmj04dVysWtgd7TWhxnwAp8wwdpfOXAOj7
         mobOcC3idnPigt5nrv9PjZ3ksG9NSFrO/63UEsU8/dpfmu7yQkDVapBFdfChKkysP18b
         ykKw==
X-Gm-Message-State: APjAAAVCDSRU+oRE4ypKM2aBjiKV+OXau42Vh04lt8rnGfSMe4tcKn4P
        FmZdHd7VhezWO0LRSRUPu4fiemWaIiQ=
X-Google-Smtp-Source: APXvYqwNQCrdCFHTukIHH1DK6nRM7MJZzWyMFUL9UiO15cy292nTnKgFD12L+5CE972wcyK17lAy5w==
X-Received: by 2002:a37:67d6:: with SMTP id b205mr35982090qkc.183.1571148597145;
        Tue, 15 Oct 2019 07:09:57 -0700 (PDT)
Received: from [192.168.1.10] (201-92-249-168.dsl.telesp.net.br. [201.92.249.168])
        by smtp.gmail.com with ESMTPSA id q5sm13241324qte.38.2019.10.15.07.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 07:09:56 -0700 (PDT)
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
To:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
Cc:     Guilherme Piccoli <gpiccoli@canonical.com>, linux-mm@kvack.org,
        mike.kravetz@oracle.com, linux-kernel@vger.kernel.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <CAHD1Q_ynd6f2Jc54k1D9JjmtD6tGhkDcAHRzd5nZt5LUdQTvaw@mail.gmail.com>
 <4641B95A-6DD8-4E8A-AD53-06E7B72D956C@lca.pw>
 <CAHD1Q_x+m0ZT_xfLV3j6ma3Cc88fk9KnoS4yytS=PHBvJN7nnQ@mail.gmail.com>
 <20191015121803.GB24932@dhcp22.suse.cz>
 <b6617b4b-bcab-3b40-7d46-46a5d9682856@gpiccoli.net>
 <20191015140508.GJ317@dhcp22.suse.cz>
From:   "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Message-ID: <2d593c95-3c69-8f50-17ff-223bd607caf1@gpiccoli.net>
Date:   Tue, 15 Oct 2019 11:09:53 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015140508.GJ317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/19 11:05 AM, Michal Hocko wrote:
> On Tue 15-10-19 10:58:36, Guilherme G. Piccoli wrote:
>> On 10/15/19 9:18 AM, Michal Hocko wrote:
>>> I do agree with Qian Cai here. Kdump kernel requires a very tailored
>>> environment considering it is running in a very restricted
>>> configuration. The hugetlb pre-allocation sounds like a tooling problem
>>> and should be fixed at that layer.
>>>
>>
>> Hi Michal, thanks for your response. Can you suggest me a current way of
>> preventing hugepages for being created, using userspace? The goal for this
>> patch is exactly this, introduce such a way.
> 
> Simply restrict the environment to not allocate any hugepages? Kdump
> already controls the kernel command line and it also starts only a very
> minimal subset of services. So who is allocating those hugepages?
> sysctls should be already excluded by default as Qian mentioned.
> 


OK, thanks Michal and Qian, I'll try to make things work from kdump 
perspective. The trick part is exactly preventing the sysctl to get 
applied heh

Cheers,


Guilherme
