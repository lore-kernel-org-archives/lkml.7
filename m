Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6C9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF0F2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556921487;
	bh=YxHTZShOcDV00VQUHv/xm7oSbg5tXMsEy2BisbYC/z4=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=uusgyzvHtuP6wmo76ZNIvim3hfXsny31dSwk2Rm+jJp1tX9Pu8RjfFMD5e/KTbfvs
	 fpcqd3Jx/O27NKGU41Vz0rod/tUa+p3CzOhAACbzIOD3X9aZUwam01gBrzZWXblFC4
	 oy13p+t544AYovMNiNjRydmvdq4U0R1gt6+Swke8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfECWL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfECWLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:11:25 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BAB206E0;
        Fri,  3 May 2019 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556921484;
        bh=YxHTZShOcDV00VQUHv/xm7oSbg5tXMsEy2BisbYC/z4=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=oMojVehQzvqv1ds0vigIDtbGTnRifWLy0j05yvSTQ0IgKts12O328jAFiC29VawIe
         ZEyiwy+G8XG2HboizeOA9yARJIf13horlV899Fj2fNkFzWQjyU42U+NSKPsxtVVuMn
         7WA8VJaQr2xx/XOdmFPgKK1qr+/9SzcBhHjv2en8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190503212208.223232-1-dianders@chromium.org>
References: <20190503212208.223232-1-dianders@chromium.org>
Cc:     hal@halemmerich.com, linux-rockchip@lists.infradead.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: rockchip: Don't yell about bad mmc phases when getting
Message-ID: <155692148370.12939.291938595926908281@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 15:11:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-05-03 14:22:08)
> At boot time, my rk3288-veyron devices yell with 8 lines that look
> like this:
>   [    0.000000] rockchip_mmc_get_phase: invalid clk rate
>=20
> This is because the clock framework at clk_register() time tries to
> get the phase but we don't have a parent yet.
>=20
> While the errors appear to be harmless they are still ugly and, in
> general, we don't want yells like this in the log unless they are
> important.
>=20
> There's no real reason to be yelling here.  We can still return
> -EINVAL to indicate that the phase makes no sense without a parent.
> If someone really tries to do tuning and the clock is reported as 0
> then we'll see the yells in rockchip_mmc_set_phase().
>=20
> Fixes: 4bf59902b500 ("clk: rockchip: Prevent calculating mmc phase if clo=
ck rate is zero")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Change looks fine, but this driver should call clk_hw_get_rate() on the
clk instead of clk_get_rate(). Unless that needs to recalc the rate for
some reason?

Also, we don't check for errors from clk_ops::get_phase() in clk.c
before storing away the result into the clk_core::phase member. I
suppose we should skip the store in this case so that debugfs results
don't look odd.

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..2455b2c43386 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2606,14 +2606,14 @@ EXPORT_SYMBOL_GPL(clk_set_phase);
=20
 static int clk_core_get_phase(struct clk_core *core)
 {
-	int ret;
+	int ret =3D 0;
=20
-	clk_prepare_lock();
+	lockdep_assert_held(&prepare_lock);
 	/* Always try to update cached phase if possible */
 	if (core->ops->get_phase)
-		core->phase =3D core->ops->get_phase(core->hw);
-	ret =3D core->phase;
-	clk_prepare_unlock();
+		ret =3D core->ops->get_phase(core->hw);
+	if (ret >=3D 0)
+		core->phase =3D ret;
=20
 	return ret;
 }
@@ -2627,10 +2627,16 @@ static int clk_core_get_phase(struct clk_core *core)
  */
 int clk_get_phase(struct clk *clk)
 {
+	int ret;
+
 	if (!clk)
 		return 0;
=20
-	return clk_core_get_phase(clk->core);
+	clk_prepare_unlock();
+	ret =3D clk_core_get_phase(clk->core);
+	clk_prepare_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_get_phase);
=20
@@ -2850,16 +2856,24 @@ static struct hlist_head *orphan_list[] =3D {
 static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 				 int level)
 {
+	int phase;
+
 	if (!c)
 		return;
=20
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
+	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
-		   clk_core_get_rate(c), clk_core_get_accuracy(c),
-		   clk_core_get_phase(c),
-		   clk_core_get_scaled_duty_cycle(c, 100000));
+		   clk_core_get_rate(c), clk_core_get_accuracy(c));
+
+	phase =3D clk_core_get_phase(c);
+	if (phase >=3D 0)
+		seq_printf(s, "%5d", phase);
+	else
+		seq_printf(s, "-----");
+
+	seq_printf(s, " %6d\n", clk_core_get_scaled_duty_cycle(c, 100000));
 }
=20
 static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *=
c,
@@ -2899,6 +2913,8 @@ DEFINE_SHOW_ATTRIBUTE(clk_summary);
=20
 static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 {
+	int phase;
+
 	if (!c)
 		return;
=20
@@ -2909,7 +2925,9 @@ static void clk_dump_one(struct seq_file *s, struct c=
lk_core *c, int level)
 	seq_printf(s, "\"protect_count\": %d,", c->protect_count);
 	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate(c));
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
-	seq_printf(s, "\"phase\": %d,", clk_core_get_phase(c));
+	phase =3D clk_core_get_phase(c);
+	if (phase >=3D 0)
+		seq_printf(s, "\"phase\": %d,", phase);
 	seq_printf(s, "\"duty_cycle\": %u",
 		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
@@ -3248,10 +3266,7 @@ static int __clk_core_init(struct clk_core *core)
 	 * Since a phase is by definition relative to its parent, just
 	 * query the current clock phase, or just assume it's in phase.
 	 */
-	if (core->ops->get_phase)
-		core->phase =3D core->ops->get_phase(core->hw);
-	else
-		core->phase =3D 0;
+	clk_core_get_phase(core);
=20
 	/*
 	 * Set clk's duty cycle.
