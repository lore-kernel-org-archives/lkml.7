Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5430BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358642173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfHVSCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:02:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33825 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfHVSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:02:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id g128so5068486oib.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 11:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h4HLC/ZMcej4QwTFBU3hYph7KTFLlz07LCtS+Hruuhk=;
        b=aOS62eQqJ5Ms6gnVdD3fBpaogG1GY7SI+b95tqVDjfEOLE9hCMVXabPahCaDi7qG6a
         ZoHbuH3o7eTBDt+dwR+iepeaVFZRJu6HQncyQNHxbGX+lYvaJ4f/PLoZSSXda+frlkCM
         xI6I5bCMWYMdqzWf4mgj1B7p9fDwGCSsXtE+3PSjzNM11rWB91Uc54fEPcA0J4dlE9Bq
         AQscmFCiRqcvvTKPgmOrv9sO4samKlXVIjTkhJD2eqlYvqDc1qu01h1KzuVk8ylVrzTn
         BR4LicsB7xAUDZgmwICyPVwt6xZghdFUtSTJY0IYTQyN5wPWeWM7/xIzosPQSIH9Q9oB
         Nakw==
X-Gm-Message-State: APjAAAUugfW2NChcbQ1sx8nAWYpRsHx+IzsgbgtNQk396SBrxJ5Ufr/c
        Xe1fYcl3J3SIL1ZLxkDP+X4=
X-Google-Smtp-Source: APXvYqyUYP4/lZX+eCDveqQeqWdCXDo0bY2DhBbEvArHfbzlqv5ewmtI81CJSd+J2leLy7f7nZEVcA==
X-Received: by 2002:aca:edc8:: with SMTP id l191mr270438oih.15.1566496931917;
        Thu, 22 Aug 2019 11:02:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a17sm91005otq.56.2019.08.22.11.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 11:02:10 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ element
 size
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
 <20190807075122.6247-3-benh@kernel.crashing.org>
 <20190822002818.GA10391@lst.de>
 <87e1fea1c297ef98f989175b3041c69e8b7de020.camel@kernel.crashing.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4fc11568-73fe-c8b5-ac29-d49daee9abad@grimberg.me>
Date:   Thu, 22 Aug 2019 11:02:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87e1fea1c297ef98f989175b3041c69e8b7de020.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> wrote:
>>> +#define NVME_NVM_ADMSQES	6
>>>   #define NVME_NVM_IOSQES		6
>>>   #define NVME_NVM_IOCQES		4
>>
>> The NVM in the two defines here stands for the NVM command set,
>> so this should just be named NVME_ADM_SQES or so.  But except for
>> this
>> the patch looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> So maybe Sagi can just fix this up in the tree.
> 
> Ah ok I missed the meaning. Thanks. Sagi, can you fix that up or do you
> need me to resubmit ?

I'll fix it. Note that I'm going to take it out of the tree soon
because it will have conflicts with Jens for-5.4/block, so we
will send it to Jens after the initial merge window, after he
rebases off of Linus.
