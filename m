Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D1217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="MqahV2l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbfDRRlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:41:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41486 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388579AbfDRRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:41:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id x10so2506954qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=+u8xx0kfwjOANYusi1JuAEu1J7GummvUrW8wAjhnujs=;
        b=MqahV2l7ci7bo46SESx4QtqLji3f5DTGg0MNPOWCixmmoZmrJMG05tpCmsxG/kNQbJ
         RYrYcdbAIVPnzpfTYhYBvWEAa54IC2QoYH6vzoTD9B/4WgldcGe/1mz5pCkjbnG75cS3
         l3DDome+PC0KGqhP2BXLZYXTmMP1BkJqIn2LwxR3PCrHHNE8CQ2BObpBC4IaDr8jlBhT
         PPk3k9h4usd0NSnZNAuyhgb0N0kQ/pZZo229ahgHboLN8+SFFwUK2ge4siYGnxYDXDyz
         /YZ6F7S7Qvd3/A/D5QL0D4nBhqF52es+eGo7PuAgofWt37RDSQAXCys3OWg7T4Z0EoaM
         jiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+u8xx0kfwjOANYusi1JuAEu1J7GummvUrW8wAjhnujs=;
        b=biMDXhfRQDtzCU2JgdF9uaX4vixPmOnNp1UFb4Ry8cS5Kx0nB5LLg4cK4lNsZ3eAJG
         s1EB6fo5HM0NO1Qt2pSW9TgEK0n9uw3UBRlVmcYBc/lIvAWXtkWoMwcMjj3vVQVQhluI
         PyeF+zUHBuef9s9axVRr4xsFYIMz7RTByq3EgZZTEphrz/RS8yW2an29m+WrwQLi/xyC
         dXVWAFmejslmpvZE2E1oYtv2n6MKOnPVijrX4l63xnN9BKnMOLbawt2O3ebRZ/uPlAqK
         9ytlPCLC9CQOSi2f51le7wrZJoel+YcohXj3wEWFi4PuzXH1Pob2js1YYOYqKGVm5iVZ
         jNeg==
X-Gm-Message-State: APjAAAWzmI9pOH/fruGtJicCifdWkF50krWnsqwK9xKqSMIf/XfjNidP
        5+PD2/2xwFS4jCEq0bjuaIDX7fuYWUk=
X-Google-Smtp-Source: APXvYqxPQnlrt2Krb2GlPvvw3pcbr1EU1/XdbztNCpijoFdp435Aw+mbRgqJ/YKlKF4Tbg4F8whnIg==
X-Received: by 2002:a0c:9599:: with SMTP id s25mr76423623qvs.119.1555609277722;
        Thu, 18 Apr 2019 10:41:17 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z38sm1323439qtz.13.2019.04.18.10.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 10:41:17 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:41:11 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        xdp-newbies@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        aniel@iogearbox.net, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC PATCH 3/3] net: ethernet: ti: cpsw: add XDP support
Message-ID: <20190418104111.559a0e74@cakuba.netronome.com>
In-Reply-To: <20190418094008.GB27879@khorivan>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
        <20190417174942.11811-4-ivan.khoronzhuk@linaro.org>
        <CAJpBn1y0odvL97-kP5yzKC+tN=fx178nxigfBfDwXhRhPRvDuQ@mail.gmail.com>
        <20190418094008.GB27879@khorivan>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 12:40:10 +0300, Ivan Khoronzhuk wrote:
> >work?  The stack's TX ring has a lock, and can be used from any CPU,
> >while XDP TX rings are per-PCU, no?  
> Yes and no.
> am572 has more queues then CPU num, How I can choose tx queue not based on CPU
> num? It's always shared and has to have lock, and cpdma is done in this way.

Oh, I see, you already have another lock.

> Here another thing bothering me, I send it to queue 0 always, instead of
> taking cpu num. Not sure about this, but I expect to have some tx queue
> not bind to cpu and didn't find a way it can be changed dynamically in
> redirect.

Not sure I understand :)
