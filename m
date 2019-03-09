Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E79C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3659D20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PlXRhObj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCIAHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:07:38 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53414 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfCIAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:07:37 -0500
Received: by mail-it1-f193.google.com with SMTP id v2so23505561ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 16:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOPcnDwjRtJASG8Fba0cKGK/d1DjEdud1jwRt8aKDI4=;
        b=PlXRhObjwAdZN7AAiZ2bWddoC1oosqYiiZL1k0N5D0LUZUcACt8t4GGtdsijI9mojy
         UDUwLFQ27juS3Nb/MbSt4WGsjTUO7O6TW/h9pNLb7bTqyVD5AeS0mKHcsgvZtblOjyE9
         HUAipZkVTxq9Yz1op9tNxDNvBg6les8O5DVhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOPcnDwjRtJASG8Fba0cKGK/d1DjEdud1jwRt8aKDI4=;
        b=hQu7Cl/+ItEjK1JrjtZZI76cjE67tC9roOtT4UNluUTZ8oNCV8+csaEQU/aFolEb1B
         QWSlSrgnfJxLjubNh2kvtzDQDE2eF3ftOCtVMue1jpSEsDLKOKUPjxJUIaJ2bdVqTxia
         zZ0lNxFuTrbIqDyO6JciyZ82yz7wu+BIZAFNyAptjVw/r9VFsD4Kkg/Vy9NBFm4erltk
         ckHwzkOu18B0VfgbgCEBPSdinvUBQcgyBg6C+Yo5fkcmySIZcKFVlw0HkZwDSP9PVozz
         dHqML//47QpdBfN7Xpinz1GDczcxKyq+nri+A+knKeOU/sYjyoSflW9/rUafvX2GP7Rt
         N/hg==
X-Gm-Message-State: APjAAAUW7I5ta1FknETKuPqIUxvs9s8PE8T0Sja8CzbzttA8EQeB6kLt
        Xut3MF5NYUeI0cL1YFhQtwCKMVL2ULUCKUoW0JFs9fw9S2A=
X-Google-Smtp-Source: APXvYqx+CvNkXkFPILtiDtq7hMgAmz9fa0XOxlKdN5dYCZOQRRw/hYpMhIzEUISiNm+eq+BoEdN0hw6G2Cb0AXk4Pdk=
X-Received: by 2002:a24:38c:: with SMTP id e134mr9809713ite.24.1552090055522;
 Fri, 08 Mar 2019 16:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20190305044936.22267-1-dbasehore@chromium.org> <20190305044936.22267-4-dbasehore@chromium.org>
In-Reply-To: <20190305044936.22267-4-dbasehore@chromium.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Fri, 8 Mar 2019 16:07:24 -0800
Message-ID: <CAGAzgsqBnLtsnfp5aqhgng-SSWb=hP=j1vzGkkA4d3a-tSzJtQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] clk: change rates via list iteration
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 8:49 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> This changes the clk_set_rate code to use lists instead of recursion.
> While making this change, also add error handling for clk_set_rate.
> This means that errors in the set_rate/set_parent/set_rate_and_parent
> functions will not longer be ignored. When an error occurs, the clk
> rates and parents are reset, unless an error occurs here, in which we
> bail and cross our fingers.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/clk/clk.c | 256 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 176 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e20364812b54..1637dc262884 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -39,6 +39,13 @@ static LIST_HEAD(clk_notifier_list);
>
>  /***    private data structures    ***/
>
> +struct clk_change {
> +       struct list_head        change_list;
> +       unsigned long           rate;
> +       struct clk_core         *core;
> +       struct clk_core         *parent;
> +};
> +
>  struct clk_core {
>         const char              *name;
>         const struct clk_ops    *ops;
> @@ -49,11 +56,9 @@ struct clk_core {
>         const char              **parent_names;
>         struct clk_core         **parents;
>         u8                      num_parents;
> -       u8                      new_parent_index;
>         unsigned long           rate;
>         unsigned long           req_rate;
> -       unsigned long           new_rate;
> -       struct clk_core         *new_parent;
> +       struct clk_change       change;
>         struct clk_core         *new_child;
>         unsigned long           flags;
>         bool                    orphan;
> @@ -1735,19 +1740,52 @@ static int __clk_speculate_rates(struct clk_core *core,
>  static void clk_calc_subtree(struct clk_core *core)
>  {
>         struct clk_core *child;
> +       LIST_HEAD(tmp_list);
>
> -       hlist_for_each_entry(child, &core->children, child_node) {
> -               child->new_rate = clk_recalc(child, core->new_rate);
> -               clk_calc_subtree(child);
> +       list_add(&core->prepare_list, &tmp_list);
> +       while (!list_empty(&tmp_list)) {
> +               core = list_first_entry(&tmp_list, struct clk_core,
> +                                       prepare_list);
> +
> +               hlist_for_each_entry(child, &core->children, child_node) {
> +                       child->change.rate = clk_recalc(child,
> +                                                       core->change.rate);
> +                       list_add_tail(&child->prepare_list, &tmp_list);
> +               }
> +
> +               list_del(&core->prepare_list);
> +       }
> +}
> +
> +static void clk_prepare_changes(struct list_head *change_list,
> +                               struct clk_core *core)
> +{
> +       struct clk_change *change;
> +       struct clk_core *tmp, *child;
> +       LIST_HEAD(tmp_list);
> +
> +       list_add(&core->change.change_list, &tmp_list);
> +       while (!list_empty(&tmp_list)) {
> +               change = list_first_entry(&tmp_list, struct clk_change,
> +                                         change_list);
> +               tmp = change->core;
> +
> +               hlist_for_each_entry(child, &tmp->children, child_node)
> +                       list_add_tail(&child->change.change_list, &tmp_list);
> +
> +               child = tmp->new_child;
> +               if (child)
> +                       list_add_tail(&child->change.change_list, &tmp_list);
> +
> +               list_move_tail(&tmp->change.change_list, change_list);
>         }
>  }
>
>  static void clk_set_change(struct clk_core *core, unsigned long new_rate,
> -                          struct clk_core *new_parent, u8 p_index)
> +                          struct clk_core *new_parent)
>  {
> -       core->new_rate = new_rate;
> -       core->new_parent = new_parent;
> -       core->new_parent_index = p_index;
> +       core->change.rate = new_rate;
> +       core->change.parent = new_parent;
>         /* include clk in new parent's PRE_RATE_CHANGE notifications */
>         core->new_child = NULL;
>         if (new_parent && new_parent != core->parent)
> @@ -1767,7 +1805,6 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>         unsigned long new_rate;
>         unsigned long min_rate;
>         unsigned long max_rate;
> -       int p_index = 0;
>         long ret;
>
>         /* sanity */
> @@ -1803,17 +1840,15 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                         return NULL;
>         } else if (!parent || !(core->flags & CLK_SET_RATE_PARENT)) {
>                 /* pass-through clock without adjustable parent */
> -               core->new_rate = core->rate;
>                 return NULL;
>         } else {
>                 /* pass-through clock with adjustable parent */
>                 top = clk_calc_new_rates(parent, rate);
> -               new_rate = parent->new_rate;
> +               new_rate = parent->change.rate;
>                 hlist_for_each_entry(child, &parent->children, child_node) {
>                         if (child == core)
>                                 continue;
> -
> -                       child->new_rate = clk_recalc(child, new_rate);
> +                       child->change.rate = clk_recalc(child, new_rate);
>                         clk_calc_subtree(child);
>                 }
>                 goto out;
> @@ -1827,16 +1862,6 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                 return NULL;
>         }
>
> -       /* try finding the new parent index */
> -       if (parent && core->num_parents > 1) {
> -               p_index = clk_fetch_parent_index(core, parent);
> -               if (p_index < 0) {
> -                       pr_debug("%s: clk %s can not be parent of clk %s\n",
> -                                __func__, parent->name, core->name);
> -                       return NULL;
> -               }
> -       }
> -
>         if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
>             best_parent_rate != parent->rate) {
>                 top = clk_calc_new_rates(parent, best_parent_rate);
> @@ -1844,13 +1869,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                         if (child == core)
>                                 continue;
>
> -                       child->new_rate = clk_recalc(child, parent->new_rate);
> +                       child->change.rate = clk_recalc(child,
> +                                       parent->change.rate);
>                         clk_calc_subtree(child);
>                 }
>         }
>
>  out:
> -       clk_set_change(core, new_rate, parent, p_index);
> +       clk_set_change(core, new_rate, parent);
>
>         return top;
>  }
> @@ -1866,18 +1892,18 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
>         struct clk_core *child, *tmp_clk, *fail_clk = NULL;
>         int ret = NOTIFY_DONE;
>
> -       if (core->rate == core->new_rate)
> +       if (core->rate == core->change.rate)
>                 return NULL;
>
>         if (core->notifier_count) {
> -               ret = __clk_notify(core, event, core->rate, core->new_rate);
> +               ret = __clk_notify(core, event, core->rate, core->change.rate);
>                 if (ret & NOTIFY_STOP_MASK)
>                         fail_clk = core;
>         }
>
>         hlist_for_each_entry(child, &core->children, child_node) {
>                 /* Skip children who will be reparented to another clock */
> -               if (child->new_parent && child->new_parent != core)
> +               if (child->change.parent && child->change.parent != core)
>                         continue;
>                 tmp_clk = clk_propagate_rate_change(child, event);
>                 if (tmp_clk)
> @@ -1898,101 +1924,152 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
>   * walk down a subtree and set the new rates notifying the rate
>   * change on the way
>   */
> -static void clk_change_rate(struct clk_core *core)
> +static int clk_change_rate(struct clk_change *change)
>  {
> -       struct clk_core *child;
> -       struct hlist_node *tmp;
> -       unsigned long old_rate;
> +       struct clk_core *core = change->core;
> +       unsigned long old_rate, flags;
>         unsigned long best_parent_rate = 0;
>         bool skip_set_rate = false;
> -       struct clk_core *old_parent;
> +       struct clk_core *old_parent = NULL;
>         struct clk_core *parent = NULL;
> +       int p_index;
> +       int ret = 0;
>
>         old_rate = core->rate;
>
> -       if (core->new_parent) {
> -               parent = core->new_parent;
> -               best_parent_rate = core->new_parent->rate;
> +       if (change->parent) {
> +               parent = change->parent;
> +               best_parent_rate = parent->rate;
>         } else if (core->parent) {
>                 parent = core->parent;
> -               best_parent_rate = core->parent->rate;
> +               best_parent_rate = parent->rate;
>         }
>
> -       if (clk_pm_runtime_get(core))
> -               return;
> -
>         if (core->flags & CLK_SET_RATE_UNGATE) {
> -               unsigned long flags;
> -
>                 clk_core_prepare(core);
>                 flags = clk_enable_lock();
>                 clk_core_enable(core);
>                 clk_enable_unlock(flags);
>         }
>
> -       if (core->new_parent && core->new_parent != core->parent) {
> -               old_parent = __clk_set_parent_before(core, core->new_parent);
> -               trace_clk_set_parent(core, core->new_parent);
> +       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               clk_core_prepare_enable(parent);
> +
> +       if (parent != core->parent) {
> +               p_index = clk_fetch_parent_index(core, parent);
> +               if (p_index < 0) {
> +                       pr_debug("%s: clk %s can not be parent of clk %s\n",
> +                                __func__, parent->name, core->name);
> +                       ret = p_index;
> +                       goto out;
> +               }
> +               old_parent = __clk_set_parent_before(core, parent);
> +
> +               trace_clk_set_parent(core, change->parent);
>
>                 if (core->ops->set_rate_and_parent) {
>                         skip_set_rate = true;
> -                       core->ops->set_rate_and_parent(core->hw, core->new_rate,
> +                       ret = core->ops->set_rate_and_parent(core->hw,
> +                                       change->rate,
>                                         best_parent_rate,
> -                                       core->new_parent_index);
> +                                       p_index);
>                 } else if (core->ops->set_parent) {
> -                       core->ops->set_parent(core->hw, core->new_parent_index);
> +                       ret = core->ops->set_parent(core->hw, p_index);
>                 }
>
> -               trace_clk_set_parent_complete(core, core->new_parent);
> -               __clk_set_parent_after(core, core->new_parent, old_parent);
> -       }
> +               trace_clk_set_parent_complete(core, change->parent);
> +               if (ret) {
> +                       flags = clk_enable_lock();
> +                       clk_reparent(core, old_parent);
> +                       clk_enable_unlock(flags);
> +                       __clk_set_parent_after(core, old_parent, parent);
>
> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> -               clk_core_prepare_enable(parent);
> +                       goto out;
> +               }
> +               __clk_set_parent_after(core, parent, old_parent);
> +
> +       }
>
> -       trace_clk_set_rate(core, core->new_rate);
> +       trace_clk_set_rate(core, change->rate);
>
>         if (!skip_set_rate && core->ops->set_rate)
> -               core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
> +               ret = core->ops->set_rate(core->hw, change->rate,
> +                               best_parent_rate);
>
> -       trace_clk_set_rate_complete(core, core->new_rate);
> +       trace_clk_set_rate_complete(core, change->rate);
>
>         core->rate = clk_recalc(core, best_parent_rate);
>
> -       if (core->flags & CLK_SET_RATE_UNGATE) {
> -               unsigned long flags;
> +out:
> +       if (core->flags & CLK_OPS_PARENT_ENABLE)
> +               clk_core_disable_unprepare(parent);
> +
> +       if (core->notifier_count && old_rate != core->rate)
> +               __clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
>
> +       if (core->flags & CLK_SET_RATE_UNGATE) {
>                 flags = clk_enable_lock();
>                 clk_core_disable(core);
>                 clk_enable_unlock(flags);
>                 clk_core_unprepare(core);
>         }
>
> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
> -               clk_core_disable_unprepare(parent);
> +       if (core->flags & CLK_RECALC_NEW_RATES)
> +               (void)clk_calc_new_rates(core, change->rate);
>
> -       if (core->notifier_count && old_rate != core->rate)
> -               __clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
> +       /*
> +        * Keep track of old parent and requested rate in case we have
> +        * to undo the change due to an error.
> +        */
> +       change->parent = old_parent;
> +       change->rate = old_rate;
> +       return ret;
> +}
>
> -       if (core->flags & CLK_RECALC_NEW_RATES)
> -               (void)clk_calc_new_rates(core, core->new_rate);
> +static int clk_change_rates(struct list_head *list)
> +{
> +       struct clk_change *change, *tmp;
> +       int ret = 0;
>
>         /*
> -        * Use safe iteration, as change_rate can actually swap parents
> -        * for certain clock types.
> +        * Make pm runtime get/put calls outside of clk_change_rate to avoid
> +        * clks bouncing back and forth between runtime_resume/suspend.
>          */
> -       hlist_for_each_entry_safe(child, tmp, &core->children, child_node) {
> -               /* Skip children who will be reparented to another clock */
> -               if (child->new_parent && child->new_parent != core)
> -                       continue;
> -               clk_change_rate(child);
> +       list_for_each_entry(change, list, change_list) {
> +               ret = clk_pm_runtime_get(change->core);
> +               if (ret) {
> +                       list_for_each_entry_continue_reverse(change, list,
> +                                                            change_list)
> +                               clk_pm_runtime_put(change->core);
> +
> +                       return ret;
> +               }
>         }
>
> -       /* handle the new child who might not be in core->children yet */
> -       if (core->new_child)
> -               clk_change_rate(core->new_child);
> +       list_for_each_entry(change, list, change_list) {
> +               ret = clk_change_rate(change);
> +               clk_pm_runtime_put(change->core);
> +               if (ret)
> +                       goto err;
> +       }
>
> -       clk_pm_runtime_put(core);
> +       return 0;
> +err:
> +       /* Unwind the changes on an error. */
> +       list_for_each_entry_continue_reverse(change, list, change_list) {

I thought about this, and I think this should go back to the way I did
things in v1 with the change order. Since clk set_rate callbacks can
rely on the parent's current rate, undoing changes in reverse order
might result in incorrect changes.

> +               /* Just give up on an error when undoing changes. */
> +               ret = clk_pm_runtime_get(change->core);
> +               if (WARN_ON(ret))
> +                       return ret;
> +
> +               ret = clk_change_rate(change);
> +               if (WARN_ON(ret))
> +                       return ret;
> +
> +               clk_pm_runtime_put(change->core);
> +       }
> +
> +       return ret;
>  }
>
>  static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
> @@ -2026,7 +2103,9 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>                                     unsigned long req_rate)
>  {
>         struct clk_core *top, *fail_clk, *child;
> +       struct clk_change *change, *tmp;
>         unsigned long rate;
> +       LIST_HEAD(changes);
>         int ret = 0;
>
>         if (!core)
> @@ -2052,14 +2131,17 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>                 return ret;
>
>         if (top != core) {
> -               /* new_parent cannot be NULL in this case */
> -               hlist_for_each_entry(child, &core->new_parent->children,
> +               /* change.parent cannot be NULL in this case */
> +               hlist_for_each_entry(child, &core->change.parent->children,
>                                 child_node)
>                         clk_calc_subtree(child);
>         } else {
>                 clk_calc_subtree(core);
>         }
>
> +       /* Construct the list of changes */
> +       clk_prepare_changes(&changes, top);
> +
>         /* notify that we are about to change rates */
>         fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>         if (fail_clk) {
> @@ -2071,7 +2153,19 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>         }
>
>         /* change the rates */
> -       clk_change_rate(top);
> +       ret = clk_change_rates(&changes);
> +       list_for_each_entry_safe(change, tmp, &changes, change_list) {
> +               change->rate = 0;
> +               change->parent = NULL;
> +               list_del_init(&change->change_list);
> +       }
> +
> +       if (ret) {
> +               pr_debug("%s: failed to set %s rate via top clk %s\n", __func__,
> +                               core->name, top->name);
> +               clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
> +               goto err;
> +       }
>
>         core->req_rate = req_rate;
>  err:
> @@ -3338,6 +3432,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>         core->max_rate = ULONG_MAX;
>         INIT_LIST_HEAD(&core->prepare_list);
>         INIT_LIST_HEAD(&core->enable_list);
> +       INIT_LIST_HEAD(&core->change.change_list);
> +       core->change.core = core;
>         hw->core = core;
>
>         /* allocate local copy in case parent_names is __initdata */
> --
> 2.21.0.352.gf09ad66450-goog
>
