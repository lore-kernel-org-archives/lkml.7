Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E20C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A94206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLsqUiP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfDCFHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:07:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33734 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfDCFHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:07:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so5534426plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vzp3n6uryNztVCaQLKpnML2kS9F5n5mFa9SP/GPpQa0=;
        b=pLsqUiP9jFfXMoXaQRc51fT5fGRUrrmdFjvNHIUyXXrf9861DiSSP8+udOWgUyXoT2
         V3wNfoAUcECaWTLFMEV2xlIh2xMJcBCujLEJoPmLA9Zi4wHai6aOdnmk4Nct6IX0NQx4
         AxLof7OiEZs6aZDpE/u7HXv99aK5SDAy/ZT9qq0DsdJQZeu8P91KivbqnIIwXMOSaJQq
         VPDzhPUOpo8B/Kob8S+K5kiKi4Up/VE/4jlLgawa0zRcqPuR8ARJFaFqgmPB4B31tmYS
         JdD9MMrqrPb4hYu+uhZ+9fxw0KRiSRpom0dAF/4T+Lvm0eMteJQqCryCyc/Chqi1Aor1
         XwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vzp3n6uryNztVCaQLKpnML2kS9F5n5mFa9SP/GPpQa0=;
        b=Q6lCevSu4Ts0B7hqh7ukm9XQWudjrMWEEvoY3FJB6VqMo7lC822o8SmjkjJKtyKFZR
         EYVqjqfn7nF5wzxOCJlDUU5gpNimwZKaDmkx6L0/FpmgvSL4L/6xb/CRq1L49bFwp+yy
         qn5GCK0wLMg4aLwt2IELWD3h8g4UhenDmiBUXu7p0Bq5IhNvYlAa+6CScMYP56soBB/t
         kI09pzzPMMMWsUgdbIUFJLewDcqr/K3vT/pD9RieKIhT4LnNGUDsBRwdWluJDMm4gUY9
         QApNORGB1jEjMQSkZMpTU8vhrvEWcGUbZWgPfYjavp8/wGf+b9U5taTZ0zrV9Xgi7V+h
         2Ecg==
X-Gm-Message-State: APjAAAUBhmPVX4tzQHok7JR6W+0ZPcos4+sZoe1U2U4zkXnNEPrBNUc/
        lKFWmymOSvdWCUOXgrRc2izWbw==
X-Google-Smtp-Source: APXvYqwhVEDSiMsOki7aoV3tKnB4jUmTSNW/16gAzsqGLFUcYdFAmKhp3ByDND1e2qvdrlZ/64wIFw==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr59607758plo.279.1554268019510;
        Tue, 02 Apr 2019 22:06:59 -0700 (PDT)
Received: from [10.71.9.192] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id 13sm18450626pfi.172.2019.04.02.22.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 22:06:58 -0700 (PDT)
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bo YU <tsu.yubo@gmail.com>
References: <20190403145609.6eda97b6@canb.auug.org.au>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b5e42db8-a873-5667-f179-78cadf5b2bf5@linaro.org>
Date:   Wed, 3 Apr 2019 06:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403145609.6eda97b6@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/04/2019 04:56, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>    drivers/misc/fastrpc.c
> 
> between commit:
> 
>    01b76c32e3f3 ("misc: fastrpc: add checked value for dma_set_mask")
> 
> from the char-misc.current tree and commit:
> 
>    977e6c8d1d18 ("misc: fastrpc: use correct spinlock variant")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
Greg did request Bo YU to rebase this patch on top of char-misc tree.

That would be a real fix for this conflict, until then this fixup should 
work.

--srini
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
