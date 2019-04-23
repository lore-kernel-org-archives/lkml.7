Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D502C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8A721738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556022663;
	bh=u7lnxaA3VGgOHosfe3qn7k9Mtx+2ly87vbM5KCVMkKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RaikM8rK7RmC6YX73oCuGE3gtGyspWRlBhfp7NYmS31iIoemG5XHJFQzaoHAwPlt8
	 39bNuC+eUGyYBxkdxZTw6I+r85L+Wg3AIXgFj30DXPO+R+9I1ZVzqzKrmxQ5pNCaVB
	 IYArQiJ3D3fsecLhjkPbk9swEUAZP0H68wen8JA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfDWMbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:31:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36579 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDWMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:31:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id b1so8652127wru.3;
        Tue, 23 Apr 2019 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+9wxr5R3pk2oel1OfIQlHTOTnUvOX8cEZ1l94U4oBF8=;
        b=mizTPRShAF1dM0yfIHmgRTVxwNuSoOi0eKbP73V2j33rQDacaUAhCJuGXkvLMgTbhr
         RtU+YjH6ln1gfb+c7IA98DBdvSekblLz9zQzCvc1X0yZvcbolEn2kzHmMr3Trbd9X6Op
         pIAzfuBqkj6eWWdBNM/KJ+6zTJrjpSnpdSMoNTVl52bggJtjpgMzCgvlry6OYQfOvqbZ
         U0tIJIGzgplGfdFs2rwUekxic6kaFUOGcmsGindeMnkmLk1v5p1sVbEdq496JeqBwoNP
         2GcEs2hJWFEtbNImdzQIjV7LE77X2sFwnxSQ4MDEYz7L/ipzVCjFKp0NbpoO+PeumJ67
         zCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+9wxr5R3pk2oel1OfIQlHTOTnUvOX8cEZ1l94U4oBF8=;
        b=lvJEdEfoN08wzR/bD/GdGYlhe3QK37eukn5iyiYrSk9qAc5siRitJAHzW353JuW+6l
         Kk8CLBCe4hD6QgyhZtdfU9wwQJSRuCsPtKwuQBcTNSN3Lcd/F1GN1jikz+m5NFgrCrWS
         E1zGSuD9f4vHJrR8hACK64p2LAYmqZLSjiKR/ZTH7rqrch/yKp6do8bi/c9OGXXE1eec
         pwlPLV5RdfyxtKhhNrOJpbGoE2lPU5XDsOBPvTGdLYum9RkFs6PRsX7JGhlj91eQEBhB
         853zLfudnKRQuEfOB4mxkurzHLqpIpjkkLozVM95aYr5bqRbw1Q1kbOV6eeJwUYf1toB
         O4tg==
X-Gm-Message-State: APjAAAWoIcwfUG45pYS89fNrdt3ZEFqxs5sq/RuofJvkEAVYJHrlK1DZ
        5mtoTF6y+GWaEs+nwYYLyoY=
X-Google-Smtp-Source: APXvYqznVXo22PgJ4A60yTTxCmKJ8qyXu+UGtlFM23tosnZ73o8aQYHrMIjQiYyi5NfqXepCIz4knA==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr17589058wrj.66.1556022660471;
        Tue, 23 Apr 2019 05:31:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v22sm2981298wml.32.2019.04.23.05.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 05:30:59 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:30:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 38/79] docs: scheduler: convert docs to ReST and
 rename to *.rst
Message-ID: <20190423123057.GA91497@gmail.com>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <2a3b2b06459e0134a3af4fbf3e6f62e6d42c4d26.1555938376.git.mchehab+samsung@kernel.org>
 <20190423082937.GZ11158@hirez.programming.kicks-ass.net>
 <20190423103202.GA13655@gmail.com>
 <20190423111937.GM11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423111937.GM11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 23, 2019 at 12:32:02PM +0200, Ingo Molnar wrote:
> 
> > The .rst files still read like text files, right?
> 
> Like a harder to read text file for no gains.

I just looked through a couple of RST files in Documentation/, and they 
look like perfectly readable text files to me.

Some of the formatting details are arguably 'special' and can be broken 
via "text edits" without being aware of the RST markup relevance - but I 
don't think it's a problem for RST-unaware developers to break that 
markup, the Documentation/ folks have been rather generous and flexible 
in fixing those up, in addition to fixing all the typos as well.

So I'd be cautiously in favor of the RST conversion, assuming I don't get 
yelled at if I break the markup. ;-)

Thanks,

	Ingo
