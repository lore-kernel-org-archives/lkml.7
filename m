Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493FFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C5A20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1Cr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:47:56 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:37391 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbfH1Crz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:47:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8F456182CED28;
        Wed, 28 Aug 2019 02:47:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: van62_44cf316c12c5a
X-Filterd-Recvd-Size: 1646
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 02:47:52 +0000 (UTC)
Message-ID: <e8851ba7888c433dac2ffa5d80f3289cd05940a3.camel@perches.com>
Subject: Re: [PATCH v2 00/14] treewide: prefer __section from
 compiler_attributes.h
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Aug 2019 19:47:51 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
References: <20190827204007.201890-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 13:39 -0700, Nick Desaulniers wrote:
> GCC unescapes escaped string section names while Clang does not. Because
> __section uses the `#` stringification operator for the section name, it
> doesn't need to be escaped.
> 
> This fixes an Oops observed in distro's that use systemd and not
> net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.
> 
> Instead, we should:
> 1. Prefer __section(.section_name_no_quotes).
> 2. Only use __attribute__((__section(".section"))) when creating the

Please use __ before and after section

i.e. __attribute__((__section__("<section_name>")))


