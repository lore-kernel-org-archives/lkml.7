Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2864C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F642183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="gcLpwLnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfCTXXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:23:31 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:27991 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1174; q=dns/txt; s=iport;
  t=1553124210; x=1554333810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+DVdRepSu84yfowrZ6ypAs5+WZg8d0uiCTV7N33jOI=;
  b=gcLpwLnwL8oK6W3uyQDGERr7rwHRYaZ6p+c1bTt642oVyVP1OggiT96x
   sB7I2mZOXe/n4Ez44SukC3J4CWlTtejYWqV9wByv/w3bYdJmgXh5uWE3Y
   ROty3q/EM834OIDGXF9NuNZ0YZ2GkYs1yr6uqGPCnykMTXSxmWilNxEej
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AQAACbypJc/4oNJK1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBVAEBAQEBAQsBghCBODMnl0eCDYkzhQwRiXmBZwsBARi?=
 =?us-ascii?q?EVAKEZyI3Bg0BAQMBAQkBAwJtKIVKAQEBAQMBOTQLEAsOBwIBCSUPEgcUEwg?=
 =?us-ascii?q?GE4UAAxWsRYgFDYIfFA6BDQGLMReBQD+EI4JXgXcBEQIBhX8DkiaGGotrGzY?=
 =?us-ascii?q?JgkuMLHqDMyUMk1mSRYtbAgQGBQIVgWIiZXEzGggbFTuCbJBrHwMwjQ0BAQ?=
X-IronPort-AV: E=Sophos;i="5.60,250,1549929600"; 
   d="scan'208";a="537691888"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 20 Mar 2019 23:23:30 +0000
Received: from zorba ([10.154.176.41])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id x2KNNSaN001900
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Mar 2019 23:23:29 GMT
Date:   Wed, 20 Mar 2019 16:23:28 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        linuxppc-dev@lists.ozlabs.org, Daniel Walker <dwalker@fifo99.com>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] add generic builtin command line
Message-ID: <20190320232328.3bijcxek2yg43a25@zorba>
References: <20190319232448.45964-2-danielwa@cisco.com>
 <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.176.41, [10.154.176.41]
X-Outbound-Node: alln-core-5.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:53:19PM -0700, Andrew Morton wrote:
> On Tue, 19 Mar 2019 16:24:45 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> 
> > This code allows architectures to use a generic builtin command line.
> 
> I wasn't cc'ed on [2/4].  No mailing lists were cc'ed on [0/4] but it
> didn't say anything useful anyway ;)
> 
> I'll queue them up for testing and shall await feedback from the
> powerpc developers.
> 

You weren't CC'd , but it was To: you,

 35 From: Daniel Walker <danielwa@cisco.com>
 36 To: Andrew Morton <akpm@linux-foundation.org>,
 37         Christophe Leroy <christophe.leroy@c-s.fr>,
 38         Michael Ellerman <mpe@ellerman.id.au>,
 39         Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
 40         linuxppc-dev@lists.ozlabs.org, Frank Rowand <frowand.list@gmail.com>
 41 Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
 42 Subject: [PATCH 2/4] drivers: of: generic command line support

and the first one [0/4] should have went to the linuxppc-dev , and xe-linux-external. Maybe 
our git-send-email isn't working with our mail servers.

Thanks for picking it up.

Daniel
