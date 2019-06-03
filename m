Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E99CC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E499427BD9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMNScuJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfFCGKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:10:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51725 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfFCGKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:10:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id f10so9793995wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0RCVB0UhfwlSsI+hwGlS0DnajwIQfpTejbTT6PWoEpI=;
        b=UMNScuJpI5Z7NKECMSEw+Tjp9IcgQNY7K/x1TfIib5knNWm6PNiZYpSxytZIyeE6gE
         1rPBb0RcJ+9gTYLsvColleBwjjggWJZbJ9ZDp+Wywh82xXyBpKnciyZ7AvAwABNgO1CV
         X7p78ft0ph7X/W7hogqFJAS9BnWDkUShM/gRSkQSv603SPUoq9kNdBtwzzcvilaQVheO
         OwqABbQGB0xHER+C3oWotMhTUHg1S62+b4z0vhuOzndHFukxsZUGRsIcHg+/m6zmpezX
         /5xuybw8Dp8yY+4pI7+z6KrTLJzMYuMvhLKXzFJa0Z/O+iul+f87tNKCh9b9/JoI93YC
         KyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0RCVB0UhfwlSsI+hwGlS0DnajwIQfpTejbTT6PWoEpI=;
        b=FKL9B5ZDqWR3ct1zdHd3WP13AUbgoG+vnV8XgKZDMPdyZX4VAoaU0QXDt0eSHxBKLR
         J3RVPUEAouLYMo2NPtJMI/kZmprbT9sTMIvGecIpJAUFz0IN0VWgwdeBN//vVJipjYOo
         RsDpwFO6kLnzpvE1pwJfOp3/3I+5VS/th8YdUyFrPhVF5ikhy9Xsfvm6c8+5kDfNomlL
         tlG9OB0qDOpew8MzMFEp06X8cCvjjzKCd49qptHSxuY3pvjzhtEHqjXOdUMmDOvSjwfa
         An/Qk/Tj9tBRUXQ+LpO4cYSWSpHvrjHho9uF+NxZA6vmkGiU/C1sYZGTt26NtzhiTQeb
         nSBw==
X-Gm-Message-State: APjAAAW1YFSTVHgJXO+FkI2p5hTfZ6dEXRan9dSmGFsEmVGDj5kL7O4A
        Fn2lpeyw4jEXhL32AW4whIvaZ+Wf
X-Google-Smtp-Source: APXvYqxmv2dl4Iz9vGKwSOgpmnSjL6n9UAqCSY8ne25hU6Mfd78IhnAQMe7dwMBoea9/tOtQ1Fz/nA==
X-Received: by 2002:a05:600c:23d2:: with SMTP id p18mr3401885wmb.108.1559542228100;
        Sun, 02 Jun 2019 23:10:28 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba? ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id w6sm2897575wro.71.2019.06.02.23.10.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 23:10:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove redundant definition of
 ETH_ALEN
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190602163528.28495-1-straube.linux@gmail.com>
 <9ca0c459d047c72fc459313ad570ecc59cf5d300.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <936cc2d2-e05c-3153-fa66-89ca22b5d755@gmail.com>
Date:   Mon, 3 Jun 2019 08:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9ca0c459d047c72fc459313ad570ecc59cf5d300.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-02 22:07, Joe Perches wrote:
> On Sun, 2019-06-02 at 18:35 +0200, Michael Straube wrote:
>> ETH_ALEN is defined in linux/if_ether.h which is included by
>> osdep_service.h, so remove the redundant definition from ieee80211.h.
> []
>> diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
> []
>> @@ -14,7 +14,6 @@
>>   
>>   #define MGMT_QUEUE_NUM 5
>>   
>> -#define ETH_ALEN	6
>>   #define ETH_TYPE_LEN		2
>>   #define PAYLOAD_TYPE_LEN	1
> 
> While you're at it:
> 
> neither ETH_TYPE_LEN nor PAYLOAD_TYPE_LEN appear to be used.
> 
> 

They are removed in the second patch of the series.
