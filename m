Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1BC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBC920726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575977626;
	bh=68JjJmoT8I3qU5Q/P5bOk80sj0dcYg8A7oRgziUQR4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ef+XyE1D+x6HmpxpbIO9KStHi929VB7XhR6yjJ1EYX4u2gsPvs3esaoEU+2OH60qV
	 E8yjhPLZXWCI7b75wq9v975YBrDfDaZSU7wUMK2t0cex22cWwWc9fLn2u8+KrVf9RT
	 VTSbBcW3Vpm5imBue+pfHX0BCie3/75WHICSowA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLJLdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:33:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37178 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJLdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:33:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so19717079wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 03:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5FjJVeyO3t8h7dBh1OV5fyqjNeQvVR1/7i0vehSFQ7Q=;
        b=SdNy8mJXxAQwBFs58J+/WXSJWszpKCYnwYNNYT4a5WCuP0ZMapJ6UJv3qTt30epR99
         OuNpt87tnWqi+6KGaNvuRWkPvx8EooGWpUfLDU9wzZCtAT7TY+H3bfocdJyuNc652hIr
         2Ofy6EA1XRrqRTCziGwLA+WiYlAUMpGNpcmyuYLVSi7TQCAUA4HgePI1uBfdhBBj4rjm
         scZArcpZn0P3/m1KTYaHeMvFCGmXVSajx7hoDFXk4n9Y4rv6WD9Yx/2iLqfJIG9t+VIP
         PmQ2CVquRncRyiqO9KLcwlI3ml1oBX2s9rzZDSv1Y5VRhV7H2cNkUZPY/2ua2vDO3kf2
         YTrA==
X-Gm-Message-State: APjAAAURbasMriVRbSONr200nc1WtcbLPPdHMo8CUqfzMOxtVxVG2GQQ
        Ce1I6tEQO7CgfpEZXnx2UO1VZnMQ
X-Google-Smtp-Source: APXvYqzkugwvlsjND7ToEIirpqoYxESepaGkmHvs85JyAcauF8rYz8Sxxgefxkb/nARkaEk8hRhsRw==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr2709672wrh.272.1575977623129;
        Tue, 10 Dec 2019 03:33:43 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v188sm2784884wma.10.2019.12.10.03.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:33:42 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:33:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191210113341.GG10404@dhcp22.suse.cz>
References: <20191206150524.14687-1-bhe@redhat.com>
 <20191209100717.GC6156@dhcp22.suse.cz>
 <20191210072453.GI2984@MiWiFi-R3L-srv>
 <20191210102834.GE10404@dhcp22.suse.cz>
 <20191210104303.GN2984@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210104303.GN2984@MiWiFi-R3L-srv>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-12-19 18:43:03, Baoquan He wrote:
> On 12/10/19 at 11:28am, Michal Hocko wrote:
> > On Tue 10-12-19 15:24:53, Baoquan He wrote:
[...]
> > > But after system bootup, we should be able to hot add/remove any memory
> > > board. This should not be restricted by a boot-time kernel parameter
> > > 'mme='. This is what I am trying to fix.
> > 
> > This is a simple statement without any actual explanation on why. Why is
> > hotplug memory special? What is the usecase? Who would want to use mem
> > parameter and later expect a memory above the restrected area to be
> > hotplugable?
> 
> The why is 'mem=' is used to restrict the amount of system ram during
> boot. We have two ways to add system memory, one is installing DIMMs
> before boot, the other is hot adding memory after boot. Without David's 
> use case, we may need redefine 'mem=' and change its documentation in
> kernel-parameters.txt, if we don't want to fix it like this. Otherwise,
> 'mem=' will limit the system's upper system ram always, that is not
> expected.

I really do not see why. It seems a pretty consistent behavior to me.
Because it essentially cut any memory above the given size. If a new
hotplugable memory fits into that cap then it just shows up. Quite
contrary I would consider it unexpected that a memory higher than the
given mem=XYZ is really there. But I do recognize a real usecase
mentioned elsewhere which beats the consistency argument here because
all setups where such a restriction would be really important are
debugging/workaround AFAICS.
-- 
Michal Hocko
SUSE Labs
