Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDF520851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="a/y7lS55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCGPkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:40:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46633 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCGPke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:40:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so11701921pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qnglpDXP6LMI8XwQg2EEpR4hqD6rquMvzppPijm7Fk=;
        b=a/y7lS55fuDHwUA8MekGZGHhgDL/PB3T12RZaNiZwCoy1iGI3dQmVyMcmdGv2PznFS
         SBuI/djzFwzyTlx73N/cyAPsrWB2tSFdsf3ycDltNTqERX37CJZY9EU5JgRTK1LMafX1
         GGqsr2+Tvu/YFf1O/roJxdbGePGeCsHmyzy/KqahJBZKkGm8TvZMzCPsh61mwAxt7eZu
         Hoi4V9AeTbOmsGzqy7yy4Ye2T+HXysL5+woS9wP2LLRPul3XG+y+/81bQhm2xqEqm3yS
         tUMI4H4+yxETo2nCi7QOeFQBO4xumvAcG5uYQA0IogPYB+rGruuDT3vB5xqJ8YVUL7EB
         n/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qnglpDXP6LMI8XwQg2EEpR4hqD6rquMvzppPijm7Fk=;
        b=qqvuj5J24K2QflQfTxUjIxfR4zCUNw/G3Hz/ecrsOWCXnKuIlrlMqypndyES2o9Ena
         BGYt78cSf7eLq+yJWHjaQYDzsnKE8m/aL9hO5u2Ous6xa48I3RcTKNQKG7tGEuL2BdW7
         QulI5gZ/g5N3s/3ekej4BAGLOk9Ff3icc0q1sPZkZo7hmgdu5rRVVC2859qSaF+BKrfh
         uUO1WoCfAW3YiQH2rAs+IFGX4Znt/CCM9R/bTbqATPafKNV1RUD76GqfESFatQHOBHmG
         Zl2jcIS61EiHVETuY1xDGFFp21+9PJZKJYs082ceG+RDgCsY2P6XMK9o1c0i8yNpRoNy
         ZUqA==
X-Gm-Message-State: APjAAAW3+dSDMCec+qWMaHmWPW8AR0BbNlj2PEOzWrPk1a7ocEMckEbY
        oE562fgDyn2jSsguzvrYWsR5iw==
X-Google-Smtp-Source: APXvYqx7qAS/CjVObUKOP0BvztCNQ201sB4rDR1H2CEdEMye/3slTIgcRp+PDGAk7JM1w3rtj6dhfQ==
X-Received: by 2002:a62:ab04:: with SMTP id p4mr13341557pff.142.1551973233549;
        Thu, 07 Mar 2019 07:40:33 -0800 (PST)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id g28sm9548763pgb.45.2019.03.07.07.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 07:40:33 -0800 (PST)
Date:   Thu, 7 Mar 2019 07:40:29 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz
Subject: Re: [PATCH 1/2] ipmr: Make cache queue length configurable
Message-ID: <20190307074029.3f1f0c28@shemminger-XPS-13-9360>
In-Reply-To: <20190306201956.30248-2-brodie.greenfield@alliedtelesis.co.nz>
References: <20190306201956.30248-1-brodie.greenfield@alliedtelesis.co.nz>
        <20190306201956.30248-2-brodie.greenfield@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 09:19:55 +1300
Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz> wrote:

> +ip_mr_cache_queue_length - INTEGER
> +	Limit the number of multicast packets we can have in the queue to be
> +	resolved.
> +	Bear in mind that when an unresolved multicast packet is received,
> +	there is an O(n) traversal of the queue. This should be considered
> +	if increasing.
> +

Why not make it to a unsigned value? A negative value doesn't make
much sense here.

Although other sysctl values date back to a time when Linux was
sloppy about allowing negative values, it would be good to use unsigned
now.
