Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FDC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD8A20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mre2L5rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDALD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:03:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42132 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDALD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:03:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22so3031546lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiCiS1Zhnbd3fQPNfsi5vJTpnrNw+zSlVcGSn/ESGsI=;
        b=mre2L5rxLZz9BI69ewP/lJ+Cmz8RPbAJDgXxv5x964fEb/LWlH16VYXblgie+iMRf+
         lHBL+6e6AcBNQxg1PiH8xJduAztSln6xOZgEeMDmvlcYv0Pvn5r+Oe+vPTNhIvj8b3+y
         ralhDrCyq7Bnr6MK0PfJvrVeh+6edaXJI/9DMLltCoL04YmCETBWGki8vs/VXPSyYvAa
         HYKVUhX1pDOCzdQXLFHt+7vAH0GmxZluA/jLWl9VbTPtdeOYoEqgX3C7uVAkyvTM3xyn
         fPSWtfvOxwwd/bVIAIM4PFeuCqiFFEhO9Gaf7E4LkfRUBnFuw7yrQjdYuhjL8VrSUcN0
         Lv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiCiS1Zhnbd3fQPNfsi5vJTpnrNw+zSlVcGSn/ESGsI=;
        b=PHMmBuEW4vPxV+zNY5kc+ojAliAvMfiqaytqW9tUWTr721pRrjnh0vuSavX6oAT9yu
         n43IXHx6Q5HG86BhzY/yEa0UkTyeJDz65tx7yCB3AsMLpEka5QrNJxWXh4by52Zkheus
         CL/X+CHFBLr4D150UDdNcv6gwuqWHlnmUwTvzaetsIINVL+ATog5GQVKN6pFvwjNyvH2
         gV5+VlZJ07nPZqNIOdFwThREcAN97O8elis9h9fv/aweM0zevNcuIixO7SZiuNUXK1LJ
         cPbY7CLH6FuiDcUctt7v6Q7xkA17Kx6fDwUSVRbphbkENu3SAs8r65+5/cDGrpfJ4D4x
         swFw==
X-Gm-Message-State: APjAAAVuMsz4k/5FRfYx5i2dz7rCRBdurPWcI8RuGKGAqlmqZ4/LwE89
        +IKRNhpU9NdRNlZJuInurmCRjLLPi1Q=
X-Google-Smtp-Source: APXvYqzqm+A6vWviSeMyVdsq3PTk8FVZSVOOR+xTIUZVf2V1/IpJfx46V0LxrOwPJU9Jy4R7E4pFYg==
X-Received: by 2002:a2e:96cb:: with SMTP id d11mr9047927ljj.157.1554116634897;
        Mon, 01 Apr 2019 04:03:54 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id w19sm1334465lfe.23.2019.04.01.04.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 04:03:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 1 Apr 2019 13:03:47 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 0/1] improve vmap allocation
Message-ID: <20190401110347.aby2v6tvqfvhyupf@pc636>
References: <20190321190327.11813-1-urezki@gmail.com>
 <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

>
> It's a lot of new code. I t looks decent and I'll toss it in there for
> further testing.  Hopefully someone will be able to find the time for a
> detailed review.
> 
I have got some proposals and comments about simplifying the code a bit.
So i am about to upload the v3 for further review. I see that your commit
message includes whole details and explanation:

http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/commit/?id=b6ac5ca4c512094f217a8140edeea17e6621b2ad

Should i base on and keep it in v3?

Thank you in advance!

--
Vlad Rezki
