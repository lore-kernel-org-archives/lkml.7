Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB4C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B33207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V0acmw1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407748AbfIXRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:23:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407047AbfIXRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:23:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so2841574wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zojDqhIDCVa616KN7v7PXKcR+n3TBwC2cffseILAS8Y=;
        b=V0acmw1iJ5RBkC5LpIbyw+IvcVgmzKokEwS7utek9s8pSqnOYmD545QAUQGVet8zNs
         6g+6V8Fds7Z2wu0dO4BufUP+UOAGIL5yk4vrfRXCNmXsuyHxPP8WbCyx5R3z53xAty0z
         E/A+HJ2vV6CvIFmfp9xG8Cc/0FAt/2AGAr2dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zojDqhIDCVa616KN7v7PXKcR+n3TBwC2cffseILAS8Y=;
        b=E6PBQepfTAq18bjVqUaSft+SsdQAmrlYeMxHFiF4/dRwcEaSTmDZjDOa/KdZrH/IXJ
         8jImbacfnIvExuEh3AOuLqOEl0PbGpNBkFesJ5wZd4Wblru88uP7aHPhBrd/PNGM/3sJ
         eXyBBgtXnbfzvLNiMh85h+vwEtThJf108twQMg/AtgLUEJDWDNdflMe2s36ErkJT4t3v
         lWXrvtbb9w7XqkzrJjS5fFIQRnB/38jNwzC/ac5TONqCpMjlxvLh5l7IEYKvQUw5QJs2
         hT9RBdx1xzw9UyEh4ctIAiMiVdTrE6FWe7s8gUwp7Dbvn9P2hlciL6fa9p4u7dMerDe8
         nPWA==
X-Gm-Message-State: APjAAAUPqL2CqhU0rVYWjo3R0stPvrB3t5qvN19oW3iMLHrw10RMd3nE
        1ZZK7Z3vLxtrPwQEepAVj7awkxH50m2jrD1c
X-Google-Smtp-Source: APXvYqzr1eNgy01G5ZmPie1GWfVJKyFXlGRTrtigOTJblOF8z3EvSnaXA/4EHakD7hQmv1T23Zruag==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr3365604wrw.208.1569345798765;
        Tue, 24 Sep 2019 10:23:18 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o12sm4269440wrm.23.2019.09.24.10.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 10:23:18 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] i2c: iproc: Add i2c repeated start capability
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        Icarus Chau <icarus.chau@broadcom.com>,
        Shivaraj Shetty <sshetty1@broadcom.com>
References: <1565150941-27297-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190830125626.GC2870@ninjato>
 <3e70fa7e-de13-4edd-2e17-b7c56e91d220@broadcom.com>
 <20190831094940.GA1138@kunai>
 <540c4e2d-0dd5-5260-30b2-e1589b279d71@broadcom.com>
 <20190904213745.GG23608@ninjato>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <5ab79d0e-eb54-8fe1-1ca3-e763a17c6426@broadcom.com>
Date:   Tue, 24 Sep 2019 10:23:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904213745.GG23608@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 9/4/19 2:37 PM, Wolfram Sang wrote:
> 
>> I think you are right that the controller does not seem to support
>> additional I2C features in addition to SMBUS.
>>
>> However, my concern of switching to the smbus_xfer API is:
>>
>> 1) Some customers might have used I2C_RDWR based API from i2cdev. Changing
>> from master_xfer to smbus_xfer may break the existing applications that are
>> already developed.
> 
> Well, given that you add new quirks in the original patch here, you are
> kind of breaking it already. Most transfers which are not SMBus-alike
> transfers would now be rejected. For SMBus-alike transfers which are
> sent via I2C_RDWR (which is ugly), I have to think about it.
> 
>> 2) The sound subsystem I2C regmap based implementation seems to be using
>> i2c_ based API instead of smbus_ based API. Does this mean this will also
>> break most of the audio codec drivers with I2C regmap API based usage?
> 
> I don't think so. If you check regmap_get_i2c_bus() then it checks the
> adapter functionality and chooses the best transfer option then. I may
> be missing something but I would wonder if the sound system does
> something special and different.
> 

We did more investigation on this.

First of all, like you said, there's no concern on regmap based API, the 
smbus_xfer only based approach should just work.

Secondly, for most i2ctools like i2cget, i2cset, i2cdump, there's no 
concern either, given that they already use I2C_SMBUS based IOCTL.

However, for i2ctransfer or any customer applications that use I2C_RDWR 
IOCTL, i2c_transfer (master_xfer) is the only supported function. And we 
can confirm we do have at least one customer using i2ctransfer for 
EEPROM access on their system, e.g.,  i2ctransfer 1 w2@0x50 0x00 0x00 r64.

In my opinion, it's probably better to continue to support master_xfer 
in our driver (with obvious limitations), in order to allow i2ctransfer 
(or any apps that use I2C RDWR) to continue to work.

What do you think?

Regards,

Ray
