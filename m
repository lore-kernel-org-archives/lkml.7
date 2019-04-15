Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F632183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZ1ZZFbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfDORVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:21:10 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38411 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfDORVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:21:10 -0400
Received: by mail-ua1-f66.google.com with SMTP id t15so5776345uao.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avV9dZ4pPRg8tX22GHAisWdDdC1du7r40MwLPAtDyuA=;
        b=GZ1ZZFbATO9m4LJ6YAFkqdFgQHCIFMXdWDv8x47rLF7o51Bn0Q5iwiQgJGMdl1opIy
         Okc01kBp4fo0+fyOpGRfxiQv6X891zIvSyQXA/MWUlI10ldmOwsPyrbM7B9+zZUHSHZg
         YWv2NCfIFve31VYQHF46y8Dff6PRVW3CKYrFfGeJJYe0UwjRM2uR7X4YLwuZtQ+yXERH
         V0mlhaea77ATv8TrLUBb7jTePVutlx8XHQd67B1UsNdnUtIMQCbuOD1f6Fg5f9xg19BD
         9YJzbS7qc/9b220O7NeJzj/RSv4GH04EOBFvhoulyxVNvNWfITNfgiPzJR2eWBY1Wz6g
         pz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avV9dZ4pPRg8tX22GHAisWdDdC1du7r40MwLPAtDyuA=;
        b=EFbwMX/9CzFko2R2QNcNrIAmL5rZ7qby7zPz8NN+PL1Oz7I57ZyWU7IXE0SDy/j4Pl
         1A0mkcjGoWPeYgaFMpvIDsr5F+Cnb0R7mR6szYNkSBnYp+0hbJuTY1L/WKa4ZppU1fom
         CzeoU0yCqbo6nuCBbENxb0Zl0icGomL5/eSmlmMSj35V3p+GiblggJtWxxVMp0mbIsZj
         iI/agQg9AzAtK2YBqBOjYaVuIP//40ZJqGF+9JMLCu3X1WWrIu4IYWDuDOBUNSgbBwr8
         7OMeJ33yld7O6QvpFqUhniawM5zDIHDiTUAAGcLyRcPXCwKIj+noUnQv/UW4/V5XGhey
         X/fQ==
X-Gm-Message-State: APjAAAUvYwjz2qyKaB1kKd0iUEis8crkdJsF0MqexktlxyfNOgWCDsHO
        69NoQvvNF3oK4d1h4RlV1h0cD3n+/d8+EOnynVmjLg==
X-Google-Smtp-Source: APXvYqxEbG2XZRxd0EbQkSDmy0Zph3Doj14ALsHvxWsGw8nON15RQ+4ajY/P5TU2VkIPdpxyH46NT+lTE9sve2cK3vQ=
X-Received: by 2002:ab0:130b:: with SMTP id g11mr1652044uae.74.1555348868873;
 Mon, 15 Apr 2019 10:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190408173252.37932-1-eranian@google.com> <20190408173252.37932-3-eranian@google.com>
 <20190415155742.GI12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190415155742.GI12232@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Apr 2019 10:20:57 -0700
Message-ID: <CABPqkBQtJ81TMvjExJ3+hm1f+E1zkbTi-au-GkJRTg9ovZgEsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf/x86/intel: force resched when TFA sysctl is modified
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, mingo@elte.hu,
        nelson.dsouza@intel.com, Jiri Olsa <jolsa@redhat.com>,
        tonyj@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 8:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 08, 2019 at 10:32:52AM -0700, Stephane Eranian wrote:
> > +static ssize_t set_sysctl_tfa(struct device *cdev,
> > +                           struct device_attribute *attr,
> > +                           const char *buf, size_t count)
> > +{
> > +     bool val;
> > +     ssize_t ret;
> > +
> > +     ret = kstrtobool(buf, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* no change */
> > +     if (val == allow_tsx_force_abort)
> > +             return count;
> > +
> > +     allow_tsx_force_abort = val;
> > +
> > +     get_online_cpus();
> > +     on_each_cpu(update_tfa_sched, NULL, 1);
> > +     put_online_cpus();
> > +
> > +     return count;
> > +}
>
> So we care about concurrent writing to that file?
Not likely but we care about seeing the effects on event scheduling
before the sysctl returns.
