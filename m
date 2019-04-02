Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E433C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3A2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554191781;
	bh=mMPgC8EnOzY7J3BpsjKX05fu4ov0hnhGTrD61TARtHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W9YJp3LEY1Avy2vntyRNOVIjcgjtxyogRI1LW8gp8iLXT5pEsiegZ/ulG8ix+GM/O
	 dS0CEhx0l5MG6vLt+gb+UfPycl5+QmF4OQpm4axPhXlq/9IwQSivscpdYS4Oq68yOE
	 S7koHGSvOM7iYFxUxQsYu3RrtOgIGAvUKN7dX0bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfDBH4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:56:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42497 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:56:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so9665345oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxZt69luV57N76FSX+J4AEY/lLKOcrkiu5B1vhb9OD8=;
        b=IUuyAN9a+FCVH3gn3/qetmTiwcTRV1qDQmFuyJ40KXvMkSMeVeQsdeV9hPR5Kcck86
         PEwrmlv+JAN/hkCpTxxmOD+BZzxjX0nBWaH8zBdbOtlkvrsh17soETbrXdJ3kP0KJmZf
         b701XyqFlPpdnndJ1YcTevRLE9WgkyxStuGbfYSYAiQwAUXEzSTkH6Kw6fQZaCyEKKhN
         MnkhGRw0miuYKCW5WtpowueltuGT6+T5qb+IUzs3W2+Pqbkjs+JZs2Y/r6HCgrUc4q+S
         Q5GTF863/73SO/JOLivoFjAypSg9CL2q8QRV41KhIlbXOIsoqR4BNQ1bmt6mcZEre0B+
         m6tw==
X-Gm-Message-State: APjAAAUYqbI4JfBtKzYxaBMINTuR4EvgrMTtJzpOQCKLfGzYEcQpMsPD
        BtXO/YDZY7jCi0niBDVKkWZwcgITeOe3Yc/55v0=
X-Google-Smtp-Source: APXvYqxdfcSz0HlkCoUjtY0fbWiHQs0o+fc9717/YqQQTA8gbP0+0EfysJezfB7bPk6BKvQUMwCnJUJJYYDzfoGrG9Q=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr16027040oii.76.1554191778427;
 Tue, 02 Apr 2019 00:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190322201440.GA30814@ubu-Virtual-Machine> <cover.1554151487.git.kimbrownkd@gmail.com>
 <18a50bab72e6bd326250b2bd5b5a4b414351815d.1554151487.git.kimbrownkd@gmail.com>
In-Reply-To: <18a50bab72e6bd326250b2bd5b5a4b414351815d.1554151487.git.kimbrownkd@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Apr 2019 09:56:05 +0200
Message-ID: <CAJZ5v0hPZ2q+6aGYtx7oouyUUPVv4wj_5NXkUL_7zL44E1iGmw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cpufreq: schedutil: Replace default_attrs field
 with groups
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 4:51 AM Kimberly Brown <kimbrownkd@gmail.com> wrote:
>
> The kobj_type default_attrs field is being replaced by the
> default_groups field. Replace sugov_tunables_ktype's default_attrs field
> with default groups. Change "sugov_attributes" to "sugov_attrs" and use
> the ATTRIBUTE_GROUPS macro to create sugov_groups.
>
> This patch was tested by setting the scaling governor to schedutil and
> verifying that the sysfs files for the attributes in the default groups
> were created.
>
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Ackedy-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5c41ea367422..148b60c8993d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -598,13 +598,14 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
>
>  static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
>
> -static struct attribute *sugov_attributes[] = {
> +static struct attribute *sugov_attrs[] = {
>         &rate_limit_us.attr,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(sugov);
>
>  static struct kobj_type sugov_tunables_ktype = {
> -       .default_attrs = sugov_attributes,
> +       .default_groups = sugov_groups,
>         .sysfs_ops = &governor_sysfs_ops,
>  };
>
> --
> 2.17.1
>
