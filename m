Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BFC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6789F20718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575310765;
	bh=Mxs13Bq2Hc395fEDycCp4i58HTi6qNbE8hBTBrlz/Vk=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=n6C2vWoUGyhTGOWX7sSk9r+j5wi1HALC2flkRr4haBVv8lR9g4k8AjOAF4zaECGQB
	 vOzkBiAeeVSOy428aGizyzLG1ygIqRkdFUXc+SsDUKT+6nZFmvsnZEPGwgTwwz89sr
	 m5IBXz5A2NHWQYBxxAg7fTx0sujlA3yHKQOhwEwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfLBSTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfLBSTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:19:24 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D26D20717;
        Mon,  2 Dec 2019 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575310763;
        bh=Mxs13Bq2Hc395fEDycCp4i58HTi6qNbE8hBTBrlz/Vk=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=Q/YlT+Dq1E8auTOdqK2zgTCyqjrXkH7Qs4t9Afs/PDOP5MK95Qw2QeP4iaEiz7TT2
         uOh0Re1R14g1AD1HhkohYGrDRbu/TSxt81UpEtNxodTU+7p2KO2nmJxIT4rxDvpI7S
         EhLgJm10101qxvcLruG3RmRCZJOrAa/MyBBXtUjM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191129161658.344517-1-jbrunet@baylibre.com>
References: <20191129161658.344517-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: walk orphan list on clock provider registration
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Mon, 02 Dec 2019 10:19:22 -0800
Message-Id: <20191202181923.4D26D20717@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-11-29 08:16:58)
> So far, we walked the orphan list every time a new clock was registered
> in CCF. This was fine since the clocks were only referenced by name.
>=20
> Now that the clock can be referenced through DT, it is not enough:
> * Controller A register first a reference clocks from controller B
>   through DT.
> * Controller B register all its clocks then register the provider.
>=20
> Each time controller B registers a new clock, the orphan list is walked
> but it can't match since the provider is registered yet. When the
> provider is finally registered, the orphan list is not walked unless
> another clock is registered afterward.
>=20
> This can lead to situation where some clocks remain orphaned even if
> the parent is available.
>=20
> Walking the orphan list on provider registration solves the problem.
>=20
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string n=
ames")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Sounds right. Thanks for making the fix!

I suspect there should be a reported-by tag though?

>  drivers/clk/clk.c | 59 +++++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ef4416721777..917ba37c3b9d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3249,6 +3249,34 @@ static inline void clk_debug_unregister(struct clk=
_core *core)
>  }
>  #endif
> =20
> +static void __clk_core_reparent_orphan(void)

Maybe drop the double underscore. clk_core prefix already means "private
to this file".

> +{
> +       struct clk_core *orphan;
> +       struct hlist_node *tmp2;
> +
> +       /*
> +        * walk the list of orphan clocks and reparent any that newly fin=
ds a
> +        * parent.
> +        */
> +       hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_n=
ode) {
> +               struct clk_core *parent =3D __clk_init_parent(orphan);
> +
> +               /*
> +                * We need to use __clk_set_parent_before() and _after() =
to
> +                * to properly migrate any prepare/enable count of the or=
phan
> +                * clock. This is important for CLK_IS_CRITICAL clocks, w=
hich
> +                * are enabled during init but might not have a parent ye=
t.
> +                */
> +               if (parent) {
> +                       /* update the clk tree topology */
> +                       __clk_set_parent_before(orphan, parent);
> +                       __clk_set_parent_after(orphan, parent, NULL);
> +                       __clk_recalc_accuracies(orphan);
> +                       __clk_recalc_rates(orphan, 0);
> +               }
> +       }
> +}
> +
>  /**
>   * __clk_core_init - initialize the data structures in a struct clk_core
>   * @core:      clk_core being initialized
> @@ -3259,8 +3287,6 @@ static inline void clk_debug_unregister(struct clk_=
core *core)
>  static int __clk_core_init(struct clk_core *core)
>  {
>         int ret;
> -       struct clk_core *orphan;
> -       struct hlist_node *tmp2;
>         unsigned long rate;
> =20
>         if (!core)
> @@ -3416,27 +3442,8 @@ static int __clk_core_init(struct clk_core *core)
>                 clk_enable_unlock(flags);
>         }
> =20
> -       /*
> -        * walk the list of orphan clocks and reparent any that newly fin=
ds a
> -        * parent.
> -        */
> -       hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_n=
ode) {
> -               struct clk_core *parent =3D __clk_init_parent(orphan);
> +       __clk_core_reparent_orphan();
> =20
> -               /*
> -                * We need to use __clk_set_parent_before() and _after() =
to
> -                * to properly migrate any prepare/enable count of the or=
phan
> -                * clock. This is important for CLK_IS_CRITICAL clocks, w=
hich
> -                * are enabled during init but might not have a parent ye=
t.
> -                */
> -               if (parent) {
> -                       /* update the clk tree topology */
> -                       __clk_set_parent_before(orphan, parent);
> -                       __clk_set_parent_after(orphan, parent, NULL);
> -                       __clk_recalc_accuracies(orphan);
> -                       __clk_recalc_rates(orphan, 0);
> -               }
> -       }
> =20
>         kref_init(&core->ref);
>  out:
> @@ -4288,6 +4295,10 @@ int of_clk_add_provider(struct device_node *np,
>         mutex_unlock(&of_clk_mutex);
>         pr_debug("Added clock from %pOF\n", np);
> =20
> +       clk_prepare_lock();
> +       __clk_core_reparent_orphan();
> +       clk_prepare_unlock();
> +

Maybe make a locked version of this function and an unlocked version?

>         ret =3D of_clk_set_defaults(np, true);
>         if (ret < 0)
>                 of_clk_del_provider(np);
> @@ -4323,6 +4334,10 @@ int of_clk_add_hw_provider(struct device_node *np,
>         mutex_unlock(&of_clk_mutex);
>         pr_debug("Added clk_hw provider from %pOF\n", np);
> =20
> +       clk_prepare_lock();
> +       __clk_core_reparent_orphan();
> +       clk_prepare_unlock();
> +

So we don't duplicate this twice.

>         ret =3D of_clk_set_defaults(np, true);
>         if (ret < 0)
