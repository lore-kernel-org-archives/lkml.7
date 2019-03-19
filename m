Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E59C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02972075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWCZLoCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfCSTxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:53:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35741 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCSTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:53:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id t13so201428lji.2;
        Tue, 19 Mar 2019 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zXtxPJ87/33goR16DjapW/V5zlkg6yHkG2KpYXdA1cc=;
        b=PWCZLoCO1JRGPaMmL2DpJUT8bAhdH6zh77mnH3obdppAdBdC0h8D+fybL2HCw+ziii
         XyfDjzRVsoBeSqI9M4JvxHuNcEJ8l4GGEN4pMFizKqKvOZ1nKSQFd46aZdgHQHuyCqos
         n8XlN+Gn5NS/JyvwtI5dZqoOTs4xSAONVj2Y2O15WweVMRl7kM/KwI/h+LEs8xe4XSwF
         gpF1Mzqk+UBR1BlBbp/l4taDHDV1tErASwMMrSCLU3P+FPAdpOZuy4KrnXKsK3YtfedV
         qZFC1aeKb2332u2jSJCwfjktaWjtn22cHRf+kvyC7ELnf0dsyCTWWCm9lUM3scNjxruv
         uuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXtxPJ87/33goR16DjapW/V5zlkg6yHkG2KpYXdA1cc=;
        b=HiKXKHn/PKxvqNnq5OLF82RIV2KX/TTQnp/nSIRguWSRF+FwiYNrXlt4VfWLYCfhhv
         bF3LZIWFG3iNaxEuCCqdIdBfZ8AK++QLc4O5pRsezf3T0zFvpIAP7YBziaIHA7DixXNx
         cReSs12FaPjbC+MRcNH6cJ+7u8cE1pWN5SRp3QuU7y97vANRGYM8U83QgDSCTFqzXFl+
         1uBPDuHqmKt34maxfVnUlRxrcBp/R9rdtjXFwIBQxN7XPhaL53TaHKnaLim7I66GUKpa
         3Mg3rpG1+1Y6PT2PTrugmajoyww8REdxfP5ZvXFQN+Ep3xd8AD9GbYzz8zG55x0xG3Hd
         3Aiw==
X-Gm-Message-State: APjAAAXqVyaJfA0/nvXMK7EVRiMM8RpJI8JEf0MjDKAqb9SLH1RbR6lv
        V8B4XkI/Tz1+pXU+rp2QkwE=
X-Google-Smtp-Source: APXvYqwofBm+X2TxrEHDwdYnvtHjFg0YLQofDaeCm+39pcB4Yn32iUgNrJFs8kYYhKiKE8BOGRqdkg==
X-Received: by 2002:a2e:9086:: with SMTP id l6mr14691193ljg.190.1553025223139;
        Tue, 19 Mar 2019 12:53:43 -0700 (PDT)
Received: from [192.168.1.18] (dma160.neoplus.adsl.tpnet.pl. [83.24.56.160])
        by smtp.gmail.com with ESMTPSA id j23sm2887915lfb.17.2019.03.19.12.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:53:42 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the leds tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
References: <20190319135833.64ad30b8@canb.auug.org.au>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <33578161-eed4-3f19-5fcb-09e4b400dd18@gmail.com>
Date:   Tue, 19 Mar 2019 20:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319135833.64ad30b8@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for the report.

On 3/19/19 3:58 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the leds tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/leds/leds-pca9532.c: In function 'pca9532_probe':
> drivers/leds/leds-pca9532.c:536:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>     devid = (int)of_id->data;
>             ^

Applied the fixup to the original commit, which missed to carry
the cast properly from the previous state of code.

-               devid = (int)of_id->data;
+               devid = (int)(uintptr_t) of_id->data;


> Introduced by commit
> 
>    6b788fae618c ("leds: fix a potential NULL pointer dereference")
> 

-- 
Best regards,
Jacek Anaszewski
