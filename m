Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51363217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GPtdwf0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfC2Eqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:46:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40947 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfC2Eqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:46:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so440885pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 21:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aGE+rNDsRy/rFAu+iSL9yJvymTxn2x/oeXkSrAHDaGg=;
        b=GPtdwf0wu56ceA4MtaJdr4WZsKF9nSYMHV4GxfI+fXQP7vXGxbfJgtsFHgjR/Ka+x7
         fnfTb0DVQ91DZuqaRu92QPkMIZNEdQRzYP8tmVLI/bd+wZ3lsH7FyjDZkyXstvnNQNKt
         6jRF4zMkyVIZegKEDZSKcajwiOAeeqoII/saE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGE+rNDsRy/rFAu+iSL9yJvymTxn2x/oeXkSrAHDaGg=;
        b=b5ggLStycas3s68Erl7oxIHEQ8Qd/rNxsnc6vgF/VjDqbS/DCtncLiEcnN/RgzBrGB
         95q/LHENGR0Q+ahz9iKnwtpAfw3z1Vl5soZxRg1/N3xkWz4815aW0ShRDZrAG6oyow3k
         nOMqY434mIlMvB69c8Np2Ym4sObHGDMRtyjXHZijEhbhnuUJrx7Ck3+hVn2RiiSggXkc
         JEQ7h3PX0ebVh+f3q+ujY/KM2I1YtOcxYhmXJ0sDAKV7052HrwXTykMyf8rAXy8g2BZq
         emQRGDrkwnVwuml2vM3k00U2RPMs19PNkFY8Q7FiT86MochhgD2BAIfOsYrc5as+GA0T
         XdPQ==
X-Gm-Message-State: APjAAAUIrhcG8SQiZ2MvdmlcCU1OoMgIZ9aj+q4RabxzTZX95A0PyzGc
        egQucEbXAV0KDPYmXmk/4/hqxA==
X-Google-Smtp-Source: APXvYqy9rgnzOaMOKiXP3sDP/bXGxipWOp3di5oUZZ4bsPrLveyGN8n+4jVukkkeB36nlOw9fbpuuw==
X-Received: by 2002:a65:60ca:: with SMTP id r10mr43932713pgv.429.1553834791096;
        Thu, 28 Mar 2019 21:46:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z6sm1072733pfz.65.2019.03.28.21.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 21:46:30 -0700 (PDT)
Date:   Fri, 29 Mar 2019 00:46:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] doc/rcuref: Document real world examples in kernel
Message-ID: <20190329044629.GA234754@google.com>
References: <20190329024047.206989-1-joel@joelfernandes.org>
 <CAG48ez1DrHKG2PoQjdpc=vT55enaRgQpGfAwo5ujV25TLHJL0g@mail.gmail.com>
 <20190329044405.GA229534@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329044405.GA229534@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 12:44:05AM -0400, Joel Fernandes wrote:
> On Fri, Mar 29, 2019 at 05:06:21AM +0100, Jann Horn wrote:
> > On Fri, Mar 29, 2019 at 3:40 AM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > > Document similar real world examples in the kernel corresponding to the
> > > second and third code snippets. Also correct an issue in
> > > release_referenced() in the code snippet example.
> > >
> > > Cc: oleg@redhat.com
> > > Cc: jannh@google.com
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > ---
> > >  Documentation/RCU/rcuref.txt | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
> > > index 613033ff2b9b..e5f4a49f886a 100644
> > > --- a/Documentation/RCU/rcuref.txt
> > > +++ b/Documentation/RCU/rcuref.txt
> > > @@ -28,7 +28,8 @@ add()                         search_and_reference()
> > >  release_referenced()                   delete()
> > >  {                                      {
> > >      ...                                            write_lock(&list_lock);
> > > -    atomic_dec(&el->rc, relfunc)           ...
> > > +    if(atomic_dec_and_test(&el->rc))       ...
> > > +       kfree(el);
> > >      ...                                            remove_element
> > >  }                                          write_unlock(&list_lock);
> > >                                             ...
> > > @@ -114,6 +115,11 @@ element can therefore safely be freed.  This in turn guarantees that if
> > >  any reader finds the element, that reader may safely acquire a reference
> > >  without checking the value of the reference counter.
> > >
> > > +The other advantage of the last pattern is, if there are several calls to
> > > +search_and_reference() in parallel to the delete(), then all of those will
> > > +succeed in obtaining a reference to the object if the object could be found in
> > > +the list before it was deleted in delete().
> > 
> > Isn't this the same as what the previous paragraph said? "if
> > any reader finds the element, that reader may safely acquire a reference
> > without checking the value of the reference counter".
> 
> You are right.  But I felt it was less explicit about the fact that several
> search_and_reference() calls can succeed will not FAIL like the previous example.
> 
> I can reword it as below:
> 
> As can be seen, a clear advantage of the last pattern is, if there are
> several calls to search_and_reference() in parallel to the delete(), then all
> of those will succeed in obtaining a reference to the object if the object
> could be found in the list before it was deleted in delete(), unlike the
> previous pattern which would fail to acquire references.
> 
> Or, can I entirely drop it if Paul and others also feel it is not necessary.

Here I meant "I can entirely drop this part of the patch if Paul and others
also feel it is not necessary."

thanks,

 - Joel

