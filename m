Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2731FC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2EE206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM7LQlpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLBVwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:52:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44585 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLBVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:52:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so577660plb.11;
        Mon, 02 Dec 2019 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DKQuQUQU+fWjwkzxr/9M3x6IPd20hNnMSDfxGwR3Y/4=;
        b=KM7LQlpn2KyybSGilq38mPO/47e0cUj2zVxIpZAQcdNlKSb1hktZB++pZf9yjLprnB
         bJRYb5AfPAEcrVbHx4Go25MwF5L1l6EjTJGjt81B99Te14/CfkYHQkYq8MdfSLi2U/mW
         9Vo8lJuwS9ppRGQ3Peap19A+JM096XBFLKwLFt4geV8dPyzOdRemTZHMS1uA9qyaScFc
         4U5786BkF5FUOWT6HJ+/WoLhNkg49fvFBrKJpdBmiPx0uPwowFdvD6hGaXg72N62hK1q
         DICDt89N+JhEg+s9zn2PHQnPudnLQ1KIr1kwIdOWvVpgC/iLmIWkv0D62wmj+8APIZMx
         FeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKQuQUQU+fWjwkzxr/9M3x6IPd20hNnMSDfxGwR3Y/4=;
        b=pk5nsxyzFIdP1n+tBahcBmrul6OYeb/RjY735eCFDAi4oeDYfYpHMG/z0qgs7SkA/z
         zS7XNpzBMBKvqgVjmjpaCPsGGQL+npc6vV1AbjUTF6jeDpF3+5s4TOkHSc3UrPC2/KGB
         D4GZ03V7CHL8SbLQZTUtaKQmaq+2/zGPuQSN/zgdVisiciFd0+iGM1obA/tLuo2E4dHG
         /AN3Dv9OZP36lELIqU48NEIB98GGiNhzUACxMwJyYA+7yqLfE8YqsFCsd2MyKbMduT07
         P3pz1jmORIMqwvADG3o5zNAPSTES2Z+IbVH8QF5SVkpTo3eucs+GjEYmQ2rS/ONRwMBw
         AkvQ==
X-Gm-Message-State: APjAAAVWoXsxl/5Mi5eVHcY3hGZdeAKMtBWnd1r5GWrLRP5ge+LASxPJ
        OZtB5r8ucSFqNNiBhzvZOSY=
X-Google-Smtp-Source: APXvYqyYk7B/uTbdN1PRD7srWRuJs2LVk2wDcPCLPWC8JPFAcNPmFN/GIXrqWqN2FZofn5IB1uVtFw==
X-Received: by 2002:a17:90a:a4cb:: with SMTP id l11mr1424187pjw.47.1575323560958;
        Mon, 02 Dec 2019 13:52:40 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:7624])
        by smtp.gmail.com with ESMTPSA id a25sm473564pff.50.2019.12.02.13.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 13:52:39 -0800 (PST)
Date:   Mon, 2 Dec 2019 13:52:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     tglx@linutronix.de, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: bpf and local lock
Message-ID: <20191202215237.jz7zkriantxyclj5@ast-mbp.dhcp.thefacebook.com>
References: <20191125.111433.742571582032938766.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125.111433.742571582032938766.davem@davemloft.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:14:33AM -0800, David Miller wrote:
> 
> Thomas,
> 
> I am working on eliminating the explicit softirq disables around BPF
> program invocation and replacing it with local lock usage instead.
> 
> We would really need to at least have the non-RT stubs upstream to
> propagate this cleanly, do you think this is possible?

Hi Thomas,

seconding the same question: any chance local lock api can be sent upstream
soon? If api skeleton can get in during this merge window we will have the next
bpf-next/net-next cycle to sort out details. If not the bpf+rt would need to
wait one more release. Not a big deal. Just trying to figure out a time line
when can we start working on concrete bpf+rt patches.

