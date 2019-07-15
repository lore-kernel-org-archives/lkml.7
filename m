Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3348C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971132171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563223793;
	bh=0eRTix/Lpgnym75b99LGPTKC4kIZbevGRLJucViLRRM=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=YVdQtX6Cx8eHpq234kz11K7lGSdhoXF4ueztwxFnw/KuXg8pBRhy7OnZQ5KxRlfVT
	 grjj0ClmJBxYFxbNIQSSoPKQxkYKQnhyrKteKm4JVLRzkrqAauRxR/uJj9M9CT5inj
	 rfLL7/l7cih2Yod4QND6ExiowZQQGStCiNKVCbe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbfGOUtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfGOUtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:49:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A292145D;
        Mon, 15 Jul 2019 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563223789;
        bh=0eRTix/Lpgnym75b99LGPTKC4kIZbevGRLJucViLRRM=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=aIF9Xc7kksoCd5+piTlYItO2JJkplr3Zs63iETQ8IW811WfXwuxPAPJI1oh+5quib
         rXKPgHWrXlwCMiqD7m50O6ehrnfpk/sPNoDrpTZhRJwAnlAyWAh6JjKOS2Tt/SLIaG
         n16Oh2OnOo8KfLr1uolIPKFySXqgf16LCNWWJdqE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190712081744.87097-7-brendanhiggins@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com> <20190712081744.87097-7-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH v9 06/18] kbuild: enable building KUnit
User-Agent: alot/0.8.1
Date:   Mon, 15 Jul 2019 13:49:48 -0700
Message-Id: <20190715204949.96A292145D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-07-12 01:17:32)
> KUnit is a new unit testing framework for the kernel and when used is
> built into the kernel as a part of it. Add KUnit to the root Kconfig and
> Makefile to allow it to be actually built.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

