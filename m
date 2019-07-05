Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F2DC468A7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD08521738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562359560;
	bh=oAiALuxJspRsWP6V+83E4hobjwlRqF6YTuLRBtR+Lvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zOhgJQhXMAzqgSmmIGOft4R+qOUKw4z63mvWJq6c3g8F1AZnnKucpa9BlEYEwusCP
	 HrHG6EboFk/0COH/wrPOYM429kyPPrY3/tmtAdx4rQz4Ty5WVskkYbN1Qz+i+LBCcC
	 aMBAYWAPQU56mLWPZpVE+20NaZDsz1+bk/GDz+rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfGEUp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:45:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33856 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGEUp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:45:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so159904pfo.1;
        Fri, 05 Jul 2019 13:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4GIgI5QbQFYYHeADDS48yN0XwXbMzJsu3FTa+FaXcs=;
        b=EEgnxdKVae5dLG3AvMagDH2whhQVFatQ1XfuuTEMJqXFdaO81LmDCsFAcpbXRXazur
         7Nz9FFgtVruBbgzIgpctdysszanug/y2zd/g5vOxp3UN+b6QKLuEAYYr2U3JiMbYE+DV
         TYlt2ztyXic2xsBnJVD83P/XZQo2NetHL8/uhaDiBNHPtYiESiTw+b6I3FZrDDVO/4Gi
         s4miR5mx4pbg+DGbK4q1+Hu4TSPEsjdGWRNuEhBK0rES5AnCWosP+Rr1i/ZJ7X9el03m
         Cib0JPx+zM0ZuGItBypJtpnoG8yFnSPKYyW5LRbSWzKq89pTwdaJ2IomEBW100+5C+x/
         m2bg==
X-Gm-Message-State: APjAAAVyVdJhG2B2iMb3yH27o0FgAHWKKO7VK9eklZHNNXdqVokPkBOc
        HNMWDyL99aBK7LL88X7Biyw=
X-Google-Smtp-Source: APXvYqzeFsCVF2ZvnbfqZHx8vhkEXe3aUADAaqpXImPQcsaBURcoZTbfCuqJiBja1aAbbmI4GIuc+A==
X-Received: by 2002:a63:e018:: with SMTP id e24mr7383945pgh.361.1562359558392;
        Fri, 05 Jul 2019 13:45:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s66sm13955192pgs.39.2019.07.05.13.45.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:45:57 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9151F40190; Fri,  5 Jul 2019 20:45:56 +0000 (UTC)
Date:   Fri, 5 Jul 2019 20:45:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        rdunlap@infradead.org, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v6 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190705204556.GD19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-18-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-18-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 05:36:14PM -0700, Brendan Higgins wrote:
> From: Iurii Zaikin <yzaikin@google.com>
> 
> KUnit tests for initialized data behavior of proc_dointvec that is
> explicitly checked in the code. Includes basic parsing tests including
> int min/max overflow.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
