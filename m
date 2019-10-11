Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3914C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C43206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="hUTUq2OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfJKP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:27:48 -0400
Received: from one.firstfloor.org ([193.170.194.197]:50938 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJKP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:27:48 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 27D6A868DE; Fri, 11 Oct 2019 17:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1570807665;
        bh=LWf4Mf2c6cmPhu3atJhi75qc62kg/5WZ5L8xBUnpSnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUTUq2OF4NerTT3sgcefuV/i+dJf2RLNpQdpDtV1Xl4Vg06AlPz8ESAOlTtFPSLQ+
         x5yfwc60E6MRgx689dUh5xHLxF+QTlNAgza5AWzg1EqYWBxWWh7qpsbyiHso0GgZZZ
         zbd9+2oBRXbP68d27O8B8KZnaBY52MdSw/+pf15w=
Date:   Fri, 11 Oct 2019 08:27:44 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf data: Fix babeltrace detection
Message-ID: <20191011152744.kfuogoz66zcbifyj@two.firstfloor.org>
References: <20191007174120.12330-1-andi@firstfloor.org>
 <20191008115240.GE10009@krava>
 <20191008142143.ts5se4pzwfnfnbsh@two.firstfloor.org>
 <20191011140548.GA20544@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011140548.GA20544@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:05:48PM +0200, Jiri Olsa wrote:
> On Tue, Oct 08, 2019 at 07:21:44AM -0700, Andi Kleen wrote:
> > On Tue, Oct 08, 2019 at 01:52:40PM +0200, Jiri Olsa wrote:
> > > On Mon, Oct 07, 2019 at 10:41:20AM -0700, Andi Kleen wrote:
> > > > From: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > The symbol the feature file checks for is now actually in -lbabeltrace,
> > > > not -lbabeltrace-ctf, at least as of libbabeltrace-1.5.6-2.fc30.x86_64
> > > > 
> > > > Always add both libraries to fix the feature detection.
> > > 
> > > well, we link with libbabeltrace-ctf.so which links with libbabeltrace.so
> > > 
> > > I guess we can link it as well, but where do you see it fail?
> > 
> > On FC30 the .so file is just a symlink, so it doesn't pull
> > in the other library.
> > 
> > $ gcc test-libbabeltrace.c -lbabeltrace-ctf
> > /usr/bin/ld:
> > /usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
> > undefined reference to `bt_packet_seek_get_error'
> > /usr/bin/ld:
> > /usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
> > undefined reference to `bt_packet_seek_set_error'
> > collect2: error: ld returned 1 exit status
> 
> I'm confused,
> the test-libbabeltrace.c checks for bt_ctf_stream_class_get_packet_context_type
> which is in libbabeltrace-ctf:

AFAIK libbabeltrace-ctf uses these symbols from the object containing
bt_ctf_stream_class_get_packet_context_type

I assume you have FC30 so you should be able to reproduce it

-Andi
