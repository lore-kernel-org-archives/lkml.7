Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE46C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D4B2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565654382;
	bh=Ihx5qucsrmvrAAE/5ImD3U15K8tabsAl8VFviXM9+Bg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=IrPrEbcWqKuqa1NgoO3fpaVS8HvdsEYEqUH5NXInO923GAd5PT2Igjwe+Scx82JWn
	 0iOVXB2qEJFdmPlaOuEdOMK/o/txArKVmC1P3sHVRSZ9cKEy0NGLw20yHzBgGnvX8F
	 YqQL7FfPKYShLKKNRhnds98wtTnj9P+6MwmkewuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfHLX7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfHLX7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:59:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100842063F;
        Mon, 12 Aug 2019 23:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565654380;
        bh=Ihx5qucsrmvrAAE/5ImD3U15K8tabsAl8VFviXM9+Bg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fIGb9dkjeLM6ykUlYcegOGMgH57XYg0i2e09hxpU6M5SeZwLGIFKwZRTa3F446++Q
         7v31k+Hz3Z3dkW7F1eUzFN+GhoaUfon3TmFOSQ+Kek1TG5+5BWGh5EPASd4FKHvy+z
         H+flEKxiF+rQtxdwpE+w2sauD520cIpSgMU1N6LU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812233336.GA224410@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-4-brendanhiggins@google.com> <20190812225520.5A67C206A2@mail.kernel.org> <20190812233336.GA224410@google.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream like string builder
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
        wfg@linux.intel.com
To:     Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 16:59:39 -0700
Message-Id: <20190812235940.100842063F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 16:33:36)
> On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> > Quoting Brendan Higgins (2019-08-12 11:24:06)
> > > +void string_stream_clear(struct string_stream *stream)
> > > +{
> > > +       struct string_stream_fragment *frag_container, *frag_containe=
r_safe;
> > > +
> > > +       spin_lock(&stream->lock);
> > > +       list_for_each_entry_safe(frag_container,
> > > +                                frag_container_safe,
> > > +                                &stream->fragments,
> > > +                                node) {
> > > +               list_del(&frag_container->node);
> >=20
> > Shouldn't we free the allocation here? Otherwise, if some test is going
> > to add, add, clear, add, it's going to leak until the test is over?
>=20
> So basically this means I should add a kunit_kfree and
> kunit_resource_destroy (respective equivalents to devm_kfree, and
> devres_destroy) and use kunit_kfree here?
>=20

Yes, or drop the API entirely? Does anything need this functionality?

