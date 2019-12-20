Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D782C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D0F227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3HnJVXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLTByR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:54:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40420 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLTByR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:54:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id w21so1974525otj.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrVCaXEfHvX+lnDggpjErS+G1Eq8p2H1vH06TCxns20=;
        b=V3HnJVXX4pWRfYu8eVwKHnJhC9yVTxMJVJDqOKPc/P5GMqGPuWnmyn6WE9gBbIcvSl
         3Fb8t/ruxD0vK7dFGq9zYBu2AKNZkVHkPygHtvAu4aR6CSPyEdBZFVeKxkKzOEKJOOE/
         wbVZm5+o0FjVQI66ZX9AdYhU3jwXpTVqufrUrsdeGL7NSYRV3eB1IoV0S0SXHdvsiduk
         I4nTBAetn8sNk6ZH4oY90YZ3VZZbu2k5yHcbN9KaJa1KTf79BCSbFJr4UkLpaaM4jVKM
         /BO2c9SDbIy/e8UOFAVLVAUtSxorkSiZ1XyMA2ILg1yHHQfXv2SQQD1ladEEEgrHDo6W
         ntYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrVCaXEfHvX+lnDggpjErS+G1Eq8p2H1vH06TCxns20=;
        b=QcZYoB+wGTQcH7KAG9RGvD14P+riHJNdlIsRi3tE4GJzmSICXxJqkEkvQX4XeiGg+V
         0cVuWqplUVaHsDFOYoPVOG1NPsS+UIt2WHsVz9sbFNcwcHmg7QDo8iajOpGyc/rV3JwU
         850jngIToLMBZv8Da7fexHyjaqUeZL+KZcwQE3mCnQ3ozRdtPeDPT//ir2p8ExUd9i+A
         NYX2p0Kmzqpsb9kbEOEyVZLQWZhnCqUv1zEvkKWpILywAv3CwfGV0PDOr1jJBbjAXHLK
         FjxUcaIgblovofIM8C2t+BwIE0SwiU1k1+vk8163q55YpYdvbU107laq2rv3mxJ0kWsG
         txvA==
X-Gm-Message-State: APjAAAX/kZGHGNH6azT4eztKHpPHAFmnmpUMX+qZzkRG3g+IaLQmIf/c
        xA61pwu7eXkSLlMJwfPxBkFLjdKGpCwBCteSZp72xw==
X-Google-Smtp-Source: APXvYqwF8LUcvERTD8QoVWU4AMTDQhIYbphG5FT7NUrQIS8O0ugVQZbqMOXtfj6JIBssVng0vq1ZBpif6Z9b794FiJE=
X-Received: by 2002:a05:6830:10d5:: with SMTP id z21mr12550357oto.30.1576806856088;
 Thu, 19 Dec 2019 17:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20191219223834.233692-1-shakeelb@google.com> <1da649da-6527-d4c2-7d12-40126856ae75@intel.com>
In-Reply-To: <1da649da-6527-d4c2-7d12-40126856ae75@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Dec 2019 17:54:05 -0800
Message-ID: <CALvZod7zi+t9A=4_L-iiD3JhFpGU0Jt-=Q1_ee=7=7KAUMykVA@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: Fix potential memory leak
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 3:27 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Shakeel,
>
> On 12/19/2019 2:38 PM, Shakeel Butt wrote:
> > The set_cache_qos_cfg() is leaking memory when the given level is not
> > RDT_RESOURCE_L3 or RDT_RESOURCE_L2. Fix that.
>
> I think it would be valuable to those considering whether they need to
> backport to know that RDT_RESOURCE_L3 and RDT_RESOURCE_L2 are currently
> the only possible levels with which this function is called. It is thus
> not currently possible for this leak to occur. Indeed a valuable safety
> to add in case this code may change in the future. Thank you very much.
>

Do you want me to add that info the commit and resend the v2 of the patch?
