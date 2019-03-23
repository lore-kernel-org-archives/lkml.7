Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623A7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC9221741
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 23:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfCWX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 19:26:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43565 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfCWX0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 19:26:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so3871072pfd.10;
        Sat, 23 Mar 2019 16:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xTcPoy2UwJ8FrDaFPvlnYZR9QLLEZDKavUokOFJMVXE=;
        b=XKsIV9MnY1GHvcLpTw6r/hEnNKR8CyJxlOZQTGFUZt1jIdgEiYgwFe5UyO8xQPnmly
         FTjWe+gXxAPwM1Zn4EeKwQKpsNgkOuNdMbeVak3DMnxrWIrXBxD+vCxz0muK+QhZUjSh
         Cp3930yM+uBiW/os/DGz23PztQXKqUY3eb0P+UfO72A2ciJEUnZe7uZY45s9ZcaY89yf
         GfrnZBRDtarNGRUZSQmx+0GiBrVTtOdPzxDU1Mw3fYjrUlLyX3km3uFWljpw2lTCWFVc
         oHVQDaYDWLT8fSALYkhg0bXCH+fEOWrzcG6aU1JtNQAYxD8tevfdPqbprA9r5HZ4dvT1
         GFvw==
X-Gm-Message-State: APjAAAX9ikS0oHCXeX1x/pzk2W0hZi5NjhCWksdu4Z2/ZSxyQBAEjFzZ
        s8IdLFcxLhPPWCqCOAZ+J1cfdCd4
X-Google-Smtp-Source: APXvYqxg0n+7jcCr3We5mfdcFzDSB0NQRncD4Hg5vxXyOFypohh04rtH68JQbsBjREK8lIrc8N+7gg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr10237549plp.74.1553383560657;
        Sat, 23 Mar 2019 16:26:00 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id j20sm14975415pfa.158.2019.03.23.16.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 16:25:59 -0700 (PDT)
Subject: Re: [PATCH] infiniband: cxgb4: fix a potential NULL pointer
 dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190309051921.15212-1-kjlu@umn.edu>
 <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <26f51579-c9bc-372d-3659-5cf778845215@acm.org>
Date:   Sat, 23 Mar 2019 16:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CC1E06D8-7817-4314-AAD4-434FEB8C4157@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 7:37 PM, Kangjie Lu wrote:
>> On Mar 8, 2019, at 11:19 PM, Kangjie Lu <kjlu@umn.edu> wrote:
>> get_skb may fail and return NULL. The fix returns "ENOMEM"
>> when it fails to avoid NULL dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>> drivers/infiniband/hw/cxgb4/cm.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
>> index 8221813219e5..502a54d57e2c 100644
>> --- a/drivers/infiniband/hw/cxgb4/cm.c
>> +++ b/drivers/infiniband/hw/cxgb4/cm.c
>> @@ -1919,6 +1919,9 @@ static int send_fw_act_open_req(struct c4iw_ep *ep, unsigned int atid)
>> 	int win;
>>
>> 	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
> 
> Can someone review this patch? Thanks.

Hi Kangjie,

Please change the patch description to the imperative mood (see also 
https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/SubmittingPatches). 
A good way to invite feedback is to add a relevant Cc-list to a patch. 
The output of scripts/get_maintainer.pl can be a good start.

Bart.
