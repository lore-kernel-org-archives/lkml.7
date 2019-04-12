Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E422BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12462084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3XvMB3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfDLKKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:10:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33721 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfDLKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:10:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so8360084ljc.0;
        Fri, 12 Apr 2019 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7g8hJg8giu60a8Iz1TikpygimYCfB9s7E04Q1bb0ETk=;
        b=h3XvMB3LAYaJLkOtdcq0GY2Ay1+aRQralk7+KQBW7oLmkWAQjKVP8ryyb5FJ0+jjR5
         NgfFp8m6K6oy5lSgJF5/OpZFqdI13Ue6Ci2ARp77BQa0V7/+o7Gy0+z0WCV9eSl3tMqa
         NCNX/8jpUypjm12KAnVlyb15cnu884ripFuhEld/zfSxfOHv+95Bzm1jxWB+6vgLuBfl
         fXpyaQCF92A6BLW7AZzJ4ofTgzT5yQvYaYzIx3dTvk/fE5xnJ/y6HGdMA17PVg+IS0rl
         dF+t+Ctmi96E84CtloCvIqGw/llKbPYRD0xVBcqmEq6mWdNhrpT9ifWLNRcH4rscEdly
         L5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7g8hJg8giu60a8Iz1TikpygimYCfB9s7E04Q1bb0ETk=;
        b=irn77fYwmETvnbpJmySCvzKCzgfTuYhx/D7W3UKBS67pR7MoGXLv0mGHDd2S+jwYRS
         p0sF9JcFoecImiuzsLP+j4qYIyOI+lqs1GIvSK2brNA8LLjgH6W0fqV9lt75fNlZzKyF
         oXxvYhTtUt9cnlimsCQOQjWpLLEQa/yEVH+GjNwSAyH9h1ew9ND0oITgHS8pLbLvXuTT
         MSVJ1QBWsW+2A2bH7u2GlXFKPH7oixX0MplEQtA6xAku/3pahWq20/oR1VZCIiz8aybX
         JCSiRA+tcDqtuOHr1NcR3ImcYqOiv13VKZae4GGbJqQNKom+aOE21Xd7GoPbtOyUpjO1
         vSlA==
X-Gm-Message-State: APjAAAV0SSI9yAB7mjZDJhCiFdQxKOjzcv2HdNRruTX7T92YhaVsWUOB
        P17gpt0s1bfohm3JsPYk3guqzpaA
X-Google-Smtp-Source: APXvYqxuRxIwDwj+wctn9pVxOAzihA1ZkY1ZBzxZlFu1HLlMPdVfZcPMEUSlMuU28FYQWt2jWxMQBA==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr13653349ljj.51.1555063799512;
        Fri, 12 Apr 2019 03:09:59 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id z83sm8195508ljb.48.2019.04.12.03.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:09:58 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] ARM: dts: tegra30: Add External Memory Controller
 node
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411230221.31362-1-digetx@gmail.com>
 <20190411230221.31362-4-digetx@gmail.com>
 <20190412080158.GG12975@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <46d3b12f-7279-c7c5-68ba-e524406f1c85@gmail.com>
Date:   Fri, 12 Apr 2019 13:09:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412080158.GG12975@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 11:01, Peter De Schrijver пишет:
> On Fri, Apr 12, 2019 at 02:02:21AM +0300, Dmitry Osipenko wrote:
>> Add Add External Memory Controller node to the device-tree.
>>
> 
> One 'Add' is enough I think :)

Indeed, thank you!

