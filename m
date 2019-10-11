Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D744C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238521D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYC3+Ay0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfJKJAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:00:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46346 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJKJAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:00:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so10921900wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxVxglgeL3qKEjfGtgRUEcui49ts/sXRyc9+Ru8EifA=;
        b=ZYC3+Ay0TTFta5z+ySOxT1yy5LpFRPW45F3DLzdLsSnFcssZD5FOIoGQzZIffj9PRE
         Xp7tSexxRRmFAfnkZnIO/H9xELp4WVgYngxAfGg8CAkMhxaspm/T7nIm0G2TR3GBanTM
         HqldEpDOP6i/fQq5iP7PdzKUQ73+2B+htlySlLloN30Ckav9CMDVbj8L/1jq8qHlMuEz
         YSYFbHAkouAl/MqRdWYzltEq+OMpzt0VkOObZO2U4wKuaPGaxKGOQoWrgL6uV88JNJd/
         sUUF0JmM2ZIyFw0Yiq/i0uyoqVA3RTqSFnfGEK+4ptYDsw83NTiLM6z1t2Wu9kKgKTSh
         Y0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxVxglgeL3qKEjfGtgRUEcui49ts/sXRyc9+Ru8EifA=;
        b=LTyWtMeIwxUjaubJAKbdAxPJNm0D7vbkbr9KDIoubPDvaVmVSGZeLBGkzo52ss8JW6
         ++WqYZQGsIVT+lcObQtQ0/PnNplO+D2Z5yrqL+VfbDS9p5gcrEpvlPrI14frJqbm2jim
         kecI9T0FKfS88DxcAJnpKmu1rI4+A48G7NRQHdDIoF/FLbXpBzlKMxrLS+BV3BM219Of
         9730la8l/x4vICUUTUGEZqA5eqpErKcM027Mfolvs92lSbQvKZ0gNjGx0kc2n+4SGpuN
         jmsSjmHfLULh2eZoTjhRuGfuFjIdL0mR+xhg2YnAWiNSpgLRqGhiCdIH7Z9ERtnrZtqS
         d9yQ==
X-Gm-Message-State: APjAAAWjcFQCJ11bH44y9k1JzoLlf2SKlztj0hZmKrHs8aZxQkBlqcKz
        Q6bdF1tGqgjZkXNjJ9J98TFMydfc6E/DUw==
X-Google-Smtp-Source: APXvYqyR+DoSJgDCtUsig3sb1fDtuGA9PsnsC+D7kvTxXfD4QRaZRJeDBKJ/39231CiBye99kWAcyA==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr11609168wro.99.1570784397867;
        Fri, 11 Oct 2019 01:59:57 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id b186sm11494222wmd.16.2019.10.11.01.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:59:57 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:59:52 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/5] staging: octeon: remove typedef
 declaration for cvmx_wqe_t
Message-ID: <20191011085952.GA9748@wambui>
Reply-To: alpine.DEB.2.21.1910110817340.2662@hadrien
References: <cover.1570773209.git.wambui.karugax@gmail.com>
 <1b16bc880fee5711f96ed82741f8268e4dac1ae6.1570773209.git.wambui.karugax@gmail.com>
 <alpine.DEB.2.21.1910110817340.2662@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910110817340.2662@hadrien>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:18:25AM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 11 Oct 2019, Wambui Karuga wrote:
> 
> > Remove typedef declaration from struct cvmx_wqe_t in
> 
> You can remove the _t from the name as well.
Should I remove the _t from all the enums/structs?
> 
> > drivers/staging/octeon/octeon-stubs.h.
> 
> It's not really necessary to give the name of the file in the log message,
> as it can easily be seen below.
> 
> julia
> 
Okay, thought it would be clearer for the commit messages/git log.
Thanks
