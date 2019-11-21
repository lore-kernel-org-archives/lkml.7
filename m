Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB4C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E381020855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="useGTkdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUMAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:00:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56211 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfKUMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:00:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so3394745wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 04:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WrOuxnJH8z2LEEHoE05aukaO/S+sx3wY2zDdww+CY48=;
        b=useGTkdN0kfUCxBWV9RVjDP3oiQcR9V49e5HKxDCuTBBzMhtkSB2nI8wDmoBr/mW5C
         TmjYUmPWezdDw1B7n9ApPP3cbiai0aK1FGpiJQ9nrn7kl4UvBKRRk2+m7AK6y31zYgnl
         CRPNmwxP72YZVNHYWVGbx0FIdi2nQVraF1Xlhb6mlI4s3S/sDN9uH6nVW/GXf1OG1j1F
         VGf/ecBKNX0K+1Z+bhPP4m5vrgU27NHp9nlLc/+Vmlfp2OQg6/Cwr+jOTJsGr64cHWkx
         CrGus92zgDlOnt9XyXmo1rsgznb7U7KdED2CxhPMvmJLgjqBZKpFTmU5PYu5YnfKm/Fu
         S4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WrOuxnJH8z2LEEHoE05aukaO/S+sx3wY2zDdww+CY48=;
        b=VSSggUUr7vVpAB1UGU0rpLxd96nGxyM0NxDZEz+8LwizrTG+pr6/icq2hg1LapvL0T
         0vkBeJ7DisWyhxtFj81/df+xIEqpIwr8z0K2jO4q0gZuivkBjRcnhDa5PIERyAEDDv3g
         t0aqDAYBl86GiB0AwchBIW5nvmJmRjkXNiOBd5SvNbHvJQIlgyi3fTmViYyvRG03BZOb
         CZfnySLGR1t6zgpFhgzVdCnt97gvuhfyUmwwQ7S290z1TYGW3lBE7irrooMoLDKZOJ/v
         FXCFyW3wv/es8a1P2yeuOEna6oZ2gLrOvTYx4Q2Go4u3FYLRsP8qKrRqHPkJ3fIB2Brc
         HE0A==
X-Gm-Message-State: APjAAAWMQJeJcwxkfnwwFlEejHmZNfTMib4fcNpgKaYqJKbf7IGF0lLM
        91azCCLv2pgO+OLiGAvRVWef9I1rhOw=
X-Google-Smtp-Source: APXvYqyM6C2IJRK4LboK981iYVXOFrMvxJ76CqD2oSxC4D3XEox98MQP5yp44ZaKWEXezC3rVNyY8A==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr9577217wme.152.1574337617994;
        Thu, 21 Nov 2019 04:00:17 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id j7sm3289396wro.54.2019.11.21.04.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 04:00:17 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:00:14 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 0/3] sched/fair: Task placement biasing using uclamp
Message-ID: <20191121120014.GA214532@google.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120175533.4672-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 Nov 2019 at 17:55:30 (+0000), Valentin Schneider wrote:
> While uclamp restrictions currently only impacts schedutil's frequency
> selection, it would make sense to also let it impact CPU selection in
> asymmetric topologies. This would let us steer specific tasks towards
> certain CPU capacities regardless of their actual utilization - I give a
> few examples in patch 3.
> 
> The first two patches are just paving the way for the meat of the thing
> which is in patch 3.

This makes sense, and is in line with what Qais proposed for RT I think.
So, with the nit applied to patch 3:

  Reviewed-by: Quentin Perret <qperret@google.com>

Thanks!
Quentin
