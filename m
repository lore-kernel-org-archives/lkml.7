Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA9FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839124690
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLK+2FLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLSH5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:57:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726439AbfLSH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 02:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576742258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYvhhfdfRXcH4jO+EP53VpwP3E/K4rAyanO/djc7fbc=;
        b=NLK+2FLnx6EcnNM1kSfE2NzbPJG+sSIplXoWdFFKvB8kHe07AfLWKn47EAeG+CCru2QaKS
        cld2L5fnVWHKX4ua8I0ZL616YzgpVL/qENW8lWvIDY1CeAUmTwjP5JvA1l6hjtmyGZ9x4Y
        RhEATXSbaiviHhS7xLL2RNNf5zAIVig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-UkhMKIxTMPm8eSJTniRGqw-1; Thu, 19 Dec 2019 02:57:32 -0500
X-MC-Unique: UkhMKIxTMPm8eSJTniRGqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB2A107ACE3;
        Thu, 19 Dec 2019 07:57:28 +0000 (UTC)
Received: from carbon (ovpn-200-37.brq.redhat.com [10.40.200.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B0861000330;
        Thu, 19 Dec 2019 07:57:24 +0000 (UTC)
Date:   Thu, 19 Dec 2019 08:57:22 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Marek Majkowski' <marek@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Paolo Abeni <pabeni@redhat.com>, brouer@redhat.com
Subject: Re: epoll_wait() performance
Message-ID: <20191219085722.23e39028@carbon>
In-Reply-To: <b71441bb2fa14bc7b583de643a1ccf8b@AcuMS.aculab.com>
References: <bc84e68c0980466096b0d2f6aec95747@AcuMS.aculab.com>
        <CAJPywTJYDxGQtDWLferh8ObjGp3JsvOn1om1dCiTOtY6S3qyVg@mail.gmail.com>
        <5f4028c48a1a4673bd3b38728e8ade07@AcuMS.aculab.com>
        <20191127164821.1c41deff@carbon>
        <5eecf41c7e124d7dbc0ab363d94b7d13@AcuMS.aculab.com>
        <20191128121205.65c8dea1@carbon>
        <b71441bb2fa14bc7b583de643a1ccf8b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 16:37:01 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Jesper Dangaard Brouer
> > Sent: 28 November 2019 11:12  
> ...
> > > Can you test recv() as well?  
> > 
> > Sure: https://github.com/netoptimizer/network-testing/commit/9e3c8b86a2d662
> > 
> > $ sudo taskset -c 1 ./udp_sink --port 9  --count $((10**6*2))
> >           	run      count   	ns/pkt	pps		cycles	payload
> > recvMmsg/32  	run:  0	 2000000	653.29	1530704.29	2351	18	 demux:1
> > recvmsg   	run:  0	 2000000	631.01	1584760.06	2271	18	 demux:1
> > read      	run:  0	 2000000	582.24	1717518.16	2096	18	 demux:1
> > recvfrom  	run:  0	 2000000	547.26	1827269.12	1970	18	 demux:1
> > recv      	run:  0	 2000000	547.37	1826930.39	1970	18	 demux:1
> >   
> > > I think it might be faster than read().  
> > 
> > Slightly, but same speed as recvfrom.  
> 
> I notice that you recvfrom() code doesn't request the source address.
> So is probably identical to recv().

Created a GitHub issue/bug on this:
 https://github.com/netoptimizer/network-testing/issues/5

Feel free to fix this and send a patch/PR.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

