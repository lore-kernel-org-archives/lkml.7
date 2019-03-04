Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C440F206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LuwO2PIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCDRWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:22:05 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36612 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:22:03 -0500
Received: by mail-ua1-f65.google.com with SMTP id e15so5110315uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqdsfHiNVs4rO3T3EP9agsxB/fwg1sQmtuaGIHuzrGM=;
        b=LuwO2PIK/q3mY5KdjFM3Imc0hE8c0sSBHk8qdkulv9vOSnxxFCvlCrrGtkjJpj7BST
         0rCDQJgJqcQk+8KErymH2XhJZB6xj2LKzpNpNfOO0dsc4iU9e6Ad5ZgCf2Pi8B3MVjTZ
         f/zmfB6BOmV4ViPSbfycKAnt1hBaysYAlJeqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqdsfHiNVs4rO3T3EP9agsxB/fwg1sQmtuaGIHuzrGM=;
        b=IQOhKMybGvGiTomsmgs0Zmq+hXmLLXRDjYdwXKHQNPfYPlLlab8g0LaHo1v+/fXZYZ
         qglL4kCRFSokcIqTtU8BlBboBrNfXerlROSsBcAJTG1J0gY33JZ5HzRMlUpRXIZXTgEl
         Mh3lFQhqwwOfJv/eMA4UcPogSRjK3TMDyFqf7zxNcyi91o/7wMs68B4S708KLQvOV3jn
         wd+W+iMd2UTcMz8JYEOpxlWM/FEpsZc75cUa9Xq/JQbl7ex+omDgtPeHvhWZcmIUNDa7
         RuEu2+9V4E4n7kJAzeBR4pzTdT+/oe5YcSV+z+z08Wj4hDBrSYd01UB3Sw6K7HiHOhHH
         hrGg==
X-Gm-Message-State: APjAAAVrhnMAeh21J7KAxD+RGeCsLE1YLn2lrMAxw1FI9RecE04IxGUn
        FEeUNZKxo7Sp92rns/TCNoT3V67bsAM=
X-Google-Smtp-Source: APXvYqwWgJij8Q/RvUVt+VChwqFUTnGHLudUvKHuHVRRRM/nlKGLDm7ntWlnNKIHR0YhdZ/e+BRtdw==
X-Received: by 2002:a9f:2bc5:: with SMTP id f5mr10386837uaj.7.1551720121296;
        Mon, 04 Mar 2019 09:22:01 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id c3sm1151164uar.11.2019.03.04.09.21.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 09:21:58 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id x140so1302536vke.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 09:21:58 -0800 (PST)
X-Received: by 2002:a1f:58d:: with SMTP id 135mr10643887vkf.4.1551720117691;
 Mon, 04 Mar 2019 09:21:57 -0800 (PST)
MIME-Version: 1.0
References: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com>
In-Reply-To: <06d16c65a81d28016643d714f8aa3dfd7a2ad3ed.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 4 Mar 2019 09:21:46 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJLGc7gi3PuJ-J8D=+7H0T340LdpoQWYkxUJJ_k6umeKg@mail.gmail.com>
Message-ID: <CAGXu5jJLGc7gi3PuJ-J8D=+7H0T340LdpoQWYkxUJJ_k6umeKg@mail.gmail.com>
Subject: Re: [PATCH] power: Add and use pr_fmt
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 9:14 AM Joe Perches <joe@perches.com> wrote:
>
> Prefix all printk/pr_<level> messages with "PM: " to make the
> logging a bit more consistent.
>
> Miscellanea:
>
> o Convert a few printks to pr_<level>
> o Whitespace to align to open parentheses
> o Remove embedded "PM: " from pr_debugs as pr_fmt adds it
>
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/base/power/domain.c | 12 +++++++-----
>  drivers/base/power/main.c   | 21 +++++++++++----------
>  drivers/base/power/trace.c  |  2 ++
>  drivers/base/power/wakeup.c |  4 +++-
>  4 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2c334c01fc43..764e0f28979e 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -6,6 +6,8 @@
>   * This file is released under the GPLv2.
>   */
>
> +#define pr_fmt(fmt) "PM: " fmt
> +
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
> @@ -1657,8 +1659,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>         genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
>
>         if (!list_empty(&subdomain->master_links) || subdomain->device_count) {
> -               pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
> -                       subdomain->name);
> +               pr_warn("%s: unable to remove subdomain %s\n",
> +                       genpd->name, subdomain->name);
>                 ret = -EBUSY;
>                 goto out;
>         }
> @@ -1767,7 +1769,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 if (ret)
>                         return ret;
>         } else if (!gov) {
> -               pr_warn("%s : no governor for states\n", genpd->name);
> +               pr_warn("%s: no governor for states\n", genpd->name);
>         }
>
>         device_initialize(&genpd->dev);
> @@ -2514,7 +2516,7 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>                                                 &entry_latency);
>         if (err) {
>                 pr_debug(" * %pOF missing entry-latency-us property\n",
> -                                               state_node);
> +                        state_node);
>                 return -EINVAL;
>         }
>
> @@ -2522,7 +2524,7 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>                                                 &exit_latency);
>         if (err) {
>                 pr_debug(" * %pOF missing exit-latency-us property\n",
> -                                               state_node);
> +                        state_node);
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 5a8149829ab3..f80d298de3fa 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -17,6 +17,8 @@
>   * subsystem list maintains.
>   */
>
> +#define pr_fmt(fmt) "PM: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/mutex.h>
> @@ -128,7 +130,7 @@ void device_pm_add(struct device *dev)
>         if (device_pm_not_required(dev))
>                 return;
>
> -       pr_debug("PM: Adding info for %s:%s\n",
> +       pr_debug("Adding info for %s:%s\n",
>                  dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>         device_pm_check_callbacks(dev);
>         mutex_lock(&dpm_list_mtx);
> @@ -149,7 +151,7 @@ void device_pm_remove(struct device *dev)
>         if (device_pm_not_required(dev))
>                 return;
>
> -       pr_debug("PM: Removing info for %s:%s\n",
> +       pr_debug("Removing info for %s:%s\n",
>                  dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>         complete_all(&dev->power.completion);
>         mutex_lock(&dpm_list_mtx);
> @@ -168,7 +170,7 @@ void device_pm_remove(struct device *dev)
>   */
>  void device_pm_move_before(struct device *deva, struct device *devb)
>  {
> -       pr_debug("PM: Moving %s:%s before %s:%s\n",
> +       pr_debug("Moving %s:%s before %s:%s\n",
>                  deva->bus ? deva->bus->name : "No Bus", dev_name(deva),
>                  devb->bus ? devb->bus->name : "No Bus", dev_name(devb));
>         /* Delete deva from dpm_list and reinsert before devb. */
> @@ -182,7 +184,7 @@ void device_pm_move_before(struct device *deva, struct device *devb)
>   */
>  void device_pm_move_after(struct device *deva, struct device *devb)
>  {
> -       pr_debug("PM: Moving %s:%s after %s:%s\n",
> +       pr_debug("Moving %s:%s after %s:%s\n",
>                  deva->bus ? deva->bus->name : "No Bus", dev_name(deva),
>                  devb->bus ? devb->bus->name : "No Bus", dev_name(devb));
>         /* Delete deva from dpm_list and reinsert after devb. */
> @@ -195,7 +197,7 @@ void device_pm_move_after(struct device *deva, struct device *devb)
>   */
>  void device_pm_move_last(struct device *dev)
>  {
> -       pr_debug("PM: Moving %s:%s to end of list\n",
> +       pr_debug("Moving %s:%s to end of list\n",
>                  dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>         list_move_tail(&dev->power.entry, &dpm_list);
>  }
> @@ -418,8 +420,8 @@ static void pm_dev_dbg(struct device *dev, pm_message_t state, const char *info)
>  static void pm_dev_err(struct device *dev, pm_message_t state, const char *info,
>                         int error)
>  {
> -       printk(KERN_ERR "PM: Device %s failed to %s%s: error %d\n",
> -               dev_name(dev), pm_verb(state.event), info, error);
> +       pr_err("Device %s failed to %s%s: error %d\n",
> +              dev_name(dev), pm_verb(state.event), info, error);
>  }
>
>  static void dpm_show_time(ktime_t starttime, pm_message_t state, int error,
> @@ -2022,8 +2024,7 @@ int dpm_prepare(pm_message_t state)
>                                 error = 0;
>                                 continue;
>                         }
> -                       printk(KERN_INFO "PM: Device %s not prepared "
> -                               "for power transition: code %d\n",
> +                       pr_info("Device %s not prepared for power transition: code %d\n",
>                                 dev_name(dev), error);
>                         put_device(dev);
>                         break;
> @@ -2062,7 +2063,7 @@ EXPORT_SYMBOL_GPL(dpm_suspend_start);
>  void __suspend_report_result(const char *function, void *fn, int ret)
>  {
>         if (ret)
> -               printk(KERN_ERR "%s(): %pF returns %d\n", function, fn, ret);
> +               pr_err("%s(): %pF returns %d\n", function, fn, ret);
>  }
>  EXPORT_SYMBOL_GPL(__suspend_report_result);
>
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index b11f47a1e819..2bd9d2c744ca 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -7,6 +7,8 @@
>   * devices may be working.
>   */
>
> +#define pr_fmt(fmt) "PM: " fmt
> +
>  #include <linux/pm-trace.h>
>  #include <linux/export.h>
>  #include <linux/rtc.h>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index f1fee72ed970..d0e77d56c1d9 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -6,6 +6,8 @@
>   * This file is released under the GPLv2.
>   */
>
> +#define pr_fmt(fmt) "PM: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/sched/signal.h>
> @@ -853,7 +855,7 @@ bool pm_wakeup_pending(void)
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>
>         if (ret) {
> -               pr_debug("PM: Wakeup pending, aborting suspend\n");
> +               pr_debug("Wakeup pending, aborting suspend\n");
>                 pm_print_active_wakeup_sources();
>         }
>
>


-- 
Kees Cook
