Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D7CECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF462133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 03:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lzHc6dfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJIDpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 23:45:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40500 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfJIDpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:45:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so360542pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=liff+2I181mBeYcP7vnPa93eBbGSoVxP2sz1/iUSuJA=;
        b=lzHc6dfnxI3dTD9LV+12XsYQ1hfX4oAzzxy28wzYWGuzZM3OrIjcsVdMJsl2NCRffU
         nWHgdMrHBTKPRwoxwzLvUhyy8+d2CPtNvSNRmbX+PAPE0Ock4jWRBw/8L7PZq6VSYJx6
         Wv8bE4jrOsVmNqFT23UsmDV0HmsolL/P4rXtlBlF+xM0rKtomvz/At5XZpHwH2tV/p/X
         2tPKwyTBRpPAicoHU6BbukbZuruFT9/c0DLwvVTqcGPa4gaWWoIx5Xo9vxUbogtWfuM5
         VWd9rWEFHfhBen67fEILP6GH7uk3wS10t9Etur1Gac3M1FmL3+9NljBpx/B9grMGbZOB
         X4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=liff+2I181mBeYcP7vnPa93eBbGSoVxP2sz1/iUSuJA=;
        b=LxhAIvOl48b0VFpgy/VOhKnB4qLefqqkmCrIOfwRZ2M88bh4jj4gkSzS0Yc5iFHNtm
         UlSNCmq+WGrz9M08wXB5amcNG/PrLFdx62z+IMMN4UCU5P4DiU3mOgGkLXqMZ9cpVcsD
         xYfq534O9WSxhidNFzOm2ypvNu2odR/eWnA6TEYJgBNtN3saoGhGbbJNBSj6SIUljbEf
         RA7QRupUGiHfjyzuOi6nMzTR0eELlpMEZh0ym2cPvMUurGiIch5KuFgVwJujoMMPbpry
         SL7MOfQpNZwx4+y84NYATLs3vmU+coBHu11oHiuqY43oNqlTCHfZenPGoINqIQL0tAl1
         7UgQ==
X-Gm-Message-State: APjAAAVYmsyaGuEG6h/xZLJv/EZ9T54axc89KNuGmODo2m0Y9rutK3a0
        FPR4TV/XXymPlXGIcscK4jQazQ==
X-Google-Smtp-Source: APXvYqzfO/3qMUWyXK1s8QSMSKpYAi65qrIiMZYufP6UyQiC5vB5Y5+5O56CER+1kzI4YCQYOTisoQ==
X-Received: by 2002:a17:902:8d8e:: with SMTP id v14mr1030449plo.287.1570592721944;
        Tue, 08 Oct 2019 20:45:21 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id w11sm563669pfd.116.2019.10.08.20.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 20:45:20 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 5.3 15/71] rbd: fix response length parameter for
 encoded strings
To:     Sasha Levin <sashal@kernel.org>, Ilya Dryomov <idryomov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <20191001163922.14735-1-sashal@kernel.org>
 <20191001163922.14735-15-sashal@kernel.org>
 <CAOi1vP-2iSHxJVOabN05+NCiSZ0DxBC9fGN=5cx98mk5RvaDZA@mail.gmail.com>
 <20191008212944.GD1396@sasha-vm>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecddc946-4fbf-4bb2-aac2-689135473f36@kernel.dk>
Date:   Tue, 8 Oct 2019 21:45:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008212944.GD1396@sasha-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/19 3:29 PM, Sasha Levin wrote:
> On Tue, Oct 01, 2019 at 07:15:49PM +0200, Ilya Dryomov wrote:
>> On Tue, Oct 1, 2019 at 6:39 PM Sasha Levin <sashal@kernel.org> wrote:
>>>
>>> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>>
>>> [ Upstream commit 5435d2069503e2aa89c34a94154f4f2fa4a0c9c4 ]
>>>
>>> rbd_dev_image_id() allocates space for length but passes a smaller
>>> value to rbd_obj_method_sync().  rbd_dev_v2_object_prefix() doesn't
>>> allocate space for length.  Fix both to be consistent.
>>>
>>> Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
>>> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
>>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>   drivers/block/rbd.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index c8fb886aebd4e..69db7385c8df5 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -5669,17 +5669,20 @@ static int rbd_dev_v2_image_size(struct rbd_device *rbd_dev)
>>>
>>>   static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
>>>   {
>>> +       size_t size;
>>>          void *reply_buf;
>>>          int ret;
>>>          void *p;
>>>
>>> -       reply_buf = kzalloc(RBD_OBJ_PREFIX_LEN_MAX, GFP_KERNEL);
>>> +       /* Response will be an encoded string, which includes a length */
>>> +       size = sizeof(__le32) + RBD_OBJ_PREFIX_LEN_MAX;
>>> +       reply_buf = kzalloc(size, GFP_KERNEL);
>>>          if (!reply_buf)
>>>                  return -ENOMEM;
>>>
>>>          ret = rbd_obj_method_sync(rbd_dev, &rbd_dev->header_oid,
>>>                                    &rbd_dev->header_oloc, "get_object_prefix",
>>> -                                 NULL, 0, reply_buf, RBD_OBJ_PREFIX_LEN_MAX);
>>> +                                 NULL, 0, reply_buf, size);
>>>          dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
>>>          if (ret < 0)
>>>                  goto out;
>>> @@ -6696,7 +6699,6 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>>>          dout("rbd id object name is %s\n", oid.name);
>>>
>>>          /* Response will be an encoded string, which includes a length */
>>> -
>>>          size = sizeof (__le32) + RBD_IMAGE_ID_LEN_MAX;
>>>          response = kzalloc(size, GFP_NOIO);
>>>          if (!response) {
>>> @@ -6708,7 +6710,7 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
>>>
>>>          ret = rbd_obj_method_sync(rbd_dev, &oid, &rbd_dev->header_oloc,
>>>                                    "get_id", NULL, 0,
>>> -                                 response, RBD_IMAGE_ID_LEN_MAX);
>>> +                                 response, size);
>>>          dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
>>>          if (ret == -ENOENT) {
>>>                  image_id = kstrdup("", GFP_KERNEL);
>>
>> Hi Sasha,
>>
>> This patch just made things consistent, there was no bug here.  I don't
>> think it should be backported.
> 
> I'll drop it, thanks!

How did it even get picked up, it's not marked for stable?

-- 
Jens Axboe

