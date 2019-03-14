Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F8C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B3E2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UN/J5P94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfCNXn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:43:29 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46448 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfCNXn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:43:29 -0400
Received: by mail-pf1-f177.google.com with SMTP id s23so4903811pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIC83MkNNWtD+yghVyMZZOh3+WVU1WtBYDwPrahmWQc=;
        b=UN/J5P94rJYL64qMojBByaatGIbMy5P0pJIgDrsjxMRJQqcr4bQ4IAt+i+xQyAbe78
         VRMKZ5Q78V8rty2U22huxlDxR7T9MYdJLGFYu/W5wH6aFvb37U9r6zaEkrJlDcg2dxzN
         MpHJ9qaQ+LsF/gAFieOK2LdQ6H+mU79fRg1BvjtZ6EP1XaMV0LDertFkUqO3NacKOfh5
         AqLIXjsTmxMFQROdeEJXF6gPuXhBv9ci3/kobntL/w7nwz3eG4W8BaWIgRg3ZQGfUfcV
         O3/m8Ln0t7kNdA4c74WGtXMw+juGDLy3PFJuZNAV//RoQSEt/lT23y+fYnqC0SRZJsU8
         gEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIC83MkNNWtD+yghVyMZZOh3+WVU1WtBYDwPrahmWQc=;
        b=qf/4r5a3Pb+ZobkzG3/nmyAuAnP9M/DdXWWQpCvpSIiCb2qNXJOXBAQLsVklGuc1uS
         gyZdR/ZbmaxYMvOyu/9xmQWIyygh60+yN+sShCoibMm+MnaXbaj0Q7SyjLw/Huyz0nEQ
         J7Z2kYGuBb0w6NRnOkUu9ovbQqlICUERRoNMwi6QTxV+jmiNU4kP/tZwrlEUzAgJ5zsk
         IDu7ikWI/SCsyBr0Y7uims7x9GWUr8p4CZMwSIMw1BMlg7G/r4ButdSE+Zpg9JviFkM1
         7JgH5hz3WaGESLpKllvFkr+/xE62GhyeBshLNQPLBWAEUPAVCDawwLtPE1a3zBMDJbkQ
         HkyQ==
X-Gm-Message-State: APjAAAW5aJ3s/uq9Yc3lCN6NweAVom6Di/CZWsXrTP/fBlTrH0+hnCbn
        hH3OynhEDkfNNXwpYcMYYZb3OQ/IxikyzQ==
X-Google-Smtp-Source: APXvYqwKkgIOmg/D28qaZrTVrMOtVC2oJFXGukQ5XnTC2ekOmHwMnlkEdg1Q//8kPWzvwc/AWFSXpg==
X-Received: by 2002:a63:6a48:: with SMTP id f69mr466207pgc.7.1552607008767;
        Thu, 14 Mar 2019 16:43:28 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n75sm289187pfb.39.2019.03.14.16.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 16:43:27 -0700 (PDT)
Subject: Re: paride/pf.c: blk-mq use-after-free (kernel v5.0)
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org
References: <30c63b2d-92d2-51be-40f0-62cada110388@infradead.org>
 <7d24a06f-f219-e50a-e8f8-915a6cc1b796@infradead.org>
 <e2a66da2-5433-5b42-1ebe-9f1c135b5471@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59cb035e-6880-de5a-33c5-d4db6ed910f4@kernel.dk>
Date:   Thu, 14 Mar 2019 17:43:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e2a66da2-5433-5b42-1ebe-9f1c135b5471@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/19 5:09 PM, Randy Dunlap wrote:
> On 3/11/19 6:34 PM, Randy Dunlap wrote:
>> On 3/11/19 6:25 PM, Randy Dunlap wrote:
>>> [Has this already been addressed/fixed?]>>
>>
>> Same bug occurs with paride/pcd.c driver.
> 
> This still happens (in blk-mq) in v5.0-11053-gebc551f2b8f9 of Mar. 12, 2019,
> around 4pm PT.  [caused by paride: pf.c and pcd.c)

I'll take a look at this, been busy with other stuff. How are you
reproducing this? I'm assuming you don't actually have any hardware :-)

-- 
Jens Axboe

