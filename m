Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3BCC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F91C204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUkhRRVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfGMGDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 02:03:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44036 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfGMGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:03:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so5462194pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 23:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQgRg0T5PdVfnE425hM/hCSmyQkNW7o2UlEkrx8jKco=;
        b=jUkhRRVrPqbfiTENoKWmRTf3OZ0c9oTwX3IQCL4AVARSk5yB9wVJGwyp9aPkf67hPu
         oAev4A3Fpl+9yaePMTVh7T5x5fjziCa8fuFkJ5HX4zoRw4H0vFacq8rivG30PbLtJE+G
         vgEEa2DY3YVxnsLEIgIslMnzDrhAkJCXpJ4jIY2aoJohr1CRJyQQlxZ5Nh1jtd+Kx3v4
         +B4EeYwRxOjLoTi9ugbNcEt/OYL878qYVCbVL2XOTt4vvpRp5eCv7EH2rfW691gnFxWS
         BvzHUMKHoAwUnyWB70SjVCDm23w9NY2UBZta/E9jYUFRQ7DbkbsCB1hXqsH/w2PCyJV1
         xfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQgRg0T5PdVfnE425hM/hCSmyQkNW7o2UlEkrx8jKco=;
        b=OQGyZt8hKtaKkK6w0bNZDkTBdSbDQDN0+G2wDQSGYN6uCxklycSBtTFGdqBQ/giBJ9
         Y0Gwf8TSE4zC7J9lFuowFYXZGpPOPyiujPi9llX8+PbQk7W0NqPaIKMfBFVs6HkN8d1Y
         S4OC6i6C/Hxrw6F41rk5zYordRE+d/Dk/XXPv5c8hxYilh5UFudzs6PaDEV30r8K8CtH
         szgiI9OgjxraNkgUUfvBZsS+C1TX4WJWMnJJGN79QzbT1QDBbMLVPnaGldVyIal/BecD
         K90ubWNmORbxkPWA1HbiAivgWfsU5kYIUX/HG2OXsGtgP7builVQQpWswRmcvf2Yh2hZ
         cJ2g==
X-Gm-Message-State: APjAAAVJ6m4Pi8ULT7LIEKBWhs5Ca+S/hzbfKBy20D6ZSLMf98dJB1/A
        kMF72SXyr7wvsEonXJaFTcWZ/JBT
X-Google-Smtp-Source: APXvYqxIDTIiPCcRJ4OhNzUxwyOYufjAvQ5hxq/4tKWI2GkMk1IsykR29xkpJUbqA5xepELpcu7sNA==
X-Received: by 2002:a63:784c:: with SMTP id t73mr15725145pgc.268.1562997798075;
        Fri, 12 Jul 2019 23:03:18 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 3sm11384614pfg.186.2019.07.12.23.03.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 23:03:17 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 13 Jul 2019 15:03:00 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Vincent Whitchurch <rabinv@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Do not lose last line in kmsg buffer dump
Message-ID: <20190713060300.GA1038@tigerII.localdomain>
References: <20190711142937.4083-1-vincent.whitchurch@axis.com>
 <20190712091251.or4bitunknzhrigf@pathway.suse.cz>
 <20190712092253.GA7922@jagdpanzerIV>
 <20190712131158.5wgy5wxjtqn6uqly@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712131158.5wgy5wxjtqn6uqly@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/12/19 15:11), Petr Mladek wrote:
> > Looks correct to me as well.
> > 
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> The patch has been committed into printk.git, branch for-5.3-fixes.
> 
> I am still a bit undecided whether to send pull request the following
> week or wait for 5.4. On one hand, it is very old bug (since 3.5).
> On the other hand, I think that it was not reported/fixed earlier
> only because it was hard to notice. And loosing the very last message
> is quite pity.

My call would be - let's wait till next merge window.

	-ss
