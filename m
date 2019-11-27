Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B320B206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stpAGTM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfK0WmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:42:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41895 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfK0WmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:42:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so5988726otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rNYvHaXnQ1WbhAz1gLcZb3BwvdsfcBJhYCLb9LE8pqc=;
        b=stpAGTM8GaaGeBhO30eh8FCArzy4tmKYSEzojSWiaPe6jJAAmdHmrjwo2zSGGiojVj
         8qRt5U8LUnu6hKe8lgvmEFLPv/8epFf+Z5RSk78GyqZzfsz4NWFqSwP/+TNAQsKfv0om
         8/Lx1H7BJTRRogJeJ16pdOlGN59tixq2ZFjtX0NSdwcgkLtT7Ru6CuUN1VnmXnYx3ZkP
         khmE+P3JFcJf02cQXvxGEjBD68fNht8EWT96hVtKKu93nJuKKdTvXPH/8eaa44JsTWqU
         iRD+y7/5HHG3VOW89CvcfjDFeqiepFrRJvpekP6PWjJYevtmLwWc4aNyWAZDujU8Kb74
         +21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rNYvHaXnQ1WbhAz1gLcZb3BwvdsfcBJhYCLb9LE8pqc=;
        b=bUeRqypGPM1ehuCZNLL5G/s9EuIXy52TzvrxCQxsD5lnUl3D9V9obTADj0zDX5bn7E
         xGRsJ9Kf02OQpOk4No6nSl8+QwEpyxCsNSsAogGTMwks0m48UhYhCullda/fUdcVPNHi
         9KIE03fQ4bqDWM3YIDzo2CS8HrMYhl3tfgc08Kk4/SVU584LgLa5xaaW3i9jYGnJZrTD
         PTdjE9luvou3HCIeX0v0evqaLw/s4ZTU902HkxW93i31YjS9Vj1NyK7jU+Tcg2O3QkO+
         h8kMxwhfPJRv0Uc/5pJwdP6+wm1/iE2QW8dAsBoUagzFmP/0Gmxh2nLKf/QPI7S2z9Ah
         svDQ==
X-Gm-Message-State: APjAAAVzX1PXALUyMzPJPhSZYLrnjbWP0MtohxiVpUxqGw5PQ3K0OArK
        kF7PjEMcv5ruDeD3Hs8oIaz1AAnJ
X-Google-Smtp-Source: APXvYqyUvNA/I2GSlQTOFGFO1DK9oDDkC2c9ZejDanOogC5r2La6wfEd9omxlVq8p5GmAwwlddunVQ==
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr1535504otm.261.1574894527044;
        Wed, 27 Nov 2019 14:42:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9sm5450346oik.18.2019.11.27.14.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 14:42:06 -0800 (PST)
Subject: Re: [PATCH] driver core: Fix test_async_driver_probe if NUMA is
 disabled
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20191127202453.28087-1-linux@roeck-us.net>
 <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <377feb00-9288-e03c-b8a7-26ba87e24927@roeck-us.net>
Date:   Wed, 27 Nov 2019 14:42:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/19 1:24 PM, Alexander Duyck wrote:
> On Wed, 2019-11-27 at 12:24 -0800, Guenter Roeck wrote:
>> Since commit 57ea974fb871 ("driver core: Rewrite test_async_driver_probe
>> to cover serialization and NUMA affinity"), running the test with NUMA
>> disabled results in warning messages similar to the following.
>>
>> test_async_driver test_async_driver.12: NUMA node mismatch -1 != 0
>>
>> If CONFIG_NUMA=n, dev_to_node(dev) returns -1, and numa_node_id()
>> returns 0. Both are widely used, so it appears risky to change return
>> values. Augment the check with IS_ENABLED(CONFIG_NUMA) instead
>> to fix the problem.
>>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Fixes: 57ea974fb871 ("driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/base/test/test_async_driver_probe.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
>> index f4b1d8e54daf..3bb7beb127a9 100644
>> --- a/drivers/base/test/test_async_driver_probe.c
>> +++ b/drivers/base/test/test_async_driver_probe.c
>> @@ -44,7 +44,8 @@ static int test_probe(struct platform_device *pdev)
>>   	 * performing an async init on that node.
>>   	 */
>>   	if (dev->driver->probe_type == PROBE_PREFER_ASYNCHRONOUS) {
>> -		if (dev_to_node(dev) != numa_node_id()) {
>> +		if (IS_ENABLED(CONFIG_NUMA) &&
>> +		    dev_to_node(dev) != numa_node_id()) {
>>   			dev_warn(dev, "NUMA node mismatch %d != %d\n",
>>   				 dev_to_node(dev), numa_node_id());
>>   			atomic_inc(&warnings);
> 
> I'm not sure that is really the correct fix. It might be better to test it
> against NUMA_NO_NODE and then if it is not that make sure that it matches
> the node ID. Adding the check against NUMA_NO_NODE would resolve the issue
> for cases where the device might be assigned to multiple NUMA nodes.
> 
I think you are suggesting that dev_to_node(dev) might return NUMA_NO_NODE
even on systems with CONFIG_NUMA enabled. I have no idea if that can happen.
The code in test_async_probe_init() seems to suggest that the node is set
to a valid node id for all asynchronous nodes, so I don't immediately see
how that could be the case. I may be missing something, of course.

Thanks,
Guenter
