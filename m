Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A01D21872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573515574;
	bh=giENcYoxNX1U3BVpJL1kOu9YRWXh/5mhELyr0r5TYJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pFjpnKRVSaVSdB/p7HCDAuL5LvoJfnJE0m3CdymQ9HC46lgNG+8pjN+acOBz3U0xY
	 VOomsTbMpIQdVw39EieuI+9TkIZHj+G48XfmbP/GLU/RigElivbb1T59n942m627oM
	 kIHL8dusz6ROaFm9DXcVYR9WCpn1jpAhrVGgov7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfKKXjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfKKXjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:39:33 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387A3214DB;
        Mon, 11 Nov 2019 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573515572;
        bh=giENcYoxNX1U3BVpJL1kOu9YRWXh/5mhELyr0r5TYJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HE5NIfwe5GY7DfSwk8ze/X5zVp8IQcxUPElx2TZeg4Tv2iW5Tns2MCmOoxbCLN21b
         rMqFg+EiT5ZzKgUdyEwteLODj92Da4xGPsS0yyZ1fG+xzO8+k/HfTuw2FnaI2y3OTl
         eIhNmOepWnUnSIOgk0gXIVqjHTVWYwCZWw2ZYHxc=
Date:   Mon, 11 Nov 2019 15:39:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitalywool@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] zswap: allow setting default status, compressor and
 allocator in Kconfig
Message-Id: <20191111153931.199e4c729bfad2e8201e75a5@linux-foundation.org>
In-Reply-To: <20191108235107.2837339-1-mail@maciej.szmigiero.name>
References: <20191108235107.2837339-1-mail@maciej.szmigiero.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Nov 2019 00:51:07 +0100 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> wrote:

> The compressed cache for swap pages (zswap) currently needs from 1 to 3
> extra kernel command line parameters in order to make it work: it has to be
> enabled by adding a "zswap.enabled=1" command line parameter and if one
> wants a different compressor or pool allocator than the default lzo / zbud
> combination then these choices also need to be specified on the kernel
> command line in additional parameters.
> 
> Using a different compressor and allocator for zswap is actually pretty
> common as guides often recommend using the lz4 / z3fold pair instead of
> the default one.
> In such case it is also necessary to remember to enable the appropriate
> compression algorithm and pool allocator in the kernel config manually.
> 
> Let's avoid the need for adding these kernel command line parameters and
> automatically pull in the dependencies for the selected compressor
> algorithm and pool allocator by adding an appropriate default switches to
> Kconfig.
> 
> The default values for these options match what the code was using
> previously as its defaults.

Shouldn't there be a Documentation/ update along with this change?
