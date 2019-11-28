Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D44C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3C52071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574952160;
	bh=QwKlxzUl4sHG0ur2o10utsaDBup5tBYpJskjq6A4cok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zy3hF+1DyH8nEQOhh+HkK00HlLxWM8XUJIaSe0D+MD1VTobJsUfIEJ/2r21vpaR+Z
	 RncPxv6cJc+EXYZcDNtLkiS8VwcEW+CbH9KSa2VWAu2CU8vaeb/rp3q4zY/kW11Qcj
	 sgF4l3p+rSM1ykFhsULkuLn8+8AcuG86QLQPz6Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfK1Omj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:42:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38389 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1Omj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:42:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so31515808wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kyRDRW0pDU5PLmANaY7B3Wbm9V4zGfXOFbv7d7Ln9uY=;
        b=ndqfxrjT1Lz1J1l/+Gpkjaes40AvidYTHUXI9sZr8V1dp47uRfbx/T8N01gpitY5Pz
         CiOn1NDZWlmW5J+Lqnq7m4MynoVIywey02+2y24KGNuwnsnV3J43IhyjtyWcVLuu3Kz9
         xigb11aZwINwipCfyZNXYXxiMs1BIDlwaL9jTLOLYJ+TYjdDQQeZxQJpZJZG0JilVFlh
         0+K4BDBGV9v4vmCBrtvCkbZwUg0LzQU4EFSq9ogw9FwctxGClvz6p3OF7Gw6DxmlNyOL
         HkkqYtN99Cney8veMq1nKDXCx/CMbPkIl63rW1T/d0BE7iIHAg7RR6JNOl/lfyO7qFT4
         +gPw==
X-Gm-Message-State: APjAAAUIfp/x156tj43Wv2acC9705c2wMH2Sa3pSPB2WX90HuJxbZlXJ
        rFwszqrsBmPMvmbnE0ITrMQ=
X-Google-Smtp-Source: APXvYqzpQLTcWFIZdzjt+z41SmyfcH0vkfxatCxchZrmtNExp539N0q1tdUfIbuLq9gG1ha4GCekug==
X-Received: by 2002:adf:9185:: with SMTP id 5mr50384780wri.389.1574952156976;
        Thu, 28 Nov 2019 06:42:36 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f2sm3817378wmh.46.2019.11.28.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:42:36 -0800 (PST)
Date:   Thu, 28 Nov 2019 15:42:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in
 find_(smallest|biggest)_section_pfn
Message-ID: <20191128144235.GN26807@dhcp22.suse.cz>
References: <657e4a9d-767d-5140-a4f4-d963794cdf0c@redhat.com>
 <270C2A1D-25B0-4BC5-A521-9EEADF3A6B75@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <270C2A1D-25B0-4BC5-A521-9EEADF3A6B75@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-11-19 09:30:29, Qian Cai wrote:
> 
> 
> > On Nov 28, 2019, at 9:03 AM, David Hildenbrand <david@redhat.com> wrote:
> > 
> > That's why we have linux-next and plenty of people playing with it
> > (including you and me for example).
> 
> As mentioned, it is an expensive development practice. Once a patch
> was merged into linux-next, it becomes someone else’s problems
> because if nobody flags it as problematic, all it needs is a good eye
> review and some time before it gets merged into mainline eventually.

I would tend to agree. linux-next shouldn't be considered a low bar
target. Things should be reviewed before showing up there. There are
obviously some exceptions, as always, but it shouldn't be over used.

I wish MM patches would be applied to mmotm (and linux-next) more
conservatively.
-- 
Michal Hocko
SUSE Labs
