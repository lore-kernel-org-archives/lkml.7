Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B0C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7648B21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HfBSz/IN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="TGYs9VDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfIINsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:48:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64220 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfIINsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:48:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6F832823C;
        Mon,  9 Sep 2019 09:48:18 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=PPL3tsPzTCjx0UJ55+KB4byy/08=; b=HfBSz/
        INF8pkRHwV3efZ8mB9+b1v1XCNa26Er8EBT9zJyIhfppOGw9dHvu9yjMrql92Zl3
        ZL5O/PS1Yf32NRitygbaoT9YENTjdr8yJACbmJCFTfcQ3mDb1bCy6YKVCE2ALv9K
        5Xlhljdon/UpZeDhRYIpRd8t9KHiTy1vcDGBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF89F2823B;
        Mon,  9 Sep 2019 09:48:18 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=23ZJLxU481DjocaHI4wqPJqunWt7SkjVe1vkmCDbANA=; b=TGYs9VDY3vZ1PfWtkq8dDLtHwpDJB/QsgdSsumomNVqSekQX8XDIKO5KKKXYTuQtNi9w9hji2uhHMF/ky9Teg5O8QdIamZ1T5pYyBnAi8tAjU1wxbRVMOBBPqSROZDZYvhCOuVEfhGKVUVxROjOjlq77/00Rhdwgb+BZZLoAvQM=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1243B2823A;
        Mon,  9 Sep 2019 09:48:18 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 37A812DA01B6;
        Mon,  9 Sep 2019 09:48:17 -0400 (EDT)
Date:   Mon, 9 Sep 2019 09:48:17 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] export.h: remove defined(__KERNEL__)
In-Reply-To: <20190909105317.20473-1-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1909090942420.3091@knanqh.ubzr>
References: <20190909105317.20473-1-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 7A8F552A-D308-11E9-80F7-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019, Masahiro Yamada wrote:

> This line was touched by commit f235541699bc ("export.h: allow for
> per-symbol configurable EXPORT_SYMBOL()"), but the commit log did
> not explain why.
> 
> CONFIG_TRIM_UNUSED_KSYMS works for me without defined(__KERNEL__).

I'm pretty sure it was needed back then so not to interfere with users 
of this file. My fault for not documenting it.


Nicolas
