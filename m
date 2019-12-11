Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5778CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD982077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfLKNAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:00:35 -0500
Received: from www62.your-server.de ([213.133.104.62]:53664 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLKNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:00:34 -0500
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1if1bU-0002Im-Km; Wed, 11 Dec 2019 14:00:32 +0100
Date:   Wed, 11 Dec 2019 14:00:32 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Fix build in minimal configurations, again
Message-ID: <20191211130032.GB23015@linux.fritz.box>
References: <20191210203553.2941035-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210203553.2941035-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25660/Wed Dec 11 10:47:07 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:35:46PM +0100, Arnd Bergmann wrote:
> Building with -Werror showed another failure:
> 
> kernel/bpf/btf.c: In function 'btf_get_prog_ctx_type.isra.31':
> kernel/bpf/btf.c:3508:63: error: array subscript 0 is above array bounds of 'u8[0]' {aka 'unsigned char[0]'} [-Werror=array-bounds]
>   ctx_type = btf_type_member(conv_struct) + bpf_ctx_convert_map[prog_type] * 2;
> 
> I don't actually understand why the array is empty, but a similar
> fix has addressed a related problem, so I suppose we can do the
> same thing here.
> 
> Fixes: ce27709b8162 ("bpf: Fix build in minimal configurations")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
