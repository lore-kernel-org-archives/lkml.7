Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46ACC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7B3206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgqIdL6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLHGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:06:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46444 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:06:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so12641606pfc.13;
        Mon, 11 Nov 2019 23:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ql1jIUeiY1C+T9LmSMtc8/U6bCDKCcN1H4rKQhpHe/0=;
        b=GgqIdL6fGJCr52h3bBiwOZ91GQso8g/u0NSxUoU843cCxITwTIK4te7Kg45C0R79bi
         lcuGiZB+F+5cn0xci/il1FZ8VFTE0SpXvbFxA1qnlwb+7k3AGfpBZVq2147wAZIic4Td
         qOr5ui7JVwZQGCO3zOmv5vQu3blUPI29tuAEjAuCRo9J33o1ZfzN3N4+CYxkG3khT720
         LuxsauggumYUcqoAFrRtFEuQqiSEshgoN8QN4gwkMydeEKpXJ5LqOly5p1oG5bN+DTFT
         HxT1ODX/G9efYmZqd6bpOCCPYJ9Kos+r85/e+pc77jqRBcxNSB2N8rLqSyElxw8CpGJa
         dZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ql1jIUeiY1C+T9LmSMtc8/U6bCDKCcN1H4rKQhpHe/0=;
        b=s7BMn9kUPbzi1GvytqPq2ext4hJkabOU5r7wSx+p7n026k86MQrjw6aPQnRjZkSIi8
         FSolYLSvE7OOKFwBw5pMN9+s7CmuRkNv36yKIZqrPBSTl1rnij0AiiH+7KD+pVcCU/HB
         3bH/T6Zre1h67tSxyoCMxRfc8i5OYzDeZbf6tMpgH7iR2S00EM0AS7eLjn0gE3bTlaLB
         fONqYhwEKlEKG2NtzEBWqYDWkU2ca6pJcUxI0jN3c8DtiXGRrjmthk0kuh5CDw0vREWx
         JHSgFIWadmPTNIYEZYLJM4yOnkiB7ARn9H+sGPyBBmgdgcN6qSQboyBaED4LvcdDRzRO
         F/cg==
X-Gm-Message-State: APjAAAVPYKe6V0dlCueSjx/zsrEHlfk1TV73MnJIUMPxaKioA1jGVfK5
        DYVwInxW33WU7W7mfQsa30gJAOfzPLKoPQ==
X-Google-Smtp-Source: APXvYqwsbPm6gC6wIu0VgkQMTf+DYXTY585sOnUoaTQ6eOTwS/0nh5E9s5+rfZdvUBr0QuyW9Kj2qw==
X-Received: by 2002:a17:90b:4386:: with SMTP id in6mr4396434pjb.33.1573542404409;
        Mon, 11 Nov 2019 23:06:44 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.252.152])
        by smtp.gmail.com with ESMTPSA id x2sm23519376pfj.90.2019.11.11.23.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 23:06:43 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:36:38 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik04@gmail.com, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        joel@joelfernandes.org, mchehab@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: RCU: whatisRCU:
 Updated full list of RCU API
Message-ID: <20191112070638.GA2561@workstation-kernel-dev>
References: <20191111181122.28083-1-madhuparnabhowmik04@gmail.com>
 <20191111213659.GP2865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111213659.GP2865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 01:36:59PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 11, 2019 at 11:41:22PM +0530, madhuparnabhowmik04@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > 
> > This patch updates the list of RCU API in whatisRCU.rst.
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> Queued, thank you!  Phong, Amol, could you please take a look at this?

Tested-by: Amol Grover <frextrite@gmail.com>

Thanks
Amol

> 
> 						Thanx, Paul
> 
> > ---
> >  Documentation/RCU/whatisRCU.rst | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index 2f6f6ebbc8b0..c7f147b8034f 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -884,11 +884,14 @@ in docbook.  Here is the list, by category.
> >  RCU list traversal::
> >  
> >  	list_entry_rcu
> > +	list_entry_lockless
> >  	list_first_entry_rcu
> >  	list_next_rcu
> >  	list_for_each_entry_rcu
> >  	list_for_each_entry_continue_rcu
> >  	list_for_each_entry_from_rcu
> > +	list_first_or_null_rcu
> > +	list_next_or_null_rcu
> >  	hlist_first_rcu
> >  	hlist_next_rcu
> >  	hlist_pprev_rcu
> > @@ -902,7 +905,7 @@ RCU list traversal::
> >  	hlist_bl_first_rcu
> >  	hlist_bl_for_each_entry_rcu
> >  
> > -RCU pointer/list udate::
> > +RCU pointer/list update::
> >  
> >  	rcu_assign_pointer
> >  	list_add_rcu
> > @@ -912,10 +915,12 @@ RCU pointer/list udate::
> >  	hlist_add_behind_rcu
> >  	hlist_add_before_rcu
> >  	hlist_add_head_rcu
> > +	hlist_add_tail_rcu
> >  	hlist_del_rcu
> >  	hlist_del_init_rcu
> >  	hlist_replace_rcu
> > -	list_splice_init_rcu()
> > +	list_splice_init_rcu
> > +	list_splice_tail_init_rcu
> >  	hlist_nulls_del_init_rcu
> >  	hlist_nulls_del_rcu
> >  	hlist_nulls_add_head_rcu
> > -- 
> > 2.17.1
> > 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
