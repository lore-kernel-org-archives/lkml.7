Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F912075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dMnvRTnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfCZLsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:48:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36495 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:48:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so12576455wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fa2xvDyBWPKh1AMvGuNxT7XAM2KGvKq3flijrnW9m+M=;
        b=dMnvRTnZ10nw9pxJmvvzNPMcAp0Lyt8z9wnS+MD1YUjzwVlFJo7SdeNicuN0tggadj
         eOtVNLSgtGhi75+H7vs1viBFnY1bItVW9WlKvY18m87/f6O+zJUoqH1aCI79aJMFYCJ+
         r55nEk0sWOFCl8Lwza3+Yw8eJqNfVsw8Fu7SoXyRXqgeu06G5xPvGG8QZl/ieDgWuX/2
         /vA5a8Xc290YtCuz+ko7uAQgF5WUGTlKzyutIAT6iXtHm9IpZ3hKL9lWS7ATvgMPKdSU
         8ztAT68oXX+IwLSnx43riawPAmzj8w4NwlOrnKTqUXHv/lD91HgVd38ZJnyIqyXLs2Am
         zBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fa2xvDyBWPKh1AMvGuNxT7XAM2KGvKq3flijrnW9m+M=;
        b=IL1u7kZcLuP/qm/LDryW5x48jvvdacH1O6vuEfJcuUtSkTx52MutyBX6xPm/mNDhA7
         7wu7ww/gZ6kV4MVu6Ns3tWSkueiKuqFDQMHp3OspU0ldw1ZooeK5KusDmXcvtUOMnq1Y
         cJQkA7qkeyyXT8w1pNVzKc8zg6wIKUyczBsOsHSBmTczI1KHayiLQXrAzwUYdpsJSfdC
         Xf8spz0jDPewyld55Qv2+TY7OlKWU7s2aNVsUQNZ6P9Jk0SmnejQKM4kRbUklJnGK4ak
         Bu+VH/hnMe56QnbFHn44qivYXvySzg3pkFULCnBnRqCCAoOf8HDQGea3rL1d13edp89v
         EuTw==
X-Gm-Message-State: APjAAAX2mYoSyTIPaDZqJqH20dAOcGSFVfWy7juNUgo42sOkWJJTV782
        CWR3Wis+Tn+S0rtSCkrt+tAd4Q==
X-Google-Smtp-Source: APXvYqzvF8RdxV2v9gTqWBQIra8L6CXRIph9fK2pV9Gr/UkrZCk2dqD/8hAsnnR29H7DqdyoIRHiXA==
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr15288275wmo.52.1553600933629;
        Tue, 26 Mar 2019 04:48:53 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id v16sm19884003wro.48.2019.03.26.04.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 04:48:53 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:38:05 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/22] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190326113805.GE2230@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <16ffb1fbfa8f54de587ac52f4ff95e5034c590b4.1553532199.git.mkubecek@suse.cz>
 <20190326100836.GA2230@nanopsycho>
 <20190326103115.GI26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326103115.GI26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 26, 2019 at 11:31:15AM CET, mkubecek@suse.cz wrote:
>On Tue, Mar 26, 2019 at 11:08:36AM +0100, Jiri Pirko wrote:
>> 
>> I don't think we should put permaddr if driver did not set it. 2
>> solutions:
>> 1) provide a helper that driver will use to set the perm_addr. This
>>    helper sets a "valid bit". Then you only put IFLA_PERM_ADDRESS
>>    in case the "valid bit" is set.
>> 2) Assuming that no driver would set permaddr to all zeroes,
>>    don't put IFLA_PERM_ADDRESS in case permadd is all zeroes.
>
>I already replied to similar suggestion in v4 discussion:
>
>  http://patchwork.ozlabs.org/patch/1060164/#2117512
>
>But I don't have really strong opinion about this. The problem with not
>being able to distinguish between "no/unknown permanent address" and
>"old kernel not providing the information" is going to become less
>important over time.

If the attribute is sent to userspace, it should mean the permaddr is
there and valid.


>
>Michal
