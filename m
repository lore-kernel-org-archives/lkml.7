Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204B5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F370F2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfH1Mls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:41:48 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35621 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfH1Mlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:41:47 -0400
Received: by mail-ed1-f42.google.com with SMTP id t50so2882501edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 05:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XQb3z9P4gf099Mugft8AnZzlB0sXTeRvVgkGP0skJyk=;
        b=S6458ypgOU5jorIyO8hSuva+Y9SCSumx+waVFCA70BgHgcOpy/ZrCb6z/aoWy0LORL
         o84+uD+0zdEQ7d1zt7bLKACmiIApsFZYpZEkKWPeNt2yQwD919LgdIvt9UOMQG0tfHgF
         TwGQg/bGdjQywXj8VIlh4A1LPF49iehaKeoqYgB+4hPisyK6wazD3hgivofeBsch7cyx
         a3R/jQJ4yuU/yyrY8cNhUIt+UT9q6jAO/jfF4b9IXZ76WNZTKHKB1OksSso1WZCj65Do
         Z4ft2+qssjHBnGAbI4lu4xebJNpGr8fqq1pU0a4xP88KbdAbW2haBn+BHSu9kJh8Flms
         qGMg==
X-Gm-Message-State: APjAAAUdaQwVBe1Oyn1qKThjWx9ldFXWYlB6lNTH5ZqHfCHNXL/UYGYg
        4hvdyMNuDvAmWGlgELdndmE=
X-Google-Smtp-Source: APXvYqz57QeeTvorHo5cXarpWRCeQpcGtAf1c3aKwtJlruwTu/+crGW/L46mB112EyJC75bvpTlxgw==
X-Received: by 2002:a50:fd10:: with SMTP id i16mr3650722eds.97.1566996105050;
        Wed, 28 Aug 2019 05:41:45 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id 59sm440043edg.44.2019.08.28.05.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 05:41:44 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <496b3d09-47a2-3836-2899-d964267993d3@linux.com>
Date:   Wed, 28 Aug 2019 15:41:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> As a human I am confused. Is !likely(x) equivalent to x or !x?
> 
> Julia
> 

As far as I could understand it:

# define likely(x)	__builtin_expect(!!(x), 1)

!likely(x)
!__builtin_expect(!!(x), 1)
!((!!(x)) == 1)
(!!(x)) != 1, since !! could result in 0 or 1
(!!(x)) == 0
!(!!(x))
!!!(x)
!(x)

Thanks,
Denis
