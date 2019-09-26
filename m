Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD3C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D43222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FDwis0Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfIZLTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:19:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40019 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIZLT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:19:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id f7so2336711qtq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fYPToXR0NbT6CEGxTuAqdgHd5+edDYqh00rkxBfwc+g=;
        b=FDwis0Men9NI9YQN4z3fTSsiW3WRxGnkwpSNIUznkIm9T9QlUki5GrSyFpzt0k9IxA
         /wZ/ZBxP8iTaECWgBw33oNZfTxFbQEnW1FtPGpCaSAOCF8pnITk0E5QFliWObZ1CLjdX
         tpIUvr1OsnhE+cK8rRx+MtEopb0zkDjFOtdIeulag7FO6DO3+GlUV/C6LCNrQ9D4ePfA
         uiksPXhP+iH+cP9/pg0g4tP0zxRrG5ZNqlUWavoAX4K8s6iCeAuLfMwmx7R8nUoSYGVJ
         8uCjyWHijpa8ZPr8Ex93VILlJU8A3/jAu3NyWQNi2YPSR2iUhv16hk7CzyXChdGfiQlz
         qrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fYPToXR0NbT6CEGxTuAqdgHd5+edDYqh00rkxBfwc+g=;
        b=jSVZtuovo0xm8H8Bp0bDOjpsn/nW8VMf7tHw0xDqMdpSfMrV1YsmXvMzsfZrwGRmL6
         RrfZOCc8ys3lufsdGEPjpJ0dBu/3YLHhQNn/cOYBYgTPtR9rA1aOhObWR1ClgY1JYgsK
         v06WmaMjnTI3YJcwrcZjLU4uCAEFYyWejsAOIGZIWMTYU+0ChvGQrrxE5DuzOtTzzz6Y
         IAB/dIbJWVgQRvTofYCxvCyZpRpC+c3p1kBTlXL0mQ4lmRriYGQ4Zmg/Vvtii56rm3xy
         PG6lvYrXkpAlX0u04WHnvHM4riX7rVqB6puerZpfrVDEgM+xEewrdDBap/MrXcglLJfj
         j0xQ==
X-Gm-Message-State: APjAAAXq6pCv4pKV5fG/eDos+U2/fCbdqfzmjk5XTW/7L5IVqEflkkgg
        kLPRaxj6x59cDClguKtAPCK0epmBO+qbrg==
X-Google-Smtp-Source: APXvYqwV2ycsL7eT1GE5Ae675yE7aehFn4ca0zlLCKzexIiFu9hFxuG6zLao80D35lhl4n5Uxk+M5g==
X-Received: by 2002:ac8:41ca:: with SMTP id o10mr3194278qtm.352.1569496768610;
        Thu, 26 Sep 2019 04:19:28 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 63sm875654qkh.82.2019.09.26.04.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:19:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Date:   Thu, 26 Sep 2019 07:19:27 -0400
Message-Id: <C8DA5249-2DEB-47D5-937E-5A774B1CB08B@lca.pw>
References: <20190926072645.GA20255@dhcp22.suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20190926072645.GA20255@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> OK, this is using for_each_online_cpu but why is this a problem? Have
> you checked what the code actually does? Let's say that online_pages is
> racing with cpu hotplug. A new CPU appears/disappears from the online
> mask while we are iterating it, right? Let's start with cpu offlining
> case. We have two choices, either the cpu is still visible and we update
> its local node configuration even though it will disappear shortly which
> is ok because we are not touching any data that disappears (it's all
> per-cpu). Case when the cpu is no longer there is not really
> interesting. For the online case we might miss a cpu but that should be
> tolerateable because that is not any different from triggering the
> online independently of the memory hotplug. So there has to be a hook
> from that code path as well. If there is none then this is buggy
> irrespective of the locking.
>=20
> Makes sense?

This sounds to me requires lots of audits and testing. Also, someone who is m=
ore
familiar with CPU hotplug should review this patch. Personally, I am no fun o=
f
operating on an incorrect CPU mask to begin with, things could go wrong real=
ly
quickly...=
