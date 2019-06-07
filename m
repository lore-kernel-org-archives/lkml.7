Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37820C46460
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C0F208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jO3oZfMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFGDJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:09:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45132 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfFGDJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:09:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id x7so233031plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l+eyft39Sxn5qe5vMNB20kZPpijDjrsF0Bx6tS0M+aU=;
        b=jO3oZfMykEb2BKY03jwz+kXsoHKQu8zpBv3e9ZNS7BXIyYR/sEGVEFW9rSU68Zy1ot
         IX0rtILNEioETVtdCXdqCOjaXhQ6/V04I0kMZnyT9uAFkUnJlsbn/FwJrqnKB2Os2ksT
         R53jyDqUcEUCKxZhGJVubTxckdzTThcfvDdIz0S8HBVqukvgRLaV1siEQry2y5iZQAbl
         vKBALUpv+YBPbjHlLhxwTRYoMGVBCwfChg8Ho7hryobzfamryOk1Du0IIkzBOZY3dsTX
         JnQdwsgJ42i3qYhLFbv5re2YKfUGqR+mUm+ao0AZQrauGRw39/y/oWs7VXh57ppBrbIX
         Wb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l+eyft39Sxn5qe5vMNB20kZPpijDjrsF0Bx6tS0M+aU=;
        b=PY5NpiuOwfnWGfHByh9zGtc4t03KDhma0kie9D45IKPxQfsW6wgeGS6k4+MDvCCOdE
         a48D3+kNiC5bJDb2ATWSBZblrfjgCTMfMDgGgdsR6zyS7iOsjFMafO+ADB30bdwcBjmy
         DL9NjGAnUqww44txYgknUx4L3Ks/VOVdnqLMt15K+ZsWXsGjQY5TEov328tbTAkWRMOw
         cMsta0w4W2Fqcr9luWYsKyyte1CZqZFRrcYYHGOXK7swFVHaoRRlcbplS/eUc5dGOqw/
         M/IIjOTihYEtGJAbp7OGPz89MSFlWhwOdHyiqv1dApH5nZihJtiEotbzqFqXfV9KhscT
         ba6w==
X-Gm-Message-State: APjAAAUKSMCDFkLDUydOyLN0TLPeBc7wACxi/Ilk/4RqHmTFnbcsuJ2H
        SoxP3INvoGmNiREjNQ3zOBhphw==
X-Google-Smtp-Source: APXvYqxSqWXpBXwjcMAABVRmHPcPaj26pGvwVZ6X1iptlArZMPbZRpUwdAHAy4afbL5j8QWqG+Rk4Q==
X-Received: by 2002:a17:902:15c5:: with SMTP id a5mr54260265plh.39.1559876944294;
        Thu, 06 Jun 2019 20:09:04 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id e184sm537134pfa.169.2019.06.06.20.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 20:09:03 -0700 (PDT)
Date:   Fri, 7 Jun 2019 08:39:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, linux-arm-kernel@lists.infradead.org,
        f.fainelli@gmail.com, ptesarik@suse.com, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
Message-ID: <20190607030901.qdnjj7udw7ky3sfx@vireshk-i7>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
 <20190606142255.29454-5-nsaenzjulienne@suse.de>
 <20190606170949.4A46720652@mail.kernel.org>
 <eb72a26b55cf17c29df6a7fd3c5def08182e00af.camel@suse.de>
 <20190606173609.2C3952083D@mail.kernel.org>
 <153579ddd7e6bd1e5c860a7a01115e47c78a1442.camel@suse.de>
 <20190606182335.1D15F20872@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606182335.1D15F20872@mail.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-19, 11:23, Stephen Boyd wrote:
> Yes, thanks. I see that largely follows the commit description so it
> looks OK to me.

Do you want to provide your Reviewed/Acked-by tag before I apply it ?

-- 
viresh
