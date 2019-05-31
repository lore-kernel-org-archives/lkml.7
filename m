Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E6BC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C437826351
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTxizZXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEaAoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:44:19 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:33246 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfEaAoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:44:18 -0400
Received: by mail-pl1-f169.google.com with SMTP id g21so3259305plq.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 17:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjwii2Brt6xBSvnEhlUw9zNfgBaud+bUpP81y7elYvE=;
        b=gTxizZXBja6W+65pLwkqK5NdinqbCGNOQ2cqLq+phnhxipCCbStvCBzm8gTVxhMJl4
         gb4hdeabjxPG35YWiwUM8KCuwL7WlXGBWiRVHCJ7K+/0fgiiUniJ50zU2aJwkwkN2WxZ
         Yh2kRldOVf7uxz+T3PVPsw9rD+3QidYAQX6/xdgelQyq5i7vpLJXY78Pp0ND8zvwZLo+
         QlrERKMK8lhlHnP638GJ3XiCA1vJ8EElrYSlalAu38L5p/IoNa8rdcexn7OfUT3ePz89
         HUWCtH+aCYAY11LGYjnumt/4mvovZzrzqxMXSloKiMAteN0C/4I9WgxFaiPMSYhklrNJ
         /Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjwii2Brt6xBSvnEhlUw9zNfgBaud+bUpP81y7elYvE=;
        b=OpD16mLurFO806gfGbv/YQwWOa+oxfJI/6FzkwE9It5CCnhWgcFwY/ilYJ0tBhaeZ1
         v8JiUdJDzhs+pdOUxyh+urBh4t069c5L20mmjfEUSJqL+r7ssuXugO4JifDpKXn5dNUz
         EhNia9Dg+nAqZn192hWNEk28ZopX/9wh6dLIYQO6uBY/IHOfRMbm5yJmGtxSPu8mYbNP
         c8Eirmas5IX9q+UO8gpbhgfOvWoZhf6h7rVIkkPSbUqOa9NNzk9AQnK8nQPCoVIsQNq3
         2HMFJRdZls+xEjHfQXNAJG92GUwwqJDMhQmFHcA0+CvxFeMmVnpHEnhdv9yRvB7+6k7I
         eV1Q==
X-Gm-Message-State: APjAAAUFy+BMpycaEJqES5WmuEXKf9rfz5+hwp/I6PlicLKfc22vmLwI
        FzR2K7ItbasOMEE1RVkJXgM=
X-Google-Smtp-Source: APXvYqylgEoZaxBsuYfrywx4mBS5rVGmwnIH23UDrqpIkPpDOhikd9YwQuznSYdzCo5BNwB7tyz9FQ==
X-Received: by 2002:a17:902:2d:: with SMTP id 42mr6330841pla.34.1559263458100;
        Thu, 30 May 2019 17:44:18 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id d9sm3460684pgj.34.2019.05.30.17.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:44:17 -0700 (PDT)
Date:   Fri, 31 May 2019 08:44:05 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, dm-devel@redhat.com,
        agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm-init: fix 2 incorrect use of kstrndup()
Message-ID: <20190531004405.GA3090@zhanggen-UX430UQ>
References: <20190529013320.GA3307@zhanggen-UX430UQ>
 <fcf2c3c0-e479-9e74-59d5-79cd2a0bade6@acm.org>
 <20190529152443.GA4076@zhanggen-UX430UQ>
 <20190530161103.GA30026@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530161103.GA30026@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, it should have the tags Bart suggested.
> 
> I'll take care it.
> 
> Thanks,
> Mike
Thanks for your reply, and please keep me informed if it is applied.

Thanks
Gen
