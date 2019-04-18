Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7792BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463A42183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7qDTuXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfDRK5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:57:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41451 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbfDRK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:57:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so2411266wrq.8;
        Thu, 18 Apr 2019 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Lbj+1gpirf5WRLjhJzE/ZuN1+1rn3LsnABrKVg8Fs0s=;
        b=A7qDTuXBmI2gH8mOHPhhZMQccX1Gl36azN/DgvtlpFDAD2YG/bqYarmJBBIhTVYRnG
         mEtHpYETJKRqGWCYAgj1loRBBOjoMPKThm8y3AoDC4ixo/chlOc2seYKpg2HVs3lB/cX
         UWZa8v/jNvyfDnT4mGcDD87YIAQWkpIslSL2hDlp29qLuQGBxU0X0oDGth0gvnqh620l
         0z/rB4rXJa/bIahqp+ugtLQZVFvHXw6FYg1RMn+0NmNvvN8cOrpjaG4ubCAxwimfIKDA
         nOT6aWiePc2SacREFxujEvlhCOd8zMA4ZAwwXAqhBXl8NrKkYWm6SKusgisg+3/AidJ/
         nkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Lbj+1gpirf5WRLjhJzE/ZuN1+1rn3LsnABrKVg8Fs0s=;
        b=Jnf68TYlNf8eqcYMQcydSK6g3wr7xiHGwLs3GiG2Yzwh3+lXtACaS8QqiXHFrjBMAh
         Nytp5m8H8JwgFwnXEDeMtJWvZLt3pewZMTardEfvHkRLpmPQoJ/d8bwJedKxzg1bkset
         CvpTTrdxad9fSDiL2RDQSggKXvAIay4ET5XRlTUZ2ZzpSG2zdhLYgzEuCOTFFAEr6J/F
         maWmG8C7voCzUdHvpCoQlxvxhA/GvbbsJGrUHDkQRTw3OpmG5XHVTuUnNrgIdRrfhx3U
         3ddzSvaMCIlHsMbpnZOYZ6mtQTq6TNkrCSc+PYgdJqVaoGlWNqACm5PwUKNDjfBvocEx
         YhEw==
X-Gm-Message-State: APjAAAXWm/E30qZ61tB58vHeQpW7fu1QJUyQpnbkmjt49OwIjxlWqEhu
        MnBKkepr0O6jwEbQ4hrPY9Q=
X-Google-Smtp-Source: APXvYqzJIudDxUQcJCFjEZVe9C2DzZwiz2ZbqXuaMPr+FEhg67/WEh9SXJFKfva+SnqrGotkghP0cQ==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr40066484wrw.301.1555585066704;
        Thu, 18 Apr 2019 03:57:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id z63sm1954512wme.30.2019.04.18.03.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:57:46 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: dynamic DMA-buf sharing between devices
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190418091315.GU13337@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7cc155fc-1582-9a80-283a-f9e7c84b120d@gmail.com>
Date:   Thu, 18 Apr 2019 12:57:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418091315.GU13337@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.04.19 um 11:13 schrieb Daniel Vetter:
> On Tue, Apr 16, 2019 at 08:38:29PM +0200, Christian König wrote:
>> Hi everybody,
>>
>> core idea in this patch set is that DMA-buf importers can now provide an optional invalidate callback. Using this callback and the reservation object exporters can now avoid pinning DMA-buf memory for a long time while sharing it between devices.
>>
>> I've already send out an older version roughly a year ago, but didn't had time to further look into cleaning this up.
>>
>> The last time a major problem was that we would had to fix up all drivers implementing DMA-buf at once.
>>
>> Now I avoid this by allowing mappings to be cached in the DMA-buf attachment and so driver can optionally move over to the new interface one by one.
>>
>> This is also a prerequisite to my patchset enabling sharing of device memory with DMA-buf.
> Ok, with the discussions and thinking I think this design is solid and
> should work out. Bunch of api and documentation polishing still to do, to
> make sure we have really clear semantics and as little room as possible
> for misunderstanding - refactoring a mess in dma-buf is a lot more tricky
> than just ttm, there's a lot more users.

Yeah, I'm pretty aware of that after changing all the users of the map 
API to use a structure for the parameters.

Well at least it's not UAPI :)

Christian

> -Daniel

