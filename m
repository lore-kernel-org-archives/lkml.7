Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E6DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE872070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565647833;
	bh=SPZRl5pSVopkTs0dY+BYgF4YdIC5weWXIEKe9ul/RDw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=MEwKBDfuSXyJp4NQKoh0d2lnS4kVFwdeQtibTOsqXEA8NGtOFdBRSt0CvNQ83t4Cp
	 hI3W8f4Lv6bxPday+Ki2ibIb2XMvw7UZF0/TkjJf4UqULpcV68auqqSXNq8V6JYpq6
	 qGj1IPfCLWwbCLQs5WYapcV9NuBjsLN3pdKHwU2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfHLWKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfHLWKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:10:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B31206C2;
        Mon, 12 Aug 2019 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565647830;
        bh=SPZRl5pSVopkTs0dY+BYgF4YdIC5weWXIEKe9ul/RDw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V3lZzoj5A/ZUJ82O/D6JOwCAESMHhjfhFsM/G+WlAQFOJn0eCYLeKxiUav3yhAWrc
         3bLOfvUeJqm5cu0JRjxhkYqU/qNE2mLaefdclg0BgxHvmqSh/kXGRMQIhxkerIgm9f
         dbMpOgSRN5v/bzLnxQ4pQx6d7nMjpT4h51jSvW3c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-3-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-3-brendanhiggins@google.com>
Subject: Re: [PATCH v12 02/18] kunit: test: add test resource management API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 15:10:29 -0700
Message-Id: <20190812221030.99B31206C2@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:05)
> Create a common API for test managed resources like memory and test
> objects. A lot of times a test will want to set up infrastructure to be
> used in test cases; this could be anything from just wanting to allocate
> some memory to setting up a driver stack; this defines facilities for
> creating "test resources" which are managed by the test infrastructure
> and are automatically cleaned up at the conclusion of the test.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

