Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C450020449
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIHTYDdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfGaNGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:06:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44080 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbfGaNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:06:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so30449821plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sHzl5921BHWgqtoPY6MJP39IB1JpWgzFb78ZaMImV9c=;
        b=eIHTYDdXX3KVuT8JA2IPHAnoMU+cnJBLShjNMC/nmhnG1CqVefQKtVPLO9W7U/HdJ8
         Of2Xb1et/5mL2x7hVkD5G0EsAdytxOjb8gfiwTXzjqm1R+gg9cfrKgbuEc/eRM9JPNf9
         jtYGhNhrHd6ZH8f9zAUfzvtGOE14Wg+HE8MbbBurTnFieNUUcd4ra8cyeyBYV1BSF3tw
         cH9j9PhgqJT+Buzs07dHk/ctfwXh5ivj7PWuyvL6NJWkdqs3ZNqzjYlNIhwv2OEEl+HX
         QlgcMUhjBJOZ0SRyDPmmwHeoA9xfeQx+EkVvOL5yz4AzRGU4Ue3YEsvI0Vir9RggQx6r
         MIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHzl5921BHWgqtoPY6MJP39IB1JpWgzFb78ZaMImV9c=;
        b=ZVdfxl3S5tMHglSV9HewjbW/ppsZKHTJKUlzDlCp00QYU3y9y5dg5j0a6hZOadZrr+
         G8WRai67nJT8zO3XCTp7L3VmJByImGmJgoGS/THGz1A8/W5lSe2HB9ivfJ630pCS1VE0
         aAXr5tFbNVpJNcVh5ZdjaMZTVIFpcWF5TffDnCoJQfnxTijv7om/0ocz7PEgDDaZhddu
         iXEugvGAefltIl99e1o/0Y5T0Q73cDaCKHHMzr1cgQ/dWOIz9V3ki/YFTRf8QV9Nd8rh
         XSxZwejxKJnHSKrrFI8icWStvurDCTTszcw7LrtWqsgruYvKmviz10eLgJQFTv0M5G7r
         mwuQ==
X-Gm-Message-State: APjAAAXl+NseXA5Hs/2L8tPCrtiWO6zE9uErEHiQ9AlAOP6SUlD7Qv3Q
        RUevQbVWz/dSU2Tcw7ql6YE=
X-Google-Smtp-Source: APXvYqxKRNunAcobOCBM99+h3P7ofHJm9idjLpl1HCgi6/PRQgXTspPdXUvXOee0ReubfC+m1Lr/6A==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr117037501pld.340.1564578392879;
        Wed, 31 Jul 2019 06:06:32 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.105.8])
        by smtp.gmail.com with ESMTPSA id p20sm109750505pgj.47.2019.07.31.06.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 06:06:31 -0700 (PDT)
Subject: Re: [PATCH] mailbox: zynqmp-ipi-mailbox: Add of_node_put() before
 goto
To:     Michal Simek <michal.simek@xilinx.com>, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190709172841.13769-1-nishkadg.linux@gmail.com>
 <eaf1fcbe-615e-0fec-d330-ae94e8f3c102@xilinx.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <6a5306bd-946d-383f-0b42-f17675c24218@gmail.com>
Date:   Wed, 31 Jul 2019 18:36:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <eaf1fcbe-615e-0fec-d330-ae94e8f3c102@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 2:01 PM, Michal Simek wrote:
> On 09. 07. 19 19:28, Nishka Dasgupta wrote:
>> Each iteration of for_each_available_child_of_node puts the previous
>> node, but in the case of a goto from the middle of the loop, there is
>> no put, thus causing a memory leak. Hence add an of_node_put before the
>> goto.
>> Issue found with Coccinelle.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> index 86887c9a349a..bd80d4c10ec2 100644
>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>> @@ -661,6 +661,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>>   		if (ret) {
>>   			dev_err(dev, "failed to probe subdev.\n");
>>   			ret = -EINVAL;
>> +			of_node_put(nc);
>>   			goto free_mbox_dev;
>>   		}
>>   		mbox++;
>>
> 
> Patch is good but when you are saying that this was found by Coccinelle
> then it should be added as script to kernel to detect it.

This particular patch was suggested by a script I did not write myself; 
someone else wrote it and sent it to me. How should I proceed in this case?

Thanking you,
Nishka

> Thanks,
> Michal
> 

