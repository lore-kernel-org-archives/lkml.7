Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F50C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6419B20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="mvLY+Ww0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfDWQJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:09:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35894 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfDWQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:09:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id l23so3458781lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B987w6H/8sLrkjb92qYyMAxvrC7y1yIfwD5xAOGqELY=;
        b=mvLY+Ww0TF2UkCnhyiF3YEOBg2yn3r0wRvDrJ/gS91LsuCviMTm9pFFwGJdG2Tt6So
         Eq7cwxuAhkYjBev0KDzoT0H7w0T+LXcxtJpmhtAKUYblhQ3QxyS5viTPL42IhJOyiIx4
         AJctrPEGV8JmtmoPb4DC0LvOXbkhR0A7WIn9VhhY61hFhrUHZqO6MTdbzAMpELm3B/CW
         d8qgw19+oOmEZyIGa6/W36Tvd6GMuevH0Qryuf/c+t+EGtuDJ0hpVlKKf+8G8NkH7s5p
         /Rp6rGxFlEiDjhL0BI/3A9sttoGT28HVHiWGTRiUneKQ1Ar86g/cWUW9OzAIc0ugFIwl
         Rjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B987w6H/8sLrkjb92qYyMAxvrC7y1yIfwD5xAOGqELY=;
        b=LtHfWT61BKD/iQkBy3JxMZcRyXP4IeETZA2sQicvkYPAvQv7pqnmtTdShG3BuQL453
         c/x4VmzcvWU84suJgv08TlHjyWRNzQgxVw/VNn4mGBgBLAxXaKXIjXrSlg5V5FRN4759
         p/FlGI6jTT9Op9wql21UXyBQc3HtSMV9ar5cW4WO0B8upoP/1ZWVlDDlbmpAtRujmSFY
         /xARgQ4k9+bcHimQvXyeMfEwYkoLNTnyGwiGE402EB+REd32bHE8QAdyLV/2WPcl4QdC
         OXZD6BMYKbULFPc9PYTFP14iOSJ8mw+03ea/avJrXTuqT0OhcFfIIALuSqWGBxRIyY29
         mytg==
X-Gm-Message-State: APjAAAWRO50r0UAwB4hctMj+r4wSfePMgey8l3vPkYgbN1HS/c8um7sX
        ufZQEFOwtd55s/dRA0OE2MOV6g==
X-Google-Smtp-Source: APXvYqx+P/bxote7QB0GizHRyFZECju3SA5IlB9D4y57NhwLsHlujQh9IG37ByidE/DTvMqe79C7ew==
X-Received: by 2002:a2e:9597:: with SMTP id w23mr14252872ljh.111.1556035764793;
        Tue, 23 Apr 2019 09:09:24 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.73])
        by smtp.gmail.com with ESMTPSA id c5sm4538958ljd.18.2019.04.23.09.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:09:23 -0700 (PDT)
Subject: Re: [PATCH v11 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
 <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
 <OFF96C004A.0EFDDD69-ON482583E5.0032EE18-482583E5.00337F42@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <060316c8-7675-cfaf-bfef-c3e6458bfa82@cogentembedded.com>
Date:   Tue, 23 Apr 2019 19:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFF96C004A.0EFDDD69-ON482583E5.0032EE18-482583E5.00337F42@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2019 12:22 PM, masonccyang@mxic.com.tw wrote:

>> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> [...]
>>
>>   Do dote that I'm opposed to the driver separation as it's presented in
>> this patches, and I have a large patch reworking both MFD and SPI drivers
>> in the works.
>>
> 
> Do you mean add your name in both MFD & dt-binding ?

   Of course not!

> i.e.,
> [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF MFD bindings
> 
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> 
> 
> [PATCH v12 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver
> 
> Add a driver for Renesas R-Car Gen3 RPC-IF MFD.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> 
> Is it ok ?

   I'm not OK with the most of the driver code ending up in the SPI driver,
I think most of the code should be kept in the MFD driver and just be called
by SPI/HF drivers.

> best regards,
> Mason

MBR, Sergei
