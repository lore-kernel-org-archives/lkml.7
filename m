Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357BDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15109218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbfJJIu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:50:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389959AbfJJIuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:50:24 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4DB33DE04
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:50:24 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id z17so2404839wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbUGk/zH7Jd7BlhB+4/oDRz4mPdioNN/Nf5e+ZFx1KA=;
        b=G+++O+sio+lslwqKpLTAQs4NNqDgVNgfa2t6uxFVBkfyjyFlN9E0Ha2n1xyZat81+O
         Vqia7vuDCK3Es0mTVOFjpIa+3VkjDI9XD7NKpw1SWehwVknHmFbOyMNzLw99lL7nAq1F
         XtYarzHWJG/rtT49VhN2qwLKAvVGSPSwfmd/rYgFP6TBbC2rXVC3HtWyeTi0usfW8Q9I
         KR8cIWS8qHoS56b6WuonLgD1iPhjXOenDVdk+AxTLzE2EqcBVcDBEwTolA5ltQt7d2Z+
         IbtEYiXruQG6/HbGf0pu9i8KF76zTebvuBIcnqbETckzG8sZ/1ET6xNfEFCkowSdc1xG
         vvkw==
X-Gm-Message-State: APjAAAWv18hNjpjxnWKcKYFVMS4mLfOEaIdyKP4YdLNE9ZiXCY2SfW0t
        oNZNfwWvwQnPlE/husS6dXATNdLJT6GW5g6XswQ+DKrBZtFXypARlHKHtfw4KeITt0AjPXUyl8E
        tPjp7QTPTX00C7bGPzKTO63uC
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr7690214wrw.286.1570697423407;
        Thu, 10 Oct 2019 01:50:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoCA81jZEGW66oRDsEIESbM+AgkqiF20vI6cPaP0YoBTkJocF4+GdZwig79Aeir6Qomx30bw==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr7690208wrw.286.1570697423217;
        Thu, 10 Oct 2019 01:50:23 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id y8sm6284711wrm.64.2019.10.10.01.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 01:50:22 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:50:20 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 06/13] vsock: add 'struct vsock_sock *' param to
 vsock_core_get_transport()
Message-ID: <20191010085020.w5mbse7mnpzalhyr@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20190927112703.17745-7-sgarzare@redhat.com>
 <20191009115433.GG5747@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009115433.GG5747@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:54:33PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:56PM +0200, Stefano Garzarella wrote:
> > -const struct vsock_transport *vsock_core_get_transport(void)
> > +const struct vsock_transport *vsock_core_get_transport(struct vsock_sock *vsk)
> >  {
> >  	/* vsock_register_mutex not taken since only the transport uses this
> >  	 * function and only while registered.
> >  	 */
> > -	return transport_single;
> 
> This comment is about protecting transport_single.  It no longer applies
> when using vsk->transport.  Please drop it.

Right, dropped.

> 
> Otherwise:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks,
Stefano
