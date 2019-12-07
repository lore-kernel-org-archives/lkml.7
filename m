Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE46C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3C8217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 01:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVktpsWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLGBVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 20:21:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGBVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:21:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so4230113pfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 17:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yEn14k+clLvmNnACMsBkTxLXcZL5KjXBaody+Go5YQA=;
        b=RVktpsWsyDJ2zmC5kzzH0C65ikVPwt/aU1ngdwnfogURM6j3WsR3m2gPL5rckVuipn
         37OfiaQUZKb4e4iABBSyMR3akYVbt2fuiScLpd0tFMdOMr06qAkUA5GZ0rNg3zN9ZOR3
         3sVtvBvg67wLijt8omw4z3DHgUa3jjQldzcQDG0U8kMq7o8rF703wcLWkYrNVkq/Dmay
         rmfOzXv2nDlUtcLk+xRbhOHolVoOUsmpJ3+X1dbxmT542OBbniJALQgylZCRjjJ96WGG
         WdtXyXWdVYqXsriR1Ay4dUdrbOA7+4QG2AuDIIUfl7qWV04gAKemav+hoX3HsGy18eZA
         KNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yEn14k+clLvmNnACMsBkTxLXcZL5KjXBaody+Go5YQA=;
        b=mLeVY/+lgCy6UOO6C+SM/QoSIL7evrvFl12Jkyd4IWMMADbOXJFC5r9sdpMXneP01s
         b80EH8NWCCUUkbW2egdqn+VgsOOqcGiii7E2XBVphM5nFFYFQYcjtaZlPCDOJSBnp49S
         N5nQkmEIdQh5Q5BiUkHKnK2nflNflyu1djM+pY9SZqWPpYX+wV+iBVPC0p4Gnaw5ZIEG
         Le8nRcO2++r5jLbgr/ItCnXTSKoQCXMEztjBAjZp99dp7F25/Hk2vmDofM41Hy5zZnYf
         cfJM2EfM1xN3YnLWbcjuHW4Gg4Kost8Re+ImdatfTP2WSCFk6z0Sm9ehwFFMlg+fdprD
         lopw==
X-Gm-Message-State: APjAAAVgmmcnaAjcqZ3A9zgLEvH507dUOC+1mRV7hYC42aBnC13b8KMc
        atxkCJg2xMrshN8AFG0104sM9Q==
X-Google-Smtp-Source: APXvYqzfNrW47rjcKV8huzvGoXPAKRUzD/VyzmnJ6kimzv2+42ubB+gwb5kQUmNkYzvseub7koSQ9A==
X-Received: by 2002:a63:4f5c:: with SMTP id p28mr6632289pgl.409.1575681673644;
        Fri, 06 Dec 2019 17:21:13 -0800 (PST)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id b65sm17348072pgc.18.2019.12.06.17.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 17:21:12 -0800 (PST)
Date:   Fri, 6 Dec 2019 17:21:08 -0800
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        johannes.berg@intel.com
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
Message-ID: <20191207012108.GA220741@google.com>
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com>
 <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
 <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:32:34PM -0800, Brendan Higgins wrote:
> On Thu, Dec 5, 2019 at 11:23 PM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
> [...]
> > 1. There is a proposed patch for the build system to fix it.

So I just tried the patch you linked on the cover letter[1], and I am
still getting the build error described above:

arch/um/drivers/pcap_user.c:35:12: error: conflicting types for ‘pcap_open’
 static int pcap_open(void *data)
            ^~~~~~~~~
In file included from /usr/include/pcap.h:43,
                 from arch/um/drivers/pcap_user.c:7:
/usr/include/pcap/pcap.h:859:18: note: previous declaration of ‘pcap_open’ was here
 PCAP_API pcap_t *pcap_open(const char *source, int snaplen, int flags,

Looking at the patch, I wouldn't expect it to solve this problem.

Are there maybe different conflicting libpcap-dev libraries and I have
the wrong one? Or is this just still broken?

> > 2. We should be removing all old drivers and replacing them with the
> > vector ones.
> 
> Hmm...does this mean you would entertain a patch removing all the
> non-vector UML network drivers? I would be happy to see VDE go as
> well.
> 
> In any event, it sounds like I should probably drop this patch as it
> is currently.
> 
> Thanks!

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=938962#79
