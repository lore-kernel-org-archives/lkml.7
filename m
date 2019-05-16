Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E79EC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB212082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEPOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:21:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54101 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfEPOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:21:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so3844399wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pBYZyFUkM5nWJomyVpE/m2x1DxoC1ycwj8/edxQgVk=;
        b=X4zD9FQ0xtCItWa1BZQetw+63B+7PxjyaCanowmvPbt1GYLvOh7smNTsKNAdopBf14
         JuJP5sd/prNREqiPE3zG3mmfp1P2K94RBo5ZlzvABceN4DQ1XlbPTrc+Shj1K7SmXg7c
         EKlxs4PwWlwyE2Ol2C/1mPoVpILZxcJ2kd5O8ctyq5X3b5IFWQAzzoykUmqZ4fjSbKOT
         t/m0UMa/VbbZ4ZClW+88ShDqYDfro1tho6BrL44tRoyTTC0RRWArlJpaQ1fnPa2pH1mO
         NGQXFFHJCqJHSSYbnH36xD5BsEHpV0crG25YZb2+GstjOmgynnzBuNKkShl8y2XrWHwb
         56ew==
X-Gm-Message-State: APjAAAXABDl4bp+tTTxf+ac17p1Emv86p3cdPrjMHgSdDTn1lYtPqGt4
        yH4mpIG6Sdg0xdPgOjMFGhNt8cM1cqHj4g==
X-Google-Smtp-Source: APXvYqxXwoK109kD/ez3T5lP/j8A8AQ1AFMnns5SxEo7Ap1IuaYOUMPIMyPdhIllQencoKBO77rrOw==
X-Received: by 2002:a1c:2245:: with SMTP id i66mr12110548wmi.19.1558016504222;
        Thu, 16 May 2019 07:21:44 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j82sm7364200wmj.40.2019.05.16.07.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 07:21:43 -0700 (PDT)
Date:   Thu, 16 May 2019 16:21:42 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] mm/ksm, proc: introduce remote madvise
Message-ID: <20190516142142.qti3zfevuf67dedn@butterfly.localdomain>
References: <20190516094234.9116-1-oleksandr@redhat.com>
 <20190516104412.GN16651@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516104412.GN16651@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, May 16, 2019 at 12:44:12PM +0200, Michal Hocko wrote:
> On Thu 16-05-19 11:42:29, Oleksandr Natalenko wrote:
> [...]
> > * to mark all the eligible VMAs as mergeable, use:
> > 
> >    # echo merge > /proc/<pid>/madvise
> > 
> > * to unmerge all the VMAs, use:
> > 
> >    # echo unmerge > /proc/<pid>/madvise
> 
> Please do not open a new thread until a previous one reaches some
> conclusion. I have outlined some ways to go forward in
> http://lkml.kernel.org/r/20190515145151.GG16651@dhcp22.suse.cz.
> I haven't heard any feedback on that, yet you open a 3rd way in a
> different thread. This will not help to move on with the discussion.
> 
> Please follow up on that thread.

Sure, I will follow the thread once and if there are responses. Consider
this one to be an intermediate summary of current suggestions and also
an indication that it is better to have the code early for public eyes.

Thank you.

> -- 
> Michal Hocko
> SUSE Labs

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
