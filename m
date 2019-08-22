Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE18C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA332339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbfHVJPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfHVJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:15:52 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0078881DEB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:15:52 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a17so2919905wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=20y8QC7R6t0IGb5Wrdbux5c0c2oCVqxmDr+q12FCKEs=;
        b=ZKdAB2SdZdgJlb/HYi9ZvdJXoYLnX8SszzlIEcOl3ug0vDtm3gi+0y/lB4JCs9rJW+
         ocZJwMrL3sUqNPDyqV7TIrIogGntiti3e/FMl1p264s70haoHbFZuRvtGcMYaSpl7EsG
         8RcBEXh1FvXsY/Gj0LXOc0/t9p4xW1IumCioKkW3meoidut3gV9XwUrFVipgdik5ER7f
         EXrpd0IXHNi6P+oscIoDTB4jocmxVlye1lEc0DSGYt89CViySJNHiJZrWpO0ymZ3fZUE
         nd5f06n91GGYY35DjEvX6Lh4ydPu95WPTRKrsjK4Jk1YNIa9n6p1WNxhxW5QEFoFaxbp
         hcSA==
X-Gm-Message-State: APjAAAUUpG4otU8RlufYRpzi+gOZ9xMzeQFbP/U+EvaGDa5upXZsCD8t
        p1oHahhJb3ctPzihR6ofaMKrShgI9zjD2WG8Q1yTSX4tzlEts+H5cE+COVCJo+ewr+m+uLWlLk9
        Tu0JS0JnIwhHEJFNRY4Px2PLy
X-Received: by 2002:adf:e710:: with SMTP id c16mr2290129wrm.292.1566465350615;
        Thu, 22 Aug 2019 02:15:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwumlNcw/ZaeykOzM5ZvW/kCRWj/R7ioHse/WHT5NLNMpD8iDBx8WLTrtd1YQliRUUYxN5lNw==
X-Received: by 2002:adf:e710:: with SMTP id c16mr2290089wrm.292.1566465350391;
        Thu, 22 Aug 2019 02:15:50 -0700 (PDT)
Received: from steredhat (host80-221-dynamic.18-79-r.retail.telecomitalia.it. [79.18.221.80])
        by smtp.gmail.com with ESMTPSA id l9sm2678299wmi.29.2019.08.22.02.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 02:15:49 -0700 (PDT)
Date:   Thu, 22 Aug 2019 11:15:46 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] vsock_test: wait for the remote to close the
 connection
Message-ID: <20190822091546.qcns2kot6tzju7yv@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
 <20190801152541.245833-12-sgarzare@redhat.com>
 <20190820082828.GA9855@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820082828.GA9855@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:28:28AM +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 01, 2019 at 05:25:41PM +0200, Stefano Garzarella wrote:
> > +/* Wait for the remote to close the connection */
> > +void vsock_wait_remote_close(int fd)
> > +{
> > +	struct epoll_event ev;
> > +	int epollfd, nfds;
> > +
> > +	epollfd = epoll_create1(0);
> > +	if (epollfd == -1) {
> > +		perror("epoll_create1");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	ev.events = EPOLLRDHUP | EPOLLHUP;
> > +	ev.data.fd = fd;
> > +	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) == -1) {
> > +		perror("epoll_ctl");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	nfds = epoll_wait(epollfd, &ev, 1, TIMEOUT * 1000);
> > +	if (nfds == -1) {
> > +		perror("epoll_wait");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	if (nfds == 0) {
> > +		fprintf(stderr, "epoll_wait timed out\n");
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	assert(nfds == 1);
> > +	assert(ev.events & (EPOLLRDHUP | EPOLLHUP));
> > +	assert(ev.data.fd == fd);
> > +
> > +	close(epollfd);
> > +}
> 
> Please use timeout_begin()/timeout_end() so that the test cannot hang.
> 

I used the TIMEOUT macro in the epoll_wait() to avoid the hang.
Do you think is better to use the timeout_begin()/timeout_end()?
In this case, should I remove the timeout in the epoll_wait()?

> > diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> > index 64adf45501ca..a664675bec5a 100644
> > --- a/tools/testing/vsock/vsock_test.c
> > +++ b/tools/testing/vsock/vsock_test.c
> > @@ -84,6 +84,11 @@ static void test_stream_client_close_server(const struct test_opts *opts)
> >  
> >  	control_expectln("CLOSED");
> >  
> > +	/* Wait for the remote to close the connection, before check
> > +	 * -EPIPE error on send.
> > +	 */
> > +	vsock_wait_remote_close(fd);
> 
> Is control_expectln("CLOSED") still necessary now that we're waiting for
> the poll event?  The control message was an attempt to wait until the
> other side closed the socket.

Right, I'll remove it in the v3

Thanks,
Stefano
