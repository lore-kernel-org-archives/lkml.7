Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E64C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F46217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qX8y18Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfE1RsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:48:10 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42770 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfE1RsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:48:10 -0400
Received: by mail-lj1-f178.google.com with SMTP id 188so18536315ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2b+zSBhPUFYF8TBcN9S0abTU+XNsI8SZLoQByKSROWg=;
        b=qX8y18Zy+GnzVQa2UigP1iRWt+eWH2IvHmgfCT3SGRK1RLT3u3ZkxEq5ulQl015/6P
         bcUK7u6Urwg/yga0aWUmCiP5HjwwCcK3HDZBnnUusAWTbUSRnskCM8K5qnGHLAYY+PrA
         u/pnUg2xKKJQ4RcCUv5FI2i4nW0K9pWMXuPllE+bBKuEHBS7oCDPM4pzYgPzhBhDJD9m
         KQW73mD4AnCgsoJ5Slg1aiDUBVeERnp6OLebxRK8m5r8o4uA3mRX7ycpaNylAoKcHs4U
         7lFasX2dOAzUNi6OAY8cPlSa3MwVIBFYDZjO5QxKDT61RGSN8CekqS0ZVu7I1iLlJAu8
         Sxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2b+zSBhPUFYF8TBcN9S0abTU+XNsI8SZLoQByKSROWg=;
        b=Hev9oWGYfBCxyVflwiaAnO98z+hDrmtoVVHX4HBEnT+Nulja4vv50s6Mf4fk7uvdmn
         ZN0MIxRmyLM23hvI3EVlVpOEB4WZDutwmZIkDhRLjLpxzys9w7Uk0NabLOEWiQboxPNN
         pUiVkr6m9bzTdMuLjEJ0jodatIBltIfct4pI/EIYRUUgsIPXTxbC2IJYq06W6UWcokuz
         JLWTNUohckd+gg6mJIiyqR5db0bqkVXwheqr/AQGOMivbHB1EDqqdSQrqG/ZY7w9KC6r
         eQ8PVYuQ645+cz6HMjNpgFbC7fsW980lupp6ZL8FGQhI79uyc/QSkbYGb4qf/fJ0X1UA
         Z4Nw==
X-Gm-Message-State: APjAAAWHYVewmdrcI7bCqGHMf03wdhQXRSPKd0lMnLS/AFXbgqvBagia
        Q1Zkw0SmoPjkTCc5O4ruLgoTyg==
X-Google-Smtp-Source: APXvYqzGAfNp2urKxLyPkaIXh7rQVPVPHDYGjYpJ53BFyfb2W3CmKlz169LP2vWgEVFSJtyS7SBhfw==
X-Received: by 2002:a2e:818b:: with SMTP id e11mr65623965ljg.82.1559065687568;
        Tue, 28 May 2019 10:48:07 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id j7sm3641208lji.27.2019.05.28.10.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:48:07 -0700 (PDT)
Date:   Tue, 28 May 2019 20:48:05 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: correct .ndo_open
 error path
Message-ID: <20190528174803.GA3233@khorivan>
Mail-Followup-To: grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190528123352.21505-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190528123352.21505-1-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this version, I've sent version 2 that do the same but is more
adjustable for later on changes and based on usage counter.

-- 
Regards,
Ivan Khoronzhuk
