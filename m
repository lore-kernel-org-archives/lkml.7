Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 11:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A042173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566645952;
	bh=p0T18Ac2XKyz8tWjMXJ1tfKYxEKJw+mV/K1hBTkTLdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n7X/hX3SaHZIQsGfrg4niB5ePDkuI/H7KmQT/O9Wck36k2Knqgj/nao9tTYsrNOJT
	 w6rEVXzpOQVu+FHtaol4FUM9ShRZseTp0Nyo6+HB+PEL1+WCyQaD8yHpT9HOYBObbF
	 A79hv/fIMwkKanRBA2D6yqLSe75n2go3rzJciONE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHXLZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 07:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfHXLZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 07:25:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA5D206BB;
        Sat, 24 Aug 2019 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566645950;
        bh=p0T18Ac2XKyz8tWjMXJ1tfKYxEKJw+mV/K1hBTkTLdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2CmPfEKS8W1/Txnq5raX/38HHvvimfslr6SB+oGrQSDls/D7J9Bco9NNUGtujrHs
         q9PQqsqwGngHAaLNowMgJ+xsUI2EdALL+jZeWRwMzGHHIhF8O1psIuKq8TT86NQQvH
         m2CGOkOQUmyeA77k5EP7ArwKtxP1l0hRJsvXg1sg=
Date:   Sat, 24 Aug 2019 12:25:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Yonghong Song <yhs@fb.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH 12/16] arm64: prefer __section from compiler_attributes.h
Message-ID: <20190824112542.7guulvdenm35ihs7@willie-the-truck>
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-12-ndesaulniers@google.com>
 <20190813082744.xmzmm4j675rqiz47@willie-the-truck>
 <CANiq72mAfJ23PyWzZAELgbKQDCX2nvY0z+dmOMe14qz=wa6eFg@mail.gmail.com>
 <20190813170829.c3lryb6va3eopxd7@willie-the-truck>
 <CAKwvOdk4hca8WzWzhcPEvxXnJVLbXGnhBdDZbeL_W_H91Ttjqw@mail.gmail.com>
 <CANiq72mGoGpx7EAVUPcGuhVkLit8sB3bR-k1XBDyeM8HBUaDZw@mail.gmail.com>
 <CANiq72nUyT-q3A9mTrYzPZ+J9Ya7Lns5MyTK7W7-7yXgFWc2xA@mail.gmail.com>
 <CANiq72nfn4zxAO63GEEoUjumC6Jwi5_jdcD_5Xzt1vZRgh52fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nfn4zxAO63GEEoUjumC6Jwi5_jdcD_5Xzt1vZRgh52fg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 09:35:08PM +0200, Miguel Ojeda wrote:
> On Thu, Aug 15, 2019 at 11:12 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Btw, I guess that is the Oops you were mentioning in the cover letter?
> 
> Pinging about this...

Which bit are you pinging about? This patch (12/16) has been in -next for a
while and is queued in the arm64 tree for 5.4. The Oops/boot issue is
addressed in patch 14 which probably needs to be sent as a separate patch
(with a commit message) if it's targetting 5.3 and, I assume, routed via
somebody like akpm.

Will
