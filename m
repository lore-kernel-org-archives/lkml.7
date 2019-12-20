Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E2DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BFD2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3eQejOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLTVrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:47:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727422AbfLTVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576878465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bh8DaEb0kYFOBKnx1w8yAO5IROeyH1fTcPfoEsuwvnk=;
        b=g3eQejOTxXI2erMaplkyhBI55lwJvokNhTx6DR2GRqrUjSukbfXFbUJGfk7mFPHCiSlar2
        I/tYo+ClpcHKRWOshixrEUMoSQr7TlZG5CcFxU4bAGrqYs7HUNPbtDWkvVbEP1jwQtSGoL
        huzHh3v7QZfgLdFFT3lxMT84eLk0cnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-5QeP2pOWN6evlcZCAwIO0Q-1; Fri, 20 Dec 2019 16:47:42 -0500
X-MC-Unique: 5QeP2pOWN6evlcZCAwIO0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BECF91221;
        Fri, 20 Dec 2019 21:47:41 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-10.phx2.redhat.com [10.3.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 512521001DD8;
        Fri, 20 Dec 2019 21:47:40 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 7A05E11E8; Fri, 20 Dec 2019 18:47:37 -0300 (BRT)
Date:   Fri, 20 Dec 2019 18:47:37 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, tstoyanov@vmware.com,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH] tools lib traceevent: Fix memory leakage in filter_event
Message-ID: <20191220214737.GB3582@redhat.com>
References: <20191209063549.59941-1-hewenliang4@huawei.com>
 <20191219205631.2e12571c@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219205631.2e12571c@rorschach.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 19, 2019 at 08:56:31PM -0500, Steven Rostedt escreveu:
> On Mon, 9 Dec 2019 01:35:49 -0500
> Hewenliang <hewenliang4@huawei.com> wrote:
> 
> > It is necessary to call free_arg(arg) when add_filter_type returns NULL in
> > the function of filter_event.
> > 
> > Signed-off-by: Hewenliang <hewenliang4@huawei.com>
> 
> This looks fine.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Arnaldo, care to take this?

Sure, just landed in  acme/perf/urgent :)

- Arnaldo
 
> -- Steve
> 
> > ---
> >  tools/lib/traceevent/parse-filter.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> > index f3cbf86e51ac..20eed719542e 100644
> > --- a/tools/lib/traceevent/parse-filter.c
> > +++ b/tools/lib/traceevent/parse-filter.c
> > @@ -1228,8 +1228,10 @@ filter_event(struct tep_event_filter *filter, struct tep_event *event,
> >  	}
> >  
> >  	filter_type = add_filter_type(filter, event->id);
> > -	if (filter_type == NULL)
> > +	if (filter_type == NULL) {
> > +		free_arg(arg);
> >  		return TEP_ERRNO__MEM_ALLOC_FAILED;
> > +	}
> >  
> >  	if (filter_type->filter)
> >  		free_arg(filter_type->filter);

