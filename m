Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410C2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gdkeYnFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfH1Vey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:34:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33060 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfH1Vey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:34:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id w18so1177982qki.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYdive4fs3YZW5MK2IGi1qPAKF/i7A4RjMEmiRAW0YI=;
        b=gdkeYnFw6COpROHjRJ2RmqLqL7/6msb8Cb45NqPN05qHJQ8pmvP69p4niXYgy8j5yk
         jSt8bbHcrj+oIUDiYCvESLaAVZ2IXIfPdP1n6ydeuFzw0lutP3vjCAb7N4LHvp7k/1cx
         xdbLelMkamRh3ry3UdBtVW12Q/laVbA0sp/tgaxrW2pmxZX8Oe7ltO4HfrEGnk6oM9Ng
         X6frDnSQfs7zxcfUCYTadZUSkDHRu8iAnBJ5rrWTYxrGGk13wDiej28RgsMGEUJUdhzt
         04IgQ18tNdw+pjJbFUv/7x2XwYAh9ef8NqKcTrfyKZYuZMRVy/G0s9coHMiWoNZnEDcg
         WCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYdive4fs3YZW5MK2IGi1qPAKF/i7A4RjMEmiRAW0YI=;
        b=p06Ve6lqPHx8g196qbJycbdFvKgOiV2mhL5DIzCwWB0VXw/iyGJzVmoDs2sCr4jBuo
         56+51gLKTFuKsPntIM9q9HYrojbSAIf3Wl046IBLFtogGCuENBgHj6zfrOXaeYgL6c3P
         tfDV6c4mtFoPNW04FiFAIPHmS5JBig0zPRIbBoFTkDSFKA65f/+q2fnHkEyRCA+7JoLI
         QezMMFlIFqA3IHtWiBEdHAkjrEf3bkGlxmAdShR/fFs8dtyqkoPDWjFhC4CPlqyFfyGt
         P8iMF3BjYFLxy0LTip2uZd/UxNn3IvGXuINLriqt1MEqkgfa/bR3K53GTX9dXAkyirfP
         QzRQ==
X-Gm-Message-State: APjAAAWtNa9nKaFHbV0BjfBLkHeZpuBBbclSwVOobtI3DR+XoixQy1tb
        56/edMDXNfEPZi6REQ5njWfwjg==
X-Google-Smtp-Source: APXvYqxvYLog15/ffNFORB863U4m0rpbbdfB4NgE8vkgrE1rx4VHVYrp1uVsnU603atnVOdXWuIxLQ==
X-Received: by 2002:a37:47cb:: with SMTP id u194mr6226136qka.342.1567028093142;
        Wed, 28 Aug 2019 14:34:53 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y202sm182872qkb.5.2019.08.28.14.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 14:34:52 -0700 (PDT)
Message-ID: <1567028090.5576.21.camel@lca.pw>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
From:   Qian Cai <cai@lca.pw>
To:     Edward Chron <echron@arista.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Date:   Wed, 28 Aug 2019 17:34:50 -0400
In-Reply-To: <CAM3twVQ_J77-yxg+cakUJy9-oZw+j-9xdunaAJdJdfZfCb5GSA@mail.gmail.com>
References: <20190826193638.6638-1-echron@arista.com>
         <20190827071523.GR7538@dhcp22.suse.cz>
         <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
         <20190828065955.GB7386@dhcp22.suse.cz>
         <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
         <1567023536.5576.19.camel@lca.pw>
         <CAM3twVQ_J77-yxg+cakUJy9-oZw+j-9xdunaAJdJdfZfCb5GSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 14:17 -0700, Edward Chron wrote:
> On Wed, Aug 28, 2019 at 1:18 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Wed, 2019-08-28 at 12:46 -0700, Edward Chron wrote:
> > > But with the caveat that running a eBPF script that it isn't standard
> > > Linux
> > > operating procedure, at this point in time any way will not be well
> > > received in the data center.
> > 
> > Can't you get your eBPF scripts into the BCC project? As far I can tell, the
> > BCC
> > has been included in several distros already, and then it will become a part
> > of
> > standard linux toolkits.
> > 
> > > 
> > > Our belief is if you really think eBPF is the preferred mechanism
> > > then move OOM reporting to an eBPF.
> > > I mentioned this before but I will reiterate this here.
> > 
> > On the other hand, it seems many people are happy with the simple kernel OOM
> > report we have here. Not saying the current situation is perfect. On the top
> > of
> > that, some people are using kdump, and some people have resource monitoring
> > to
> > warn about potential memory overcommits before OOM kicks in etc.
> 
> Assuming you can implement your existing report in eBPF then those who like
> the
> current output would still get the current output. Same with the patches we
> sent
> upstream, nothing in the report changes by default. So no problems for those
> who
> are happy, they'll still be happy.

I don't think it makes any sense to rewrite the existing code to depends on eBPF
though.

