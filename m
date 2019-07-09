Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF587C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DCE20693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562710311;
	bh=1ihsbbNRibSWGnE8NEk8ow5w3DfKsIq3mbkUuoo43r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DsqF5F4Zl0Y/SQlYEc3Z2mvp8pobYXQWnCgh1uEwksfDk5Ahr2U9P0gRsInj2edQE
	 ek6QtBL4kcvB5MFfjUjYeOv0bR3rZluiq9XLz+ILK6qqAGlMBOK2cvlrWESWO3mgwT
	 msJ2hR29TqWx+6vreMWYA/xY6PyvQ9nIeIaohVXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGIWLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:11:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36243 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:11:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so305566qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hrdm/9H2N9NgzYgLhRIWmHIl9eGkKEmVCjuvL3vRSXE=;
        b=k97Qg2S85sMGpcqqru1ysXJl+qv2+XunuM/nlkAlv+IwCjpEXTqdCEpndxn3vBED6n
         iomUnC48MMAOffbGcHHW9R8xUZY9Mooj7yN81DrddmkbJfRWZkEis7Z367s+f5W1fzLl
         wsgoMbNVnO8ZTfjZeMQ952/lAE4PLlbZyoVuLqa42DT+fi3ydjP6ll/rxR0SkkMDJt7x
         p+Suv+l6YWHMeTnZ8epOSKriuJ25o4YwTR6qZXpI1In6g358zleB+RVvvluV6fdxtAMO
         Q4jQ1DMuBqp4RCiBmx4uxHSd+tQHvc5cOBCCumqi8Ncbv4v75BAjsBdatlQ8HYgPjiDW
         N/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hrdm/9H2N9NgzYgLhRIWmHIl9eGkKEmVCjuvL3vRSXE=;
        b=qWatW/OcV1caSYczXu1bWuT+6+/S9xBRo0WRQ69ULtH9EAthtTF9W+WlWLir4UrN2D
         U7fajOnSJwUkD7ci+E3vMl2FEzrmEnt84qTe8YJUVCX4KbOS0fODpB2VrQi1eYGX37zH
         ssEkrE0jzCaKgj82etOYDHhTWXTJt+YnDmzz/e41WoWE2mylkN737ORdP0i/8ZkqZTns
         Y61d1rrvijzJXrgM0r1yDMosqDwJgEwBgFdP+7/42fOahSsWq6U8oSD7zAxt20a9cdn4
         mFv5W30kCTSjvaRSyUwnXy0kWU620QQ4n+q3Sx5CCE/Buv8FOitosUrOUAvfOEKcvEDI
         /2fg==
X-Gm-Message-State: APjAAAXHTGuBCxqYo0ImPJUL7q1koDXCMDBNzl6HuDqVGSd5goDRABlH
        9lE1jiKQV1bo7OxpuG2oBaI=
X-Google-Smtp-Source: APXvYqx7FCjpDnPyrZoIsonoGb8u75NTaRsidhm0/XijaZ7yZU3MOCx0NM++7Lg3x/nxK4rYLEdBSQ==
X-Received: by 2002:a0c:8a23:: with SMTP id 32mr22012221qvt.231.1562710309253;
        Tue, 09 Jul 2019 15:11:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id k2sm29808qtq.87.2019.07.09.15.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 15:11:48 -0700 (PDT)
Date:   Tue, 9 Jul 2019 15:11:47 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ipmi_si_intf: use usleep_range() instead of busy looping
Message-ID: <20190709221147.GM657710@devbig004.ftw2.facebook.com>
References: <20190709210643.GJ657710@devbig004.ftw2.facebook.com>
 <20190709214602.GD19430@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709214602.GD19430@minyard.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 04:46:02PM -0500, Corey Minyard wrote:
> On Tue, Jul 09, 2019 at 02:06:43PM -0700, Tejun Heo wrote:
> > ipmi_thread() uses back-to-back schedule() to poll for command
> > completion which, on some machines, can push up CPU consumption and
> > heavily tax the scheduler locks leading to noticeable overall
> > performance degradation.
> > 
> > This patch replaces schedule() with usleep_range(100, 200).  This
> > allows the sensor readings to finish resonably fast and the cpu
> > consumption of the kthread is kept under several percents of a core.
> 
> The IPMI thread was not really designed for sensor reading, it was
> designed so that firmware updates would happen in a reasonable time
> on systems without an interrupt on the IPMI interface.  This change
> will degrade performance for that function.  IIRC correctly the
> people who did the patch tried this and it slowed things down too
> much.

Also, can you point me to the exact patch?  I'm kinda curious what
kind of timning they used.

Thanks.

-- 
tejun
