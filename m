Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BBDC5B577
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB6F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561679788;
	bh=PICKkzuRIN0u+4VXuVjhCIIJMir1hgAYcWkusaYstOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LBIrolkycmDT/4Zf8O+4ie9gT5Ve185ETsEYjh04JwUayOYZJ8eTjMCl1fSMNV2tJ
	 fyv9vHuPZYINJ5WGfgh2UY9CWlOwIpzZbmGH4n6650Q9Q8aPX0NgB+PpQwqo+u1Hzf
	 J+6a6P/+bJ4imzi14BQDHn6Y9nc/So34MJbaT5q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfF0X41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:56:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43114 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0X41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:56:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so1720595pgv.10;
        Thu, 27 Jun 2019 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CLj4gZCTfK/NAoTIvU2cEk9DiiqDuv0OJwpnaduKmqA=;
        b=TD/Y9ETxzwIz92B9+E24f8PXv4qRImq4vZCpEFH0DQAK0HYr9/LCzuC51LYrglkt9H
         x107u1OY4skzs+uUyX/5RNDgKbdmpfJ8q6NcbT0lRYiwUwQqAQXplH4P8knqbVMuCLfr
         r/QQe6OnL2EdKXhlSxyR6ooko9ZkW529nCwU12nL1zwuVwh8bQieBXaxA9q9y5G+xBqY
         JuztrCRRnJKg3B6VfnSKAdOn3ZHw5uh4V1BpQH+y3R+eK1C30Ajm+GSGH2SLlqmnzRb5
         Oq2itXwjtvyt4k1Z1Jlm5GX+GuhGPQJiPvrankJmbqYBzY2I7Rr8KdQBdGF8XuhmHrYj
         vdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CLj4gZCTfK/NAoTIvU2cEk9DiiqDuv0OJwpnaduKmqA=;
        b=JdblmkY8OVO4EA6r017peX+ZP0oxInKF8xEVAd8R9dRgcfqbK1VDSiun12D+rmCHiU
         txn8Z+GD7o8ovcrypvrO1UKYyK6RBK/jRUWA9brEnAOXrDUtb5mtFikm9FSUlUo9Tw8v
         i97VgHKmQNT/Txhb/y4y9Ko9Uj0SsVmsIg681Hx3VhNKfCGoLfkg/CFD/HVbjhpWq/IK
         edb8C2RBSHdKOLM/FdTEavZMghIj9V6gi7/FrRxHJPMsqJMo+No6jpYqZlBn0yaDI1tD
         wjLwXEO0FGuk5zcxzc4ymQwRgUSwijl2r2m/z+KXVC1J0QTHgLWaEyFp7DC7nexeCIon
         QKtA==
X-Gm-Message-State: APjAAAUBsCC0LwGK7gA/35/xdzyYma4ALA1nUM+3YH/reuLwoUCEBGDq
        EAI7HDjG5q0erJozET/3TyE=
X-Google-Smtp-Source: APXvYqwioUiNv41x01aQdRcQnt8g3CLHIHh9zwhAz5EQgEvfxKBbPX0L6hoApe0uDHiYVFbY+15cDA==
X-Received: by 2002:a63:4c46:: with SMTP id m6mr6527455pgl.59.1561679786207;
        Thu, 27 Jun 2019 16:56:26 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id a3sm319767pje.3.2019.06.27.16.56.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:56:24 -0700 (PDT)
Date:   Fri, 28 Jun 2019 08:56:18 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 1/5] mm: introduce MADV_COLD
Message-ID: <20190627235618.GC33052@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190627115405.255259-2-minchan@kernel.org>
 <343599f9-3d99-b74f-1732-368e584fa5ef@intel.com>
 <20190627140203.GB5303@dhcp22.suse.cz>
 <d9341eb3-08eb-3c2b-9786-00b8a4f59953@intel.com>
 <20190627145302.GC5303@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627145302.GC5303@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 04:53:02PM +0200, Michal Hocko wrote:
> On Thu 27-06-19 07:36:50, Dave Hansen wrote:
> [...]
> > For MADV_COLD, if we defined it like this, I think we could use it for
> > both purposes (demotion and LRU movement):
> > 
> > 	Pages in the specified regions will be treated as less-recently-
> > 	accessed compared to pages in the system with similar access
> > 	frequencies.  In contrast to MADV_DONTNEED, the contents of the
> 
> you meant s@MADV_DONTNEED@MADV_FREE@ I suppose

Right, MADV_FREE is more proper because it's aging related.

> 
> > 	region are preserved.
> > 
> > It would be nice not to talk about reclaim at all since we're not
> > promising reclaim per se.

Your suggestion doesn't expose any implementation detail and could meet your
needs later. I'm okay. I will change it if others are not against of it.

Thanks, Dave.
