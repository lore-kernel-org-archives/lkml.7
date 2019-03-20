Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7852C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8462075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Tf02fvKl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vx/uDYBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCTMTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:19:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:19:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF8C960C72; Wed, 20 Mar 2019 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553084350;
        bh=5Ow5BLiBktBFkLUKVHs84llgiP+XTfs7SDHTTiVLkYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tf02fvKlJLsiHudL7TdwHWRR1izJjzu4lfLWXjAGZPxxM/jLnUnBj7K6HR473nStt
         sAmS+RRd9ELfcsjLywo5y1Bxg8KENs7Vb7V6AIVuvDf37L6UJfezWAUAAVnMry3JVJ
         4sgUEYtgG7a8NKqLZxpEuv+6urJJeyicHlnQEz3E=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BEA060237;
        Wed, 20 Mar 2019 12:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553084349;
        bh=5Ow5BLiBktBFkLUKVHs84llgiP+XTfs7SDHTTiVLkYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vx/uDYBjp6U17FUUTYYqf98xGmZqZiuLZuS2Q+1i5dfL9uBs/h+HX+O8tulWTFr4h
         Rf+ftGvpUCjpaa1QOTBZxvTZv5zuGfXhZOR01wY9D3Arn1RJlGeha12MRUE+F+KXv4
         H48THITo0urORMYqLfsRe9FypFKho/OK40gfAj9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BEA060237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] thunderbolt: xdomain: Fix to check return value of
 kmemdup
To:     David Laight <David.Laight@ACULAB.COM>,
        'Aditya Pakki' <pakki001@umn.edu>
Cc:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20190318225508.7886-1-pakki001@umn.edu>
 <57793438545e41cc85d00beab7505143@AcuMS.aculab.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <034573d6-61dc-4555-2559-acb4aa86dabe@codeaurora.org>
Date:   Wed, 20 Mar 2019 17:48:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <57793438545e41cc85d00beab7505143@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 4:27 PM, David Laight wrote:
> From: Aditya Pakki
>> Sent: 18 March 2019 22:55
>>
>> kmemdup can fail and return a NULL pointer. The patch modifies the
>> signature of tb_xdp_schedule_request and passes the failure error upstream.
>>
>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>> ---
>>   drivers/thunderbolt/xdomain.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
>> index e27dd8beb94b..b0e9cc30d708 100644
>> --- a/drivers/thunderbolt/xdomain.c
>> +++ b/drivers/thunderbolt/xdomain.c
>> @@ -526,7 +526,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
>>   	kfree(xw);
>>   }
>>
>> -static void
>> +static bool
>>   tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
>>   			size_t size)
>>   {
>> @@ -534,13 +534,16 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
>>
>>   	xw = kmalloc(sizeof(*xw), GFP_KERNEL);
>>   	if (!xw)
>> -		return;
>> +		return false;
>>
>>   	INIT_WORK(&xw->work, tb_xdp_handle_request);
>>   	xw->pkg = kmemdup(hdr, size, GFP_KERNEL);
>> +	if (!xw->pkg)
>> +		return false;
> You're leaking 'xw' here.


Yes , Clean up is missing otherwise patch looks good.

Mukesh

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
