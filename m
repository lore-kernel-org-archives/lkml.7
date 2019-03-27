Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E28C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D21217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLOoBW5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfC0RxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:53:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42648 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfC0RxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:53:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id v22so15200919lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ks3fxtSZlKQBgoNpjVRc6wQA+v4+teq/lZyU60c9fgs=;
        b=eLOoBW5UMJhFDLnE2Ewwwpd7w0Rtp0wnCJjFCKo+vUMzMMSKHxY4cvi5p6d56CRiGa
         XKrPjhwovTqyEFre4dQKU5SU0lwypKMRKbjASXQPnyTFUB0yVPurpXPXVendAztwqYbV
         jzP1iM0kFugJB4/VILYoD40P3R7Kfmv4lN1twMnwqO0OGt7JG3mmujOW+vQy93iDTqZM
         BlZvAaWZqBlPoia8jtd8rkCxjC2aOemSuNAzByuXZ8kowtfsM3hol+p8nkoEtjanwSTf
         uCnm5FdfT6j/ZxeOZ/LPHbjaklYCQ0X/7+VNJK/r1l3OD+BHio+qyhk6uh3IEtaVU1za
         RRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ks3fxtSZlKQBgoNpjVRc6wQA+v4+teq/lZyU60c9fgs=;
        b=I9tNGnaTTOqOa+1Og7AO7SZ/Baha1REMXqw+6dCn7KE9ifj5X/UxNQ+C8RGB8O5NHj
         z3iMRk+8SNF4M/u1iu5f0kSCTRAitSK2yt1ClciSbabZoq6tgyzouAGRhVn9xFAMEvZe
         g3xQu5l1d2gOS7imjWuvDw5o+xEKn/Wcu3UCM2dD4uksmUHeZHKtPHumPYqvurc4COR4
         IsEyRjAZ7mI8zrj564Ct97vvQBDQizGgBNio1+5IS2lQ4dztif1DugO2aVarafLKEAEI
         8FuGY+cz+mAgeGrknC26kJo1gUQOwxZ7flks3GIWr/NHmdDchUiK6HyjR8metuJvvjKG
         R3dg==
X-Gm-Message-State: APjAAAXu9p5qqxctrL3wKh3bDBCnHSlhqOmIpGnUlGeefpGCLiLTlUXQ
        2REqwYxSQABcPWUg442ryvc=
X-Google-Smtp-Source: APXvYqy4ZHvhmz7Fjg7AKYQv+qcVHXUb1EiQdhUrRCZ1a8JBPr2TYyQmUddYr3/ObIP+g6KX3QxbQg==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr11239277ljg.93.1553709184278;
        Wed, 27 Mar 2019 10:53:04 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id q2sm4627322lfj.58.2019.03.27.10.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 10:53:03 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 27 Mar 2019 18:52:56 +0100
To:     Roman Gushchin <guro@fb.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 1/1] mm/vmap: keep track of free blocks for vmap
 allocation
Message-ID: <20190327175256.stktpllvub7s6lwx@pc636>
References: <20190321190327.11813-1-urezki@gmail.com>
 <20190321190327.11813-2-urezki@gmail.com>
 <20190322215413.GA15943@tower.DHCP.thefacebook.com>
 <20190325172010.q343626klaozjtg4@pc636>
 <20190326145153.r7y3llwtvqsg4r2s@pc636>
 <20190327004130.GA31035@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327004130.GA31035@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman.

> 
> Hello, Uladzislau!
> 
> Yeah, the version above looks much simpler!
> Looking forward for the next version of the patchset.
> 
> Thanks!
Will upload it soon.

Thanks!

--
Vlad Rezki
