Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEB3C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEDD2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="datq/tqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfDBTFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:05:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35426 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfDBTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:05:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so7030217pgf.2;
        Tue, 02 Apr 2019 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzyRa8cjTsPh8BeC6LSVOIA2BFgCNkK7tVkBCVr1Hjw=;
        b=datq/tqeMrV5ycr3TDGun4TgGeTmuhdMmY/5fyZ11t02AOjaYa77JsyqGjDfT4/Dfs
         fKh5vJWTYuj2kZ6OglKrw4Ry9IO40Te6uciA2TpCrLJQzQjuDNyhJBud46XuwUo9rQHQ
         jrpZ3xHSreU5y++GgV/aINXRyqyQFctWvDK2EngrNnD80Ri4m7Mc52k4lrzutPceNpjc
         0wAf3JgNdDJ964T4uJ620o2oq4owg2VNYMn4y9E+oummOaWsqm4QLNXxCyiSqu3Dyt+y
         LLTccHgaxbsRBusaT+R8TaVRmvi8EjKI1KmvYobThcLgxuGaELkMPHrdxK69VZT0kw9U
         H/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzyRa8cjTsPh8BeC6LSVOIA2BFgCNkK7tVkBCVr1Hjw=;
        b=e0MevqRK1V3O5btxGoZGvOaSmQLHw7SaHgSQQZWQAcuZTnwPX2VKq4L8+As39f4MKF
         yE6mTtunDHS1oBA7vke/Zsqs6YbXGMybjrl/suwMBA9TwemZANQkvLiCww4VUh62/61W
         gh3O3RIjYy1sarX6ZaUGER21PlXTvW7JejVdgHbDKa1w5+3iCKQGKs6EL9KOnEABt+bY
         OGpm0Q3QBizznoPOFqMNIT1eu8NiwAbCKbUWTpga9/znrGKAIpiB+Zh3OtOM4EQaptyS
         TIf6mVig2t28dnSENkF/qC2scmZzyeoraGzLzf26z7BGYrMe/bC6x972ntuZsgpcDRq+
         /Irw==
X-Gm-Message-State: APjAAAV4jz/DfqrLnaKXmrl2WLJW9q8HFWypp9re/UDFsbJSZQBWH0yk
        TkzicYs6hJQ9H7w4e4q8YPY=
X-Google-Smtp-Source: APXvYqzRs0hLdSYlobrF77gO7zJYjvLUjNg8ys56sRwCx3O2Wc9MiRMHuRfqKP4yjvQeCQf9FSFLcg==
X-Received: by 2002:a65:4802:: with SMTP id h2mr51250048pgs.98.1554231905090;
        Tue, 02 Apr 2019 12:05:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f125sm26216593pfc.91.2019.04.02.12.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:04:58 -0700 (PDT)
Date:   Tue, 2 Apr 2019 12:04:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/56] 4.9.167-stable review
Message-ID: <20190402190457.GC14232@roeck-us.net>
References: <20190401170103.398401360@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:02:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.167 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Apr  3 17:00:20 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 316 pass: 316 fail: 0

Guenter
