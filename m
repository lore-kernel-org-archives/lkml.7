Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF7CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80602206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=inango-systems.com header.i=@inango-systems.com header.b="oSprewSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfLaIAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 03:00:38 -0500
Received: from mail.inango-systems.com ([178.238.230.57]:54166 "EHLO
        mail.inango-sw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLaIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 03:00:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id D6E55108023B;
        Tue, 31 Dec 2019 10:00:35 +0200 (IST)
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 37p05ZsNb_tb; Tue, 31 Dec 2019 10:00:35 +0200 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.inango-sw.com (Postfix) with ESMTP id 2B3421080793;
        Tue, 31 Dec 2019 10:00:35 +0200 (IST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.inango-sw.com 2B3421080793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inango-systems.com;
        s=45A440E0-D841-11E8-B985-5FCC721607E0; t=1577779235;
        bh=8QoFj6020f2oz7cgEpv34krD08H/vaMw8FFEohnLH5Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oSprewSsRZeHfjXco1in1triItB0VnrIoxm6QyIBgZ+x5qJ43I9q8tuPszUzois5i
         w+ubfcSfcjoaVN07FH/Su7m/CCHtOnd9RUQmEnTBN5Yx/adsN55ENFm5zqRLYjeERj
         HbmMNP1v3nsJk3/UnyWOSBXRr6svUxyt8j3c+xJDHig3u0nifxvHY8WPT/PUWubQl/
         DvaN6DEGFHmQTaJyA+gNAuJKv8VZzhXSH2FK/w/wgUd7MYRJ6pYPe8GxKwL5IBk8IO
         U7vNtRYhahqy2DQDF5aRNkYAihrE66lf/wJ3FEneoTh0xDtMW36a8QsyEd3E930dJo
         Q6dqDHy17zcpQ==
X-Virus-Scanned: amavisd-new at inango-sw.com
Received: from mail.inango-sw.com ([127.0.0.1])
        by localhost (mail.inango-sw.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gsy2vsuohm1Z; Tue, 31 Dec 2019 10:00:35 +0200 (IST)
Received: from mail.inango-sw.com (mail.inango-sw.com [172.17.220.3])
        by mail.inango-sw.com (Postfix) with ESMTP id 09BD2108023B;
        Tue, 31 Dec 2019 10:00:35 +0200 (IST)
Date:   Tue, 31 Dec 2019 10:00:34 +0200 (IST)
From:   Nikolai Merinov <n.merinov@inango-systems.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>
Message-ID: <1964542716.432661.1577779234764.JavaMail.zimbra@inango-systems.com>
In-Reply-To: <201912301227.47AE22C61@keescook>
References: <20191223133816.28155-1-n.merinov@inango-systems.com> <201912301227.47AE22C61@keescook>
Subject: Re: [PATCH] pstore/ram: fix for adding dumps to non-empty zone
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.220.3]
X-Mailer: Zimbra 8.8.15_GA_3888 (ZimbraWebClient - GC78 (Linux)/8.8.15_GA_3890)
Thread-Topic: pstore/ram: fix for adding dumps to non-empty zone
Thread-Index: 36Ysipr7NL/eU1rEZu744OuMFxwNVw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 31, 2019, at 1:37 AM, Kees Cook keescook@chromium.org wrote:
> On Mon, Dec 23, 2019 at 06:38:16PM +0500, Nikolai Merinov wrote:
>> From: Aleksandr Yashkin <a.yashkin@inango-systems.com>
>> 
>> The circle buffer in ramoops zones has a problem for adding a new
>> oops dump to already an existing one.
>> 
>> The solution to this problem is to reset the circle buffer state before
>> writing a new oops dump.
> 
> Ah, I see it now. When the crashes wrap around, the header is written at
> the end of the (possibly incompletely filled) buffer, instead of at the
> start, since it wasn't explicitly zapped.

Yes, you are right. We observed this issue when we got two consecutive
reboots with a kernel panic: After the first reboot the pstore was able
to parse the saved data, but after the second we got a part of the
previous compressed message and the new compressed message with the
ramoops message header at the middle of the file. 

According to our analysis the same issue can occur if we get more
than (rampoops.mem_size/ramoops.record_size) kernel oops during work.

> 
> Yes, this is important; thank you for tracking this down! This bug has
> existed for a very long time. I'll try to find the right Fixes tag for
> it...

We would like to see this changes in the LTS kernel releases. Could you
please point me the manual about propagation such fixes?

> 
> -Kees
> 
>> Signed-off-by: Aleksandr Yashkin <a.yashkin@inango-systems.com>
>> Signed-off-by: Nikolay Merinov <n.merinov@inango-systems.com>
>> Signed-off-by: Ariel Gilman <a.gilman@inango-systems.com>
>> 
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index 8caff834f002..33fceadbf515 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -407,6 +407,13 @@ static int notrace ramoops_pstore_write(struct
>> pstore_record *record)
>>  
>>  	prz = cxt->dprzs[cxt->dump_write_cnt];
>>  
>> +	/* Clean the buffer from old info.
>> +	 * `ramoops_read_kmsg_hdr' expects to find a header in the beginning of
>> +	 * buffer data, so we must to reset the buffer values, in order to
>> +	 * ensure that the header will be written to the beginning of the buffer
>> +	 */
>> +	persistent_ram_zap(prz);
>> +
>>  	/* Build header and append record contents. */
>>  	hlen = ramoops_write_kmsg_hdr(prz, record);
>>  	if (!hlen)
>> --
>> 2.17.1
>> 
> 
> --
> Kees Cook
--
Nikolai Merinov
