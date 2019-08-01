Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0627C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA2D206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfHAP6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:58:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40673 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732315AbfHAP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:58:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so63707068wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a0EUgeGqQ7K8JBk8474/F7Qfdf6czPogTZsCAuEQGPE=;
        b=cVmJk6D1wod+tuZTBfVHAlrliIJ3ms6lCGgvUyU2UPvU4KppdfpeKk1EeHhDDdIaRv
         6cLFdnXSoEe/iQx9doMuGV820dOKv2h9VYObUlrvhWDGNvusaRdfsm68JBONq31gA0Os
         mAEMqycclXCYvZjdXhQFhhB0iyn+qHkP/pTar46PzlM7S/Sz5YWXleV6yFzdBZGYdWu1
         jAsvS9+eRIDosEXb1HzcPXIqigGGncyO8lr23y6MNZKFvXYED6cuTFYJzcmHn29YBorU
         LVNfbea3l9h/SKT7h2jt3On6YVVnBhBQENj85ICYodQ7Vl4xoN+JPRkKgR1Zx7g5WOik
         f7zw==
X-Gm-Message-State: APjAAAXGVDN3scq7mVkG+oQ7ez/juKdJQH0tkFfNO15GETo168v4ybhC
        6ZfdQgqkEzWBIAwCj0yCWEjQww==
X-Google-Smtp-Source: APXvYqzzbNpTopM4KULhskQlC6/TwvH5ODVZW62e6oBlm1yrl91OGvxzGfqciA+7f4tgcVTJRlc2uQ==
X-Received: by 2002:a05:600c:2388:: with SMTP id m8mr15142423wma.23.1564675119726;
        Thu, 01 Aug 2019 08:58:39 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id r4sm44542036wrq.82.2019.08.01.08.58.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:58:39 -0700 (PDT)
Date:   Thu, 1 Aug 2019 17:58:36 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] vsock_test: skip read() in test_stream*close
 tests on a VMCI host
Message-ID: <20190801155836.ssounrtdtm5m6q6u@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
 <20190801152541.245833-11-sgarzare@redhat.com>
 <79ffb2a6-8ed2-cce2-7704-ed872446c0fe@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ffb2a6-8ed2-cce2-7704-ed872446c0fe@cogentembedded.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:53:32PM +0300, Sergei Shtylyov wrote:
> Hello!
> 

Hi :)

> On 08/01/2019 06:25 PM, Stefano Garzarella wrote:
> 
> > When VMCI transport is used, if the guest closes a connection,
> > all data is gone and EOF is returned, so we should skip the read
> > of data written by the peer before closing the connection.
> > 
> > Reported-by: Jorgen Hansen <jhansen@vmware.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  tools/testing/vsock/vsock_test.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> > index cb606091489f..64adf45501ca 100644
> > --- a/tools/testing/vsock/vsock_test.c
> > +++ b/tools/testing/vsock/vsock_test.c
> [...]
> > @@ -79,16 +80,27 @@ static void test_stream_client_close_server(const struct test_opts *opts)
> >  		exit(EXIT_FAILURE);
> >  	}
> >  
> > +	local_cid = vsock_get_local_cid(fd);
> > +
> >  	control_expectln("CLOSED");
> >  
> >  	send_byte(fd, -EPIPE);
> > -	recv_byte(fd, 1);
> > +
> > +	/* Skip the read of data wrote by the peer if we are on VMCI and
> 
>    s/wrote/written/?
> 

Thanks, I'll fix it!
Stefano

> > +	 * we are on the host side, because when the guest closes a
> > +	 * connection, all data is gone and EOF is returned.
> > +	 */
> > +	if (!(opts->transport == TEST_TRANSPORT_VMCI &&
> > +	    local_cid == VMADDR_CID_HOST))
> > +		recv_byte(fd, 1);
> > +
> >  	recv_byte(fd, 0);
> >  	close(fd);
> >  }
> [...]
> 
> MBR, Sergei

-- 
