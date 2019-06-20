Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D20C20679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561039806;
	bh=In4iPzMtA12SlLlIsTZg3dyDk6G1l8NLDcEXnix/BLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dG6FdXkxEaZfwQgiAjrgytqFZdyUc3BvlcmufefmRxErIygpydyQNf7H1VsXOusA6
	 9u3DTdwKmW+VAdZc6Mj2rX58PyfLIiEBGbZJchsPgMKTthfuyxUfShIh8aNn1mVOLb
	 xvvnBbqREaFoyff1oKhT7XmHKRZI/lhaFgmUaOrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfFTOKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:10:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33809 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so1763472pfc.1;
        Thu, 20 Jun 2019 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCea24nGIZCu7ydKVsC+l/7geTYb5i00s0rd6yWS+Lo=;
        b=IWe8EDOoK2wLDjqbj0Q5/jydeaDsHVyB9wekftRSAfWJT9rXjLQbWXWfgQVqkmTAON
         Pkh5w12/Qbk8ywybCXAes9aRTnj0/CVDTJlOHgtFSaObrK8Tg+iWLnl+xP6E6P70ZyU0
         NUvXvIJkgxm1DNoPCrYGWXkyzEzgeNWmuUpLXvwJBOPSNAtsKdp4Cyv4ujTrWU+ns7ag
         +FvvsUK/Fx3fOzQQ0TGFCKqtZm8XxmiYQ1AFK5ZhnyOMtdBaTECVvndIgna8S0cKxUZh
         DOnco2bN23vOj+4CqKWqGno7Ka9gU24ZMgOxJKyap/SHvXiRoR2ydSewJmFHRYEe2kTW
         4nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCea24nGIZCu7ydKVsC+l/7geTYb5i00s0rd6yWS+Lo=;
        b=ZiA+kS+eCTd8SUnE4iZsghJtRWF0TqE82pNwMO6tzTFz41C+yErzJ4veFRJNuWgvJr
         P7kjpGL5gImh/ktfKG3zo+GD28PAHh7Ej1UnWDN7MIehOAtriUheIf6huqyD+osB581j
         kN4ECfL1wTJpl1LdEejnmZqiLnJtBojwOUE2rf8mL855xi6zCTmbIU8f7GKaGkahd0Mg
         9o0MFX/qTR8YmXUM9IfzmfwhdlQ+Ri3dlza9o4JYB4uNHn4uWDV6JV4SwzMg2ynzVn0m
         TkwVrLipXfQphAjZyNdnWGCXxl9alyoQCsCQyPD5uo32kAfNPC007T089sdpu2uxO154
         mcrA==
X-Gm-Message-State: APjAAAXUpspHkdJs/O6UCiFxGMYm8vC3IU3KFdgw6jak5mtnW+CVJZeu
        XfTBGveGrB6G5lhnyaw3TmCQqdy6mJE=
X-Google-Smtp-Source: APXvYqxNob875mJkUZ2u3rUWNFdkn3jBRyn2WGNqnLD+JtO5vQY5bk0YhhB3Uo3P1Dr8kFVmA+R10Q==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr3334565pjn.134.1561039803189;
        Thu, 20 Jun 2019 07:10:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:a5e4])
        by smtp.gmail.com with ESMTPSA id d132sm23393702pfd.61.2019.06.20.07.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 07:10:02 -0700 (PDT)
Date:   Thu, 20 Jun 2019 07:10:00 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oneukum@suse.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] deadlock with flush_work() in UAS
Message-ID: <20190620140937.GJ657710@devbig004.ftw2.facebook.com>
References: <1560871774.3184.16.camel@suse.com>
 <Pine.LNX.4.44L0.1906181156370.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906181156370.1659-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 18, 2019 at 11:59:39AM -0400, Alan Stern wrote:
> > > Even if you disagree, perhaps we should have a global workqueue with a
> > > permanently set noio flag.  It could be shared among multiple drivers
> > > such as uas and the hub driver for purposes like this.  (In fact, the 
> > > hub driver already has its own dedicated workqueue.)
> > 
> > That is a good idea. But does UAS need WQ_MEM_RECLAIM?
> 
> These are good questions, and I don't have the answers.  Perhaps Tejun 
> or someone else on LKML can help.

Any device which may host a filesystem or swap needs to use
WQ_MEM_RECLAIM workqueues on anything which may be used during normal
IOs including e.g. error handling which may be invoked.  One
WQ_MEM_RECLAIM workqueue guarantees one level of concurrency for all
its tasks regardless of memory situation, so as long as there's no
interdependence between work items, the workqueue can be shared.

Thanks.

-- 
tejun
