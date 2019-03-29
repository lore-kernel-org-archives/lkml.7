Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702872184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quldYy1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfC2O4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:56:51 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:33867 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2O4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:56:51 -0400
Received: by mail-qk1-f178.google.com with SMTP id n68so1538591qka.1;
        Fri, 29 Mar 2019 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZiap2M1AhC+zxtLX15mX+0/Aulk8UbPSdrxx5k/4zs=;
        b=quldYy1H+e12vPz7T+EbcZ9xYhjVxREhF9aniL85fH5oup1L3MQRlN7/GHilRCXfR4
         Aet2WzdOq/yWoO+SefNJiSJ1pbquvWc2P0bHrxUDIqpJnNvnsqpsRqv86+AfxyfjSUTo
         wBsEznijWifKZ/tTfCpCQ93R/37dmgtb7KAgU461VRYs8eNtMiqF+ZJ6WTZtDv6A9FBS
         X+qTaZK1lD2CvycoJ8u1fSc+0uxjsFL4vliwMfSZ7akq9KnpOaocpLw+NZ/e5xLeW9aD
         0dq20IPT72D9tzbHJA04LuetHhpvhkhmQ8P9+G0EDdu6v2qlpCmocWzqZDlwn/RNAyh9
         7TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZiap2M1AhC+zxtLX15mX+0/Aulk8UbPSdrxx5k/4zs=;
        b=MyA2AJmSo3dPdQBzPwsaD05O897rlnoQs5xT1CWPk5SY201awKs1zIhSkA6HCanHE7
         4VQKReLLCUW9O/t7nxh2cXjBXRDFjseuf663IIGbHEJwnoGKhOxxl8t9bslCkPzw+ZDO
         52bosuJ6BBCOwgoq8QDp6MHqyRlb+82xLVAmiGScYgNEBJHlrTZLEtX1xoWtGJrnAspw
         z9W/wL2aQiek9rpaGPwulOAsv5O69RzlZDStKIH7dZYlYqOBf4RIYFz6mLwaNxtCbPup
         Juxt7s2DDE5oAzw54zC7lI4QLN6OFkIMSv49qb7T3P6zXWYcKv6yO4+ZRTAe/NjkVf2a
         apTg==
X-Gm-Message-State: APjAAAU8GVydLusCUfJ6QXm9RwzleEK3g6P+jd1foE4NIAQ9xbbmBLRL
        JPhJ8kkP9udscvr5qphmyGM=
X-Google-Smtp-Source: APXvYqwmLiNG2aXb7Sg9W38TkoTbh3xOhHrjlqdSKq1oKi6knfhRHefuJVMvAUZQs8SvXA+rcfgH/Q==
X-Received: by 2002:a37:4f45:: with SMTP id d66mr17022397qkb.170.1553871409756;
        Fri, 29 Mar 2019 07:56:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id n24sm1574313qtc.21.2019.03.29.07.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:56:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 306934039C; Fri, 29 Mar 2019 11:56:45 -0300 (-03)
Date:   Fri, 29 Mar 2019 11:56:45 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf/list: Fix s390 counter long description for
 L1D_RO_EXCL_WRITES
Message-ID: <20190329145645.GA32495@kernel.org>
References: <20190329133337.60255-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329133337.60255-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 29, 2019 at 02:33:37PM +0100, Thomas Richter escreveu:
> Command
>   # ./perf list --long-desc pmu
> lists the long description of the available counters. For counter
> named L1D_RO_EXCL_WRITES on machine types 3906 and 3907 the long
> description contains the counter number 'Counter:128 Name:'
> prefix. This is wrong.
> 
> The fix changes the description text and removes this prefix.

Thanks, applied.

- Arnaldo
