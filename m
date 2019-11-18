Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A368C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D7120748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574085024;
	bh=tkzwchr8jpVR++vWA3oOBhUr6ub34Mze8RRYVaxivZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J/R3OAYwg9hlvWN6Fcjmh+8Fr+spWDVmLdpgastVcvfQ4/kiXn1Ltd8Ia3+aula2+
	 4RU+vqA+a5G7GRQ2MiTGPi0Qfw6vK+PE/Z/vUWDvBnphBTpK5ozjkxvzwRSnVUCoS7
	 pBcUS9anyX3Sn619/Wy1vzq0J/sBMWfDoVmDWV/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfKRNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:50:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38899 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfKRNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:50:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so19575129wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=12v8F/PRkzbGTRl0AiBzoPYABvSYxOjYdqftHLx6SZM=;
        b=DW0mmdA8cUnK2dAPRdOlxkqXB2vKpS8+GfGTi2UKc8VAXkFPPihnY354R7UNFf+NX0
         CTHmtz0pODgERIUFSII5RJnYgSh7QgSm/HHxiaHa2zza7rG0ALjYVVwO/BU+nIauFTbF
         +xTHEYIOiQZsUGwRMXoufcywWkviXcjcScpxMzIwBg09YTTVZSis8sznINGiqw2O6nKB
         EApP16+4bpjV1FJIPofcAFuIQQHfwcTcxWgtH92R02KB4hwv4sGu8ZK8ivp1slv4nb5y
         5ls7j6XkcbLTqKdDLRqcnFlVkZ7Ik0g7KXGXmT99zQ1RWYs5UjgpUcCkBjSBMhS/DN2n
         sn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=12v8F/PRkzbGTRl0AiBzoPYABvSYxOjYdqftHLx6SZM=;
        b=BuR+QRhFfLOfnpANr77Po0ElDaHJexmekwB6dwb+f7Pk6/TXTdgbTSCT0kbh/zvOgu
         A3aITDre5MbdagX99LpQq4IfxP+f2Ds2TbNpvv0DvqgyJCANDfeE3YMbVgjc/FiU+8iB
         +al+TE+1a0vtvh0o17V4XCWRkol2N2iJ9QqPULasAK9kL+apE2jMBs0VODWOlXM385Ak
         a/Syp4a9PJkZ6Dy9BaxAf8oUKuGixCe3G+GxSJQzMA1XhaYmTo6B8ygj7gmvuIs919uH
         7IUM+lfIVgMNcqzoPb6RwNPURcR0gt5UDOhr8xNHq/91/z4r4x7Vkk1QsQ3I5jmfogE8
         B7WA==
X-Gm-Message-State: APjAAAUK5USyhMLR3wATBl1bwr3jPWftP3Q/YlkiASAqo4Se503zg0lb
        ljftIwvxOxXQkC8h2eVO8SE=
X-Google-Smtp-Source: APXvYqznlX1ehsujpPsGb5H0/Y2O4XEuJ0VLfjAgVs5HP9VuO7ob0PsZKDt9eiX5vF3VMmKW5lqhQQ==
X-Received: by 2002:a05:6000:14e:: with SMTP id r14mr20979221wrx.165.1574085020392;
        Mon, 18 Nov 2019 05:50:20 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h205sm22059049wmf.35.2019.11.18.05.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 05:50:19 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:50:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 04/11] sched/fair: rework load_balance
Message-ID: <20191118135017.GA123637@gmail.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-5-git-send-email-vincent.guittot@linaro.org>
 <20191030154534.GJ3016@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030154534.GJ3016@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> s/groupe_type/group_type/
> 
> >  enum group_type {
> > -	group_other = 0,
> > +	group_has_spare = 0,
> > +	group_fully_busy,
> >  	group_misfit_task,
> > +	group_asym_packing,
> >  	group_imbalanced,
> > -	group_overloaded,
> > +	group_overloaded
> > +};
> > +
> 
> While not your fault, it would be nice to comment on the meaning of each
> group type. From a glance, it's not obvious to me why a misfit task should
> be a high priority to move a task than a fully_busy (but not overloaded)
> group given that moving the misfit task might make a group overloaded.

This part of your feedback should now be addressed in the scheduler tree 
via:

  a9723389cc75: sched/fair: Add comments for group_type and balancing at SD_NUMA level

> > +enum migration_type {
> > +	migrate_load = 0,
> > +	migrate_util,
> > +	migrate_task,
> > +	migrate_misfit
> >  };
> >  
> 
> Could do with a comment explaining what migration_type is for because
> the name is unhelpful. I *think* at a glance it's related to what sort
> of imbalance is being addressed which is partially addressed by the
> group_type. That understanding may change as I continue reading the series
> but now I have to figure it out which means it'll be forgotten again in
> 6 months.

Agreed. Vincent, is any patch brewing here, or should I take a stab?

Thanks,

	Ingo
