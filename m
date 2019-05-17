Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB2C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE98E20881
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558099349;
	bh=9V4P/CjYVKh59IiUM4G5zfY9ceZXaeiacs7WeVytWlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w5TJKYQKC7x5K6xnEkki503/7HkU50Sk0ZG4KWs0/Nz2A7X7pY+gy0w54dPlbp4RC
	 IfUousaIvv/4+WNd4wvQsOVj9DQov7N/K6XrP/yhZTnfvHZu9c2Ye8b5/EP5exjCmI
	 rJWqLHkaSRmVQjEhuzHU9LmH7sSpWQeKSais/0rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfEQNW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbfEQNW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:22:28 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A893D20833;
        Fri, 17 May 2019 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558099348;
        bh=9V4P/CjYVKh59IiUM4G5zfY9ceZXaeiacs7WeVytWlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5S+u9PGyBqLrb9GRUGk7Inekez2CVDrhAB4QI+jAeiuFtKt5njEWRkvy1jQSgyeH
         cFAhtgP13dJlaMkXUmPdxFPHSg2aroqOtYXC03JnTBVID6LFH6CvQH4PhZisIcZWzo
         c2NnDOqz7sV+zhZ2jRqvigDj4014nhU1Ud3bMgt4=
Date:   Fri, 17 May 2019 09:22:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v3 1/2] ftpm: firmware TPM running in TEE
Message-ID: <20190517132226.GB11972@sasha-vm>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190415155636.32748-2-sashal@kernel.org>
 <20190515081250.GA7708@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190515081250.GA7708@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:12:50AM +0300, Jarkko Sakkinen wrote:
>On Mon, Apr 15, 2019 at 11:56:35AM -0400, Sasha Levin wrote:
>> This patch adds support for a software-only implementation of a TPM
>> running in TEE.
>>
>> There is extensive documentation of the design here:
>> https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/ .
>>
>> As well as reference code for the firmware available here:
>> https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM
>
>The commit message should include at least a brief description what TEE
>is.

The whole TEE subsystem is already well documented in our kernel tree
(https://www.kernel.org/doc/Documentation/tee.txt) and beyond. I can add
a reference to the doc here, but I'd rather not add a bunch of TEE
related comments as you suggest later in your review.

The same way a PCI device driver doesn't describe what PCI is in it's
code, we shouldn't be doing the same for TEE here.

>> +
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/acpi.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/uuid.h>
>> +#include <linux/tpm.h>
>> +
>> +#include "tpm.h"
>> +#include "tpm_ftpm_tee.h"
>> +
>> +#define DRIVER_NAME "ftpm-tee"
>> +
>> +/* TA_FTPM_UUID: BC50D971-D4C9-42C4-82CB-343FB7F37896 */
>> +static const uuid_t ftpm_ta_uuid =
>> +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
>> +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
>
>Just wondering why prefixes are here in different order in the comment
>and code.

No prefixes, this is a completely randomly generated UUID.

I'll address the rest of your comments in the next ver.

--
Thanks,
Sasha
