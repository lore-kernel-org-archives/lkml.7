Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC50C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC99920883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBhhhi+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfE1MsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:48:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33513 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfE1Mr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:47:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so8325766plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4OteA4keojZHK2MF5haDWUxtIJtUSMxeYouchlVp2qA=;
        b=FBhhhi+Z4o39uwPH4T/Ze7TApUywTvM7Rv2kYb3S4S76TdPe0++tkj8dPNo52Rn0BN
         F3hz7ycsZgYHKnwd+zEz1TlChKc0yPoQYev+klwjWKFa9owxmmVbeyiLZPbPS4TKYZlJ
         znEimldEL+ulVM3IY1sQMJgusDFEQeqNaon6GmPJTfK6UJMmxfW6VWvShDPtOXqkQ6wP
         ++4cE38J97CLzTdae4HcrRMWI5l9/LYw9P5LZA5vYj/DAXUvFx8zfZDG/0eJNtTKhKkN
         ME5JHqUP64KVldcEM0wXDRTTNp0v/1t34HN5g63gFQNAxdwSq4Ef+iSeYoC/9RwNPRi+
         3zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4OteA4keojZHK2MF5haDWUxtIJtUSMxeYouchlVp2qA=;
        b=ttaJmNx3SIa20UlqP15pe3uaVk0gXdF54YLbDMsfIhXbyP1J42qFbUA7Oc68argxZa
         a2eLFVX2jywmENsRmxP9Sq9wTvjA0j/pFwjhTCj8MdBTyZZ8QiqnzK+bFrs8J9trG6zi
         /teKvdSaNgBNiAjGRlaZgKUnqUJ74lIcymGkqBxLSezugoXEp7DDV9QDJ+Z+BaU32/KW
         jwsiCbWGD4F7TnsHlTuNHD2ZKWp+HrHG6dEomstZr7OIco5ssHjklocJ7zKEHaA+MzDV
         AuvDDmkgzYtLsTvp4z41Mk5AFUP5lRipx40l4ZvAbkFJUzdL0OiMdM5LVqM4hiIdcnQK
         +nVg==
X-Gm-Message-State: APjAAAUVKVQswCZv4PUa6yvL4MIuIUsL4V0RMrkEKzpy0qa858awIqWN
        aELUciUt86z8/9bGBJRSXtDxRx6h
X-Google-Smtp-Source: APXvYqzQoHtrSOA5eVlo3n4Hf+QHuL+7RxhE1FMrtt8j3HSnmYA3BH3eWeWQzU9Z9zozRZuw+2Lzig==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21mr2424640pls.159.1559047679326;
        Tue, 28 May 2019 05:47:59 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id q6sm10543151pfg.7.2019.05.28.05.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:47:58 -0700 (PDT)
Date:   Tue, 28 May 2019 20:47:48 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question: devm_kfree] When should devm_kfree() be used?
Message-ID: <20190528124748.GA23945@zhanggen-UX430UQ>
References: <20190528003257.GA12065@zhanggen-UX430UQ>
 <20190528064949.GC2428@kroah.com>
 <20190528071400.GB18498@zhanggen-UX430UQ>
 <20190528124138.GA3578@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528124138.GA3578@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:41:38PM +0200, Greg KH wrote:
> No, you are not leaking any memory if you do not call that function.
> Try it and see :)
> 
> The function is there if you just want to "free the memory now!", it's
> not necessary if you return an error as when the device is removed the
> memory will be freed then (or if probe fails, depending on the code
> path.)
> 
> thanks,
> 
> greg k-h
Thanks for your patient replies, Greg. I thinks I am getting to know 
this issue.

Thanks
Gen
