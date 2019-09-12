Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29855C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E891620830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568322432;
	bh=Lgis+9hFoiXbbOOLmZpgaKI9VUofhTFxMgS0J7r9uVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lE1jzg/Br07XsYZI5xgA++EgQolcV5wzrqqh+xibMx4hq2qgNTtwzyjlI5nz3ZAxj
	 XgkFo4jCaLtiZ7jlepQ7hugM01brV9oqkzMbmAPRIo2eOleurcg4P0d72A3rIY+TDU
	 ANNkorTN6EeC0wAiYbkys/qzPh8Jf35I5gICVZl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfILVHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:07:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41151 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbfILVHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:07:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id j10so31309002qtp.8;
        Thu, 12 Sep 2019 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7nk601YqWAtG+BppI4tPpvttoWT+EaLudF5cFheh38=;
        b=FFrASHQ44NekZUkiYiULB1yPlB5ZHs24EM0JoHbNeivI71UUrRKiW7ppZWKGBNPied
         bzaKmz3jiSogA89RTsOOM9yLSPbJdX53Q1ggBRuLI8J4vtgOH27Qn8kLNr3Su6q0qaHa
         /Gg/NSSaXimEYmKsUqxvPxqilpVF/IF22Fn7CHrzY1gv8Fl/H0yEciDTs6kAAQkOfoxb
         jn8svAHdBHjlfYE2+CRHkdsk7YIhf3XxLBNXtbCw/o5aNFPbKFaAx5CClXf1bF1FbFKO
         bbvAYhE2Yo9NQ73feXQDui0ZKhOtbOKAWhakkZem//Q2Qr2bmCKCtTp/uS7rOaBdYmUd
         NPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7nk601YqWAtG+BppI4tPpvttoWT+EaLudF5cFheh38=;
        b=f61hvR97lUsams3h1F6xCmopO6jCWgCaFHxlzN2qvpU4a6QM84mBE/NncxFgbzWgWi
         WlbmLNhIrTJHwyz0dGvkNc3yPXgljgRMI+aKLnpQ+iPzswyZZ3iruv/rchX25ItEKiKf
         kNAXrvEMv34jPGMrcA/spnvVBWEJbveo6ln0iu8VM+J23OdImtoxqc0LLRKw+8ehCWkx
         hTdELUxyk6shNTuSvjeEXqu3niQc8AlB/ddfjqKzrLCMEkfnCxgY6Kxl163ZstuQA3gL
         Wcz4nnKYwDpfVw6UJejRW2RbuBv7zjcTu6FeamuzQwp2igTi1OX0k/qM8srXgmMo60FC
         /C8A==
X-Gm-Message-State: APjAAAVyE2n5huPov1bJW9T0BTBSJg4srlJ37sso1oevIhYWNgqcaf1n
        GDMHpxoQNosfDaIhXt87NiQ=
X-Google-Smtp-Source: APXvYqzqDBM8p56umtip5kV+4PDLCzJ17NXK8g2F1/hqe2gU67FhacZkiwCPsMnhQXSzwgnqnNIyzg==
X-Received: by 2002:ac8:700d:: with SMTP id x13mr20754210qtm.25.1568322429671;
        Thu, 12 Sep 2019 14:07:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::12af])
        by smtp.gmail.com with ESMTPSA id 194sm1352297qkm.62.2019.09.12.14.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 14:07:08 -0700 (PDT)
Date:   Thu, 12 Sep 2019 14:07:05 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Mark Crossen <mcrossen@fb.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup: freezer: fix frozen state inheritance
Message-ID: <20190912210705.GA3084169@devbig004.ftw2.facebook.com>
References: <20190912175645.2841713-1-guro@fb.com>
 <20190912175645.2841713-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912175645.2841713-2-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied 1-2 to cgroup/for-5.3-fixes.

Thanks.

-- 
tejun
