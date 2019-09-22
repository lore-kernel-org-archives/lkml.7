Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8AD208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LGqOAQrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbfIVW1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 18:27:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41983 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIVW1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 18:27:36 -0400
Received: by mail-io1-f66.google.com with SMTP id r26so28879504ioh.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hImOzMJ05KmBv4g1KzY6JsfY72PzUxGoGBvm1paBJpM=;
        b=LGqOAQrDCH7KD0IkMFNMW57vSH55x+6WbDjd+go1NQvZ9dUbZq/P8FVdunL40Hde4j
         2vjuAIMWnuCjHR4/pgoOyWvSSlh8IA/OFZnDV3Mv+7twIMdSIc1Z6X57Uj6bPn6orJuQ
         +2zQy8jS4pFoMfk9EVpO2Pgg2XN+zaNhWWaeairm6fQz0eWyUwSPTWWRiOuilW+ltgsM
         Uic0to6pKBNioMBtARf8M26aP7qmc9AqrVgQs41vDHouCR5T0fSnKnJor93xoaEP7LKw
         8r9EtllMMhHvjvK7TD93tWAZqqev2J++wziySKgO5Aj1IWl+nkOmU25P0vYlR7hzA/6q
         Ob7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hImOzMJ05KmBv4g1KzY6JsfY72PzUxGoGBvm1paBJpM=;
        b=ZquTQKHQro+/QlHKD5mcT0v1r4FbZ3eRZ/kFGGQbkQnhQJsCDn0n46yo2hffslxBOP
         SesYiP8pRTR74e+Sn1hS7Soff7ih7K9ryR4+8Al3fW5tFAwxjdFiAftpGdDzDdNSQgvy
         S5TkRzgocjAh5+4BCq15f4PoLvxUHCGv3M6xcQ1kXpGUxizD2j0065fE87jczO73pbg6
         GUD1jZqYFH68O8snvY3sG6TRNyW8uxfxPV613pCbw2QA3TiJ2lYE0OC5/PR76a5AJWA2
         HTVlEc7WGnPMsfXG5a4od7fnRxDi3Ghe+QLIpB50D7wCtEyfVSGBdn+i33Adn/eNpwyK
         uaXw==
X-Gm-Message-State: APjAAAUmlhI0j+vAEW73KZrM8F+sWwaugFUhhUGAaXpWJyAS2jMzjn6Q
        ENjDSQGso02pYR0x2LgRUJsYYl9B+x4=
X-Google-Smtp-Source: APXvYqyC8GFMaLszqNzF5bZkrveNmENlCSweZt7S0Z8Fa1QnU/6Bl4atw0oHwiEOelkywLGWoSjI5w==
X-Received: by 2002:a63:358a:: with SMTP id c132mr26480848pga.32.1569189406117;
        Sun, 22 Sep 2019 14:56:46 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id e192sm10967639pfh.83.2019.09.22.14.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 14:56:45 -0700 (PDT)
Date:   Sun, 22 Sep 2019 14:56:42 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: selftests: Flow Control test can also
 run with ASYM Pause
Message-ID: <20190922145642.55453135@cakuba.netronome.com>
In-Reply-To: <f35fa5a51f52fc1ef17a0a9ecd470e2a6792b3f8.1568887745.git.joabreu@synopsys.com>
References: <f35fa5a51f52fc1ef17a0a9ecd470e2a6792b3f8.1568887745.git.joabreu@synopsys.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 12:09:49 +0200, Jose Abreu wrote:
> The Flow Control selftest is also available with ASYM Pause. Lets add
> this check to the test and fix eventual false positive failures.
> 
> Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>

Hi Jose! 

Thanks for the patch it looks good, seems like you posted it from 
a slightly different email address than was used for signoff:

From: Jose Abreu <Jose.Abreu@synopsys.com>
vs
Signed-off-by: Jose Abreu <joabreu@synopsys.com>

Could you please fix and repost? Automation may get upset otherwise.
