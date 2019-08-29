Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC4C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2327D21726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dl9qohKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfH2SoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:44:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45607 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfH2SoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:44:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so3852381qki.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QDRi/Xd9XfnkQ5sOxj7EVRPPb6YjOhNvBvKil4zJw/0=;
        b=dl9qohKF185MJTvsc/xIx5y2bsPkyUgeQyPr5ffE0hZoRxnas8wTSWNEjE47IMjSQt
         ClxH/8EVTw9Ka+9M0wwX+9B/tIxd5c9tbC4bJVP6ZwyImFCUqm28A7X+yPLCqQJFBBAV
         3DR877YtrSKP77RLHhkN9aaVXjjdSnAuMQixQQV6IvlbzoGtwvQjTLJTjwZMLpdTQDgx
         ewvCMg70knxrpix/UuQ1dzA8dmHi5pooHb91SW/yA0O3o0XTnVkP1+7DUQVBU/n2yWRZ
         YvrEv8swmwRvi3EEp2XB0vErOGppjRla558g1r6lB4UaSNmoXh8pnI+WpxL6iTq7jsfA
         L4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QDRi/Xd9XfnkQ5sOxj7EVRPPb6YjOhNvBvKil4zJw/0=;
        b=CJlcpzquIv0katJMVe48iu3EiJFELHGJKDJKjXySaFxgjDbdPVFVHwThp5L5QaioB9
         ZYLyhv0AYL5MA58EPlAldVMN8T0hwX5t6B7NEjV3vBmx+VEj2BebvwFnrRIBozW7lGqQ
         vR+zpw4BYJs1xx1i0LePafKadkw5SaFhsT39RjAy41aje+OnYZrpCLAOZj6nhNvA+J9M
         LQmlre4Fciz0+mk77H9B+UE5WfrabJvJG8q0jqSTDQ/939pmIOgyuGFbf3tKALr7uuW2
         8y48XohkNkFkfJD7Lw4xsOcUKeujW01IzVaco8VV8iV4701O6vqNsHGQQ9TwoxiCFA4j
         8ang==
X-Gm-Message-State: APjAAAXwf3O3wztAO1WRD1fc1fhn/pE3OFpKV7bUVIyidymxSjh0ZXNC
        zOZeHqBpWmHOHr7lF2hpgp7w/w==
X-Google-Smtp-Source: APXvYqzKqT4R8SObC1LwMgc7oT0iO2TSaMYUPaXWhrxP6+vgf7kWzLYoE22jClWrLF5LNRYQJ+U22A==
X-Received: by 2002:a37:98f:: with SMTP id 137mr11278917qkj.188.1567104244278;
        Thu, 29 Aug 2019 11:44:04 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u7sm1494346qkj.113.2019.08.29.11.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 11:44:03 -0700 (PDT)
Message-ID: <1567104241.5576.30.camel@lca.pw>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
From:   Qian Cai <cai@lca.pw>
To:     Edward Chron <echron@arista.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Date:   Thu, 29 Aug 2019 14:44:01 -0400
In-Reply-To: <CAM3twVSgJdFKbzkg1V+7voFMi-SYQTCz6jCBobLBQ72Cg8k5VQ@mail.gmail.com>
References: <20190826193638.6638-1-echron@arista.com>
         <20190827071523.GR7538@dhcp22.suse.cz>
         <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
         <20190828065955.GB7386@dhcp22.suse.cz>
         <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
         <20190829071105.GQ28313@dhcp22.suse.cz>
         <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
         <20190829115608.GD28313@dhcp22.suse.cz>
         <CAM3twVSZm69U8Sg+VxQ67DeycHUMC5C3_f2EpND4_LC4UHx7BA@mail.gmail.com>
         <1567093344.5576.23.camel@lca.pw>
         <CAM3twVSgJdFKbzkg1V+7voFMi-SYQTCz6jCBobLBQ72Cg8k5VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 09:09 -0700, Edward Chron wrote:

> > Feel like you are going in circles to "sell" without any new information. If
> > you
> > need to deal with OOM that often, it might also worth working with FB on
> > oomd.
> > 
> > https://github.com/facebookincubator/oomd
> > 
> > It is well-known that kernel OOM could be slow and painful to deal with, so
> > I
> > don't buy-in the argument that kernel OOM recover is better/faster than a
> > kdump
> > reboot.
> > 
> > It is not unusual that when the system is triggering a kernel OOM, it is
> > almost
> > trashed/dead. Although developers are working hard to improve the recovery
> > after
> > OOM, there are still many error-paths that are not going to survive which
> > would
> > leak memories, introduce undefined behaviors, corrupt memory etc.
> 
> But as you have pointed out many people are happy with current OOM processing
> which is the report and recovery so for those people a kdump reboot is
> overkill.
> Making the OOM report at least optionally a bit more informative has value.
> Also
> making sure it doesn't produce excessive output is desirable.
> 
> I do agree for developers having to have all the system state a kdump
> provides that
> and as long as you can reproduce the OOM event that works well. But
> that is not the
> common case as has already been discussed.
> 
> Also, OOM events that are due to kernel bugs could leak memory and over time
> and cause a crash, true. But that is not what we typically see. In
> fact we've had
> customers come back and report issues on systems that have been in continuous
> operation for years. No point in crashing their system. Linux if
> properly maintained
> is thankfully quite stable. But OOMs do happen and root causing them to
> prevent
> future occurrences is desired.

This is not what I meant. After an OOM event happens, many kernel memory
allocations could fail. Since very few people are testing those error-paths due
to allocation failures, it is considered one of those most buggy areas in the
kernel. Developers have mostly been focus on making sure the kernel OOM should
not happen in the first place.

I still think the time is better spending on improving things like eBPF, oomd
and kdump etc to solve your problem, but leave the kernel OOM report code alone.

