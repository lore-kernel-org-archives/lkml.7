Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC6C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2482520673
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scLYmpmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDZDOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:14:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37977 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfDZDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:14:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so867781pgl.5;
        Thu, 25 Apr 2019 20:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f/vkMQfMNyY14EB7fEmlP9RksSwQM7a1FKmPIkx1Xho=;
        b=scLYmpmjxnW/wsWQBe8kSYD/40PIyRxuTfbEEXJOnZA35NLldgKIkz/Loer0mz9lgs
         cU9bFM1FirF1DmFwONnTc4/i+TrMKUs4Dj5KrB53x3876Lg4SERlBsMbBcE9fCGP9l6Q
         wck5BGiu/41d6ET8eu78tHG4xGSEwpj085sudbSF92+w6eT+YZ1j05L08/IHtmzVTlGR
         iUO9IULTd5Lz6lquPx/IJwa5wo8mgKiPa4eIP3cZx5aW9Bw828KtGjjg0DD+3HQEs0yh
         gwX/D7L99x36pPLI63nwIRk8ERTI76YPD7ykPP142HApo85d6RQEPXGpIlCDMa3ptFqQ
         nkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/vkMQfMNyY14EB7fEmlP9RksSwQM7a1FKmPIkx1Xho=;
        b=cJMwudL6VqqQsd+S7ijd5ZlwbOEZpKJBMJzjKa4rUMsCZWJhJx7dF38mQFQTO2TDiu
         IrYn9Dg5fbQFDObPjDSH2sq+kqIoVmX9VB2j4pzUUkDUpjHbPyjXamG64wWo2pv1j18v
         Cxkjo5XdyBHyg7lJXRG37JgnR9X9iPwEm7HFgIDijc2TRvVNeVMveOREUVV9pahPn5gW
         D5epD/dEQkbeZ4AnIqduVKcUIJHOACJ93V06fwh6wRjhac99y6ZwRi6BcKREWrRWFg1a
         85R2PbZPIfwtSpEQqLkbVqt3exUuqdwAY/Snu5z/joeMdIXXfC1aPCJXAX9a8q3juGcm
         5fbw==
X-Gm-Message-State: APjAAAUHisf0+OCU4SI9R7eUHBwrVmavs6vadlsC6Py/p/VTcQYm/YHj
        sRSIDXan0EHvHuvzrFDjEoM=
X-Google-Smtp-Source: APXvYqxIRejnfj7Kz4lg4HaByNh1GKBQLeGYdMqsB1Izm7o/5SnKdgCRUKFNRdiNYyjiR+NqJW2pmg==
X-Received: by 2002:a62:f24e:: with SMTP id y14mr44366448pfl.209.1556248458809;
        Thu, 25 Apr 2019 20:14:18 -0700 (PDT)
Received: from Asurada-CZ80 (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id q10sm31223778pgh.93.2019.04.25.20.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 20:14:18 -0700 (PDT)
Date:   Thu, 25 Apr 2019 20:14:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190426031413.GA2572@Asurada-CZ80>
References: <20190426130549.59f7e604@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426130549.59f7e604@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 01:05:49PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
> sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in function returning non-void [-Wreturn-type]
>  }
>  ^
> 
> Introduced by commit
> 
>   812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")

Thanks. I am submitting a fix.
