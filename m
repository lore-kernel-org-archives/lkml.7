Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9DDC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71E3246A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOh9a/Kw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfEaP5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:57:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39207 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEaP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:57:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so6462142pfe.6;
        Fri, 31 May 2019 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eloYZHuULAl9URe+9/lvxDAE1Ru67J7k+hZbTq0fmts=;
        b=mOh9a/KwRJaweTtWvyQWN2HMurhArY1e0m6ytfesKLKpxnr2dLKKKkhKqUqolWHL14
         HgkCTbwZmlPZ9mVSLI/HFY0efNOhBB8MBegx7xjwfqWOx6VyAC1uCErzNNTIUlkKntS7
         QoxbBUsnwVCOMOzyhXAKJMVsW8AF5yrR6nVwx8CINRe4WauKr9mUwZtCHEgFXTFQucYp
         QPotsoSvrqAS6E3EmgIgHFUdR1VSKHcj9ldg+razpt9IH1DxVsx663X0QsckHCISmCD9
         HPNQYgHrFPDJe1vMLiy8hAJqTMctQ6ecvVxO84zqMp6rFWtSO77ObOhI6KjOMdJLYxkr
         KAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eloYZHuULAl9URe+9/lvxDAE1Ru67J7k+hZbTq0fmts=;
        b=GcF7E/DKqWn5IlCb2X6+HuMHU4db+Fq2N2vUOAyqxXnK6oyMG/UI4RnJfwXse9hAMP
         bhAjvdF2J4SMu1j5fD9LmjVPSOP9Yl1mM6dMjvA+VbzeNamC9qJjHKzCNvPNaPOYpM/A
         GUiCyxNamzzHLNv9S8GtX5M9JeaFOIJ6kJS1YgPNrBRbuLdlGqkJ5HJGjLYKsrlHW2gj
         LSLwoGSEIQpTSJTJhBT0Tct633cgcM2k7H9YZ5Bee0ZYv/x+4wnl6lhDVWGF4SpLxeyA
         jETfXhB5QhBZmlUB7r9mA2xM+V3OrP4zXKt03g2/3Dxz+HDwyGL5oyDM4QOEwjLJLkWp
         9RWA==
X-Gm-Message-State: APjAAAV5/1Ys93jO9rGTP6Pi2m/any1V0cNKCi8Ws4mok9TV+UsoHidh
        PdU3yyWiimok8bVIoGmzpro=
X-Google-Smtp-Source: APXvYqzSQXHM1yULVV/pYLvLEO0AXzX01JxMYq//CdLY3JUbOaesBtXKPEQc7FEJxBvc9HRg37U9Xg==
X-Received: by 2002:a62:683:: with SMTP id 125mr3443030pfg.168.1559318263752;
        Fri, 31 May 2019 08:57:43 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id h1sm7906377pfq.3.2019.05.31.08.57.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 08:57:42 -0700 (PDT)
Subject: Re: [PATCH] ipv6: Prevent overrun when parsing v6 header options
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Young Xiao <92siuyang@gmail.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
References: <1559230098-1543-1-git-send-email-92siuyang@gmail.com>
 <c83f8777-f6be-029b-980d-9f974b4e28ce@gmail.com>
 <20190531062911.c6jusfbzgozqk2cu@gondor.apana.org.au>
 <727c4b18-0d7b-b3c6-e0bb-41b3fe5902d3@gmail.com>
 <20190531145428.ngwrgbnk2a7us5cy@gondor.apana.org.au>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <56a41977-6f9e-08dd-e4e2-07207324d536@gmail.com>
Date:   Fri, 31 May 2019 08:57:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531145428.ngwrgbnk2a7us5cy@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/19 7:54 AM, Herbert Xu wrote:
> On Fri, May 31, 2019 at 07:50:06AM -0700, Eric Dumazet wrote:
>>
>> What do you mean by should ?
>>
>> Are they currently already linearized before the function is called,
>> or is it missing and a bug needs to be fixed ?
> 
> AFAICS this is the code-path for locally generated outbound packets.
> Under what circumstances can the IPv6 header be not in the head?
> 
>

I guess this means we had yet another random submission from Young Xiao :/

Thanks.

