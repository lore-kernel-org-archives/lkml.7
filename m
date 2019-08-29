Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B209BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928822070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfH2R7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbfH2R7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:59:01 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAD3D4E83C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:59:00 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id x40so2649321edm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 10:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vXyDcpJzTd5p/KMVvOob/xE2M48IW9jsvqrOA8CmTz0=;
        b=Hvbv1lXf5TEkhVF0Z+j+tCbathRIdAWAbmQMdie8pjf9ovw6bnHGHo4ZjzQtH/2iYW
         NZbgH3osWBS4nkqcRWe09owghPd5eZqLV9V9zQmlrciaJrcFlWN180cpRBkgWYE4vEpO
         ZRkpYzsZ4aItgkq/ma/7e8x+kWnfzn5h5M5b9EGXuK+xihC1fDwqr8Y1W5mfL/LOZKGi
         XPQBQUC44WPeAlVUmw4/GO1GBSm2htvAEGRBlk43PVztGkK7DINCXk0VOD/6tSzoRMQ0
         hpcrbaPoc/9FofGLTlsfrMYavYqaSTFYB1xS2BeTi4FjFFTR1zTpZ6v3gDlDgpIuFR1N
         z6FQ==
X-Gm-Message-State: APjAAAXjkA3fDRWUhYvrPaPqkWDK2HSiVqao8wj8TWhvCWI4jBwgacc3
        lp9f3dR+hCwqWEJLaCOHl7SlM+bLkq/T2P4oRrGDtBYttHGsZnnlyFMOhSt1BED7bOfcv7FAo6q
        GC/lEhp+Qns6oba+p55j2alYd
X-Received: by 2002:a17:906:a2cd:: with SMTP id by13mr9362199ejb.182.1567101539496;
        Thu, 29 Aug 2019 10:58:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPz4t6r4A7CUfYi5mhv6MVRoXML2uPaai3OXbXjjP76nMbNjhhJGFBX9NOilRFWF4msKGbwg==
X-Received: by 2002:a17:906:a2cd:: with SMTP id by13mr9362185ejb.182.1567101539293;
        Thu, 29 Aug 2019 10:58:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id i18sm469032ejy.74.2019.08.29.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:58:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D9138181C2E; Thu, 29 Aug 2019 19:58:57 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "David Z. Dai" <zdai@linux.vnet.ibm.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zdai@us.ibm.com
Subject: Re: [v1] net_sched: act_police: add 2 new attributes to support police 64bit rate and peakrate
In-Reply-To: <1567100185.20025.3.camel@oc5348122405>
References: <1567032687-973-1-git-send-email-zdai@linux.vnet.ibm.com> <7a8a5024-bbff-7443-71b3-9e3976af269f@gmail.com> <1567100185.20025.3.camel@oc5348122405>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Aug 2019 19:58:57 +0200
Message-ID: <87lfvbhmzi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"David Z. Dai" <zdai@linux.vnet.ibm.com> writes:

> On Thu, 2019-08-29 at 10:32 +0200, Eric Dumazet wrote:
>> 
>> On 8/29/19 12:51 AM, David Dai wrote:
>> > For high speed adapter like Mellanox CX-5 card, it can reach upto
>> > 100 Gbits per second bandwidth. Currently htb already supports 64bit rate
>> > in tc utility. However police action rate and peakrate are still limited
>> > to 32bit value (upto 32 Gbits per second). Add 2 new attributes
>> > TCA_POLICE_RATE64 and TCA_POLICE_RATE64 in kernel for 64bit support
>> > so that tc utility can use them for 64bit rate and peakrate value to
>> > break the 32bit limit, and still keep the backward binary compatibility.
>> > 
>> > Tested-by: David Dai <zdai@linux.vnet.ibm.com>
>> > Signed-off-by: David Dai <zdai@linux.vnet.ibm.com>
>> > ---
>> >  include/uapi/linux/pkt_cls.h |    2 ++
>> >  net/sched/act_police.c       |   27 +++++++++++++++++++++++----
>> >  2 files changed, 25 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
>> > index b057aee..eb4ea4d 100644
>> > --- a/include/uapi/linux/pkt_cls.h
>> > +++ b/include/uapi/linux/pkt_cls.h
>> > @@ -159,6 +159,8 @@ enum {
>> >  	TCA_POLICE_AVRATE,
>> >  	TCA_POLICE_RESULT,
>> >  	TCA_POLICE_TM,
>> > +	TCA_POLICE_RATE64,
>> > +	TCA_POLICE_PEAKRATE64,
>> >  	TCA_POLICE_PAD,
>> >  	__TCA_POLICE_MAX
>> >  #define TCA_POLICE_RESULT TCA_POLICE_RESULT
>> 
>> Never insert new attributes, as this breaks compatibility with old binaries (including
>> old kernels)
> Thanks for reviewing it!
> My change is only contained within the police part. I am trying to
> follow the same way htb and tbf support their 64 bit rate.
>
> I tested the old tc binary with the newly patched kernel. It works fine.
>
> I agree the newly compiled tc binary that has these 2 new attributes can
> cause backward compatibility issue when running on the old kernel.
>
> If can't insert new attribute, is there any
> comment/suggestion/alternative on how to support 64bit police rate and
> still keep the backward compatibility?

Just put the new attributes *after* PAD instead of before :)

-Toke
