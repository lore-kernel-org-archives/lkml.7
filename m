Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEF92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561734260;
	bh=KILzOPQ12WfXLR33hhOBhq7Zh1NVBwQ+ehRVHZMu+70=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=alEnBZ9BtvpUXdtfktZqeuHypxoqC/PMvxCQcTLLRKmi/JmbQuxRxh23MLgOPXYxg
	 +7Vx06fC1k6147eyM35fGC6QaY4UjACgJVOYfT0NbEPLOSCHNf5RuDEPwpK+YJkKen
	 qT47Fju2irk+ejtpGNe8NAXozOdgp53Cmg4LoqsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF1PET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:04:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35306 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfF1PES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:04:18 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so13239111ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1IzoFsZk5LqS2cRTEBVCjz3mGbTcz0MMJeXo87+63Y=;
        b=MvNSFWpzsxFk5AIIkgaYDKXyzPk9/PdAzXLETkZQRaEZNrrn0vJ5XRQ5uKEwAvKaxl
         3qfYCTNQ0+MZYbbxx+5z8j/jY7b2vw2ufX1y4uSh9wloSEW5WHlDzz7n/lyyCM8jlcKC
         PQnUQb1C9oKq3eCZBErmQTCpb/YoV6paGj5tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1IzoFsZk5LqS2cRTEBVCjz3mGbTcz0MMJeXo87+63Y=;
        b=HztimWG+E3n1iTrkSKz1r/8v+D0yw8zHZ1WG/mKrBLl9z/1R3QkStLoRq2HjRzXPd1
         /EES2z4Ax0QqmMQiVNsn+eYVFdmExMw0QqhrnoHxH+3xGwHCLK4er5QHWWgJ3IT1GG0x
         5wJI2CFUZUz5jFGjeI1IyH6Lf/4d3POZu8qW8+qccb2O6le4Y2hmboMFx/P6Ri+hTWWS
         LzQ4AvOHJjwJZHX8zIaP2/12hwQecfRiF8xzztHT6+hQKrvLhO1GCg8U4XmHVGQ6K2mo
         mcjT6m4sLxg+JwGtic47KEnBHGuAbAn3onWK7iBBUSlk5z1JbwuntjWBQOfBi3p0OLPl
         +M2g==
X-Gm-Message-State: APjAAAUIeyQP+drouPNkKUDr2XaiDd6LIshJm61kit0HeHgJiEEiH+SB
        qYZgGnO1LVJszHg34UmQhcwViA==
X-Google-Smtp-Source: APXvYqymBA+yRdMC+IAMhiuSMnvDgZNtIJg/DM/UGr3vhxnQF81pj8UzRIlvdsQNe/Pn6XZ7mdgZVg==
X-Received: by 2002:a5d:9e48:: with SMTP id i8mr696097ioi.51.1561734258040;
        Fri, 28 Jun 2019 08:04:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j23sm2401337ioo.6.2019.06.28.08.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:04:17 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined behavior
 in bit shift
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
 <20190627032532.18374-4-c0d1n61at3@gmail.com>
 <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
 <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9e17c585-bd42-8c65-a37a-add6aa4d5ca4@linuxfoundation.org>
Date:   Fri, 28 Jun 2019 09:04:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/19 7:57 AM, Johannes Berg wrote:
> On Wed, 2019-06-26 at 21:34 -0600, Shuah Khan wrote:
>> On 6/26/19 9:25 PM, Jiunn Chang wrote:
>>> Shifting signed 32-bit value by 31 bits is undefined.  Changing most
>>> significant bit to unsigned.
>>>
>>> Changes included in v2:
>>>     - use subsystem specific subject lines
>>>     - CC required mailing lists
>>>
>>> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
>>> ---
>>
>> Move version change lines here. They don't belong in the commit log.
> 
> FWIW, in many cases people (maintainers) now *do* want them in the
> commit log. Here, they're just editorial, so agree, but if real
> technical changes were made due to reviews, they can indeed be useful.
> 
> johannes
> 

I went looking in the git log. Looks like there are several commits with
"Changes since" included in the commit log. It still appears to be
maintainer preference. Probably from networking and networking related
areas - wireless being one of them. This trend is recent it appears in
any case.

There is a value to seeing changes as the work evolves. However, there
is the concern that how log should it be.

This example commit has history from RFC stage and no doubt very useful
since this is a new driver.

8ef988b914bd449458eb2174febb67b0f137b33c

If we make this more of a norm, we do want to make sure, we evolve
from informal nature of these "Changes since", to "Commit log" text.

thanks,
-- Shuah
