Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E4FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6BC2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="U3Oyx9zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfG2Hl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:41:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37280 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2Hl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:41:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so35550414wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ORbzlsHDa5hfAtYywIFIzyHDT+ZvebWOt6YTGvwMpig=;
        b=U3Oyx9zN4u2Gtbuvjv+zgxcVNpE6ZKb70DCl4DIEj3I4V9ml3D84LExFTzRYkfan6s
         NRYpbieyI3krseoucYfTo3uWhnm/qloBGOsfAQeLeKSMTPmLVq5mhJNmvLkNWMpW3kw0
         8N7dxwE0J4bRWdRsK2a/ECi91IdaNWUrY6huK4eVd0YX1WVVHXNfCjobSYS+9Q7Aaahr
         T2G43s/XcEQ8J+Kdb1dFGpzgHBXSXiAC8fhlwt7V+KlWya1e7Ew0hv/VYl9wPNUvz8X7
         eCbL/7s2XVxgsrzOo5tkUEXOyGnO97DA9+NRaWTJKc56tnKpHdiFA0MikkGwnPtx2ZT5
         nmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORbzlsHDa5hfAtYywIFIzyHDT+ZvebWOt6YTGvwMpig=;
        b=idlVAayHhTJnWC//nH2uBHDB2HyDhpNjo9swGT9yw4w96LvmTLLwJ0cIKu2f0Fl1pH
         EjHu7ZH84wPqUy0loPNRYx5nORsGmZN2XgRTXDF9UeI4bNI3I4Wqb8sv2nZ1feyoMTQt
         jgpuS5RIYyICWfWd7PEcl8uk9Pk8SxIRFx3j8r417m/pagwMmbzQuu49SeeuLTmIMcNO
         9w0fpEpnkEI3k1bxC/nABGhMq0pJVwM+uylmTq0OBWIOACIHlFoxwsK+Ud6T09RgJoIL
         rXXpVhnj5Y9KpgUzEQ9f9zugRMxUPr9OJJHH/cUHEOPa5FV32JF9RTmAJ+4QwWk9kkts
         iOSA==
X-Gm-Message-State: APjAAAUupX9hRrlbow8NVdUxQh5FhFhKfWOsHYA4zu8qgFK+SXcJX9W+
        98CYA4DgsUKLKz33JNR1wPM=
X-Google-Smtp-Source: APXvYqw+rYnER7GSElPp44lGXfPWqu3WnBnRAu+1fqDmgcedrvhr4Z2/zTlGTzHIKSvjGwIqDz7wBg==
X-Received: by 2002:a5d:43c9:: with SMTP id v9mr45383532wrr.70.1564386086100;
        Mon, 29 Jul 2019 00:41:26 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id v18sm63277633wrs.80.2019.07.29.00.41.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 00:41:25 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:41:25 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: Fix a possible null-pointer dereference in
 dequeue_func()
Message-ID: <20190729074125.GB2211@nanopsycho>
References: <20190729022157.18090-1-baijiaju1990@gmail.com>
 <20190729065653.GA2211@nanopsycho>
 <4752bf67-7a0c-7bc9-3d54-f18361085ba2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4752bf67-7a0c-7bc9-3d54-f18361085ba2@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 29, 2019 at 09:32:00AM CEST, baijiaju1990@gmail.com wrote:
>
>
>On 2019/7/29 14:56, Jiri Pirko wrote:
>> Mon, Jul 29, 2019 at 04:21:57AM CEST, baijiaju1990@gmail.com wrote:
>> > In dequeue_func(), there is an if statement on line 74 to check whether
>> > skb is NULL:
>> >     if (skb)
>> > 
>> > When skb is NULL, it is used on line 77:
>> >     prefetch(&skb->end);
>> > 
>> > Thus, a possible null-pointer dereference may occur.
>> > 
>> > To fix this bug, skb->end is used when skb is not NULL.
>> > 
>> > This bug is found by a static analysis tool STCheck written by us.
>> > 
>> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> Fixes tag, please?
>
>Sorry, I do not know what "fixes tag" means...
>I just find a possible bug and fix it in this patch.

git log |grep Fixes:

If A fix goes to -net tree, it most probably fixes some bug introduced
by some commit in the past. So this tag is to put a reference.


>
>
>Best wishes,
>Jia-Ju Bai
