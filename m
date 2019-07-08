Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DB2C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9E1216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbfGHP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:58:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37636 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfGHP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:58:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so13694165qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AH8IJJmjzkjZq3idsVNsmCIYsGxgWPVTHtDYl5lUZWE=;
        b=TSGWpyUBoGoWLd7VgC/BYT8lSGWeSRphO+U3q9YNcfSbaIShvDOWMi/eXNd0x79+M+
         r/8kwYeBIcIflaeQ455w/xB3UE2YRNsrOnE3TG+t2YUNLWQDxGWaNCincxQR8ktVF2IE
         /zD9EEZK2g+xKiYT8myCHwW+Qkt5WDjk5TAGuz/94+q83M4OIeizP32o4tvu9UTZfoyK
         1I4pcPng2eJpF9QkVel8KlQNg55HaTzLDS6NUaBBusfMID5J9HrZoCLoyvs6XF+j4b5Q
         8WxNK5RclA5rX1fHdkrHSIyQnxJKy8EEZsp31Bmyd4dnNEJpEEoWDUZL2CLee6zb/TdX
         PEeA==
X-Gm-Message-State: APjAAAUtmdtq+SeaX3ZGmAIxf0QAi4bV3xBz9bWRqa25xJzhGFsswbGH
        qotPTsIKu8Y/KzMHjcS/SIJB2B8ax/dWsN5/s2g=
X-Google-Smtp-Source: APXvYqyrehAlYB2c3pyV+TDqOm5ybWzhOFmyqN8lX/9ZlBxoclluL6OWTXGUf+q3JxWAQFBJc7yWpEfbsvvmTUDGKHs=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr11219309qki.352.1562601513594;
 Mon, 08 Jul 2019 08:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190708140816.1334640-1-arnd@arndb.de> <20190708150255.GA32266@archlinux-epyc>
In-Reply-To: <20190708150255.GA32266@archlinux-epyc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jul 2019 17:58:15 +0200
Message-ID: <CAK8P3a0hR2+g+vxKqm=a8DgPcNrBaqa3sbuEHuVzaw9Fryd4Zg@mail.gmail.com>
Subject: Re: [1/2] drm/amd/powerplay: smu_v11_0: fix uninitialized variable use
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chengming Gui <Jack.Gui@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Likun Gao <Likun.Gao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 5:02 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Mon, Jul 08, 2019 at 04:07:58PM +0200, Arnd Bergmann wrote:
> >       /* if don't has GetDpmClockFreq Message, try get current clock by SmuMetrics_t */
> > -     if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0)
> > +     if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0) {
> >               ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
> > -     else {
> > +             if (ret)
> > +                     return ret;
>
> I am kind of surprised that this fixes the warning. If I am interpreting
> the warning correctly, it is complaining that the member
> get_current_clk_freq_by_table could be NULL and not be called to
> initialize freq and that entire statement will become 0. If that is the
> case, it seems like this added error handling won't fix that problem,
> right?

No, I'm fairly sure this is the right fix. Looking at the whole function:

| static int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
|                                          enum smu_clk_type clk_id,
|                                          uint32_t *value)
|{
|        int ret = 0;
|        uint32_t freq;
|
|        if (clk_id >= SMU_CLK_COUNT || !value)
|                return -EINVAL;
|
|        /* if don't has GetDpmClockFreq Message, try get current
clock by SmuMetrics_t */
|        if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0) {
|                ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);

Here &freq may or may not get initialized

|        } else {
|                ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmClockFreq,
|
(smu_clk_get_index(smu, clk_id) << 16));
|                if (ret)
|                        return ret;
|
|               ret = smu_read_smc_arg(smu, &freq);
|                if (ret)
|                        return ret;

Same here, but if it's not initialized, we bail out

|        }
|
|       freq *= 100;
|        *value = freq;

And here it gets assigned to *value

|        return ret;
|}

    Arnd
