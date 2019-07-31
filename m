Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0DCC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CC4216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwHmDfLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfGaXGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:06:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45978 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaXGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:06:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so32798537pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=049t7JxvZTTTjSKZ1poKKugPV6OSOy/7hb4LReWg88o=;
        b=uwHmDfLq0KdRRrIpXBZ7eh2E2Di7CZCsc7Q4ENgQh9pTHk3z1+zjKf7oTZBOymsGIS
         mnqtFBhdLcW/vLb9BKhOsF1r8tKUhH2SZyNqHdaOOW4EhxFLBdByJFXqYtU3rct1sR8x
         DQ4pUSojQb0BZPBAzWpkCE8DfLkjinN+3dMTHyT3vVnRNHra0YbWT/Gfw69nX8iJwdAi
         Lseiy9WWaE54CJg+RUrgeDBd7td8wHWw3TPatkiaa6sOTqPXRZqBLfjOGpLkCJMfxHJm
         RnJ2r6c81O9ZleTk+YaUC2O/dZPpRL18733LECbGGYlK9s72ycaGCqYaL4b1Gc0DEXYt
         w3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=049t7JxvZTTTjSKZ1poKKugPV6OSOy/7hb4LReWg88o=;
        b=P744u7Z1ABeaeuD/aAEjzTSU5ptREsuilasVpvKPxBL2WskJIsr8sPEdh9RSuuUj+o
         Fyo4ITWqLhWfg/Z9r375Wjk4SuMKi3LeLDdL1DUdfmXfgtqe8WO+dS+g5dH16SCCz8ey
         tGZt+fa5VmG7HiVBZb1ME/hbqgG5Bu8+fDKRUoyiAaNjiJIlVKN6s5+7zWq9hbV/wEil
         aALG0tXRlqyAeuXVQ5oZSNVfornjvSVoQM+uOQApnbjZA7AjdSKFP4F6HGs8UsJDqw+L
         HzsqMnIGGbj435Er/fOXUPX3XYgGReczNPHe/iXLVxyQ/hlygeL14w2+0m+3PYztEcP9
         pgKg==
X-Gm-Message-State: APjAAAXpFJGudcz4It5vDNKhA+fvdiXHt7mTNcaawjzjCCN18L6/5iML
        wdR3szuXygJwArLa8Ubr6v+D7z+z
X-Google-Smtp-Source: APXvYqxp2QruKLqLy7023Eu9qytL/7DmpVnAriEavxnn4B49X9D6LXrlXTRhvHAAadOvWaRD1E0HQA==
X-Received: by 2002:a62:f20b:: with SMTP id m11mr50144512pfh.125.1564614407259;
        Wed, 31 Jul 2019 16:06:47 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id p187sm110668968pfg.89.2019.07.31.16.06.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 16:06:46 -0700 (PDT)
Message-ID: <4ddee0dd719abd50350f997b8089fa26f6004c0c.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
From:   Rashmica Gupta <rashmica.g@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 01 Aug 2019 09:06:40 +1000
In-Reply-To: <20190731120859.GJ9330@dhcp22.suse.cz>
References: <20190625075227.15193-1-osalvador@suse.de>
         <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
         <20190626080249.GA30863@linux>
         <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
         <20190626081516.GC30863@linux>
         <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
         <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
         <20190702074806.GA26836@linux>
         <CAC6rBskRyh5Tj9L-6T4dTgA18H0Y8GsMdC-X5_0Jh1SVfLLYtg@mail.gmail.com>
         <20190731120859.GJ9330@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 14:08 +0200, Michal Hocko wrote:
> On Tue 02-07-19 18:52:01, Rashmica Gupta wrote:
> [...]
> > > 2) Why it was designed, what is the goal of the interface?
> > > 3) When it is supposed to be used?
> > > 
> > > 
> > There is a hardware debugging facility (htm) on some power chips.
> > To use
> > this you need a contiguous portion of memory for the output to be
> > dumped
> > to - and we obviously don't want this memory to be simultaneously
> > used by
> > the kernel.
> 
> How much memory are we talking about here? Just curious.

From what I've seen a couple of GB per node, so maybe 2-10GB total.

