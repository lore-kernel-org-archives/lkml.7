Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFF9C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74FA20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtCRDClr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfE0RNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:13:35 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53175 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfE0RNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:13:35 -0400
Received: by mail-it1-f195.google.com with SMTP id t184so235457itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l3U8dMl83RQ0UIuZ7WtEIZMTIcW7fBaA/RFlCEyKdwk=;
        b=QtCRDClrMnFIkXacp9K60MqUI5ZSdibB0CDWZ81FfL36MJoikU8cpi0jbxcF3HaJa7
         e7t996EQWvGiA0SHxFIaBj7/GTph9UL5QL2XRDldgJsXOpcqNqrlUM82tEoroVyFf9EC
         Sx0InngUoaIzcANCe2lzs1PBwRBvhIJVE9cOk5wpEQSSdYQz2TOVNp9pCDa/TZxObtBA
         am4hwT/Z7vhYrvUkI/w2zymF0t0nUNvk/IN0k6KwHTDeY0eEQmJ96CHOqUAQgeBsQNnE
         7RqTfBdCh1iAC2UHDE9qzimV/NMgF5ytQea4zGdJE6KlkLhGqIKSE2motMYAMpaIfwx1
         Du/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l3U8dMl83RQ0UIuZ7WtEIZMTIcW7fBaA/RFlCEyKdwk=;
        b=DaGRgUxODOxlDQmjjhd+tCpD0VXIMh+K0gPPcaUwkJDJingcR+o14RenCn2qgtnQmR
         d4LEBIokHU70FE+GDzd7BV+ikhteiwyuM8b6RYU7quS1HgXzk8siwbJ9tEVqP2KzPO+D
         zpgFa1ANSnePdGt/ZjhpGFTVUkGJrhy6Z+R1L3B5sPdLDJq5Ud4KIZpYop6DGv89dQzr
         UAJN+1XtjzLNWA2tZcsAVL+xvx1vQ8Qyv4xRoah9HaZHEngp7+NRmGPvtrb+5kCuRjn7
         sOiGl6aYk7ec+reL2ggHwSdyfdB0k5umhGbhsVQSw6S/zJ++XuSwHF5D2/cVwLGvOjQo
         gXEg==
X-Gm-Message-State: APjAAAVtMjPdcqLiFdxKLZgIoYG6y0nVRP8qgEg/JjoLHsA0h6G8kezp
        cH06sUgpfewexbTJATYTKAg=
X-Google-Smtp-Source: APXvYqyQejuUI8iQbyuDqXgGSHFo06EsYrWl7kCsLd35mM8hCrkAvEBbYDYV6oHW5M8kITGObCTDAw==
X-Received: by 2002:a24:704:: with SMTP id f4mr92372itf.92.1558977214930;
        Mon, 27 May 2019 10:13:34 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id k139sm214920itb.0.2019.05.27.10.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 10:13:33 -0700 (PDT)
Subject: Re: [PATCH 4.19 049/114] iommu/tegra-smmu: Fix invalid ASID bits on
 Tegra30/114
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Joerg Roedel <jroedel@suse.de>
References: <20190523181731.372074275@linuxfoundation.org>
 <20190523181736.156742338@linuxfoundation.org>
 <20190527154647.GA4050@xo-6d-61-c0.localdomain>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4db677be-2c00-aad9-c630-669e284fd4ca@gmail.com>
Date:   Mon, 27 May 2019 20:12:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527154647.GA4050@xo-6d-61-c0.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.05.2019 18:46, Pavel Machek пишет:
> On Thu 2019-05-23 21:05:48, Greg Kroah-Hartman wrote:
>> From: Dmitry Osipenko <digetx@gmail.com>
>>
>> commit 43a0541e312f7136e081e6bf58f6c8a2e9672688 upstream.
>>
>> Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
>> the TLB_FLUSH register differs from later Tegra generations that have 128
>> ASID's.
>>
>> In a result the PTE's are now flushed correctly from TLB and this fixes
>> problems with graphics (randomly failing tests) on Tegra30.
> 
> 
> Three copies of same code... maybe its time to introduce helper function?
> 
Feel free to submit a patch if you think that something could be
improved. To me it is good as-is.
