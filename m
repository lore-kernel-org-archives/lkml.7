Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A02C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712E9212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559931245;
	bh=UdznyVpRLBkTyuEoupaePTT33UjXWCnnxsQdTJKxo4Q=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=Aw5OoNxOlXJ7LMjfrlAnLRkrdLyLtNnNxPhrxxzTVWl7ftZJ+DIGKvqu03qNkxe6c
	 iV5MM7OMXwl+t0ldCEoHxx5mIK97uoKOFU0bwzCYLh7kwKWFRq3+IO6gnPjkoWsSHO
	 yZWLaNIzqKIA7VhtgOG996rNjmX6x3xOgOihuCl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfFGSOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbfFGSOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:14:03 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F9820868;
        Fri,  7 Jun 2019 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559931242;
        bh=UdznyVpRLBkTyuEoupaePTT33UjXWCnnxsQdTJKxo4Q=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=T1E46J9x/Y3mc1Ns6Or3nqaANxl2yDrd3n+pp3KNPD/W7cmLkijwMwceya5LP2rBS
         u1Tn3hQQ9pgY9IxmdiTchSQCjo6raPxsaDGE1txJUZGwvOS3pn/oCCl9cTjnNy7tcV
         I889Nknlvh4dsJejPqUpv9s8bTtXfGUN1qbUQAfY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190520080421.12575-2-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org> <20190520080421.12575-2-wens@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 01/25] clk: Fix debugfs clk_possible_parents for clks without parent string names
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 11:14:01 -0700
Message-Id: <20190607181402.B3F9820868@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2019-05-20 01:03:57)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index aa51756fd4d6..bdb077ba59b9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3000,12 +3000,16 @@ DEFINE_SHOW_ATTRIBUTE(clk_flags);
>  static int possible_parents_show(struct seq_file *s, void *data)
>  {
>         struct clk_core *core =3D s->private;
> +       struct clk_core *parent;
>         int i;
> =20
> -       for (i =3D 0; i < core->num_parents - 1; i++)
> -               seq_printf(s, "%s ", core->parents[i].name);
> +       for (i =3D 0; i < core->num_parents - 1; i++) {
> +               parent =3D clk_core_get_parent_by_index(core, i);
> +               seq_printf(s, "%s ", parent ? parent->name : NULL);
> +       }
> =20
> -       seq_printf(s, "%s\n", core->parents[i].name);
> +       parent =3D clk_core_get_parent_by_index(core, i);
> +       seq_printf(s, "%s", parent ? parent->name : NULL);

What do we do if the parent won't appear on this system, but we've
listed it as a possible parent with the '.fw_name' string? Is that not a
"possible" parent because it won't ever appear?

I'm mostly saying that we should try to detect these corner cases and
print something besides NULL. Maybe we could even print the fallback
'.name' if clk_core_get_parent_by_index() fails (and '.name' isn't
NULL).  Then we're left with the case where even the fallback '.name' is
NULL, and we can print something like "<fw_name> (fw)" to indicate that
we're waiting for the kernel to probe a provider for that parent, but
the firmware name is <fw_name> and that's all we know.

