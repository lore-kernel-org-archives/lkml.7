Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4008C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADF12073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkuE3yuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfHBFDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:03:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46233 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfHBFDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:03:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so16388635pgk.13;
        Thu, 01 Aug 2019 22:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PLsx/4tn1KtP1jYMaN33B6Oq9wyWpKhmw6fy97XSp7Q=;
        b=TkuE3yuzGt58MAj2g0b9+TEZYDKQ5B0CtD4Z/w+cOGpWu3CxLZT7bAijxRoRH55NqA
         ZACsCOjyEyHorztntjV/PF9wpawc5ofE67ZFDXSbQT4N8W4S01I7kZ9wogzMlSN0ZZXk
         ZgrvWXMtzBUzGnDsaWsHNXDNgmYVLI1NQSg0czgPrBzokvm7WBwo7mSpKnYCeSB2XO4z
         n8fc8V5s7UpXNJ4dq5a71JHBBAeQ1sYBuZfOedKauU398Biwl8ya0Mlyg25bT+QiJPEP
         Bw1gm6NMpjSt9CfleE5g63njrFVHcC9nYm2M4ZhhUNkH6aLdibamnLc1vhcWa+u8cOkr
         XYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PLsx/4tn1KtP1jYMaN33B6Oq9wyWpKhmw6fy97XSp7Q=;
        b=FvNmexNdbQzpsuYVFy5JmeHPigQTT2QcfhFFT2z/eN+6x6jld+nA8+uYzH7mEKUSN9
         a+lOh6Nvn47RmGFOC/1LEHAKrGNOuTp9q//XN08naM4GaQf4DawwE0bg6WUHWCnE/xGE
         NIWgDu8LjgFzt0982j/+lGRGKHXjD210Lj6+QOcAnifGk55vYKt7N/Pb/ZVxae788ILD
         yRqNIw1+nz3lfUSAaiWX0vZ6pTXYns5xcWF+b+ZEqqUTwbSu2rgu4vSiiZ6g4btSTrGR
         WwMRZaaVRJbiBA4kY1PBukDvuPMzDbpf/Jt9cM4+NsFY9W/4Dp+QxeU4EYWaSXGVluRP
         GZOw==
X-Gm-Message-State: APjAAAUj1YrpC8lrs5n9nBUTrXXuqChXWbpDuHI1JqPSQQsmfiPFQTNt
        S4pFwlX28w7nkMJXjvSK17g=
X-Google-Smtp-Source: APXvYqxvaxTQu4MapFsaY7OEEournyukc7qIz8j4d9yHlwAR6d+6iOboTRELkhHyATur6jTL/w0QVw==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr2364646pjb.37.1564722224831;
        Thu, 01 Aug 2019 22:03:44 -0700 (PDT)
Received: from [192.168.1.4] (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id s66sm77417263pfs.8.2019.08.01.22.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 22:03:44 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
X-Google-Original-From: Mark Balantzyan <mbalantz@exun.local>
Date:   Thu, 1 Aug 2019 22:03:39 -0700 (PDT)
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Mark Balantzyan <mbalant3@gmail.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] watchdog: alim1535: Rewriting of alim1535 to use
 watchdog subsystem
In-Reply-To: <7e17ddd7-e304-67f0-836c-8ba71c5a6778@roeck-us.net>
Message-ID: <alpine.OSX.2.21.1908012203130.6581@exun.local>
References: <20190802032655.54758-1-mbalant3@gmail.com> <7e17ddd7-e304-67f0-836c-8ba71c5a6778@roeck-us.net>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see: https://lkml.org/lkml/2019/8/2/6

Thank you.

