Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26924CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB30D205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZj6ExCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfKDRQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:16:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45660 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfKDRQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:16:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id w11so1385289pga.12;
        Mon, 04 Nov 2019 09:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0iWNKgMiZSCkjyZ9pvOXAXMd5XlBu3bb6nEU1im0MKg=;
        b=gZj6ExCI5v/5AyMvZe38iuFqKzLeMDl5eVyobOA5lUAV0qRvKfW4baDJrFUMmE1+h9
         cj206N2VooFIbxjCjjLTMvbxUXXrm/n8hsap+yda1vmYCP0fZkr+3ma+mHaAFAw1O2Mq
         qG03YbQrFF5TE3Lzojb6XI4ms68MhTypu31TLSmimjwqcHAlVzFKgtAsQjQUM9VqbB15
         casxPEqaEDByDQUiPL4kEA7Bn5PiDaRy+bEGE2s4l6ELEwhL2JdUqseJ/A9si6M+6+SG
         tsccSmy67rp+v5P27wp7k8Pj2Xqfs5HxeHRG5eswrti/SnPAuzA10XndOGXPe0fswZU7
         YFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iWNKgMiZSCkjyZ9pvOXAXMd5XlBu3bb6nEU1im0MKg=;
        b=RH0uo4LuVf+mWJzm1RBkLU4n4ryX4uxoMsdAz3gyXv8qF68gms1elQjdeabNmmzt6F
         7XGP2QJr4HkrWXLGZ425qs+OZo+B9hHVMpOdCW7ewexwHs/QxHpD6nTYydUOxwD7Vq09
         frqAv0q/225NRIlHilN4tPizP4WbMPnVh8DyX8tdGcCAXGpVg8n/F5jF1R42nhhEBMEP
         KA8DkVCm6ijOQUnC7LmnVLBs2rrhx+0VzysfklZJg57n7rCaj9CQcd4jTF4rUDgan1mY
         Ibqf+y7krl80zCdD+vlF0b1PDmrxlZq0E1fR3I1IWDk99RjcrxChdsFup5sYxtVKxLX4
         i4lw==
X-Gm-Message-State: APjAAAVfeFA3rzR0XpRqpKUgzBnyn/Ez+wZ35z+jVTVffM4LzkgeTYkp
        eu0djl5pBZ+D5skXv6h7YfQ=
X-Google-Smtp-Source: APXvYqzOgFP05782A8U4VGLpiUo4fzWQGDXm3X/B8ePj5jvEms9PIC1wv1eYI5rlOgxotppWXJxZRQ==
X-Received: by 2002:a62:53:: with SMTP id 80mr33528484pfa.192.1572887809296;
        Mon, 04 Nov 2019 09:16:49 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.253.170])
        by smtp.gmail.com with ESMTPSA id v16sm10738482pje.1.2019.11.04.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:16:48 -0800 (PST)
Date:   Mon, 4 Nov 2019 22:46:41 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: RCU: whatisRCU: Fix formatting for
 section 2
Message-ID: <20191104171641.GA15217@workstation-kernel-dev>
References: <20191104133315.GA14499@workstation-kernel-dev>
 <20191104150328.GZ20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104150328.GZ20975@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 07:03:28AM -0800, Paul E. McKenney wrote:
> On Mon, Nov 04, 2019 at 07:03:15PM +0530, Amol Grover wrote:
> > Convert RCU API method text to sub-headings and
> > add hyperlink and superscript to 2 literary notes
> > under rcu_dereference() section
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> 
> Good stuff, but Phong Tran beat you to it.  If you are suggesting
> changes to that patch, please send a reply to her email, which
> may be found here:
> 
> https://lore.kernel.org/lkml/20191030233128.14997-1-tranmanphong@gmail.com/
> 
> There are several options for replying to this email listed at the
> bottom of that web page.
> 
> 							Thanx, Paul

Thank you Paul! And that is correct, I was suggesting changes to
that patch. However, since that patch was already integrated into
the `dev` branch, I mistakenly believed this patch could be sent
independently. Sorry for the trouble, I'll re-send the patch the
correct way.

Thank you
Amol

> 
> > ---
> >  Documentation/RCU/whatisRCU.rst | 34 +++++++++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index ae40c8bcc56c..3cf6e17d0065 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -150,6 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
> >  at the function header comments.
> >  
> >  rcu_read_lock()
> > +^^^^^^^^^^^^^^^
> >  
> >  	void rcu_read_lock(void);
> >  
> > @@ -164,6 +165,7 @@ rcu_read_lock()
> >  	longer-term references to data structures.
> >  
> >  rcu_read_unlock()
> > +^^^^^^^^^^^^^^^^^
> >  
> >  	void rcu_read_unlock(void);
> >  
> > @@ -172,6 +174,7 @@ rcu_read_unlock()
> >  	read-side critical sections may be nested and/or overlapping.
> >  
> >  synchronize_rcu()
> > +^^^^^^^^^^^^^^^^^
> >  
> >  	void synchronize_rcu(void);
> >  
> > @@ -225,6 +228,7 @@ synchronize_rcu()
> >  	checklist.txt for some approaches to limiting the update rate.
> >  
> >  rcu_assign_pointer()
> > +^^^^^^^^^^^^^^^^^^^^
> >  
> >  	void rcu_assign_pointer(p, typeof(p) v);
> >  
> > @@ -245,6 +249,7 @@ rcu_assign_pointer()
> >  	the _rcu list-manipulation primitives such as list_add_rcu().
> >  
> >  rcu_dereference()
> > +^^^^^^^^^^^^^^^^^
> >  
> >  	typeof(p) rcu_dereference(p);
> >  
> > @@ -279,8 +284,10 @@ rcu_dereference()
> >  	if an update happened while in the critical section, and incur
> >  	unnecessary overhead on Alpha CPUs.
> >  
> > +.. _back_to_1:
> > +
> >  	Note that the value returned by rcu_dereference() is valid
> > -	only within the enclosing RCU read-side critical section [1].
> > +	only within the enclosing RCU read-side critical section |cs_1|.
> >  	For example, the following is -not- legal::
> >  
> >  		rcu_read_lock();
> > @@ -298,15 +305,27 @@ rcu_dereference()
> >  	it was acquired is just as illegal as doing so with normal
> >  	locking.
> >  
> > +.. _back_to_2:
> > +
> >  	As with rcu_assign_pointer(), an important function of
> >  	rcu_dereference() is to document which pointers are protected by
> >  	RCU, in particular, flagging a pointer that is subject to changing
> >  	at any time, including immediately after the rcu_dereference().
> >  	And, again like rcu_assign_pointer(), rcu_dereference() is
> >  	typically used indirectly, via the _rcu list-manipulation
> > -	primitives, such as list_for_each_entry_rcu() [2].
> > +	primitives, such as list_for_each_entry_rcu() |entry_2|.
> > +
> > +.. |cs_1| raw:: html
> > +
> > +	<a href="#cs"><sup>[1]</sup></a>
> > +
> > +.. |entry_2| raw:: html
> >  
> > -	[1] The variant rcu_dereference_protected() can be used outside
> > +	<a href="#entry"><sup>[2]</sup></a>
> > +
> > +.. _cs:
> > +
> > +	\ :sup:`[1]`\  The variant rcu_dereference_protected() can be used outside
> >  	of an RCU read-side critical section as long as the usage is
> >  	protected by locks acquired by the update-side code.  This variant
> >  	avoids the lockdep warning that would happen when using (for
> > @@ -317,15 +336,18 @@ rcu_dereference()
> >  	a lockdep expression to indicate which locks must be acquired
> >  	by the caller. If the indicated protection is not provided,
> >  	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
> > -	and the API's code comments for more details and example usage.
> > +	and the API's code comments for more details and example usage. :ref:`back <back_to_1>`
> > +
> > +
> > +.. _entry:
> >  
> > -	[2] If the list_for_each_entry_rcu() instance might be used by
> > +	\ :sup:`[2]`\  If the list_for_each_entry_rcu() instance might be used by
> >  	update-side code as well as by RCU readers, then an additional
> >  	lockdep expression can be added to its list of arguments.
> >  	For example, given an additional "lock_is_held(&mylock)" argument,
> >  	the RCU lockdep code would complain only if this instance was
> >  	invoked outside of an RCU read-side critical section and without
> > -	the protection of mylock.
> > +	the protection of mylock. :ref:`back <back_to_2>`
> >  
> >  The following diagram shows how each API communicates among the
> >  reader, updater, and reclaimer.
> > -- 
> > 2.20.1
> > 
