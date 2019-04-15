Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D47C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244FE218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrlP/nXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfDOR7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:59:16 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:39271 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfDOR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:59:14 -0400
Received: by mail-qt1-f174.google.com with SMTP id t28so20202515qte.6;
        Mon, 15 Apr 2019 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iUbNRqXkA2hYDBip+liV2zR/eZgstbN0Rd5XbstZ9Bc=;
        b=XrlP/nXtgc0mpm+HAKIMzWshnbS4iDrSJT1QxioOyIeRINBX7k35/+iykP6uP2r1QZ
         E1dUBarzGdMElPhmt7DZRgcZ5UF2MO9st3nDj12XHt/9ZDudalkasLk6fHKuzMlpToI0
         WtTG8NhgVd09K1OdMHaeqx6J1Ks9YBA4mKhYzHttY3lasUZZmhr9S4CWw2xZXYFG7o2m
         mqINdka8V2G4PdRPmbayr/Zxvb1xXTst/vnWLTHSdRlWqI9vWMQo3H3zlQLmgpN4NdOq
         3pWGaoH4jZgy7w2wReIbFmyZxeaGHE7yCHIrrV5JxAmpJOkKb9YeZ6o0xRgXr15zCEdB
         BHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iUbNRqXkA2hYDBip+liV2zR/eZgstbN0Rd5XbstZ9Bc=;
        b=kQEAs7sLbW0ZQerbtMW59UvCIjdx8New2yTqDt8fbHfkGfJHJymTgUrze/jYr0kPZZ
         gHuD9ktjbVVHtPFUr/uxGSRDOwuaF+CIUCEXnzfmsWrqclPkEgZ7onvEv2r6wMQqDQ0w
         IESYAhjdK3YPCSJpAMq8Up0aQvqvbqrtl4P3Y3y+jG1ibzUH3o5rMwc3B1RsF7ZvHBMz
         ghtFW8khAGTfCPOkA9cC4U0A/1dbIsMLcyNakNn0FZheeUTytvlfn8YXbB4Q+O/C3Abs
         irwCEzEtOuHO6MGwS6iyZIUKh+GtD8sJrZL/c+vsx5Hf1Pvmi4Put2T+cqFoEVw+U9aR
         EKug==
X-Gm-Message-State: APjAAAXSe2Fk+lfc8eXcZEYGgtlh9wJc0iHxcrwhb9sCRyx0esd5sJXn
        ZZY9OMBO9i+Oja20mqIRmU8=
X-Google-Smtp-Source: APXvYqyBBubcfYyk/wegcfOGgqaWNWAyImssms8Z8PF8aPqKgKqwG82Sk2FmQx8HU597GKKDDRqxjQ==
X-Received: by 2002:ac8:2f4a:: with SMTP id k10mr64641508qta.208.1555351152372;
        Mon, 15 Apr 2019 10:59:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id p27sm30894604qte.25.2019.04.15.10.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 10:59:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A0B54039C; Mon, 15 Apr 2019 14:59:07 -0300 (-03)
Date:   Mon, 15 Apr 2019 14:59:07 -0300
To:     Paul Clarke <pc@us.ibm.com>
Cc:     Linhaifeng <haifeng.lin@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: perf tools:Is there any tools to found out the max latency by
 irq or cpu idle
Message-ID: <20190415175907.GC11294@kernel.org>
References: <4099DE2E54AFAD489356C6C9161D53339591D64A@DGGEML502-MBX.china.huawei.com>
 <8ce8c596-123e-1342-5ccc-06a5fd8a60ec@redhat.com>
 <4099DE2E54AFAD489356C6C9161D53339591DE6D@DGGEML502-MBX.china.huawei.com>
 <6e6a98a4-a442-1e10-cf5a-56b6792d42ba@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e6a98a4-a442-1e10-cf5a-56b6792d42ba@us.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 15, 2019 at 07:52:59AM -0500, Paul Clarke escreveu:
> On 4/13/19 1:01 AM, Linhaifeng wrote:
> > Sorry, the value 131081408 is just for example. Actually the result is like this:
> >  sqrt 2019-04-10 23:53:50: 43968
> >  sqrt 2019-04-10 23:53:51: 44060
> >  sqrt 2019-04-10 23:53:52: 49012
> >  sqrt 2019-04-10 23:53:53: 38172
> >  sqrt 2019-04-10 23:53:54: 131081408
> >  sqrt 2019-04-10 23:53:55: 43600
> >  sqrt 2019-04-10 23:53:56: 46704
> >  sqrt 2019-04-10 23:53:57: 46880
> >  sqrt 2019-04-10 23:53:58: 44332
> >  ……
> >  sqrt 2019-04-10 02:17:15: 136345876
> >  ……
> >  sqrt 2019-04-10 04:40:35: 136335644
> >  ……
> 
> Given the periodicity, I'm wondering if it could be System Management Interrupts (SMIs)?
> 
> If so, some BIOSes have settings to mitigate, otherwise, there's not much that can be done, per my understanding.

[root@quaco perf]# perf list smi

List of pre-defined events (to be used in -e):

  msr/smi/                                           [Kernel PMU event]

  sunrpc:xprt_transmit                               [Tracepoint event]
  tcp:tcp_retransmit_skb                             [Tracepoint event]
  tcp:tcp_retransmit_synack                          [Tracepoint event]

  sdt_qemu:qmp_block_job_dismiss                     [SDT event]
  sdt_qemu:qmp_job_dismiss                           [SDT event]

Metric Groups:

[root@quaco perf]#

Here, using it:

[root@quaco perf]# perf stat -I 1000 -e msr/smi/
#           time             counts unit events
     1.000919819                  0      msr/smi/                 
     2.001689950                  0      msr/smi/                 
     3.002266988                  0      msr/smi/                 
     4.003049439                 16      msr/smi/                 
     5.003676064                  0      msr/smi/                 
     6.004420613                 16      msr/smi/                 
^C     6.609405666                  0      msr/smi/                 

[root@quaco perf]# 


In this Lenovo T480s I generate SMIs by pressing the mute button :-)

- Arnaldo
