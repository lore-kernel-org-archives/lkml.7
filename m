Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71366C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A9D2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Tbyfly3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ts2EdpLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfLDRVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:21:12 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:46413 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbfLDRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:21:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 701412DD;
        Wed,  4 Dec 2019 12:21:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 04 Dec 2019 12:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9ubeIjKC3jZuuIvS2hBfJBMANKt
        1k1oLz7fj1WuUt7s=; b=Tbyfly3TVKDkoiUoZHQg7xXLS4G8NNXqpAl9Zn4cPGT
        qgS/K8vabLIqQd88j1nBdXzqXKCbAfYAFQs46HLrRun23yguwIx0KvpIpMWtM9hn
        LqQNiCmmtB/i4uFCuprmxN1qJ5l3cXAbDo1J13M38lC6T62cB1B9JnRGHAlqSVtR
        bwfLAQx4DSUMRSTezwYxKnSxzFNfvQwRX0EHBZQJiz6x+ez6sq21JQhTKJxjj/pH
        D+pOJB+gYFm07otVzWwHZSqnI63n2rS6rcnFY+M3SKclQibTcalNCiqG7+/5Zf0A
        Gmg1Qfa2jph6WTncBo4JdmViPWwbFPVeWV4CYP4EXMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9ubeIj
        KC3jZuuIvS2hBfJBMANKt1k1oLz7fj1WuUt7s=; b=Ts2EdpLfqSs9gQczjnkO9C
        7QkOTVrTNGaHKVCXUjWU0g7oDboJKzukD8SxblkLKvcEQvEBG2fOVGcxCf9OR+q2
        0RGtdRdph2ZNGl++zumD0MbIkzCGBwueCsKkHT52jlMIJoz8zXSkqXpyjPCilEEP
        ofcpL48l1n3P6h/r9e44WQlsaIqlzYkIUTkjJ5BktuliHrk802ygOzocsEXS7NNp
        bV2knn2Nkz7NbzDmpceBeDQNTjaW/pgm03g3d4hR8L6CuYwB2m4MKJ5DObHEQEah
        Oo5tNNGycmd+KEAiSuK5Yo+XWuDuvUvd3N2SfY0G4aAgzbRXTY60mt2mDtO2ky+w
        ==
X-ME-Sender: <xms:BevnXXs_LZpeXpopEPqildbfm6FG-Fszj_6rxpRhnFSzVwrydHw98g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necukfhppedvudejrdeikedrgeelrdejvdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:BevnXdhXsmiuw9ovucuwAEMXY8GHHHeL7cVDQ6pQtPYPW8fSzzO0sQ>
    <xmx:BevnXXy8IQXGBtANZ2gRQYNGx1xvmRNgbAtCmzL68lemVtlYdSaZjg>
    <xmx:BevnXT5KMz5urWivHUhElwWvT3i7V_kqzGmDEkKah2MLZKbgCSlE_g>
    <xmx:BuvnXWYKJDSmn5Q4J3B3HwduuwA5SU4jr56jpRY3lxRPaXTbgzsyUA>
Received: from localhost (unknown [217.68.49.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44E5B30600AA;
        Wed,  4 Dec 2019 12:21:09 -0500 (EST)
Date:   Wed, 4 Dec 2019 18:21:07 +0100
From:   Greg KH <greg@kroah.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: make usb_interrupt_msg() a static inline
Message-ID: <20191204172107.GF3627415@kroah.com>
References: <20191204143035.31751-1-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204143035.31751-1-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 03:30:35PM +0100, Enrico Weigelt, metux IT consult wrote:
> usb_interrupt_msg() effectively is just an alias for usb_bulk_msg(),
> no need for being an real function, thus converting it to an
> inline function.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

You also didn't even cc: the proper people as per
scripts/get_maintainer.pl so you obviously didn't even want the patch to
be reviewed or applied :(
