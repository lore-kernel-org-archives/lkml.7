Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4ACC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DD02086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fMp/yGTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfJAW2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:28:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34273 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfJAW2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:28:33 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x91MS6XO1104263
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 1 Oct 2019 15:28:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x91MS6XO1104263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1569968888;
        bh=CVmGy/DI0hNYE3HWVWXwpZgLbbxVbvXXwcCGt+QPGBQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fMp/yGTiGygKC6+gmuSH52zZzbetdudCo2N9mAJbvn2+gRPMaMz9ceW2PchS/GwaL
         AEN/AWuv4IOf8rN4DFdg5kDMg34A8eEssbtu8XBVqaOC2a0+upR+Dakam53xErg3us
         QRsRUqnQpspoT+pYt1524iewwNh6vwA8qR0kWl1ek4/UvY03vsRKVUNGFKh7S8v5/L
         Mw1/D/Vy11zP9C9eS8rQiFeu+PPcboqEWeiRHf+D7dNy1+CtyvyzQ6edfznbqFpO4j
         XwDb8LtgTeEiipL7zQoixZ+4MQ/RnkRdPGSnjpdiT3HisogFUYQ+ilvVnjjvx7hVr7
         26q/UZgCO9wzw==
Subject: Re: [PATCH v2 1/3] x86/boot: Introduce the kernel_info
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, corbet@lwn.net,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
References: <20190704163612.14311-1-daniel.kiper@oracle.com>
 <20190704163612.14311-2-daniel.kiper@oracle.com>
 <5633066F-01BE-437D-A564-150FD48B6D92@zytor.com>
 <20190930150110.ekir52wu3w67v2fk@tomti.i.net-space.pl>
 <c9eb5a39-ced5-b35d-616d-6ffbe15c1396@zytor.com>
 <20191001114133.xy5nuhepzzixhuh4@tomti.i.net-space.pl>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <dda802de-2efe-3d22-7816-6da36bf9ebf8@zytor.com>
Date:   Tue, 1 Oct 2019 15:28:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001114133.xy5nuhepzzixhuh4@tomti.i.net-space.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-01 04:41, Daniel Kiper wrote:
> 
> OK, so, this is more or less what I had in my v3 patch before sending
> this email. So, it looks that I am on good track. Great! Though I am not
> sure that we should have magic for chunked objects. If yes could you
> explain why? I would just leave len for chunked objects.
> 

It makes it easier to validate the contents (bugs happen...), and would allow
for multiple chunks that could come from different object files if it ever
becomes necessary for some reason.

We could also just say that dynamic chunks don't even have pointers, and let
the boot loader just walk the list.

>> Also "InfO" is a pretty hideous magic. In general, all-ASCII magics have much
>> higher risk of collision than *RANDOM* binary numbers. However, for a chunked
>> architecture they do have the advantage that they can be used also as a human
>> name or file name for the chunk, e.,g. in sysfs, so maybe something like
>> "LnuX" or even "LToP" for the top-level chunk might make sense.
>>
>> How does that sound?
> 
> Well, your proposals are more cryptic, especially the second one, than
> mine but I tend to agree that more *RANDOM* magics are better. So,
> I would choose "LToP" if you decipher it for me. Linux Top?
> 

Yes, Linux top [structure].

	-hpa

