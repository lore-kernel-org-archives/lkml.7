Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C26C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C986A20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYUZ6ptG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfEILfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:35:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35917 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEILfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:35:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so1088347pgb.3;
        Thu, 09 May 2019 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pCzQA9iFafWm9xsaMI26hanRVNC/kRqx7QC4DMgsQhw=;
        b=tYUZ6ptGZ0VCmH5SP3u3RZe53nNjuDZy6tuB8oq1LpEe6sL19KnFH2BjIHZgo0DmnH
         P56z51i/LOEB/YxplPb/jxR+C6mmiPpaEfSWJ7yeBUd48qqkIHZPhTZm2eQ4dYljsZMd
         aprbB8wnK/FR0qI6JMO50dIA90z2pHdWpTmYUP9X2YmGICVR5+1tQGLoe/zKrgHzQGc1
         Gf+/psfSfVEOyC4JcVJ69yfwEQJ4u3rBadLyjIm8e7q+NeFb0KOufiz+pqPpXYSxex21
         6sWqZzUxEZFJ6ExWzpqpt1tPMLdjJItID4sCXixfXhZ6L9Aofy4u6khLZHKkyvCL1SOR
         4eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCzQA9iFafWm9xsaMI26hanRVNC/kRqx7QC4DMgsQhw=;
        b=qVYomWBdu9qkQFR83O3sFrHfo3YbS3xnLc0ZMZ86EoK8PFofuwZXcJmiuWM0hMUT6g
         eZdf9hxQufP4u1PjfKiA4f0K62ztiYkCRKAj5zWWuH9ZEj45rBKfGdBczXeMUoEl09pv
         ReblfE5neggSM+nbR+mXmRwhzgPr+c9/hXcWc889lqfiDWWoEdcXcFFAZ/6axdVWrEAD
         XWaYT4gUJJ4bDvzu390NUvsnOi18kbWmqxUAosUb/GgKyv9x8ZlmvXkRCh477oVyCAI5
         0jco0N/oeCCe4RgJA9a+kDj5GwLSuWANOW/uysitkeIfxfRh104dABENgK6kwL80Nc8s
         20ng==
X-Gm-Message-State: APjAAAWtEYpuK4O5zdwBerVxWiAl59xAffMx2eXn3Mar2gKmVenol5Ya
        zK7DPzS12emcT/g02N3qWKQ=
X-Google-Smtp-Source: APXvYqxmRsJST+6oDiJ8/5DEEcoDK/i0mbVlIZapJZhIrRHkp7lkL1zHzEGnt+fRmKLy5EinBajctQ==
X-Received: by 2002:aa7:9242:: with SMTP id 2mr4381343pfp.230.1557401740471;
        Thu, 09 May 2019 04:35:40 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id v40sm6937601pgn.17.2019.05.09.04.35.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:35:39 -0700 (PDT)
Subject: Re: [PATCH net V3 1/2] tuntap: fix dividing by zero in ebpf queue
 selection
To:     Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuehaibing@huawei.com, xiyou.wangcong@gmail.com,
        weiyongjun1@huawei.com, eric.dumazet@gmail.com
References: <1557372018-18544-1-git-send-email-jasowang@redhat.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1a244711-657c-88f9-6463-c503d178dd02@gmail.com>
Date:   Thu, 9 May 2019 04:35:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557372018-18544-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/19 11:20 PM, Jason Wang wrote:
> We need check if tun->numqueues is zero (e.g for the persist device)
> before trying to use it for modular arithmetic.
> 
> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Fixes: 96f84061620c6("tun: add eBPF based queue selection method")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

