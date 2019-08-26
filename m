Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA6C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF4A21881
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566853608;
	bh=vJ5uUohdIc/5pI1u/M25vO7AHh7h8uA742G5yrcV0Fo=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=ju/mE03Usl+fqQIseLtBdULUOysaP38/DHzGjfiRdceNR5+zuLrZeeqbzEcoFchm2
	 MsKSgzS5ChSjHV6DsDsL+yXh8iUh+9TVMqfY/aGBdCQP+n0KS95depiJDYzRrvbaxZ
	 Ywi6NEHkc65bAsl6bHzZW+VzZZNZ1eoEleb2dxa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfHZVGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfHZVGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:06:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A873C21881;
        Mon, 26 Aug 2019 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566853602;
        bh=vJ5uUohdIc/5pI1u/M25vO7AHh7h8uA742G5yrcV0Fo=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=BXcFaalVBpVIp5kgqs4OU3EG22zeIPuaxTV+l6NABfRck3//2UC+vOYLpWsP2z2VJ
         yX4aQivm2AmGzabk0iZf1Wzv9hlylP/FfJxlI9dqAjMqNZlD3oSNWBvJl9J9qmi+cG
         OsQGG7LOG8cLzSHTdqR5i2gvFZZVO811tLOHNbxw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819222915.56150-1-sboyd@kernel.org>
References: <20190819222915.56150-1-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH] clk: Make of_parse_clkspec() return -ENOENT on errors
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 26 Aug 2019 14:06:41 -0700
Message-Id: <20190826210642.A873C21881@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hrmm.. the subject is misleading. Let me reword it and resend.

Quoting Stephen Boyd (2019-08-19 15:29:15)
> The return value of of_parse_clkspec() is peculiar. If the function is
> called with a NULL argument for 'name' it will return -ENOENT, but if
> it's called with a non-NULL argument for 'name' it will return -EINVAL.
> This peculiarity is documented by commit 5c56dfe63b6e ("clk: Add comment
> about __of_clk_get_by_name() error values").
>=20
> Let's further document this function so that it's clear what the return
> value is and how to use the arguments to parse clk specifiers.
>=20
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
