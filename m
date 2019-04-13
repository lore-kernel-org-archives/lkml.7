Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3029AC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D8420869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 01:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEg9kkhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDMBrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 21:47:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44064 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfDMBrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 21:47:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id i21so9497128oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJ6vgr19aFDh/LmrmlazKv6OS8jUUfAfcII11TY4ZGI=;
        b=tEg9kkhH2/zP8WDNoLuFzLephtJm+P6MXVIUVbcFjHQh5VC9Xw/yoSR+G6HkGkHVmz
         ECYyl65DP1AcCNbO6lxmevdKVUaAozq6ZDJabAjx1vdPdMlqWAwFxwkqVIJN0WI440Wv
         VBvU0tp0fNz6CRnJrysIPEpP2Fd55hk5aWvSAU71H2yNvYwagdIxNihXtzzw6HO7L9Ag
         53ikRJ5EvACgJdbeqLfCcqFxU2573cSxiA3RuWwF7Wy1+nVHf4TzH5Z21OlRX5bcBA3p
         X/sUqTjPIifnCcmhZylIFkmasBmumT9mNt3fglbs6s+zRN8olnjO9njSUauFsShoaw3m
         RQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=nJ6vgr19aFDh/LmrmlazKv6OS8jUUfAfcII11TY4ZGI=;
        b=lUirCCEazyLRpwfx0xdkEvlbYyttp91UeM9b42Aha3J7XMCyJNzOXg4lZhLsrw7+1h
         pF1dLKruvUne55DE44r/X2JnkAYrZt4+HDYZHJ6ivVgbkiCmc3KEbtfvGSGn5QEYknMh
         00RTaJayKfi3zYKiyawsnYPzyejGX0GmjccuzOjQhb/BYveeFmFoMKn3kuBY5Iatjtlg
         pdL21FJt+AG6MOkaBoY7tmuKXkZQ2RkRgzLMWyRlVpn46xBdgeeMDLQS786GcVegN2Q+
         3CG97GBX/xxNmu8RcXL3MCfLi/LdiLLCnXqHA8yZ1+HjdablLR4kypA+laKcobTrXBMm
         JpxA==
X-Gm-Message-State: APjAAAUac8PNAXy+Zf6Zn2brENV9rGB5r+b0edCIY4K9UfKLgqjkBPqi
        l9e7Cn/PVOHedMM0O8OtgFGwECc=
X-Google-Smtp-Source: APXvYqwFCG0RUFDHNQSbeyi2YB6AeiuGKqFp3/xobkUft3ntpFGfcdera2D7DnK44fYynNCswb6bag==
X-Received: by 2002:aca:4b03:: with SMTP id y3mr2316359oia.21.1555120041035;
        Fri, 12 Apr 2019 18:47:21 -0700 (PDT)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id m124sm17402749oia.3.2019.04.12.18.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 18:47:20 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id A8B071800CE;
        Sat, 13 Apr 2019 01:47:19 +0000 (UTC)
Date:   Fri, 12 Apr 2019 20:47:17 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] what's struct ipmi_file_private ->file for?
Message-ID: <20190413014717.GJ25132@minyard.net>
Reply-To: minyard@acm.org
References: <20190413004757.GM2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413004757.GM2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:47:57AM +0100, Al Viro wrote:
> 	AFAICS, nothing has ever used that; am I, by any
> chance, missing some nasty macros in there?  Just curious...

I'm not sure why it's there, but it's been there since 2003 when
the driver was first added.  I've queued a patch to remove it.

Thanks,

-corey
