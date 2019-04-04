Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7567BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9FE2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc7dEU7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfDDMq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:46:58 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:44937 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDDMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:46:58 -0400
Received: by mail-lj1-f176.google.com with SMTP id h16so1940354ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=reMMzuiqlTmxhfe9tV3h+YbzlqazE2w1XS7XQ13VFNE=;
        b=Wc7dEU7dk8DngJg9sRwc2qDqBMyww9sE60sp+6LxIsCpaglx/KEIIt7gRIPwLx+ShM
         dGQGj4TK05RSwKU7WoA0+mluTfQQlnHU235rMaU2w/nLnT/kUnGwFlvmmo1K+nVlwv08
         zNe2n0hO3DXx7t1xwW6rsehLjdn2mIlru/XVDn53V0geOkNE+hYJJzeqxcBviF4CY0ED
         GerOhE9OeMFmymOpP9jRaUrlX2IKgo/+st+207+mMuygpZhdqI4/dCWM1xudAGnPjVqm
         8D/3WSUjLs8xbLjzORsKYXGN8ai93TAvVqYyfqXutRdyfEdnVFZ+RM2CD5iJaXzpqxI2
         44xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=reMMzuiqlTmxhfe9tV3h+YbzlqazE2w1XS7XQ13VFNE=;
        b=i/nlc9KLc1ZtM+BuVghRrTVux0h1p88E6GvIQ1BuGK/pUCbCurURVkBL5xAZm/lvgI
         140p2aeeaOluiWAFuPVOlM35al/uczi4tt4d1sC0kBX34ZCpjaaVmJ1kZUX0n2hHC4qj
         JRqLYnrhTufZBDp4neYTlHrgpt2oPlTTOuNnQ9UPF8n/JbUPrDs6m+9LISXdNLTHWfwO
         8UGoOamaDAX7bSO5OBSpYAGC1bnK15xl1wM4qzIEqlLdW9/N64iqDcj6oKdf7tSYAxoE
         1MO3WIJzmwCNuPEsgAjfHZxgHHiWsggq9a3U6aJffsD5KRUWkk7xg0XVMcZLC6Ejr6dG
         StjQ==
X-Gm-Message-State: APjAAAVDUKe+DDgkJTpcAhI/X6lZWVHLQfGAdLKbh0OMab1aWiIE9TOC
        4TI5OS1Cf5kHE7QE7l+KmjM=
X-Google-Smtp-Source: APXvYqz3bkD1FcH5743Jq22L8Jhq5/ErTYAufU54foMq4/6cp3gMs/mKNGgCl0R4YHsS/BFg5C2lpg==
X-Received: by 2002:a2e:9585:: with SMTP id w5mr3316555ljh.132.1554382015975;
        Thu, 04 Apr 2019 05:46:55 -0700 (PDT)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id v11sm3613643lfb.68.2019.04.04.05.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:46:55 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH] ALSA: xen-front: Do not use stream buffer size
 before it is set
To:     Takashi Iwai <tiwai@suse.de>, Juergen Gross <jgross@suse.com>
Cc:     alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190404123838.22162-1-andr2000@gmail.com>
 <4a852738-7dc1-09df-165b-a133486e3bb7@suse.com>
 <s5h4l7ec51l.wl-tiwai@suse.de>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <605c7689-de3e-06fe-2771-4b47dee1cd8f@gmail.com>
Date:   Thu, 4 Apr 2019 15:46:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <s5h4l7ec51l.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 3:45 PM, Takashi Iwai wrote:
> On Thu, 04 Apr 2019 14:42:44 +0200,
> Juergen Gross wrote:
>> On 04/04/2019 14:38, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> This fixes the regression introduced while moving to Xen shared
>>> buffer implementation.
>>>
>>> Fixes: 58f9d806d16a ("ALSA: xen-front: Use Xen common shared buffer implementation")
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
> Applied now, thanks.
> I put Cc to stable since the bug was already in 5.0.
>
>
> Takashi
Thank you,
Oleksandr
