Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E306C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6961520863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sCESZHDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfEWWyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:54:05 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:35648 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbfEWWyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:54:05 -0400
Received: by mail-pl1-f172.google.com with SMTP id p1so3337091plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/vCEODs/9DS/gyFee8buH340YRgWEPrDV2+u6E7wxSs=;
        b=sCESZHDxFOtQejQ6JERU/DPBl5BcXkF4edI7w74IPSRCgfA0C8pcJ26FErgdaADeQg
         ETujxZM1f3GAMvxQfo0k2ewnW9Moqvkz4jpYgx6+oFil1BpPQx6UwsxjWzfOqn8MKFt6
         au1wuxFe+/KGL8p15QS3kZN1Ggz6CmYHe+kWO3p1TrcKDByvp2ZNV2sIwiVJODQ3YFoh
         3+WePdtcLhuGD88pyO7LkOb/OgpylRYW8kvpMhLlrl1m9RRlwr1GjT0bHNKWce2cQFgW
         96pADDk2IrbIw1xxbw0pdXLOp8FDvtNk/IwAfkuafler0DBla2nlWAyNZG0HfuA3XZ0S
         pt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/vCEODs/9DS/gyFee8buH340YRgWEPrDV2+u6E7wxSs=;
        b=OFbIscgFdbmZ3zTBXyCSyJjO//DsoAD8tpgXeIheVBYBu6XUEosMFZetDDem3FjCwE
         eukA6zn2NvfT7qx9SmP/TMEfMNHgm0SjOs+hK31kRYwqAcuQTI4ztfC/6Yp/1y52M/Wn
         m0QODZ1tXjWW3PF/Psp00yEDfLcpm0TX1eGWGmntLAWNWBkfC3kSOYGc1Rs1YYubOGWH
         BP/vXUQS0aC68W/GukaeJZFKBtd8d42HjoXAMjLhskx3hL3+2f6C6lKV1j4mfE5mkGpl
         ysa5C1aH6V/lIoiE6zNo+TfjWM4b1TvkvY3qtDyCF1nkHnGJbRLti26vLRoMKm1IL8N3
         jjOA==
X-Gm-Message-State: APjAAAWrRS3uA7F8KcNNaH7syLTlwlySlpDCc1KkHrH4IBY/VUNivfHX
        MQhuDF3cotaI0fdFK87nRPSUag==
X-Google-Smtp-Source: APXvYqyNX4WEA6oJ/+fN2UKbYJYBspT4MTDG3EG2yBLEFmXxBg+ztIsEDnCWS8kRNZ4jX7AjqIFBBw==
X-Received: by 2002:a17:902:a81:: with SMTP id 1mr55805935plp.287.1558652043697;
        Thu, 23 May 2019 15:54:03 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id w66sm501695pfb.47.2019.05.23.15.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 15:54:02 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Keith Busch <kbusch@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
References: <20190524074500.1fde68d6@canb.auug.org.au>
 <20190523215206.GA15192@localhost.localdomain>
 <20190524083321.7ada6382@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9eb52b2c-2148-8f87-dea9-15df4d50e9de@kernel.dk>
Date:   Thu, 23 May 2019 16:54:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524083321.7ada6382@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/19 4:33 PM, Stephen Rothwell wrote:
> Hi Keith,
> 
> On Thu, 23 May 2019 15:52:07 -0600 Keith Busch <kbusch@kernel.org> wrote:
>>
>> On Fri, May 24, 2019 at 07:45:00AM +1000, Stephen Rothwell wrote:
>>> Commits
>>>
>>>    5fb4aac756ac ("nvme: release namespace SRCU protection before performing controller ioctls")
>>>    90ec611adcf2 ("nvme: merge nvme_ns_ioctl into nvme_ioctl")
>>>    3f98bcc58cd5 ("nvme: remove the ifdef around nvme_nvm_ioctl")
>>>    100c815cbd56 ("nvme: fix srcu locking on error return in nvme_get_ns_from_disk")
>>>
>>> are missing a Signed-off-by from their committer.
>>
>> Oops, I'd only added my Reviewed-by. Do I need to update the commit
>> messages and resend, or is this just putting me on notice for next time?
> 
> That depends on Jens ...

Since they at least have a reviewed-by from the committer, I say we let
it slide this time.

-- 
Jens Axboe

