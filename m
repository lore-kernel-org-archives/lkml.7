Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAD8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679B3229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erRAqgFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfGZKKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:10:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45493 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZKKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:10:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so39900665oib.12;
        Fri, 26 Jul 2019 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mCOemuW7OeSOeQ+Uqij0MoIKzzoDy+1eNdkZPdSVP54=;
        b=erRAqgFmX6IHm2FHcpL4kWfXxdwp3wr1aRpmssGeodkNKtm4UsrzE8xeqlm+TW9Wfo
         mjl9wEDRfLOUvAajobERMrV9nPA7I2GTo9C3ztvQx1Biyl12kKbWCAcHCZ0yqncoiGZ0
         JhfR6UeXc81ZENnCtFt7IQM2jIplDg3tbo6nrbFiKzB4wtHhN+eKpGoJ84VzJURKYxu2
         nwhvthWL5AL5Wg1M8ZsVoMWjnLsO06X4jzY0T5tghLkIhN/2Ac0DRBItCzpi4JLMlxiO
         uZ3tEidM6Qmg6/zdCgWSp57Lzdff9vIHCxatfKw268Ha1FTaJa597PbqrUTPL4WiWJpb
         99UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCOemuW7OeSOeQ+Uqij0MoIKzzoDy+1eNdkZPdSVP54=;
        b=tno0xkdsKlzD35MtYKZe4bcPnEr+m+AtrCafeuW/6PdU9eQpuZN0lEhiXsKnhW9ivG
         UQyKTFNcuhSELR3fpfYSBK9mDUixta8/mTKmUFdSuc4fZIvCSMwTqibQ0oI1YSjhzMBn
         5YvqrX5h1hB2xs7QNf/Qnovhr+wJ9QFmAHAxzdvX1IsgwkAyCAGFctWGjl0KEVuW+CQV
         gZr9SWcHx1+oe+gFvn2DqzCo6hIp2gz7498rAqpLkzBrlBOdaaowyOrKo3Bhj7CPTZZk
         tEL9rWPy+7ufmQW9xQW388w+0wL80jORl96SPnZlQziAr8et9bUbVrOpiNs3A7h+NJwN
         0Y2Q==
X-Gm-Message-State: APjAAAXL9wn9PSnsVSbeV77CX3hUTgKGsABDHVpby0UNodLjRdYe+VmH
        8zH+QMDtpTuX0PwgMH6cRwAR6miGGg==
X-Google-Smtp-Source: APXvYqy/af14xV8MrqcJedO7vWz5UcJLfvWlOZ6LLT0eX0/kcVOqNpzCMsX7qgAp2J1ae0+q0b0YoQ==
X-Received: by 2002:aca:2b10:: with SMTP id i16mr41898155oik.42.1564135819659;
        Fri, 26 Jul 2019 03:10:19 -0700 (PDT)
Received: from ubuntu (99-149-127-125.lightspeed.rlghnc.sbcglobal.net. [99.149.127.125])
        by smtp.gmail.com with ESMTPSA id p126sm17820827oia.10.2019.07.26.03.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 03:10:18 -0700 (PDT)
Date:   Fri, 26 Jul 2019 06:10:09 -0400
From:   Stephen Suryaputra <ssuryaextr@gmail.com>
To:     Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Cc:     davem@davemloft.net, stephen@networkplumber.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz
Subject: Re: [PATCH 1/2] ipmr: Make cache queue length configurable
Message-ID: <20190726101009.GA2657@ubuntu>
References: <20190725204230.12229-1-brodie.greenfield@alliedtelesis.co.nz>
 <20190725204230.12229-2-brodie.greenfield@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725204230.12229-2-brodie.greenfield@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:42:29AM +1200, Brodie Greenfield wrote:
> We want to be able to keep more spaces available in our queue for
> processing incoming multicast traffic (adding (S,G) entries) - this lets
> us learn more groups faster, rather than dropping them at this stage.
> 
> Signed-off-by: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>

Our system can use this. The patch applied cleanly to my net-next
sandbox. Thank you.

Reviewed-by: Stephen Suryaputra <ssuryaextr@gmail.com>
