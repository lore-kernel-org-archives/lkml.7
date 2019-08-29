Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EA2C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8842D215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="B7vedP+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH2N7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:59:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42444 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfH2N7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:59:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so1607133plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=40EqMQd0G4SVbrZfGPeA5SE4upLhPO04pKe2ongbivs=;
        b=B7vedP+381Vda1eCJ1DpCKGye34MvOP4SaLRfcWFXrezjckDaL2DCJkysvbc5x6x9K
         5ZHaAq8dolDDtXD5Emsjg2p4yLOStQjh6ER9RX2SxOPJPrpxQ9KcL7NtxmBaNUHUfkqr
         9SWPCrsL1tOOGwTXDBiFQSW/yOhdLnH2Y9d3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=40EqMQd0G4SVbrZfGPeA5SE4upLhPO04pKe2ongbivs=;
        b=JwMsukQQhlFnt/YsGx16J/jy4tWIf5Xngqskg4Afm1yGRBjWE/QtHifsxyoIApaWSA
         UOVgBJ10LKjSE4XwZS5gBOr62H7KHJfM5hkww1nvZ5cPmPCHfjtwN8Ghoouv7uZVHZ13
         8t+Fb3rfxjHhjdFfHOeYpdtD/WPMpaP0XFosN0Sf9ekebugy5SsAVSJT9arUpwyyxOJx
         XQpC4mFtWU8b/qsz0R6WG+204xQIb/L5GuWK16jT35VRXw4nqhWmlEoICW5jRfCOkFOw
         ZQP8nd4QyyBjg2tjgwTTL9sQ+y6Oh16xIomzVVKkbXOHk7mtw3TbP6onVDIw8eBftpFr
         g/Dw==
X-Gm-Message-State: APjAAAWDO6XhXJOv1xlktEBNIrvoovu7C16EmoeXs7duw50oR964hPju
        bBud4TSECtbrK9Bff5cR0wu3OA==
X-Google-Smtp-Source: APXvYqyN3H4PkVt4D8iZLYVpLv8rCMjL0d2y1VW3RXuJ+ApI39d4sYSpewllOECHNz60vokFKp1bBQ==
X-Received: by 2002:a17:902:223:: with SMTP id 32mr10245894plc.220.1567087149497;
        Thu, 29 Aug 2019 06:59:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id dw7sm2200431pjb.21.2019.08.29.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 06:59:08 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:59:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190829135907.GC63638@google.com>
References: <5d648897.1c69fb81.5e60a.fc70@mx.google.com>
 <20190828202330.GS26530@linux.ibm.com>
 <20190828210525.GB75931@google.com>
 <20190828211904.GX26530@linux.ibm.com>
 <20190828214241.GD75931@google.com>
 <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829034336.GD4125@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:43:36PM -0700, Paul E. McKenney wrote:
[snip] 
> On the tracing patch...  That patch might be a good idea regardless,
> but I bet that the reason that you felt the sudden need for it was due
> to the loss of information in your eventual ->dynticks_nesting field.
> After all, the value 0x1 might be an interrupt from idle, or it might
> just as easily be a task running in the kernel at process level.

True, however what really triggered me to do it was the existing code which
does not distinguish between entry/exit from USER and IDLE.

> The reason the patch might nevertheless be a good idea is that redundant
> information can be helpful when debugging.  Especially when debugging
> new architecture-specific code, which is when RCU's dyntick-idle warnings
> tend to find bugs.

Sure, and also that it is more readable to ordinary human beings than "++="
and "--=" :-D.

thanks,

 - Joel

