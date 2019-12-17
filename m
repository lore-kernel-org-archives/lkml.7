Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C93C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57532218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594801;
	bh=lhuF5SdNJFPeYCFB/zIMrntW3mcXP5Pb5b/AvPYM/Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GWszhOsn58ILNA1ZVe7wIKfI+gMt2Tp0zJy6gad1zch6SRhgTGlDH1SNr8LLIZeTG
	 ykfP89ctSkUrzivre4+0/q4PxxsYxrb1kooHNJMhhN/jbBOvG1pERU/yTenzlRbA1Q
	 bKZumWsEEiEQdkHfp1zflNdjgU6B5NzCoBz05Poo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfLQPAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:00:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41274 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLQO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:59:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so840404wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 06:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2RPvkS3wiyM/cXFFWnnKAmIdzbhl6b/6rYSNRYDRpP8=;
        b=g1BWMS+p2nxhx3Mjb9k5TfnQZ0eeq6TkI4Oc1s8hHQl9D2xJX9i5xWhtcAdtW7THvh
         Y5cBtcFW1/lsydm3Hix0M1w6YLrzvvUrHXQ5UkkppfeP2OvrIX13rQosFcc3YlI9CvO4
         bOBkcTWaMtBEhzErWm60NB8dH6hjhAVYg2HizVozxd5elAMtV68wMgpxLdaoTjNMNZYL
         iJH5LXdqMNdun3128+xJe1YshHCHOFntUBINycsTyv5lSmIKWDdQBJyoLP/2c/erGgXh
         ZBEAj+c56n3k7LR9ip2rR/kqxP4TiabEyegTEAPlKb96QHeYRYNsp30exO3Rxcb3vjoA
         v3dw==
X-Gm-Message-State: APjAAAVvmGe6A6TpIAcU7AdhE2gWBvf72Zu2N65xnnqJ6ckLXdOeHNtI
        wF5EvHiuSs6BK5ZDoJWCj50=
X-Google-Smtp-Source: APXvYqwToPCZf/hfVwtsEh/E6+vprZwTG2iGnaekZ116daSVUTobkTHQ+iBS7F0gfpLxiRWdwBWXFw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr37413605wrt.15.1576594797705;
        Tue, 17 Dec 2019 06:59:57 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f1sm25682801wro.85.2019.12.17.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:59:56 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:59:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] mm/hugetlb: Defer freeing of huge pages if in
 non-task context
Message-ID: <20191217145956.GB7272@dhcp22.suse.cz>
References: <20191217012508.31495-1-longman@redhat.com>
 <20191217093143.GC31063@dhcp22.suse.cz>
 <4bb217ac-d80a-12b8-839f-2db9ced2636b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb217ac-d80a-12b8-839f-2db9ced2636b@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-12-19 09:06:31, Waiman Long wrote:
> On 12/17/19 4:31 AM, Michal Hocko wrote:
> > On Mon 16-12-19 20:25:08, Waiman Long wrote:
[...]
> >> +	pr_debug("HugeTLB: free_hpage_workfn() frees %d huge page(s)\n", cnt);
> > Why do we need the debugging message here?
> 
> It is there just to verify that the workfn is properly activated and
> frees the huge page. This message won't be printed by default. I can
> remove it if you guys don't really want a debug statement here.

Yes, drop it please. We are not adding debugging messages unless they
are really actionable. If this is a sign of a bug then put a WARN_ONCE or
somethin like that. But with a simple code like this it doesn't really
seem to be suitable IMHO.

Thanks!
-- 
Michal Hocko
SUSE Labs
