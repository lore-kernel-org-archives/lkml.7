Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8390AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9A321019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU8Tgobs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCQLp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:45:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33874 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfCQLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:45:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so9484404pgq.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 04:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z4n40todjnRTIKKAQMQrSnVYr/XVFE5DONB9mPbKH1c=;
        b=EU8Tgobso16FRAwci8WBT25GRkmg52LrRuBBlFi1LlmfuOO7oYO7cvVoFFc5Al1St3
         RVmA2Ibnztp5PE1ALjBwmFCwjOdi2zwFbLcxC+J1C30NB/yoRhJdFwcYOfdcCE1XPm5R
         cDuxAm+dpe8A0Drtm65mtWARTM0vYLxH71VrA7MduQiJTdCp1Rv1RebotmsY9p4M9Wq1
         1SLRdDW5TpMGfg57cacsUqKm6VY/o82YCoV4hkYuJUcgXinDgfjD7oeH59w3DR990kqg
         oJuMM8gsh3Zmp+OoCFqNondg9GxZuf01nagMbTDIetIqmazQCoeW0pAnnbGFPVg7GQmn
         xfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4n40todjnRTIKKAQMQrSnVYr/XVFE5DONB9mPbKH1c=;
        b=CqOno3gmmMzAmj6HrPvEeHUE3uBHyCWByd9mHadere0v529M1y3NyBis+JTXwQr1a6
         Fi+8MfMiL717/ZWemVnsaHD/3wcLXHZR6RsPox34wlQ1sG7GbXfp9AENpnM8GdAyc2iK
         56y/NGdOL+n6J94QRPwr1B6bnatBrbHcnCc8+63g7j0PEr0sPy4b/qrDuVQDrOkf5qjf
         qLAnY1RyKEivGAo65pxZicQh4uG+7uHPLuzjv8lPPSB3ZEvzHCSj8V/mEG0Uey4Jj/5S
         26ex/rDs3BCeCILqLeQLmBjt3F0ris+5ay31E74FBjuhs+UvkclsrWZL3tjsugbqGw71
         8GoQ==
X-Gm-Message-State: APjAAAXnAVWCB0LBmc3Un4FcUVWLfei9zQaFKmYmjN+Gk5RaIPqMXO0W
        0Gx5HRaE8rVrzWyzQL4dHf8=
X-Google-Smtp-Source: APXvYqwiMmjZ3411Wo5Tl5KxaXn3DQH1XVXyxOZeTckHyfopLdulKXgb+0YIVOWBZPUUl23TLfKVKA==
X-Received: by 2002:aa7:854d:: with SMTP id y13mr13699850pfn.175.1552823156905;
        Sun, 17 Mar 2019 04:45:56 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id j12sm2077091pfa.33.2019.03.17.04.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 04:45:56 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 17 Mar 2019 20:45:46 +0900
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        devel@driverdev.osuosl.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: do not use __constant_cpu_to_le16
Message-ID: <20190317114546.GA20365@tigerII.localdomain>
References: <20190314083155.23164-1-sergey.senozhatsky@gmail.com>
 <20190317112829.GI4614@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317112829.GI4614@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/17/19 12:28), Greg Kroah-Hartman wrote:
> On Thu, Mar 14, 2019 at 05:31:55PM +0900, Sergey Senozhatsky wrote:
> > A trivial patch.
> 
> No need to put this in the changelog text at all.
> 
> Please fix up and resend.

OK.

	-ss
