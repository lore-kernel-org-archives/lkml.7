Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CBF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5TGVYtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404147AbfJWUAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:00:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733176AbfJWUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:00:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so2105277plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jL7YH7Fjq1P1RNBDDDVMpkcwNNt3gwJI8ibnwp8UcA0=;
        b=H5TGVYtbmxJDnjBAlV5R0/O1Wg+CEVoOjLx+GxePd3BfJWnKrgRN64LBI9ZRSI8SZU
         3tPLdb6b2OUUx/1PvEs5uqw72BSsrWY3TmEEtm97ELqOKPKcgod6Ib+pXFddTOSvCT/M
         I5Nd8BhuZ1dswizZVvXpxSbkwexp2nJiDrHAJ1R5WyhUL1nB0O8mBC7PWvTuzrZjeXcJ
         mHFZOfFD+Ewd0kCNXeoRyIFA4VO1sJ/O5YrCo6M4Y0OyIsJZ1B0K3Uf3ckfdVlAg0xzh
         XQ7qmYxuGzIz37MdMu/A7H0+DO+WXGPCHBP+vfhEtbT4Q259iIziW+MEigfM9GbQ6B1w
         DiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jL7YH7Fjq1P1RNBDDDVMpkcwNNt3gwJI8ibnwp8UcA0=;
        b=fffO0FUfXyTFtLamqNeERzMdpz58JPeTSZOUAgl49G55ysyLulG7rt9veK3JV7veih
         ZLAfU+bka6no21k/1ktRWhxD5veYxdw30VsuUB7WTIByIBElbVtNeO00uX28J9NavT7R
         80LQapFUfsgd70HW4QcPciWPxaN3U6DS0nGOI7DOKGCHaTRWh6ZNagKzeWn4TxdcUDFL
         rhr1coc3z+fgtOG+CA9N1zmqkTzLLyTdtunz58nzli+EG43jZiRFXtPCXZqSi/xEvk+X
         b7Px8p/7mVa4Fyw3U9zZbA7hNvMwKKxGPPSzoVz6E++ST7ohbEw1OkVO7zYb/oobp1hb
         ME/A==
X-Gm-Message-State: APjAAAVRk80Yzn3jnHv/01T6CyXf262NGCVX8P+q9QrQcx8YQ0YRYxSG
        f65OH1S4XjCA7uqi47FiprHivA==
X-Google-Smtp-Source: APXvYqwNsfwfkeoTe2BZwqQxl/10o/f9XEmvONkoaKUlhyRRYWn4js2YYJh3uOjA6AetNdKceyh2Og==
X-Received: by 2002:a17:902:9005:: with SMTP id a5mr11418732plp.204.1571860841311;
        Wed, 23 Oct 2019 13:00:41 -0700 (PDT)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id c34sm23458622pgb.35.2019.10.23.13.00.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 13:00:40 -0700 (PDT)
Date:   Wed, 23 Oct 2019 13:00:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, gavin.dg@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
In-Reply-To: <4d3c14ef-ee86-2719-70d6-68f1a8b42c28@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1910231250260.1794@eggly.anvils>
References: <1571850304-82802-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.LSU.2.11.1910231157570.1088@eggly.anvils> <4d3c14ef-ee86-2719-70d6-68f1a8b42c28@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019, Yang Shi wrote:
> On 10/23/19 12:28 PM, Hugh Dickins wrote:
> > 
> > > +	return map_count >= 0 &&
> > You have added a map_count >= 0 test there. Okay, not wrong, but not
> > necessary, and not consistent with what's returned in the PageAnon
> > case (if this were called for an unmapped page).
> 
> I was thinking about this too. I'm wondering there might be a case that the
> PMD is split and it was the last PMD map, in this case subpage's _mapcount is
> also equal to compound_mapcount (both is -1). So, it would return true, then
> KVM may setup PMD map in EPT, but it might be PTE mapped later on the host.
> But, I'm not quite sure if this is really possible or if this is really a
> integrity problem. So, I thought it might be safer to add this check.

The mmu_notifier_invalidate_range_start.._end() in __split_huge_pmd(),
with KVM's locking and sequence counting, is required to protect
against such races.

Hugh
