Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD8C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8B921019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eIF2XNHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDFRJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 13:09:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36882 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfDFRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 13:09:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so5056952pfr.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BrygOOUKaJEWhE+ZVsqSSFc7xsHEkUzhWr1Gh8NOXK0=;
        b=eIF2XNHvfqyH1zIK0wFqyogpDxEez5Yg3UhAEBC/cdwwDrm2zv2a2DBfjfl7Vii8ap
         i99eYGiQHD4UMc329ciQh8nKfN9aHHLBw+eDkQ72Z/Sk2hnuDaaaF7lc35Ly+uk0Vxs0
         qBwjFRb8BYArUE/O/1DwXgP0TLyBDOPoui6dl8dpGNsofdsxoVbFcZsM8MbQqc5PuOME
         Nb/mBGfw0E6o4hre4Kpf6qFt8pWT81H5RonQs4bFv/1YXa/nYAwo9MzbmOtKYeUPfh/0
         WDyw+H/qF90JIuoEWTCRvB8Ar4tjtSB/BGyh2sBdvOWZEBNQdZxUHGIpQEMOxmvBTQrw
         fDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrygOOUKaJEWhE+ZVsqSSFc7xsHEkUzhWr1Gh8NOXK0=;
        b=LKbVEg7Tz6gQ/2Y3BuNdkpXIazNlumzkEy1ctvZh9iqST8eLRoNJOcOZlthzQLlyvn
         1z1eMSMb+bvDzm2xna1CstEz9eOygwsjE4PxUGf2td4aPdMOmZ84nOwJUjtEcRBIk7l3
         Q7DrCB2VrHKQYGpHLVbKe6ioEqVQ30zL6y5YCeVBkvCoTfV/tOJi+EJhykv0w1Fv/HQp
         WQKBjSPrOqYcxyR61rjwB3ACYNWTFWzNGufPk7u06NPFJ1g5U0Q7DOoVwYG0dZM7pUKX
         pCA1/HezSZN6gGV8CodV9RtyuTfrOVadgK7kQMX6nFVrTkvqA2twOXbH2jQntjOL62Bf
         PARQ==
X-Gm-Message-State: APjAAAUaDFVcuewjYlbNOCxROzcURM74mjk0Zu9AYfDrhjz3M7vBqfQX
        wBodbyUH1ZcgKtTCSNvuwd8Pyw==
X-Google-Smtp-Source: APXvYqzD7RC5XtnqsQd3Nke6s37NG7y/Z8Fi9cZpVXykHE0JQxWOYbdGG+0JDvRDrCyxvZ02OVXAew==
X-Received: by 2002:a63:2ace:: with SMTP id q197mr17960177pgq.371.1554570581069;
        Sat, 06 Apr 2019 10:09:41 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 10sm1800449pft.100.2019.04.06.10.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 10:09:39 -0700 (PDT)
Subject: Re: [PATCH 00/16] sed-opal: fix shadow MBR enable/disable and clean
 up code
To:     Scott Bauer <sbauer@plzdonthack.me>
Cc:     David Kozub <zub@linux.fjfi.cvut.cz>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190406152657.GA10728@hacktheplanet>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c05ebdea-559d-fe37-04f2-b3cab71f5ea8@kernel.dk>
Date:   Sat, 6 Apr 2019 11:09:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406152657.GA10728@hacktheplanet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/19 9:26 AM, Scott Bauer wrote:
> 
> 
> 
> On Thu, Feb 14, 2019 at 01:15:52AM +0100, David Kozub wrote:
>> David Kozub (12):
>>   block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
>>   block: sed-opal: fix typos and formatting
>>   block: sed-opal: close parameter list in cmd_finalize
>>   block: sed-opal: unify cmd start
>>   block: sed-opal: unify error handling of responses
>>   block: sed-opal: reuse response_get_token to decrease code duplication
>>   block: sed-opal: add token for OPAL_LIFECYCLE
>>   block: sed-opal: unify retrieval of table columns
>>   block: sed-opal: use named Opal tokens instead of integer literals
>>   block: sed-opal: pass steps via argument rather than via opal_dev
>>   block: sed-opal: don't repeat opal_discovery0 in each steps array
>>   block: sed-opal: rename next to execute_steps
>>
>> Jonas Rabenstein (4):
>>   block: sed-opal: use correct macro for method length
>>   block: sed-opal: unify space check in add_token_*
>>   block: sed-opal: print failed function address
>>   block: sed-opal: split generation of bytestring header and content
>>
>>  block/opal_proto.h            |   2 +
>>  block/sed-opal.c              | 716 ++++++++++++++--------------------
>>  include/uapi/linux/sed-opal.h |   2 +-
>>  3 files changed, 287 insertions(+), 433 deletions(-)
> 
> Jens,
> 
> We have all the reviews done for this series from Jon, Christoph, and myself.
> When you get time will you please queue this up for 5.2?

Applied, thanks everyone.

-- 
Jens Axboe

