Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F402077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552512558;
	bh=U1m0N2wWN5MjZTBKOMKDNXJFnaOEuCkmX2T6yTqOBvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SkeqcW+Clu7hckYg7JjZSc3sj2rVPlhvM96btYDgSsebSAghFF6xMUViA+Z/9RH9g
	 h2Z/B+Xhv+D7wTw6ePtPSOtd+e3m+XsJd/c24MPk9sopGTP5/aUErdENi1Vhf7kMAY
	 tSSgad6PxefJEZqpWfIquhRCgM1+8koAj1ikL87U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCMV3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:29:16 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:43326 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfCMV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:29:16 -0400
Received: by mail-yw1-f48.google.com with SMTP id j66so2708987ywc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0L7Tct0ie94Qimc4ysdZmwZD4KVimpBhyMQ9obMNB/0=;
        b=bWm7kAUpDA9DSGeyjB2MZpE9rUxL9/Lpk7ezR4ZTTii2x0udwnH337O8AYdhy+cAGJ
         gsEteVNO11MjA1cvZLtq9BXHUcXPIgTz+GahOFHln/GjnTNH45+kgSJgYc8okO+Rtlo8
         bkPusaLOq9ZYAwb1qGSVFdFLixHVLt4rMSweKNvEYaqnGhZ2xqPsCAQ7E/rTIMLh1Y4c
         A6g65H4OqfaCzTq6tGJXQ2h9n6fYkX7txGZGNPgF4OWJnWhD0yZj1TG6vOJ3Vj5U8JXy
         B94gQpRo9B3+NUhKaJyDUnUr5zhJa5ru4cfWt+Ojub28FM/EViKdJRUjN9rZMGuMuA8e
         f2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0L7Tct0ie94Qimc4ysdZmwZD4KVimpBhyMQ9obMNB/0=;
        b=e6AnzGOPjRICPWZeALBn5HERsK/tDohovaokXO0rVQKvRHNJAUWFhGRu4KPn64fFu3
         22mzMV3S/SLpsQSVXAw4ldDPtZBxV3Fu1fKGbd8ma4CVPrMbj7xzxIFwidv1GKkoZXMa
         bYkMbVFDk5mvTs+QNwbY2DBRA6nDzp0epkm6nmCT5dDOU9ZeRF7xBfPfqsdmSik8GDge
         3C8k+eojH6i79baKiaS1SwD44d1oPpo0EXNH+Hewo4kdUKTrjfN5KRdpJFvK7wFknieE
         bAFrfTf7b2Pz/ALU7+h0c+IB5g/59cAusXREj4uZCRFY14Gsqr8/V/k36HxEZujx5q8E
         KlYw==
X-Gm-Message-State: APjAAAUW/4ITW78xig5mnBTpfuvITrkAHqUOIlHMRJd2ZyvhRpjWCvVw
        cNy38kP+K1Nk/GGY4wA8FyI=
X-Google-Smtp-Source: APXvYqxRJ5sFn9RxlNq8UlHOBHMwnTEX3aa+/kAvFoPVMHT9PI6yNkNSBwAc0x+f+LiOpCt/e8l3XQ==
X-Received: by 2002:a25:4441:: with SMTP id r62mr22561226yba.187.1552512555541;
        Wed, 13 Mar 2019 14:29:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::90f5])
        by smtp.gmail.com with ESMTPSA id 136sm4765262ywl.109.2019.03.13.14.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 14:29:14 -0700 (PDT)
Date:   Wed, 13 Mar 2019 14:29:12 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Barret Rhoden <brho@google.com>,
        Christopher Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eial Czerwacki <eial@scalemp.com>,
        linux-kernel@vger.kernel.org, Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
Message-ID: <20190313212912.GK50184@devbig004.ftw2.facebook.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com>
 <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com>
 <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com>
 <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
 <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
 <85726648-82f3-6b6b-a749-03c4159e78f3@google.com>
 <20190313202640.GJ50184@devbig004.ftw2.facebook.com>
 <20190313212255.GY13351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313212255.GY13351@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 13, 2019 at 02:22:55PM -0700, Paul E. McKenney wrote:
> Should I define DEFINE_SRCU() and DEFINE_STATIC_SRCU() only if
> !defined(MODULE)?

Yeah, that sounds like a great idea with comments explaining why it's
like that.

Thanks.

-- 
tejun
